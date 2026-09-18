-- ============================================================================
-- CORE: MAIN INITIALIZATION & BACKDROP MANAGER V15.2 (MAINUI EINGEBUNDEN)
-- ============================================================================
BerufeSkillGuide = BerufeSkillGuide or {}
local BSG = BerufeSkillGuide
BerufeSkillGuideFrame = BerufeSkillGuideFrame or nil

function BSG.ErstelleHauptfenster()
    if BerufeSkillGuideFrame then return end

    -- Hauptrahmen erstellen (Passend zu deiner BerufeSkillGuide.lua)
    local f = CreateFrame("Frame", "BerufeSkillGuideFrame", UIParent, "BackdropTemplate")
    f:SetSize(380, 520)
    f:SetPoint("CENTER", UIParent, "CENTER", 0, 0)
    f:SetMovable(true)
    f:EnableMouse(true)
    f:RegisterForDrag("LeftButton")
    f:SetScript("OnDragStart", f.StartMoving)
    f:SetScript("OnDragStop", f.StopMovingOrSizing)
    f:Hide()

    f:SetBackdrop({
        bgFile = "Interface\\ChatFrame\\ChatFrameBackground",
        edgeFile = "Interface\\ChatFrame\\ChatFrameBackground",
        tile = true, tileSize = 16, edgeSize = 1,
        insets = { left = 0, right = 0, top = 0, bottom = 0 }
    })
    f:SetBackdropColor(0.08, 0.08, 0.1, 0.95)
    f:SetBackdropBorderColor(0.25, 0.25, 0.3, 1)

    BerufeSkillGuideFrame = f
end

function BSG.ToggleFenster()
    if not BerufeSkillGuideFrame then BSG.ErstelleHauptfenster() end
    if BerufeSkillGuideFrame then
        if BerufeSkillGuideFrame:IsVisible() then BerufeSkillGuideFrame:Hide() else BerufeSkillGuideFrame:Show() end
    end
end
BSG.ToggleWindow = BSG.ToggleFenster

-- EVENT-MOTOR: Startet alle Module nacheinander beim Login des Spielers
local initFrame = CreateFrame("Frame")
initFrame:RegisterEvent("PLAYER_LOGIN")
initFrame:SetScript("OnEvent", function(self, event, ...)
    if not BerufeSkillGuideDB then 
        BerufeSkillGuideDB = { minimapPos = 45, showMinimap = true, frameAlpha = 95, debugMode = false } 
    end
    
    -- 1. Hauptfenster physisch im Spiel aufbauen
    BSG.ErstelleHauptfenster()

    -- 1b. Datenbank-Inspector still im Hintergrund laufen lassen (kein
    --     Chat-Spam), damit die Kopfzeile (MainUI.lua) direkt ein
    --     "Datenbank geprüft"-Badge zeigen kann.
    if _G["BSG_Inspector"] and _G["BSG_Inspector"].PruefeAlleStumm then
        _G["BSG_Inspector"].PruefeAlleStumm()
    end

    -- 2. Kopfzeile aufbauen: Titel, Rezept-Suchfeld, manuelle Skill-Eingabe,
    --    Optionen-Button, Schließen-Button
    if BerufeSkillGuideFrame and _G["BSG_MainUI"] and _G["BSG_MainUI"].InitialisiereUI then
        _G["BSG_MainUI"].InitialisiereUI(BerufeSkillGuideFrame)
    end

    -- 3. Das Such- und Berechnungsmenü initialisieren
    if BerufeSkillGuideFrame and _G["BSG_Search"] and _G["BSG_Search"].InitialisiereMenue then 
        _G["BSG_Search"].InitialisiereMenue(BerufeSkillGuideFrame) 
    end
    
    -- 4. DEINE NEUE SIDEBAR AKTIVIEREN UND ANHEFTEN!
    if BerufeSkillGuideFrame and _G["BSG_Sidebar"] and _G["BSG_Sidebar"].InitialisiereSidebar then
        _G["BSG_Sidebar"].InitialisiereSidebar(BerufeSkillGuideFrame)
    end
    
    -- 5. Einstellungsmenü laden
    if BSG_Options and BSG_Options.InitialisiereOptionen and BerufeSkillGuideFrame then 
        BSG_Options.InitialisiereOptionen(BerufeSkillGuideFrame, BSG.ToggleFenster) 
    end
    
    self:UnregisterEvent("PLAYER_LOGIN")
end)
