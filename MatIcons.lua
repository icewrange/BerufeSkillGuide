-- ============================================================================
-- MODUL: MATICONS V37.2 - ULTIMATE PIXEL PERFECT ALIGNMENT (PARSER FIX)
-- ============================================================================
BSG_MatIcons = {}
BSG_MatIcons.IconPool = {}

local function ErstelleEinzelnesIcon(index)
    if BSG_MatIcons.IconPool[index] then return BSG_MatIcons.IconPool[index] end
    
    local parentFrame = BerufeSkillGuideFrame or UIParent
    local btn = CreateFrame("Button", "BSG_MatClick_Icon_"..index, parentFrame, "BackdropTemplate")
    btn:SetSize(14, 14) 
    btn:SetFrameLevel(parentFrame:GetFrameLevel() + 20)
    
    btn.texture = btn:CreateTexture(nil, "ARTWORK")
    btn.texture:SetAllPoints()
    
    btn:SetBackdrop({edgeFile = "Interface\\ChatFrame\\ChatFrameBackground", edgeSize = 1})
    btn:SetBackdropBorderColor(1, 0.82, 0, 1)
    
    btn:SetScript("OnClick", function(self, button)
        if button == "LeftButton" and self.aktuellerMatName then
            local korrigierterName = self.aktuellerMatName:gsub("^%l", string.upper)
            if IsShiftKeyDown() then
                -- FEHLER BEHOBEN: Sichere Klammer-Syntax für den Aufruf im Classic-Interface
                if AuctionFrame and AuctionFrame:IsVisible() and BrowseName then
                    BrowseName:SetText(korrigierterName)
                    if AuctionFrameBrowse_Search then
                        AuctionFrameBrowse_Search()
                    end
                else
                    if ChatFrame1EditBox and ChatFrame1EditBox:IsVisible() then ChatFrame1EditBox:Insert(korrigierterName) end
                end
            else
                -- NEU: Normaler Klick (ohne Shift) ruft jetzt den GoldPlaner
                -- für dieses eine Material auf und scannt das offene AH-
                -- Suchfenster nach dem Stückpreis, hochgerechnet auf die
                -- Menge, die für den aktuellen Guide-Schritt noch fehlt
                -- (BSG_Search.LetzteGesamtBedarf).
                if BSG_GoldPlaner and BSG_GoldPlaner.OeffnePlaner then
                    local menge = (BSG_Search and BSG_Search.LetzteGesamtBedarf and BSG_Search.LetzteGesamtBedarf[self.aktuellerMatName]) or 1
                    BSG_GoldPlaner.OeffnePlaner(self.aktuellerMatName, menge)
                end
            end
        end
    end)

    btn:SetScript("OnEnter", function(self)
        if not self.aktuellerMatName then return end
        GameTooltip:SetOwner(self, "ANCHOR_RIGHT")
        GameTooltip:AddLine(self.aktuellerMatName:gsub("^%l", string.upper))

        -- NEU: Cross-Char-Bestand aufgeschlüsselt anzeigen (AccountScanner.lua),
        -- damit man sofort sieht, AUF WELCHEM Charakter das Material schon
        -- liegt, statt nur die nackte Gesamtsumme zu kennen.
        if BSG_API and BSG_API.GetItemCountByCharacter then
            local verteilung = BSG_API.GetItemCountByCharacter(self.aktuellerMatName)
            local charNamen = {}
            local gesamt = 0
            for charName, anzahl in pairs(verteilung) do
                table.insert(charNamen, charName)
                gesamt = gesamt + anzahl
            end

            GameTooltip:AddLine(" ")
            if gesamt > 0 then
                table.sort(charNamen, function(a, b) return verteilung[a] > verteilung[b] end)
                GameTooltip:AddLine(string.format("|cff00ff00Bestand (alle Charaktere): %d|r", gesamt))
                for _, charName in ipairs(charNamen) do
                    GameTooltip:AddLine(string.format("   %s: %d", charName, verteilung[charName]), 0.9, 0.9, 0.9)
                end
            else
                GameTooltip:AddLine("|cffff5500Auf keinem gescannten Charakter vorhanden.|r")
            end
        end

        GameTooltip:AddLine(" ")
        GameTooltip:AddLine("|cff00ff00Klick:|r AH-Preis für den Gesamtbedarf berechnen", 1, 1, 1)
        GameTooltip:AddLine("|cff00ff00Shift-Klick:|r Im Auktionshaus danach suchen", 1, 1, 1)
        GameTooltip:Show()
    end)
    btn:SetScript("OnLeave", function() GameTooltip:Hide() end)
    
    BSG_MatIcons.IconPool[index] = btn
    return btn
end

function BSG_MatIcons.InitialisiereIcon()
    if BSG_MatIcons.IconPool then for _, btn in pairs(BSG_MatIcons.IconPool) do btn:Hide() end end
end

function BSG_MatIcons.AktualisiereIcon(matsString, aktuellerBeruf)
    if not matsString or matsString == "" then return end
    
    local parentFrame = BerufeSkillGuideFrame or UIParent
    local aktuellerIndex = 1
    
    for teil in string.gmatch(matsString, "([^,]+)") do
        teil = teil:gsub("^%s*(.-)%s*$", "%1")

        -- FIX: Wie in Search.lua - die Datenbank-Dateien schreiben Mengen
        -- ohne "x" ("48 Seltsamer Staub"). Der alte Parser verlangte
        -- zwingend "48x Seltsamer Staub" und lieferte sonst nil, wodurch
        -- NIE ein Icon erzeugt wurde. "x?" macht das "x" optional.
        local anzahl, materialName = string.match(teil, "(%d+)x?%s+(.+)")
        
        if materialName then
            local btn = ErstelleEinzelnesIcon(aktuellerIndex)
            btn:SetParent(parentFrame)
            btn.aktuellerMatName = materialName
            
            btn:ClearAllPoints()
            -- Um denselben Betrag nach unten verschoben wie infoTextDisplay
            -- in Search.lua (von -64 auf -85, also -21px), damit die Icons
            -- weiterhin exakt neben "Material pro Gegenstand:" sitzen und
            -- nicht mehr mit dem Suchfeld/Skill-Eingabefeld überlappen.
            local yOffset = -178.3 - ((aktuellerIndex - 1) * 18.2)
            btn:SetPoint("TOPLEFT", parentFrame, "TOPLEFT", 32, yOffset)
            
            local itemTexture = nil
            local finalID = nil
            
            local sucheName = materialName:gsub("^%l", string.upper)
            local sucheNameAlternative = sucheName:gsub("Oe", "Ö"):gsub("Ae", "Ä"):gsub("Ue", "Ü")
            
            if _G.BSG_ItemDB then
                finalID = _G.BSG_ItemDB[sucheName] or _G.BSG_ItemDB[sucheNameAlternative]
            end
            
            if finalID and type(finalID) == "number" then
                itemTexture = BSG_Compat.GetItemTexture(finalID)
            end
            
            if not itemTexture then itemTexture = BSG_Compat.GetItemTexture(materialName) end
            
            btn.texture:SetTexture(itemTexture or "Interface\\Icons\\INV_Misc_QuestionMark")
            btn:Show()
            aktuellerIndex = aktuellerIndex + 1
        end
    end
end

-- NEU (Karten-Layout): Liefert Icon Nr. index für ein Material, als Kind
-- der Material-Karte. Die Karte setzt die Position selbst.
local function IconTextur(materialName)
    local sucheName = materialName:gsub("^%l", string.upper)
    local alternative = sucheName:gsub("Oe", "Ö"):gsub("Ae", "Ä"):gsub("Ue", "Ü")
    local id = _G.BSG_ItemDB and (_G.BSG_ItemDB[sucheName] or _G.BSG_ItemDB[alternative])
    local tex = (type(id) == "number") and BSG_Compat.GetItemTexture(id) or nil
    return tex or BSG_Compat.GetItemTexture(materialName) or "Interface\\Icons\\INV_Misc_QuestionMark"
end

function BSG_MatIcons.HoleIcon(index, parent, materialName)
    local btn = ErstelleEinzelnesIcon(index)
    btn:SetParent(parent)
    btn:SetSize(18, 18)
    btn:SetFrameLevel((parent:GetFrameLevel() or 1) + 3)
    btn.aktuellerMatName = materialName
    btn.texture:SetTexture(IconTextur(materialName))
    btn.texture:SetTexCoord(0.07, 0.93, 0.07, 0.93)
    btn:Show()
    return btn
end

function BSG_MatIcons.ZeichneIcon() end
