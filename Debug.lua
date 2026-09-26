-- ============================================================================
-- MODUL: DEBUG & HELP COMMANDS - HILFEFENSTER FÜR BEFEHLE V1.0
-- ============================================================================
BerufeSkillGuide = BerufeSkillGuide or {}
local BSG = BerufeSkillGuide
local bsgHelpWindow = nil

-- Funktion, die das Hilfe-Fenster physisch erstellt
function BSG.ErstelleHilfeFenster()
    if bsgHelpWindow then return end

    -- Hauptrahmen für das Hilfe-Fenster (Passend zum flachen Core-Design)
    local f = CreateFrame("Frame", "BSG_HelpWindowFrame", UIParent, "BackdropTemplate")
    f:SetSize(360, 330)
    f:SetPoint("CENTER", UIParent, "CENTER", 40, 40)
    f:SetMovable(true)
    f:EnableMouse(true)
    f:RegisterForDrag("LeftButton")
    f:SetScript("OnDragStart", f.StartMoving)
    f:SetScript("OnDragStop", f.StopMovingOrSizing)
    f:Hide()

    f:SetBackdrop({
        bgFile = "Interface\\ChatFrame\\ChatFrameBackground",
        edgeFile = "Interface\\ChatFrame\\ChatFrameBackground",
        edgeSize = 1
    })
    f:SetBackdropColor(0.08, 0.08, 0.1, 0.95)
    f:SetBackdropBorderColor(0.25, 0.25, 0.3, 1)

    -- Dunkler Titel-Balken oben
    local titleBg = f:CreateTexture(nil, "BACKGROUND")
    titleBg:SetPoint("TOPLEFT", f, "TOPLEFT", 1, -1)
    titleBg:SetPoint("BOTTOMRIGHT", f, "TOPRIGHT", -1, -35)
    titleBg:SetColorTexture(0.15, 0.15, 0.18, 1)

    -- Schließen-Button oben rechts (Das rote X)
    local close = CreateFrame("Button", nil, f, "UIPanelCloseButton")
    close:SetPoint("TOPRIGHT", f, "TOPRIGHT", -2, -2)
    close:SetScript("OnClick", function() f:Hide() end)

    -- Titel des Fensters
    local title = f:CreateFontString(nil, "OVERLAY", "GameFontNormalLarge")
    title:SetPoint("LEFT", titleBg, "LEFT", 15, 0)
    title:SetText("|cffffff00BSG - Befehlsübersicht|r")

    -- Textfeld für die Befehlsliste (Nutzt deine neue, gut lesbare Schriftgröße!)
    local helpText = f:CreateFontString(nil, "OVERLAY", "GameFontHighlight")
    helpText:SetPoint("TOPLEFT", f, "TOPLEFT", 20, -55)
    helpText:SetWidth(320)
    helpText:SetJustifyH("LEFT")
    helpText:SetSpacing(6) -- Angenehmer Zeilenabstand

    -- Hier sind all deine grundlegenden Befehle aufgelistet:
    local inhalt = ""
    inhalt = inhalt .. "|cffffd100/bsg|r  -  Öffnet / schließt das Hauptfenster\n"
    inhalt = inhalt .. "|cffffd100/bsg help|r  -  Öffnet diese Befehlsübersicht\n"
    inhalt = inhalt .. "|cffffd100/bsg optionen|r  -  Öffnet das Einstellungsmenü\n"
    inhalt = inhalt .. "|cffffd100/bsg debug|r  -  Schaltet den Debug-Modus um\n"
    inhalt = inhalt .. "|cffffd100/bsg sim <Beruf> <Skill>|r  -  Simulationsmodus\n"
    inhalt = inhalt .. "|cffffd100/bsg version|r  -  Classic / WoW Forever umschalten\n"
    inhalt = inhalt .. "|cffffd100/bsg auswahl|r  -  Auto-Auswahl im Berufefenster an/aus\n"
    inhalt = inhalt .. "|cffffd100/bsg gold|r  -  AH-Kosten für den aktuellen Schritt\n"
    inhalt = inhalt .. "|cffffd100/bsg wo <Material>|r  -  Bestand je Charakter anzeigen\n"
    inhalt = inhalt .. "|cffffd100/bsg check [Beruf]|r  -  Datenbank-Inspektor\n"
    inhalt = inhalt .. "|cffffd100/bsg bugreport [Text]|r  -  Bug-Report erstellen"

    helpText:SetText(inhalt)

    bsgHelpWindow = f
end

-- Funktion zum Umschalten (Anzeigen/Verstecken) des Fensters
function BSG.ToggleHilfeFenster()
    if not bsgHelpWindow then BSG.ErstelleHilfeFenster() end
    if bsgHelpWindow:IsVisible() then
        bsgHelpWindow:Hide()
    else
        bsgHelpWindow:Show()
    end
end
