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
            end
        end
    end)
    
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
                local _, _, _, _, _, _, _, _, _, tex = GetItemInfo(finalID)
                itemTexture = tex or GetItemIcon(finalID)
            end
            
            if not itemTexture then _, _, _, _, _, _, _, _, _, itemTexture = GetItemInfo(materialName) end
            
            btn.texture:SetTexture(itemTexture or "Interface\\Icons\\INV_Misc_QuestionMark")
            btn:Show()
            aktuellerIndex = aktuellerIndex + 1
        end
    end
end

function BSG_MatIcons.ZeichneIcon() end