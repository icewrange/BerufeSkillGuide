-- ============================================================================
-- MODUL: BUG-REPORT - FEHLERPROTOKOLL + KOPIERBARER DIAGNOSE-TEXT V1.0
-- ============================================================================
-- WoW-Addons können keine Netzwerkanfragen stellen, daher kann dieses Modul
-- einen Bug-Report nicht automatisch irgendwohin senden. Stattdessen:
--   1. Ein leichtgewichtiger seterrorhandler()-Hook fängt Lua-Fehler ab, die
--      erkennbar aus diesem Addon stammen (Dateiname/Traceback enthält
--      "BerufeSkillGuide" oder einen bekannten Modul-Dateinamen), und merkt
--      sie sich in einem kleinen Ringpuffer (BerufeSkillGuideDB.bugReportFehler),
--      damit sie auch nach einem /reload oder Neustart noch sichtbar sind.
--   2. /bsg bugreport [Beschreibung] öffnet ein Fenster mit einem fertigen,
--      reinen Text-Report (Addon-Version, WoW-Build, Locale, Debug-Modus,
--      erkannter Beruf, zuletzt aufgetretene Fehler, optionale Beschreibung
--      des Spielers) in einer Editbox, deren Inhalt beim Öffnen automatisch
--      markiert wird - der Spieler muss nur noch Strg+C drücken und den Text
--      z.B. in ein GitHub-Issue, Discord oder CurseForge-Kommentar einfügen.
BerufeSkillGuide = BerufeSkillGuide or {}
local BSG = BerufeSkillGuide

BSG_BugReport = BSG_BugReport or {}

local MAX_FEHLER = 10

-- ----------------------------------------------------------------------------
-- FEHLERERFASSUNG (seterrorhandler-Hook)
-- ----------------------------------------------------------------------------
-- Modul-Dateinamen dieses Addons, anhand derer ein Fehler-String/Traceback
-- als "kommt aus diesem Addon" erkannt wird, falls der Ordnername selbst
-- (z.B. bei einem umbenannten Addon-Ordner) nicht im Text auftaucht.
local BSG_DATEI_MARKER = {
    "BerufeSkillGuide",
    "BSG_Core.lua",
    "Search.lua",
    "GoldPlaner.lua",
    "MatIcons.lua",
    "Sidebar.lua",
    "MainUI.lua",
    "Simulation.lua",
    "Inspector.lua",
    "AccountScanner.lua",
    "Compat.lua",
    "Spielversion.lua",
    "BSG_Skillstufen.lua",
    "Daten_",
}

local function IstBSGFehler(text)
    if not text then return false end
    for _, marker in ipairs(BSG_DATEI_MARKER) do
        if text:find(marker, 1, true) then
            return true
        end
    end
    return false
end

local function SpeichereFehler(fehlerText)
    BerufeSkillGuideDB = BerufeSkillGuideDB or {}
    BerufeSkillGuideDB.bugReportFehler = BerufeSkillGuideDB.bugReportFehler or {}
    local liste = BerufeSkillGuideDB.bugReportFehler

    table.insert(liste, {
        text = fehlerText,
        zeit = date("%Y-%m-%d %H:%M:%S"),
    })

    -- Ringpuffer: älteste Einträge entfernen, wenn das Limit überschritten wird
    while #liste > MAX_FEHLER do
        table.remove(liste, 1)
    end
end

-- Vorherigen Fehlerhandler NICHT verdrängen, sondern verketten, damit andere
-- Addons (z.B. BugSack/!BugGrabber) weiterhin ganz normal funktionieren.
local vorherigerHandler = geterrorhandler and geterrorhandler()

local function BSG_ErrorHandler(msg, ...)
    local ok, istBSG = pcall(IstBSGFehler, msg)
    if ok and istBSG then
        pcall(SpeichereFehler, tostring(msg))
    end

    if vorherigerHandler then
        return vorherigerHandler(msg, ...)
    end
end

seterrorhandler(BSG_ErrorHandler)

-- ----------------------------------------------------------------------------
-- REPORT-TEXT ZUSAMMENSTELLEN
-- ----------------------------------------------------------------------------
local function HoleAddonVersion()
    -- Ältere und neuere WoW-Client-APIs unterstützen (Classic Era bekommt
    -- gelegentlich API-Wechsel je nach Patch-Stand)
    if C_AddOns and C_AddOns.GetAddOnMetadata then
        return C_AddOns.GetAddOnMetadata("BerufeSkillGuide", "Version") or "?"
    elseif GetAddOnMetadata then
        return GetAddOnMetadata("BerufeSkillGuide", "Version") or "?"
    end
    return "?"
end

function BSG_BugReport.ErstelleReportText(beschreibung)
    BerufeSkillGuideDB = BerufeSkillGuideDB or {}

    local zeilen = {}
    table.insert(zeilen, "=== Berufe Skill Guide - Bug Report ===")
    table.insert(zeilen, "Addon-Version: " .. HoleAddonVersion())

    local build, buildNr, buildDatum, tocVersion = GetBuildInfo()
    table.insert(zeilen, string.format("WoW-Build: %s (%s), Interface: %s", tostring(build), tostring(buildNr), tostring(tocVersion)))
    table.insert(zeilen, "Locale: " .. tostring(GetLocale()))
    table.insert(zeilen, "Debug-Modus: " .. (BerufeSkillGuideDB.debugMode and "an" or "aus"))

    if BSG_Simulation and BSG_Simulation.aktiv then
        table.insert(zeilen, "Simulation aktiv: ja")
    end

    if beschreibung and beschreibung:match("%S") then
        table.insert(zeilen, "")
        table.insert(zeilen, "Beschreibung des Spielers:")
        table.insert(zeilen, beschreibung)
    end

    local fehlerListe = BerufeSkillGuideDB.bugReportFehler
    table.insert(zeilen, "")
    if fehlerListe and #fehlerListe > 0 then
        table.insert(zeilen, string.format("Zuletzt erfasste Lua-Fehler (%d):", #fehlerListe))
        for i, eintrag in ipairs(fehlerListe) do
            table.insert(zeilen, string.format("[%s] %s", eintrag.zeit or "?", eintrag.text or "?"))
        end
    else
        table.insert(zeilen, "Keine Lua-Fehler seit dem letzten Login erfasst.")
    end

    return table.concat(zeilen, "\n")
end

-- ----------------------------------------------------------------------------
-- FENSTER (analog zum Hilfefenster in Debug.lua, mit kopierbarer Editbox)
-- ----------------------------------------------------------------------------
local bugReportFenster = nil
local bugReportEditBox = nil

local function ErstelleBugReportFenster()
    if bugReportFenster then return end

    local f = CreateFrame("Frame", "BSG_BugReportFrame", UIParent, "BackdropTemplate")
    f:SetSize(460, 360)
    f:SetPoint("CENTER", UIParent, "CENTER", 0, 0)
    f:SetMovable(true)
    f:EnableMouse(true)
    f:SetFrameStrata("DIALOG")
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

    local titleBg = f:CreateTexture(nil, "BACKGROUND")
    titleBg:SetPoint("TOPLEFT", f, "TOPLEFT", 1, -1)
    titleBg:SetPoint("BOTTOMRIGHT", f, "TOPRIGHT", -1, -35)
    titleBg:SetColorTexture(0.15, 0.15, 0.18, 1)

    local close = CreateFrame("Button", nil, f, "UIPanelCloseButton")
    close:SetPoint("TOPRIGHT", f, "TOPRIGHT", -2, -2)
    close:SetScript("OnClick", function() f:Hide() end)

    local title = f:CreateFontString(nil, "OVERLAY", "GameFontNormalLarge")
    title:SetPoint("LEFT", titleBg, "LEFT", 15, 0)
    title:SetText("|cffffff00BSG - Bug Report|r")

    local hinweis = f:CreateFontString(nil, "OVERLAY", "GameFontHighlightSmall")
    hinweis:SetPoint("TOPLEFT", f, "TOPLEFT", 20, -48)
    hinweis:SetWidth(420)
    hinweis:SetJustifyH("LEFT")
    hinweis:SetText("Der Text unten ist bereits markiert - einfach |cffffd100Strg+C|r drücken und z.B. in ein GitHub-Issue, Discord oder CurseForge-Kommentar einfügen. Das Addon kann Reports nicht automatisch senden.")

    -- Scrollbarer Bereich mit der Editbox
    local scrollFrame = CreateFrame("ScrollFrame", "BSG_BugReportScroll", f, "UIPanelScrollFrameTemplate")
    scrollFrame:SetPoint("TOPLEFT", f, "TOPLEFT", 20, -95)
    scrollFrame:SetPoint("BOTTOMRIGHT", f, "BOTTOMRIGHT", -36, 45)

    local editBox = CreateFrame("EditBox", nil, scrollFrame)
    editBox:SetMultiLine(true)
    editBox:SetFontObject(ChatFontNormal)
    editBox:SetWidth(400)
    editBox:SetAutoFocus(false)
    editBox:SetScript("OnEscapePressed", function(self) self:ClearFocus() end)
    -- Bewusst nicht "read-only" per API (gibt es nicht) - stattdessen wird
    -- der Inhalt bei jedem OnShow neu gesetzt, versehentliche Änderungen des
    -- Spielers wirken sich also nicht auf den gespeicherten Report aus.
    scrollFrame:SetScrollChild(editBox)

    bugReportEditBox = editBox

    local schliessenButton = CreateFrame("Button", nil, f, "UIPanelButtonTemplate")
    schliessenButton:SetSize(100, 22)
    schliessenButton:SetPoint("BOTTOM", f, "BOTTOM", 0, 12)
    schliessenButton:SetText("Schließen")
    schliessenButton:SetScript("OnClick", function() f:Hide() end)

    bugReportFenster = f
end

function BSG_BugReport.OeffneReport(beschreibung)
    ErstelleBugReportFenster()

    local text = BSG_BugReport.ErstelleReportText(beschreibung)
    bugReportEditBox:SetText(text)
    bugReportFenster:Show()

    -- Fokussieren und alles markieren, damit Strg+C sofort funktioniert
    bugReportEditBox:SetFocus()
    bugReportEditBox:HighlightText()
end

function BSG_BugReport.ToggleReport(beschreibung)
    if bugReportFenster and bugReportFenster:IsVisible() then
        bugReportFenster:Hide()
    else
        BSG_BugReport.OeffneReport(beschreibung)
    end
end
