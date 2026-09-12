-- ============================================================================
-- MODUL: SEARCH - COMPLETE CALCULATION ENGINE V1.5 (REZEPTSUCHE + UI-KOPPLUNG)
-- ============================================================================
if not _G["BSG_Search"] then _G["BSG_Search"] = {} end
local BSG_Search = _G["BSG_Search"]

local letzterBeruf = "Alchimie"
local letzterSkill = 1

-- Findet aus BerufeLehrerDB[beruf] den zum aktuellen Skill passenden
-- Eintrag, anhand der Zahlen im "stufe"-Text (z.B. "(150-225)"). Fehlt
-- ein Zahlenbereich (z.B. "Lehrling / Geselle" ohne Zahlen), wird dieser
-- Eintrag als Fallback vorgemerkt, falls kein besserer gefunden wird.
local function FindeLehrerEintrag(lehrerListe, skill)
    local fallback = nil
    for _, eintrag in ipairs(lehrerListe) do
        local von, bis = eintrag.stufe:match("%((%d+)%-(%d+)%)")
        if von and bis then
            von, bis = tonumber(von), tonumber(bis)
            if skill >= von and skill <= bis then
                return eintrag
            end
        else
            fallback = fallback or eintrag
        end
    end
    return fallback or lehrerListe[1]
end

function BSG_Search.InitialisiereMenue(mainFrame)
    if not mainFrame then return end

    if not mainFrame.infoTextDisplay then
        mainFrame.infoTextDisplay = mainFrame:CreateFontString(nil, "OVERLAY", "GameFontHighlight")
        mainFrame.infoTextDisplay:ClearAllPoints()
        mainFrame.infoTextDisplay:SetPoint("TOPLEFT", mainFrame, "TOPLEFT", 55, -85)
        mainFrame.infoTextDisplay:SetWidth(310)
        mainFrame.infoTextDisplay:SetJustifyH("LEFT")
        mainFrame.infoTextDisplay:SetSpacing(4)
    end

    BSG_Search.ScanneCharakterBerufe()
end

function BSG_Search.ScanneCharakterBerufe()
    local gefundenerBeruf, aktuellerSkill = nil, 1
    for i = 1, 25 do
        local skillName, _, _, step = GetSkillLineInfo(i)
        if not skillName then break end
        if BerufeGuideDB and BerufeGuideDB[skillName] then
            gefundenerBeruf, aktuellerSkill = skillName, step
            break
        end
    end
    if not gefundenerBeruf and BerufeGuideDB["Alchimie"] then
        gefundenerBeruf, aktuellerSkill = "Alchimie", 158
    end
    if gefundenerBeruf then 
        BSG_Search.BerechneMaterialBedarf(gefundenerBeruf, aktuellerSkill) 
    end
end

function BSG_Search.BerechneMaterialBedarf(berufsName, spielerSkill)
    if not BerufeGuideDB or not BerufeGuideDB[berufsName] then return end
    letzterBeruf, letzterSkill = berufsName, spielerSkill

    -- Merkt den aktuell angezeigten Beruf zentral auf mainFrame, damit
    -- MainUI.lua (manuelle Skill-Eingabe) weiß, welchen Beruf eine
    -- eingegebene Skill-Zahl betreffen soll, egal ob der Beruf per
    -- Sidebar-Klick, Auto-Scan oder Rezeptsuche gewählt wurde.
    if BerufeSkillGuideFrame then
        BerufeSkillGuideFrame.aktuellAusgewaehlterBeruf = berufsName
    end

    if BSG_MatIcons and BSG_MatIcons.InitialisiereIcon then BSG_MatIcons.InitialisiereIcon() end

    local textInhalt = ""

    for _, daten in ipairs(BerufeGuideDB[berufsName]) do
        local istLetzterSchritt = (daten.maxSkill == 300)
        if spielerSkill >= daten.minSkill and (spielerSkill < daten.maxSkill or (istLetzterSchritt and spielerSkill == daten.maxSkill)) then
            
            textInhalt = textInhalt .. string.format("\n|cffffffff=== %s (%d/300) ===|r\n\n", berufsName:upper(), spielerSkill)
            textInhalt = textInhalt .. string.format("|cff00ff00Aktueller Schritt (Skill %d-%d):|r\n", daten.minSkill, daten.maxSkill)
            textInhalt = textInhalt .. string.format("Stelle her: |cffffd100%s|r\n", daten.item)
            textInhalt = textInhalt .. "|cff888888Material pro Gegenstand:|r\n"
            
            local materialienTabelle = {}
            
            if daten.mats and daten.mats ~= "" then
                for teil in string.gmatch(daten.mats, "([^,]+)") do
                    teil = teil:gsub("^%s*(.-)%s*$", "%1")
                    local anzahl, materialName = string.match(teil, "(%d+)x?%s+(.+)")
                    
                    if anzahl and materialName then
                        anzahl = tonumber(anzahl)
                        -- GEÄNDERT: Nutzt jetzt BSG_API.GetItemCount statt der
                        -- rohen WoW-API GetItemCount(). BSG_API.GetItemCount
                        -- wird von AccountScanner.lua überschrieben und
                        -- summiert den Bestand über ALLE deine Charaktere
                        -- hinweg (fällt automatisch auf den aktuellen
                        -- Charakter zurück, falls noch kein Scan-Datensatz
                        -- vorliegt). Die Anzeige zeigt damit den Gesamt-
                        -- Bestand, nicht mehr nur den des aktuellen Chars.
                        local imBesitz = (BSG_API and BSG_API.GetItemCount and BSG_API.GetItemCount(materialName)) or (GetItemCount(materialName, true) or 0)
                        
                        table.insert(materialienTabelle, { name = materialName, proSchritt = anzahl, imBesitz = imBesitz })
                        
                        local farbPrefix = (imBesitz >= anzahl) and "|cff00ff00" or "|cffff0000"
                        textInhalt = textInhalt .. string.format("    %s%dx %s|r (%d)\n", farbPrefix, anzahl, materialName, imBesitz)
                    end
                end
            end
            
            local verbleibendePunkte = daten.maxSkill - spielerSkill
            textInhalt = textInhalt .. string.format("\n|cffffd100Fehlende Punkte bis %d:|r %d\n\n", daten.maxSkill, verbleibendePunkte)
            
            if #materialienTabelle > 0 then
                textInhalt = textInhalt .. string.format("|cff00ffffGesamt-Bedarf bis %d:|r\n", daten.maxSkill)
                
                for _, mat in ipairs(materialienTabelle) do
                    local gesamtBenoetigt = mat.proSchritt * verbleibendePunkte
                    if mat.imBesitz >= gesamtBenoetigt then
                        textInhalt = textInhalt .. string.format("    |cff00ff00%dx %s|r\n", gesamtBenoetigt, mat.name)
                    else
                        local fehlt = gesamtBenoetigt - mat.imBesitz
                        textInhalt = textInhalt .. string.format("    |cffff0000%dx %s|r (fehlen %d)\n", gesamtBenoetigt, mat.name, fehlt)
                    end
                end
            end
            
            if BSG_MatIcons and BSG_MatIcons.AktualisiereIcon then
                BSG_MatIcons.AktualisiereIcon(daten.mats, berufsName)
            end
            
            break
        end
    end

    -- NEU: Lehrer-Standorte anzeigen (BerufeLehrerDB existierte schon
    -- länger, wurde aber bisher nirgends in der UI angezeigt).
    -- FIX: Zeigt jetzt nur noch die zum aktuellen Skill passende Stufe
    -- (statt aller Stufen auf einmal) - der komplette Lehrer-Block
    -- sprengte sonst die Höhe des Hauptfensters.
    if BerufeLehrerDB and BerufeLehrerDB[berufsName] then
        local eintrag = FindeLehrerEintrag(BerufeLehrerDB[berufsName], spielerSkill)
        if eintrag then
            textInhalt = textInhalt .. string.format("\n|cffffd100Lehrer (%s):|r\n%s\n", eintrag.stufe, eintrag.standorte)

            -- NEU: TomTom-Wegpunkt (nur Kartenpin, KEIN automatischer Pfeil -
            -- siehe BSG_TomTom.lua fuer den Grund/die Konflikt-Vermeidung mit RestedXP)
            if BSG_TomTom and BSG_TomTom.SetzeWegpunkt then
                local fraktion = UnitFactionGroup("player")
                if fraktion == "Alliance" and eintrag.allianzZone then
                    BSG_TomTom.SetzeWegpunkt(eintrag.allianzZone, eintrag.allianzX, eintrag.allianzY, "BSG Lehrer: " .. berufsName)
                elseif fraktion == "Horde" and eintrag.hordeZone then
                    BSG_TomTom.SetzeWegpunkt(eintrag.hordeZone, eintrag.hordeX, eintrag.hordeY, "BSG Lehrer: " .. berufsName)
                end
            end
        end
    end

    if BerufeSkillGuideFrame and BerufeSkillGuideFrame.infoTextDisplay then
        BerufeSkillGuideFrame.infoTextDisplay:SetText(textInhalt)
    end
end

-- FIX/NEU: War zuvor nur ein Stub, der bei nicht-leerer Eingabe gar nichts
-- getan hat. Durchsucht jetzt zuerst die Skill-Guide-Rezepte (BerufeGuideDB)
-- und springt bei einem Treffer zur passenden Skill-Stufe. Findet sich dort
-- nichts, wird zusätzlich in den Fundorte-Infos (BerufeFundorteDB) gesucht,
-- z.B. für seltene Boss-Drop-Rezepte wie "Feurige Waffe", die nicht im
-- normalen Herstell-Guide stehen.
function BSG_Search.FuehreRezeptSucheAus(suchText)
    if not suchText or suchText == "" then
        BSG_Search.BerechneMaterialBedarf(letzterBeruf, letzterSkill)
        return
    end

    local suchTextKlein = suchText:lower()

    -- 1. Skill-Guide-Rezepte durchsuchen
    if BerufeGuideDB then
        for berufName, eintraege in pairs(BerufeGuideDB) do
            for _, eintrag in ipairs(eintraege) do
                if eintrag.item and eintrag.item:lower():find(suchTextKlein, 1, true) then
                    BSG_Search.BerechneMaterialBedarf(berufName, eintrag.minSkill)
                    return
                end
            end
        end
    end

    -- 2. Nichts im Guide gefunden -> in den Fundorte-Infos suchen
    if BerufeFundorteDB then
        for rezeptName, info in pairs(BerufeFundorteDB) do
            if type(rezeptName) == "string" and rezeptName:lower():find(suchTextKlein, 1, true) then
                -- FIX: Alte Icons vom vorherigen Rezept ausblenden, da hier
                -- kein Skill-Guide-Eintrag (mit Materialien) angezeigt wird.
                if BSG_MatIcons and BSG_MatIcons.InitialisiereIcon then BSG_MatIcons.InitialisiereIcon() end
                if BerufeSkillGuideFrame and BerufeSkillGuideFrame.infoTextDisplay then
                    BerufeSkillGuideFrame.infoTextDisplay:SetText(
                        string.format("|cffffd100%s|r\n\n%s", rezeptName, tostring(info))
                    )
                end
                return
            end
        end
    end

    -- 3. Wirklich nichts gefunden
    -- FIX: Auch hier alte Icons ausblenden (das fehlte vorher komplett -
    -- Icons vom letzten erfolgreichen Rezept blieben sichtbar stehen).
    if BSG_MatIcons and BSG_MatIcons.InitialisiereIcon then BSG_MatIcons.InitialisiereIcon() end
    if BerufeSkillGuideFrame and BerufeSkillGuideFrame.infoTextDisplay then
        BerufeSkillGuideFrame.infoTextDisplay:SetText("|cffff5500Kein Rezept gefunden für:|r " .. suchText)
    end
end
_G.BSG_Search = BSG_Search
