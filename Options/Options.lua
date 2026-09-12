-- ============================================================================
-- MODUL: OPTIONS - EIGENSTÄNDIGER MINIMAP-BUTTON (KEINE GETEILTEN LIBS)
-- ============================================================================
-- FIX: Nutzte vorher LibStub/LibDataBroker-1.1/LibDBIcon-1.0 - geteilte,
-- globale Bibliotheken, die auch von anderen Addons (z.B. Questie) genutzt
-- werden. Trotz mehrfacher Reparatur dieser Libs traten weiterhin stille
-- Kompatibilitätsprobleme mit anderen Addons auf. Der Minimap-Button wird
-- jetzt komplett eigenständig gebaut, ohne jede geteilte Bibliothek -
-- dadurch gibt es keinerlei Berührungspunkt mehr mit dem globalen
-- LibStub-Namensraum, den andere Addons ebenfalls nutzen.
BSG_Options = {}

-- Baut den Minimap-Button eigenständig, ohne LibDBIcon.
local function ErstelleMinimapButton(toggleCallback)
    local button = CreateFrame("Button", "BSG_MinimapButton", Minimap)
    button:SetSize(31, 31)
    button:SetFrameStrata("MEDIUM")
    button:SetFrameLevel(8)
    button:RegisterForClicks("AnyUp")
    button:RegisterForDrag("LeftButton")
    button:SetHighlightTexture("Interface\\Minimap\\UI-Minimap-ZoomButton-Highlight")

    local overlay = button:CreateTexture(nil, "OVERLAY")
    overlay:SetSize(53, 53)
    overlay:SetTexture("Interface\\Minimap\\MiniMap-TrackingBorder")
    overlay:SetPoint("TOPLEFT")

    local background = button:CreateTexture(nil, "BACKGROUND")
    background:SetSize(20, 20)
    background:SetTexture("Interface\\Minimap\\UI-Minimap-Background")
    background:SetPoint("TOPLEFT", 7, -5)

    local icon = button:CreateTexture(nil, "ARTWORK")
    icon:SetSize(17, 17)
    icon:SetTexture("Interface\\Icons\\Trade_Alchemy")
    icon:SetTexCoord(0.07, 0.93, 0.07, 0.93)
    icon:SetPoint("TOPLEFT", 7, -6)
    button.icon = icon

    -- Positioniert den Button entlang des Minimap-Rands anhand des in
    -- BerufeSkillGuideDB.minimap.minimapPos gespeicherten Winkels.
    local function AktualisierePosition()
        local angle = math.rad(BerufeSkillGuideDB.minimap.minimapPos or 225)
        local radius = (Minimap:GetWidth() / 2) + 5
        button:SetPoint("CENTER", Minimap, "CENTER", math.cos(angle) * radius, math.sin(angle) * radius)
    end

    button:SetScript("OnDragStart", function(self)
        self:LockHighlight()
        self:SetScript("OnUpdate", function()
            local mx, my = Minimap:GetCenter()
            local px, py = GetCursorPosition()
            local scale = Minimap:GetEffectiveScale()
            px, py = px / scale, py / scale
            BerufeSkillGuideDB.minimap.minimapPos = math.deg(math.atan2(py - my, px - mx)) % 360
            AktualisierePosition()
        end)
    end)

    button:SetScript("OnDragStop", function(self)
        self:SetScript("OnUpdate", nil)
        self:UnlockHighlight()
    end)

    button:SetScript("OnClick", function(self, mouseButton)
        if mouseButton == "LeftButton" then
            toggleCallback()
        end
    end)

    button:SetScript("OnEnter", function(self)
        GameTooltip:SetOwner(self, "ANCHOR_LEFT")
        GameTooltip:AddLine("|cffffffffBerufeSkillGuide|r")
        GameTooltip:AddLine("|cff00ffffKlicken, um den Guide zu öffnen.|r")
        GameTooltip:Show()
    end)
    button:SetScript("OnLeave", function() GameTooltip:Hide() end)

    button.AktualisierePosition = AktualisierePosition
    AktualisierePosition()

    return button
end

function BSG_Options.InitialisiereOptionen(mainFrame, toggleCallback)
    if BSG_Options.configFrame then return end

    -- 1. MINIMAP-BUTTON EIGENSTÄNDIG ERSTELLEN
    if BerufeSkillGuideDB.minimap == nil then
        BerufeSkillGuideDB.minimap = { minimapPos = 225, hide = false }
    end

    local minimapButton = ErstelleMinimapButton(toggleCallback)
    if BerufeSkillGuideDB.minimap.hide then
        minimapButton:Hide()
    end
    BSG_Options.minimapButton = minimapButton

    -- 3. OPTIONS FRAME (DEIN SCHICKES FLAT-UI DESIGN)
    local cfg = CreateFrame("Frame", "BSGConfigFrame", mainFrame, "BackdropTemplate")
    cfg:SetSize(220, 140)
    cfg:SetPoint("TOPLEFT", mainFrame, "TOPRIGHT", 5, 0)
    cfg:Hide()
    cfg:SetBackdrop({bgFile = "Interface\\ChatFrame\\ChatFrameBackground", edgeFile = "Interface\\ChatFrame\\ChatFrameBackground", edgeSize = 1})
    cfg:SetBackdropColor(0.08, 0.08, 0.1, 0.95)
    cfg:SetBackdropBorderColor(0.25, 0.25, 0.3, 1)

    local title = cfg:CreateFontString(nil, "OVERLAY", "GameFontNormalLarge")
    title:SetPoint("TOPLEFT", 15, -12)
    -- FIX: BSG_Locale selbst war ungeschützt indiziert. Falls die
    -- Locale-Datei fehlt oder nach Options.lua lädt, war BSG_Locale nil und
    -- "BSG_Locale.OPTIONS" crashte mit "attempt to index a nil value"
    -- (der alte "or"-Fallback schützte nur .OPTIONS, nicht die Tabelle
    -- selbst). Jetzt wird zusätzlich BSG_Locale selbst geprüft.
    title:SetText("|cffffff00" .. ((BSG_Locale and BSG_Locale.OPTIONS) or "Optionen") .. "|r")

    local cb = CreateFrame("CheckButton", "BSGMinimapCheckbox", cfg, "BackdropTemplate")
    cb:SetSize(18, 18)
    cb:SetPoint("TOPLEFT", title, "BOTTOMLEFT", 0, -15)
    cb:SetBackdrop({bgFile = "Interface\\ChatFrame\\ChatFrameBackground", edgeFile = "Interface\\ChatFrame\\ChatFrameBackground", edgeSize = 1})
    cb:SetBackdropColor(0.15, 0.15, 0.18, 1)
    cb:SetBackdropBorderColor(0.3, 0.3, 0.4, 1)

    local checkedTex = cb:CreateTexture(nil, "ARTWORK")
    checkedTex:SetTexture("Interface\\Buttons\\UI-CheckBox-Check")
    checkedTex:SetSize(20, 20)
    checkedTex:SetPoint("CENTER", 1, 1)
    cb:SetCheckedTexture(checkedTex)

    local cbText = cfg:CreateFontString(nil, "OVERLAY", "GameFontHighlight")
    cbText:SetPoint("LEFT", cb, "RIGHT", 10, 0)
    cbText:SetText("Minimap-Button anzeigen")

    cb:SetScript("OnShow", function(self) 
        self:SetChecked(not BerufeSkillGuideDB.minimap.hide) 
    end)
    cb:SetScript("OnClick", function(self) 
        local checked = self:GetChecked()
        BerufeSkillGuideDB.minimap.hide = not checked
        if checked then
            minimapButton:Show()
            minimapButton.AktualisierePosition()
        else
            minimapButton:Hide()
        end
    end)

    local slider = CreateFrame("Slider", "BSGAlphaSlider", cfg, "BackdropTemplate")
    slider:SetPoint("TOPLEFT", cb, "BOTTOMLEFT", 0, -42)
    slider:SetSize(190, 6)
    slider:SetBackdrop({bgFile = "Interface\\ChatFrame\\ChatFrameBackground", edgeFile = "Interface\\ChatFrame\\ChatFrameBackground", edgeSize = 1})
    slider:SetBackdropColor(0.15, 0.15, 0.18, 1)
    slider:SetBackdropBorderColor(0.3, 0.3, 0.4, 1)
    
    slider:SetOrientation("HORIZONTAL")
    slider:SetMinMaxValues(30, 100)
    slider:SetValueStep(5)
    slider:SetObeyStepOnDrag(true)

    local thumb = slider:CreateTexture(nil, "ARTWORK")
    thumb:SetTexture("Interface\\Buttons\\UI-SliderBar-Button-Horizontal")
    thumb:SetSize(16, 16)
    slider:SetThumbTexture(thumb)

    local sliderLabel = cfg:CreateFontString(nil, "OVERLAY", "GameFontNormalSmall")
    sliderLabel:SetPoint("BOTTOMLEFT", slider, "TOPLEFT", 0, 6)
    -- FIX: Gleiche Absicherung wie beim Titel oben.
    sliderLabel:SetText("|cffffff00" .. ((BSG_Locale and BSG_Locale.FRAME_ALPHA) or "Fenster-Transparenz") .. "|r")

    local lowText = slider:CreateFontString(nil, "OVERLAY", "GameFontDisableSmall")
    lowText:SetPoint("TOPLEFT", slider, "BOTTOMLEFT", 0, -6)
    lowText:SetText("30%")

    local highText = slider:CreateFontString(nil, "OVERLAY", "GameFontDisableSmall")
    highText:SetPoint("TOPRIGHT", slider, "BOTTOMRIGHT", 0, -6)
    highText:SetText("100%")

    slider:SetScript("OnShow", function(self) self:SetValue(BerufeSkillGuideDB.frameAlpha) end)
    slider:SetScript("OnValueChanged", function(self, value) 
        BerufeSkillGuideDB.frameAlpha = value 
        mainFrame:SetBackdropColor(0.08, 0.08, 0.1, value / 100) 
    end)

    BSG_Options.configFrame = cfg
end

function BSG_Options.ToggleOptionen()
    if BSG_Options.configFrame then if BSG_Options.configFrame:IsVisible() then BSG_Options.configFrame:Hide() else BSG_Options.configFrame:Show() end end
end
