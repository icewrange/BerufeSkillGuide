-- Globales BSG-API Objekt erweitern
BSG_API = BSG_API or {}
local currentCharacterName = UnitName("player")

-- Berechnet den Gesamtbestand eines Items über ALLE deine Charaktere hinweg
function BSG_API.GetItemCount(itemName)
    if not itemName then return 0 end
    local gesamtAnzahl = 0
    
    -- Prüft felsenfest, ob die Datenbank existiert
    if BerufeSkillGuideDB and BerufeSkillGuideDB.accountBestand then
        for charName, daten in pairs(BerufeSkillGuideDB.accountBestand) do
            if daten[itemName] then
                gesamtAnzahl = gesamtAnzahl + daten[itemName]
            end
        end
    end
    
    -- Fallback: Falls dieser Charakter brandneu ist, zaehle seine Taschen direkt live
    if gesamtAnzahl == 0 then
        gesamtAnzahl = BSG_Compat.GetItemCount(itemName)
    end
    
    return gesamtAnzahl
end

-- NEU: Liefert den Bestand eines Materials AUFGESCHLÜSSELT NACH CHARAKTER
-- zurück (z.B. {["Anduris"] = 12, ["Anduriswar"] = 8}), statt nur die Summe
-- wie GetItemCount(). Damit kann die UI anzeigen, AUF WELCHEM Charakter ein
-- fehlendes Material bereits liegt (z.B. um es per Post zu verschicken),
-- statt nur "hast du insgesamt genug". Charaktere mit 0 werden nicht
-- aufgeführt.
function BSG_API.GetItemCountByCharacter(itemName)
    local verteilung = {}
    if not itemName then return verteilung end

    if BerufeSkillGuideDB and BerufeSkillGuideDB.accountBestand then
        for charName, daten in pairs(BerufeSkillGuideDB.accountBestand) do
            local anzahl = daten[itemName]
            if anzahl and anzahl > 0 then
                verteilung[charName] = anzahl
            end
        end
    end

    -- Fallback: Noch gar kein gescannter Charakter vorhanden (z.B. ganz
    -- frischer Login vor dem ersten automatischen Scan) -> zeige wenigstens
    -- den live gezählten Bestand des aktuellen Charakters an.
    if next(verteilung) == nil then
        local liveAnzahl = BSG_Compat.GetItemCount(itemName, true)
        if liveAnzahl > 0 and currentCharacterName then
            verteilung[currentCharacterName] = liveAnzahl
        end
    end

    return verteilung
end

-- Scannt den aktuellen Charakter und speichert alles felsenfest auf der Festplatte
function BSG_API.ScanCharakterBestand()
    if not currentCharacterName then return end
    
    -- Erstellt die Tabellen live, falls WoW sie noch nicht geladen hat
    BerufeSkillGuideDB = BerufeSkillGuideDB or {}
    if BerufeSkillGuideDB.accountBestand == nil then BerufeSkillGuideDB.accountBestand = {} end
    
    -- Wir legen einen sauberen Speicherplatz für diesen Charakter an
    BerufeSkillGuideDB.accountBestand[currentCharacterName] = {}
    local meinBestand = BerufeSkillGuideDB.accountBestand[currentCharacterName]
    
    if BSG_DebugLog then BSG_DebugLog.Print("|cff00ff00[Live-Scan]:|r Aktualisiere Bestand für " .. currentCharacterName) end
    
    -- Moderne Classic-Variante (0 = Rucksack, 1-4 = Taschen)
    local maxTaschen = 4
    if BerufeSkillGuideFrame and BerufeSkillGuideFrame.bankOffen then
        maxTaschen = 11 -- Erweitert den Scan auf die Bankfächer, wenn sie offen sind
        if BSG_DebugLog then BSG_DebugLog.Print("|cff00ff00[Bank-Scan]:|r Bank ist offen. Scanne Tresorfächer...") end
    end
    
    -- Der Scan-Loop mit der offiziellen C_Container-API von Blizzard
    for tasche = 0, maxTaschen do
        if C_Container and C_Container.GetContainerNumSlots then
            local slotsAnzahl = C_Container.GetContainerNumSlots(tasche)
            if slotsAnzahl and slotsAnzahl > 0 then
                for slot = 1, slotsAnzahl do
                    local itemInfo = C_Container.GetContainerItemInfo(tasche, slot)
                    if itemInfo and itemInfo.hyperlink then
                        local itemName = BSG_Compat.GetItemInfo(itemInfo.hyperlink)
                        local stackAnzahl = itemInfo.stackCount or 1
                        
                        if itemName and stackAnzahl and stackAnzahl > 0 then
                            local bisher = meinBestand[itemName] or 0
                            meinBestand[itemName] = bisher + stackAnzahl
                        end
                    end
                end
            end
        end
    end
    
    -- Spezieller Scan für das Haupt-Bankfach (Slot -1)
    if BerufeSkillGuideFrame and BerufeSkillGuideFrame.bankOffen then
        if C_Container and C_Container.GetContainerNumSlots then
            local bankSlots = C_Container.GetContainerNumSlots(-1)
            if bankSlots and bankSlots > 0 then
                for slot = 1, bankSlots do
                    local itemInfo = C_Container.GetContainerItemInfo(-1, slot)
                    if itemInfo and itemInfo.hyperlink then
                        local itemName = BSG_Compat.GetItemInfo(itemInfo.hyperlink)
                        local stackAnzahl = itemInfo.stackCount or 1
                        
                        if itemName and stackAnzahl and stackAnzahl > 0 then
                            local bisher = meinBestand[itemName] or 0
                            meinBestand[itemName] = bisher + stackAnzahl
                        end
                    end
                end
            end
        end
    end
end

-- ============================================================================
-- NEU: AUTOMATISCHE SCAN-AUSLÖSER (EVENT-LISTENER)
-- ============================================================================
-- Bisher wurde BSG_API.ScanCharakterBestand() nirgends automatisch
-- aufgerufen - der accountBestand blieb dadurch leer. Diese Events lösen
-- den Scan jetzt automatisch aus:
--   - PLAYER_LOGIN: einmaliger Scan direkt beim Einloggen
--   - BAG_UPDATE: bei jeder Änderung des Taschen-Inhalts
--   - BANKFRAME_OPENED/CLOSED: markiert BerufeSkillGuideFrame.bankOffen und
--     scannt zusätzlich die Bankfächer mit
--
-- WICHTIG: BAG_UPDATE feuert oft mehrfach kurz hintereinander (z.B. beim
-- Postfach, Handel oder Verkaufen mehrerer Items). Ein direkter Aufruf bei
-- jedem einzelnen Event würde den kompletten Taschen-Scan unnötig oft
-- wiederholen. Deshalb wird der Scan per C_Timer.After um 0.5s verzögert
-- und mehrfach eintreffende Events innerhalb dieser Zeit zu einem
-- einzigen Scan zusammengefasst (Debounce).
local scanBereitsGeplant = false
local function PlaneVerzoegertenScan()
    if scanBereitsGeplant then return end
    scanBereitsGeplant = true
    C_Timer.After(0.5, function()
        scanBereitsGeplant = false
        BSG_API.ScanCharakterBestand()
    end)
end

local scanEventFrame = CreateFrame("Frame")
scanEventFrame:RegisterEvent("PLAYER_LOGIN")
scanEventFrame:RegisterEvent("BAG_UPDATE")
scanEventFrame:RegisterEvent("BANKFRAME_OPENED")
scanEventFrame:RegisterEvent("BANKFRAME_CLOSED")
scanEventFrame:SetScript("OnEvent", function(self, event)
    if event == "BANKFRAME_OPENED" then
        if BerufeSkillGuideFrame then BerufeSkillGuideFrame.bankOffen = true end
    elseif event == "BANKFRAME_CLOSED" then
        if BerufeSkillGuideFrame then BerufeSkillGuideFrame.bankOffen = false end
    end
    PlaneVerzoegertenScan()
end)
