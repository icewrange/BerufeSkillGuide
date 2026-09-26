-- ============================================================================
-- MODUL: SPIELVERSION - UMSCHALTER CLASSIC <-> WOW FOREVER V1.0
-- ============================================================================
-- Funktioniert wie der Spielversions-Button in AtlasLoot: Ein Logo-Button in
-- der Titelleiste zeigt die aktive Version. Ein Klick öffnet eine kleine
-- Auswahlliste darunter; die nicht aktive Version ist halbtransparent.
--
-- Technisch werden beim Umschalten die globalen Datenbanken ausgetauscht,
-- die ALLE Module ohnehin zur Laufzeit lesen:
--   BerufeGuideDB   -> Classic-Guides    bzw.  Forever-Guides
--   BerufeLehrerDB  -> Classic-Lehrer    bzw.  Forever-Lehrer
-- Dadurch mussten Search.lua, Sidebar.lua, Inspector.lua usw. nicht
-- umgebaut werden.
--
-- Fehlt für einen Beruf (noch) ein eigener Forever-Guide, wird automatisch
-- der Classic-Guide angezeigt und im Fenster ein Hinweis eingeblendet - die
-- Vanilla-Rezepte existieren in Forever weiterhin.
--
-- Muss in der .toc NACH allen Data\...\*.lua-Dateien geladen werden.

BSG_Spielversion = BSG_Spielversion or {}
local SV = BSG_Spielversion

SV.VERSIONEN = {
    { id = "classic", name = "Classic", unterzeile = "Era / SoD",   farbe = { 1.00, 0.82, 0.00 } },
    { id = "forever", name = "Forever", unterzeile = "WoW Forever", farbe = { 0.35, 0.80, 1.00 } },
}

local function HoleVersionInfo(id)
    for _, v in ipairs(SV.VERSIONEN) do
        if v.id == id then return v end
    end
    return SV.VERSIONEN[1]
end

local function L(key, fallback)
    return (BSG_Locale and BSG_Locale[key]) or fallback
end

-- ----------------------------------------------------------------------------
-- DATENBANKEN
-- ----------------------------------------------------------------------------
-- Die Classic-Tabellen werden JETZT (beim Laden dieser Datei, also nach allen
-- Data\...\*.lua) festgehalten, bevor irgendetwas die Globals austauscht.
local classicGuide  = BerufeGuideDB  or {}
local classicLehrer = BerufeLehrerDB or {}
local classicFundorte = BerufeFundorteDB or {}

-- Werden von Data\Forever\*.lua befüllt (gleiches Format wie Classic).
BerufeGuideDB_Forever  = BerufeGuideDB_Forever  or {}
BerufeLehrerDB_Forever = BerufeLehrerDB_Forever or {}
BerufeFundorteDB_Forever = BerufeFundorteDB_Forever or {}

local foreverGuideGemischt, foreverLehrerGemischt, foreverFundorteGemischt

-- Baut die Forever-Tabellen: echter Forever-Eintrag, sonst Classic-Eintrag
-- als Rückfall. Echte Tabellen (keine Metatables), damit pairs() in der
-- Rezeptsuche und im Inspector weiterhin alle Berufe findet.
local function BaueForeverTabellen()
    foreverGuideGemischt, foreverLehrerGemischt = {}, {}
    for beruf, daten in pairs(classicGuide) do foreverGuideGemischt[beruf] = daten end
    for beruf, daten in pairs(BerufeGuideDB_Forever) do foreverGuideGemischt[beruf] = daten end
    for beruf, daten in pairs(classicLehrer) do foreverLehrerGemischt[beruf] = daten end
    for beruf, daten in pairs(BerufeLehrerDB_Forever) do foreverLehrerGemischt[beruf] = daten end
    foreverFundorteGemischt = {}
    for k, v in pairs(classicFundorte) do foreverFundorteGemischt[k] = v end
    for k, v in pairs(BerufeFundorteDB_Forever) do foreverFundorteGemischt[k] = v end
end

-- ----------------------------------------------------------------------------
-- ZUSTAND
-- ----------------------------------------------------------------------------
function SV.StandardVersion()
    if BSG_Compat and BSG_Compat.IST_FOREVER_CLIENT then return "forever" end
    return "classic"
end

function SV.Aktiv()
    local gespeichert = BerufeSkillGuideDB and BerufeSkillGuideDB.spielVersion
    if gespeichert == "classic" or gespeichert == "forever" then return gespeichert end
    return SV.StandardVersion()
end

function SV.IstForever()
    return SV.Aktiv() == "forever"
end

-- true, wenn Forever aktiv ist, für diesen Beruf aber (noch) kein eigener
-- Forever-Guide existiert und deshalb der Classic-Guide angezeigt wird.
function SV.NutztClassicRueckfall(beruf)
    return SV.IstForever() and beruf ~= nil and BerufeGuideDB_Forever[beruf] == nil
end

-- Tauscht die globalen Datenbanken aus (ohne UI-Aktualisierung).
function SV.WendeDatenAn()
    if SV.IstForever() then
        BaueForeverTabellen()
        BerufeGuideDB  = foreverGuideGemischt
        BerufeLehrerDB = foreverLehrerGemischt
        BerufeFundorteDB = foreverFundorteGemischt
    else
        BerufeGuideDB  = classicGuide
        BerufeLehrerDB = classicLehrer
        BerufeFundorteDB = classicFundorte
    end
end

-- Öffentlicher Umschalter: speichert, tauscht Daten, aktualisiert Anzeige.
function SV.Setze(id)
    if id ~= "classic" and id ~= "forever" then return end
    BerufeSkillGuideDB = BerufeSkillGuideDB or {}
    BerufeSkillGuideDB.spielVersion = id

    SV.WendeDatenAn()
    SV.AktualisiereButton()

    -- Aktuell angezeigten Guide mit den neuen Daten neu berechnen
    if BSG_Search and BSG_Search.BerechneMaterialBedarf and BSG_Search.HoleLetztenStand then
        local beruf, skill = BSG_Search.HoleLetztenStand()
        if beruf and skill and BerufeGuideDB[beruf] then
            BSG_Search.BerechneMaterialBedarf(beruf, skill)
        end
    end

    local info = HoleVersionInfo(id)
    print(string.format("|cff00ff00[BSG]:|r %s |cff%02x%02x%02x%s|r",
        L("VERSION_SWITCHED", "Spielversion umgeschaltet auf"),
        math.floor(info.farbe[1] * 255), math.floor(info.farbe[2] * 255), math.floor(info.farbe[3] * 255), info.name))
end

-- ----------------------------------------------------------------------------
-- UI: LOGO-BUTTON + AUSWAHLLISTE (AtlasLoot-Stil)
-- ----------------------------------------------------------------------------
local BUTTON_B, BUTTON_H = 64, 24

-- Goldener 1px-Rahmen aus Linien, exakt wie AtlasLoots gameVersionButton.
local function ZeichneGoldRahmen(frame, alpha)
    local abstand = 1
    local punkte = {
        { "TOPLEFT", -abstand, abstand,  "TOPRIGHT", abstand, abstand },
        { "TOPRIGHT", abstand, abstand,  "BOTTOMRIGHT", abstand, -abstand },
        { "BOTTOMRIGHT", abstand, -abstand, "BOTTOMLEFT", -abstand, -abstand },
        { "BOTTOMLEFT", -abstand, -abstand, "TOPLEFT", -abstand, abstand },
    }
    frame.rahmen = {}
    for _, p in ipairs(punkte) do
        local l = frame:CreateLine(nil, "OVERLAY")
        l:SetThickness(1)
        l:SetColorTexture(1, 0.82, 0, alpha or 0.4)
        l:SetStartPoint(p[1], p[2], p[3])
        l:SetEndPoint(p[4], p[5], p[6])
        table.insert(frame.rahmen, l)
    end
end

-- Baut ein "Logo" (Hintergrund + zweizeiliger Schriftzug) auf einen Button.
local function BaueLogo(btn)
    btn.bg = btn:CreateTexture(nil, "BACKGROUND")
    btn.bg:SetAllPoints(btn)
    btn.bg:SetColorTexture(0.05, 0.05, 0.07, 1)

    btn.verlauf = btn:CreateTexture(nil, "BORDER")
    btn.verlauf:SetAllPoints(btn)
    btn.verlauf:SetColorTexture(1, 1, 1, 1)

    btn.titel = btn:CreateFontString(nil, "OVERLAY", "GameFontNormal")
    btn.titel:SetPoint("CENTER", btn, "CENTER", 0, 4)

    btn.unter = btn:CreateFontString(nil, "OVERLAY", "GameFontDisableSmall")
    btn.unter:SetPoint("TOP", btn.titel, "BOTTOM", 0, 0)
    local font, _, flags = btn.unter:GetFont()
    if font then btn.unter:SetFont(font, 8, flags) end

    btn:SetHighlightTexture("Interface\\Buttons\\UI-Common-MouseHilight", "ADD")
end

local function FaerbeLogo(btn, versionId)
    local info = HoleVersionInfo(versionId)
    local r, g, b = info.farbe[1], info.farbe[2], info.farbe[3]
    btn.titel:SetText(info.name:upper())
    btn.titel:SetTextColor(r, g, b)
    btn.unter:SetText(info.unterzeile)
    -- SetGradient-Signatur unterscheidet sich je nach Client -> abgesichert
    btn.verlauf:SetColorTexture(1, 1, 1, 1)
    local ok = CreateColor and pcall(btn.verlauf.SetGradient, btn.verlauf, "VERTICAL",
        CreateColor(r, g, b, 0.02), CreateColor(r, g, b, 0.22))
    if not ok then
        btn.verlauf:SetColorTexture(r, g, b, 0.12)
    end
end

local function ErstelleAuswahlListe(hauptButton)
    local liste = CreateFrame("Frame", "BSG_SpielversionListe", hauptButton, "BackdropTemplate")
    -- Gleiche Strata wie das Hauptfenster (nicht TOOLTIP), sonst würde die
    -- Liste - wie früher die Sidebar - über der Weltkarte liegen.
    liste:SetFrameLevel(hauptButton:GetFrameLevel() + 20)
    liste:EnableMouse(true)
    liste:SetBackdrop({
        bgFile = "Interface\\ChatFrame\\ChatFrameBackground",
        edgeFile = "Interface\\ChatFrame\\ChatFrameBackground",
        edgeSize = 1,
    })
    liste:SetBackdropColor(0, 0, 0, 1)
    liste:SetBackdropBorderColor(0.25, 0.25, 0.3, 1)
    liste:SetPoint("TOP", hauptButton, "BOTTOM", 0, -3)
    liste.buttons = {}

    local abstand = 2
    for i, v in ipairs(SV.VERSIONEN) do
        local b = CreateFrame("Button", nil, liste)
        b:SetSize(BUTTON_B, BUTTON_H)
        BaueLogo(b)
        FaerbeLogo(b, v.id)
        b.versionId = v.id
        if i == 1 then
            b:SetPoint("TOP", liste, "TOP", 0, -5)
        else
            b:SetPoint("TOP", liste.buttons[i - 1], "BOTTOM", 0, -abstand)
        end
        b:SetScript("OnClick", function(self)
            liste:Hide()
            if self.versionId ~= SV.Aktiv() then
                SV.Setze(self.versionId)
            end
        end)
        b:SetScript("OnEnter", function(self)
            GameTooltip:SetOwner(self, "ANCHOR_RIGHT")
            GameTooltip:SetText(HoleVersionInfo(self.versionId).name, 1, 1, 1)
            if self.versionId == "forever" then
                GameTooltip:AddLine(L("VERSION_TT_FOREVER", "Guides für World of Warcraft: Forever."), 0.8, 0.8, 0.8, true)
            else
                GameTooltip:AddLine(L("VERSION_TT_CLASSIC", "Guides für Classic Era / Season of Discovery."), 0.8, 0.8, 0.8, true)
            end
            GameTooltip:Show()
        end)
        b:SetScript("OnLeave", function() GameTooltip:Hide() end)
        liste.buttons[i] = b
    end

    local anzahl = #liste.buttons
    liste:SetSize(BUTTON_B + 10, 10 + anzahl * BUTTON_H + (anzahl - 1) * abstand)
    liste:Hide()
    return liste
end

function SV.AktualisiereButton()
    local btn = SV.Button
    if not btn then return end
    FaerbeLogo(btn, SV.Aktiv())
    if btn.liste then
        for _, b in ipairs(btn.liste.buttons) do
            b:SetAlpha(b.versionId == SV.Aktiv() and 1.0 or 0.5)
        end
    end
end

-- Wird von MainUI.InitialisiereUI aufgerufen. 'rechtsVon' ist der Frame,
-- LINKS neben dem der Button sitzen soll (der Optionen-Button).
function SV.ErstelleButton(mainFrame, rechtsVon)
    if SV.Button or not mainFrame then return end

    local btn = CreateFrame("Button", "BSG_SpielversionButton", mainFrame)
    btn:SetSize(BUTTON_B, BUTTON_H)
    if rechtsVon then
        btn:SetPoint("RIGHT", rechtsVon, "LEFT", -8, 0)
    else
        btn:SetPoint("TOPRIGHT", mainFrame, "TOPRIGHT", -130, -8)
    end
    BaueLogo(btn)
    ZeichneGoldRahmen(btn, 0.4)

    btn:SetScript("OnClick", function(self)
        if not self.liste then self.liste = ErstelleAuswahlListe(self) end
        if self.liste:IsShown() then
            self.liste:Hide()
        else
            SV.AktualisiereButton()
            self.liste:Show()
            self.liste:Raise()
        end
    end)
    btn:SetScript("OnEnter", function(self)
        GameTooltip:SetOwner(self, "ANCHOR_BOTTOM")
        GameTooltip:SetText(L("VERSION_TITLE", "Spielversion"), 1, 1, 1)
        GameTooltip:AddLine(L("VERSION_TT_CLICK", "Klicken, um zwischen Classic und WoW Forever umzuschalten."), 0.8, 0.8, 0.8, true)
        GameTooltip:Show()
    end)
    btn:SetScript("OnLeave", function() GameTooltip:Hide() end)

    -- Auswahlliste schließen, wenn das Hauptfenster zugeht
    mainFrame:HookScript("OnHide", function()
        if btn.liste then btn.liste:Hide() end
    end)

    SV.Button = btn
    SV.AktualisiereButton()
end

-- ----------------------------------------------------------------------------
-- HINWEISZEILE FÜR DEN GUIDE-TEXT
-- ----------------------------------------------------------------------------
-- Wird von Search.lua oben in den Guide-Text eingefügt.
function SV.HinweisText(beruf)
    local text = ""
    -- NEU (v2.1): berufsspezifische Forever-Hinweise (z.B. "Heiltränke macht
    -- in Forever die Erste Hilfe") aus Data\Forever\*.lua
    if SV.IstForever() and BerufeHinweisDB_Forever and BerufeHinweisDB_Forever[beruf] then
        text = text .. "|cffff8800" .. BerufeHinweisDB_Forever[beruf] .. "|r\n"
    end
    if SV.NutztClassicRueckfall(beruf) then
        text = text .. "|cff59ccff" .. L("FOREVER_FALLBACK", "Forever: noch kein eigener Guide - Classic-Route wird angezeigt.") .. "|r\n"
    end
    return text
end

-- Daten sofort beim Laden passend zur gespeicherten Version setzen.
-- (SavedVariables sind erst ab ADDON_LOADED sicher verfügbar.)
local ladeFrame = CreateFrame("Frame")
ladeFrame:RegisterEvent("ADDON_LOADED")
ladeFrame:SetScript("OnEvent", function(self, event, addonName)
    if addonName == "BerufeSkillGuide" then
        SV.WendeDatenAn()
        self:UnregisterEvent("ADDON_LOADED")
    end
end)
