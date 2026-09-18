-- ============================================================================
-- MODUL: MAINUI - KOPFZEILE MIT SUCHE, SKILL-EINGABE & OPTIONEN-BUTTON V1.0
-- ============================================================================
-- Baut den oberen Bereich des Hauptfensters:
--   - Titel "Berufe Skill Guide"
--   - "Optionen"-Button (ruft BSG_Options.ToggleOptionen auf)
--   - Schließen-Button (rotes X)
--   - Rezept-Suchfeld (ruft BSG_Search.FuehreRezeptSucheAus auf)
--   - Skill-Eingabefeld + "Suchen"-Button: zeigt den Guide für eine manuell
--     eingegebene Skill-Zahl (z.B. 255) an, OHNE den tatsächlichen
--     Charakter-Skill abzufragen (kein BSG_API.GetGelernteBerufe-Aufruf).

BSG_MainUI = {}

function BSG_MainUI.InitialisiereUI(mainFrame)
    if not mainFrame or BSG_MainUI.UIErstellt then
        return
    end

    -- ========================================================================
    -- 1. TITEL-LEISTE
    -- ========================================================================
    local titleBg = mainFrame:CreateTexture(nil, "BACKGROUND")
    titleBg:SetPoint("TOPLEFT", mainFrame, "TOPLEFT", 1, -1)
    titleBg:SetPoint("TOPRIGHT", mainFrame, "TOPRIGHT", -1, -1)
    titleBg:SetHeight(40)
    titleBg:SetColorTexture(0.05, 0.05, 0.07, 1)

    local title = mainFrame:CreateFontString(nil, "OVERLAY", "GameFontNormalLarge")
    title:SetPoint("LEFT", titleBg, "LEFT", 15, 0)
    title:SetText("|cffffd100Berufe Skill Guide|r")

    -- ========================================================================
    -- 1b. DATENBANK-STATUS-BADGE
    -- ========================================================================
    -- Zeigt das Ergebnis des stillen Inspector-Checks vom Login (siehe
    -- BSG_Core.lua -> BSG_Inspector.PruefeAlleStumm) als kleines Symbol neben
    -- dem Titel: grüner Haken = Datenbank geprüft & sauber, oranges Ausrufe-
    -- zeichen = es wurden Probleme gefunden. Klick öffnet die ausführliche
    -- Prüfung im Chat (wie /bsg check).
    local dbBadge = CreateFrame("Button", "BSG_MainUI_DBBadge", mainFrame)
    dbBadge:SetSize(16, 16)
    dbBadge:SetPoint("LEFT", title, "RIGHT", 8, 0)

    local dbBadgeText = dbBadge:CreateFontString(nil, "OVERLAY", "GameFontNormalSmall")
    dbBadgeText:SetAllPoints(dbBadge)

    local function AktualisiereDBBadge()
        local ergebnis = BSG_Inspector and BSG_Inspector.LetzterCheck
        if not ergebnis then
            dbBadgeText:SetText("|cff888888?|r")
            dbBadge.tooltipText = "Datenbank noch nicht geprüft."
        elseif ergebnis.ok then
            dbBadgeText:SetText("|cff00ff00✓|r")
            dbBadge.tooltipText = string.format(
                "|cff00ff00Datenbank geprüft:|r %d Berufe, keine Probleme gefunden.\nKlicken für erneuten Check (/bsg check).",
                ergebnis.anzahlBerufe
            )
        else
            dbBadgeText:SetText("|cffff8800!|r")
            dbBadge.tooltipText = string.format(
                "|cffff8800Datenbank geprüft:|r %d Problem(e) gefunden.\nKlicken für Details (/bsg check).",
                ergebnis.anzahlProbleme
            )
        end
    end

    dbBadge:SetScript("OnEnter", function(self)
        GameTooltip:SetOwner(self, "ANCHOR_RIGHT")
        GameTooltip:SetText(self.tooltipText or "Datenbank-Status", 1, 1, 1, 1, true)
        GameTooltip:Show()
    end)
    dbBadge:SetScript("OnLeave", function() GameTooltip:Hide() end)
    dbBadge:SetScript("OnClick", function()
        if BSG_Inspector and BSG_Inspector.PruefeAlle then
            BSG_Inspector.PruefeAlle()
        end
        AktualisiereDBBadge()
    end)

    AktualisiereDBBadge()
    BSG_MainUI.AktualisiereDBBadge = AktualisiereDBBadge

    -- Schließen-Button (rotes X, oben rechts)
    local closeBtn = CreateFrame("Button", "BSG_MainUI_CloseBtn", mainFrame, "UIPanelCloseButton")
    closeBtn:SetPoint("TOPRIGHT", mainFrame, "TOPRIGHT", -4, -4)
    closeBtn:SetScript("OnClick", function() mainFrame:Hide() end)

    -- Optionen-Button (links neben dem Schließen-Button)
    local optionsBtn = CreateFrame("Button", "BSG_MainUI_OptionsBtn", mainFrame, "UIPanelButtonTemplate")
    optionsBtn:SetSize(80, 22)
    optionsBtn:SetPoint("RIGHT", closeBtn, "LEFT", -6, 0)
    optionsBtn:SetText("Optionen")
    optionsBtn:SetScript("OnClick", function()
        if BSG_Options and BSG_Options.ToggleOptionen then
            BSG_Options.ToggleOptionen()
        end
    end)

    -- ========================================================================
    -- 2. REZEPT-SUCHFELD
    -- ========================================================================
    local searchBox = CreateFrame("EditBox", "BSG_MainUI_SearchBox", mainFrame, "InputBoxTemplate")
    searchBox:SetSize(150, 20)
    searchBox:SetPoint("TOPLEFT", mainFrame, "TOPLEFT", 24, -50)
    searchBox:SetAutoFocus(false)
    searchBox:SetText("")

    searchBox.placeholder = searchBox:CreateFontString(nil, "OVERLAY", "GameFontDisableSmall")
    searchBox.placeholder:SetPoint("LEFT", searchBox, "LEFT", 4, 0)
    searchBox.placeholder:SetText("Rezept suchen...")

    searchBox:SetScript("OnEditFocusGained", function(self)
        self.placeholder:Hide()
    end)
    searchBox:SetScript("OnEditFocusLost", function(self)
        if self:GetText() == "" then self.placeholder:Show() end
    end)
    searchBox:SetScript("OnTextChanged", function(self)
        if self:GetText() ~= "" then self.placeholder:Hide() end
    end)
    searchBox:SetScript("OnEnterPressed", function(self)
        self:ClearFocus()
        if BSG_Search and BSG_Search.FuehreRezeptSucheAus then
            BSG_Search.FuehreRezeptSucheAus(self:GetText())
        end
    end)

    -- ========================================================================
    -- 3. MANUELLE SKILL-EINGABE (unabhängig vom echten Charakter-Skill!)
    -- ========================================================================
    local skillLabel = mainFrame:CreateFontString(nil, "OVERLAY", "GameFontNormal")
    skillLabel:SetPoint("LEFT", searchBox, "RIGHT", 12, 0)
    skillLabel:SetText("Skill:")

    local skillBox = CreateFrame("EditBox", "BSG_MainUI_SkillBox", mainFrame, "InputBoxTemplate")
    skillBox:SetSize(40, 20)
    skillBox:SetPoint("LEFT", skillLabel, "RIGHT", 6, 0)
    skillBox:SetAutoFocus(false)
    skillBox:SetNumeric(true)
    skillBox:SetMaxLetters(3)

    -- Zeigt den Guide für die eingetippte Skill-Zahl an. Ruft bewusst
    -- NICHT BSG_API.GetGelernteBerufe/GetSkillLineInfo auf - der echte
    -- Charakter-Skill wird hier komplett ignoriert, es zählt nur die Zahl
    -- im Eingabefeld.
    local function ZeigeManuelleSkillStufe()
        local eingabe = tonumber(skillBox:GetText())
        if not eingabe then
            print("|cffff5500[BSG]:|r Bitte eine gültige Skill-Zahl eingeben (1-300).")
            return
        end
        eingabe = math.max(1, math.min(300, math.floor(eingabe)))

        -- Nutzt den zuletzt angezeigten Beruf (z.B. per Sidebar-Klick
        -- gewählt oder beim Login automatisch erkannt) als Kontext dafür,
        -- WELCHEN Beruf die eingegebene Zahl betreffen soll.
        local beruf = (mainFrame.aktuellAusgewaehlterBeruf) or "Alchimie"

        if BSG_Search and BSG_Search.BerechneMaterialBedarf then
            BSG_Search.BerechneMaterialBedarf(beruf, eingabe)
        end
    end

    skillBox:SetScript("OnEnterPressed", function(self)
        self:ClearFocus()
        ZeigeManuelleSkillStufe()
    end)

    local searchBtn = CreateFrame("Button", "BSG_MainUI_SearchBtn", mainFrame, "UIPanelButtonTemplate")
    searchBtn:SetSize(60, 22)
    searchBtn:SetPoint("LEFT", skillBox, "RIGHT", 8, 0)
    searchBtn:SetText("Suchen")
    searchBtn:SetScript("OnClick", ZeigeManuelleSkillStufe)

    -- Kompatibilität: Sidebar.lua schreibt den ECHTEN Skill beim Klick auf
    -- ein Berufs-Icon in "BSG_Sidebar.SkillInputBox" (Anzeige-Bequemlichkeit,
    -- überschreibt aber nicht die manuelle Suche - der echte Skill wird nur
    -- angezeigt, nicht automatisch für "Suchen" verwendet).
    if BSG_Sidebar then
        BSG_Sidebar.SkillInputBox = skillBox
    end

    BSG_MainUI.SearchBox = searchBox
    BSG_MainUI.SkillBox = skillBox
    BSG_MainUI.UIErstellt = true
end
