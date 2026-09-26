-- ============================================================================
-- MODUL: KARTEN - NEUES GUIDE-LAYOUT (v2.1)
-- ============================================================================
-- Ersetzt den einen langen Textblock im Hauptfenster durch:
--   * einen festen KOPF: Berufs-Icon, Name, aktueller Schritt, Fortschritts-
--     balken (Skill / Maximum, heller Bereich = Ziel des aktuellen Schritts)
--   * einen SCROLLBEREICH mit KARTEN (Schritt, Material, Gebiete, Lehrer,
--     Rezept-Fundort, Forever-Hinweis). Jede Karte hat eine farbige Kante,
--     eine Überschrift und Text; die Material-Karte hat pro Zeile ein Icon.
--   * ein in der Größe ZIEHBARES Fenster (Ecke unten rechts, wird gespeichert)
--
-- Kompatibilität: BerufeSkillGuideFrame.infoTextDisplay bleibt als Objekt mit
-- SetText/GetText erhalten. SetText zeigt eine einfache Textkarte, GetText
-- liefert den kompletten Inhalt als Klartext (für Tests/Debug/Bug-Report).
BSG_Karten = {}
local K = BSG_Karten

-- ----------------------------------------------------------------------------
-- FARBEN
-- ----------------------------------------------------------------------------
K.FENSTER_FARBE = { 0.055, 0.055, 0.07 }
K.AKZENT = {
    schritt = { 0.30, 0.85, 0.40 },
    material = { 0.30, 0.80, 1.00 },
    gebiete = { 0.30, 0.80, 1.00 },
    lehrer = { 1.00, 0.82, 0.00 },
    rezept = { 0.72, 0.55, 1.00 },
    forever = { 1.00, 0.53, 0.00 },
    info = { 0.60, 0.60, 0.65 },
}

local MIN_B, MIN_H, MAX_B, MAX_H = 380, 400, 1000, 1100
local STD_B, STD_H = 440, 560
local KOPF_Y = -80        -- Oberkante des Kopfbereichs (unter Such-Zeile)
local SCROLL_Y = -142     -- Oberkante des Scrollbereichs
local ABSTAND = 8         -- Abstand zwischen Karten
local ZEILE_H = 20        -- Höhe einer Material-Zeile

local function DB()
    BerufeSkillGuideDB = BerufeSkillGuideDB or {}
    return BerufeSkillGuideDB
end

local function Alpha()
    return ((DB().frameAlpha) or 95) / 100
end

-- Klartext ohne WoW-Farbcodes (für Höhenschätzung im Test / Debug)
local function Roh(t) return (t or ""):gsub("|c%x%x%x%x%x%x%x%x", ""):gsub("|r", "") end

-- ----------------------------------------------------------------------------
-- AUFBAU
-- ----------------------------------------------------------------------------
function K.Initialisiere(f)
    if K.Frame or not f then return end
    K.Frame = f

    -- Fenster-Grundfarbe (Options.lua ruft K.SetzeAlpha auf)
    f:SetBackdropColor(K.FENSTER_FARBE[1], K.FENSTER_FARBE[2], K.FENSTER_FARBE[3], Alpha())

    -- Gespeicherte Größe
    local db = DB()
    local b = math.max(MIN_B, math.min(MAX_B, db.fensterBreite or STD_B))
    local h = math.max(MIN_H, math.min(MAX_H, db.fensterHoehe or STD_H))
    f:SetSize(b, h)

    -- ---------------------------------------------------------------- KOPF
    local kopf = CreateFrame("Frame", "BSG_Kopf", f)
    kopf:SetPoint("TOPLEFT", f, "TOPLEFT", 12, KOPF_Y)
    kopf:SetPoint("TOPRIGHT", f, "TOPRIGHT", -12, KOPF_Y)
    kopf:SetHeight(54)
    K.Kopf = kopf

    kopf.iconRand = kopf:CreateTexture(nil, "BACKGROUND")
    kopf.iconRand:SetPoint("TOPLEFT", kopf, "TOPLEFT", 0, 0)
    kopf.iconRand:SetSize(38, 38)
    kopf.iconRand:SetColorTexture(1, 0.82, 0, 0.6)

    kopf.icon = kopf:CreateTexture(nil, "ARTWORK")
    kopf.icon:SetPoint("TOPLEFT", kopf.iconRand, "TOPLEFT", 1, -1)
    kopf.icon:SetSize(36, 36)
    kopf.icon:SetTexCoord(0.07, 0.93, 0.07, 0.93)

    kopf.name = kopf:CreateFontString(nil, "OVERLAY", "GameFontNormalLarge")
    kopf.name:SetPoint("TOPLEFT", kopf.iconRand, "TOPRIGHT", 10, -1)
    kopf.name:SetJustifyH("LEFT")

    kopf.schritt = kopf:CreateFontString(nil, "OVERLAY", "GameFontHighlightSmall")
    kopf.schritt:SetPoint("TOPRIGHT", kopf, "TOPRIGHT", 0, -4)
    kopf.schritt:SetJustifyH("RIGHT")
    kopf.name:SetPoint("RIGHT", kopf.schritt, "LEFT", -8, 0)
    kopf.name:SetWordWrap(false)

    local bar = CreateFrame("StatusBar", "BSG_Kopf_Balken", kopf)
    bar:SetPoint("BOTTOMLEFT", kopf.iconRand, "BOTTOMRIGHT", 10, 1)
    bar:SetPoint("RIGHT", kopf, "RIGHT", 0, 0)
    bar:SetHeight(14)
    bar:SetStatusBarTexture("Interface\\TargetingFrame\\UI-StatusBar")
    bar:SetStatusBarColor(0.95, 0.70, 0.10)
    bar:SetMinMaxValues(0, 300)
    bar:SetValue(0)
    bar.bg = bar:CreateTexture(nil, "BACKGROUND")
    bar.bg:SetAllPoints()
    bar.bg:SetColorTexture(0.15, 0.15, 0.18, 1)
    -- Heller Bereich: vom aktuellen Skill bis zum Ziel des Schritts
    bar.ziel = bar:CreateTexture(nil, "BORDER")
    bar.ziel:SetColorTexture(0.95, 0.70, 0.10, 0.25)
    bar.text = bar:CreateFontString(nil, "OVERLAY", "GameFontHighlightSmall")
    bar.text:SetPoint("CENTER", bar, "CENTER", 0, 0)
    kopf.bar = bar

    local linie = f:CreateTexture(nil, "ARTWORK")
    linie:SetColorTexture(0.25, 0.25, 0.3, 1)
    linie:SetHeight(1)
    linie:SetPoint("TOPLEFT", f, "TOPLEFT", 10, SCROLL_Y + 6)
    linie:SetPoint("TOPRIGHT", f, "TOPRIGHT", -10, SCROLL_Y + 6)

    -- ---------------------------------------------------------- SCROLLBEREICH
    local sf = CreateFrame("ScrollFrame", "BSG_KartenScroll", f, "UIPanelScrollFrameTemplate")
    sf:SetPoint("TOPLEFT", f, "TOPLEFT", 12, SCROLL_Y)
    sf:SetPoint("BOTTOMRIGHT", f, "BOTTOMRIGHT", -32, 18)
    local child = CreateFrame("Frame", "BSG_KartenInhalt", sf)
    child:SetSize(b - 44, 10)
    sf:SetScrollChild(child)
    K.Scroll, K.Inhalt = sf, child

    -- --------------------------------------------------------- GRÖSSE ZIEHEN
    f:SetResizable(true)
    if f.SetResizeBounds then
        f:SetResizeBounds(MIN_B, MIN_H, MAX_B, MAX_H)
    else
        if f.SetMinResize then f:SetMinResize(MIN_B, MIN_H) end
        if f.SetMaxResize then f:SetMaxResize(MAX_B, MAX_H) end
    end
    local griff = CreateFrame("Button", "BSG_GroesseGriff", f)
    griff:SetSize(16, 16)
    griff:SetPoint("BOTTOMRIGHT", f, "BOTTOMRIGHT", -2, 2)
    griff:SetNormalTexture("Interface\\ChatFrame\\UI-ChatIM-SizeGrabber-Up")
    griff:SetHighlightTexture("Interface\\ChatFrame\\UI-ChatIM-SizeGrabber-Highlight")
    griff:SetPushedTexture("Interface\\ChatFrame\\UI-ChatIM-SizeGrabber-Down")
    griff:SetScript("OnMouseDown", function(self, taste)
        if taste == "LeftButton" then f:StartSizing("BOTTOMRIGHT") end
    end)
    griff:SetScript("OnMouseUp", function()
        f:StopMovingOrSizing()
        local db2 = DB()
        db2.fensterBreite = math.floor((f:GetWidth() or STD_B) + 0.5)
        db2.fensterHoehe = math.floor((f:GetHeight() or STD_H) + 0.5)
        K.Layout()
    end)
    griff:SetScript("OnEnter", function(self)
        GameTooltip:SetOwner(self, "ANCHOR_RIGHT")
        GameTooltip:SetText((BSG_Locale and BSG_Locale.RESIZE_TT) or "Ziehen, um die Fenstergröße zu ändern.\nRechtsklick: Standardgröße", 1, 1, 1, 1, true)
        GameTooltip:Show()
    end)
    griff:SetScript("OnLeave", function() GameTooltip:Hide() end)
    griff:RegisterForClicks("RightButtonUp")
    griff:SetScript("OnClick", function() K.Standardgroesse() end)
    K.Griff = griff

    f:HookScript("OnSizeChanged", function() K.Layout() end)

    K.Karten, K.Specs, K.FlachText = {}, {}, ""
    K.ZeigeKopf(nil)
end

function K.Standardgroesse()
    if not K.Frame then return end
    local db = DB()
    db.fensterBreite, db.fensterHoehe = nil, nil
    K.Frame:SetSize(STD_B, STD_H)
    K.Layout()
end

function K.SetzeAlpha(wert)
    if K.Frame then K.Frame:SetBackdropColor(K.FENSTER_FARBE[1], K.FENSTER_FARBE[2], K.FENSTER_FARBE[3], wert / 100) end
end

-- ----------------------------------------------------------------------------
-- KOPF
-- ----------------------------------------------------------------------------
-- info = { beruf, skill, max, von, bis } oder nil (neutraler Kopf)
function K.ZeigeKopf(info, titel)
    local kopf = K.Kopf
    if not kopf then return end
    K.KopfInfo = info
    if not info then
        kopf.icon:SetTexture("Interface\\Icons\\INV_Misc_Book_09")
        kopf.name:SetText(titel or ((BSG_Locale and BSG_Locale.TITLE) or "Berufe Skill Guide"))
        kopf.schritt:SetText("")
        kopf.bar:SetMinMaxValues(0, 1); kopf.bar:SetValue(0)
        kopf.bar.text:SetText("")
        kopf.bar.ziel:Hide()
        return
    end
    kopf.icon:SetTexture(BSG_Berufe.Icon(info.beruf))
    kopf.name:SetText(BSG_Berufe.Anzeigename(info.beruf))
    if info.von and info.bis then
        kopf.schritt:SetText(string.format((BSG_Locale and BSG_Locale.STEP_SHORT) or "Schritt %d-%d", info.von, info.bis))
    else
        kopf.schritt:SetText("")
    end
    kopf.bar:SetMinMaxValues(0, info.max)
    kopf.bar:SetValue(info.skill)
    kopf.bar.text:SetText(string.format("%d / %d", info.skill, info.max))
    K.LayoutKopf()
end

function K.LayoutKopf()
    local info, bar = K.KopfInfo, K.Kopf and K.Kopf.bar
    if not bar then return end
    if not (info and info.bis and info.bis > info.skill) then bar.ziel:Hide(); return end
    local breite = bar:GetWidth() or 0
    if breite <= 0 then bar.ziel:Hide(); return end
    local x1 = breite * info.skill / info.max
    local x2 = breite * math.min(info.bis, info.max) / info.max
    bar.ziel:ClearAllPoints()
    bar.ziel:SetPoint("TOPLEFT", bar, "TOPLEFT", x1, 0)
    bar.ziel:SetPoint("BOTTOMLEFT", bar, "BOTTOMLEFT", x1, 0)
    bar.ziel:SetWidth(math.max(1, x2 - x1))
    bar.ziel:Show()
end

-- ----------------------------------------------------------------------------
-- KARTEN
-- ----------------------------------------------------------------------------
-- spec = {
--   id = "forever",               -- für gespeicherten Einklapp-Zustand
--   art = "schritt"|"material"|..., titel = "...", text = "...",
--   zeilen = { { mat = "Leinenstoff", links = "...", rechts = "..." }, ... },
--   kopfzeile = { links = "...", rechts = "..." },   -- graue Spaltenköpfe
--   einklappbar = true, wegpunkt = true,
-- }
local function HoleKarte(i)
    local karte = K.Karten[i]
    if karte then return karte end
    karte = CreateFrame("Frame", "BSG_Karte" .. i, K.Inhalt, "BackdropTemplate")
    karte:SetBackdrop({
        bgFile = "Interface\\ChatFrame\\ChatFrameBackground",
        edgeFile = "Interface\\ChatFrame\\ChatFrameBackground",
        edgeSize = 1,
    })
    karte:SetBackdropColor(0.11, 0.11, 0.14, 0.95)
    karte:SetBackdropBorderColor(0.20, 0.20, 0.26, 1)

    karte.kante = karte:CreateTexture(nil, "ARTWORK")
    karte.kante:SetPoint("TOPLEFT", karte, "TOPLEFT", 1, -1)
    karte.kante:SetPoint("BOTTOMLEFT", karte, "BOTTOMLEFT", 1, 1)
    karte.kante:SetWidth(3)

    karte.titel = karte:CreateFontString(nil, "OVERLAY", "GameFontNormal")
    karte.titel:SetPoint("TOPLEFT", karte, "TOPLEFT", 12, -8)
    karte.titel:SetJustifyH("LEFT")

    karte.pfeil = karte:CreateFontString(nil, "OVERLAY", "GameFontNormal")
    karte.pfeil:SetPoint("TOPRIGHT", karte, "TOPRIGHT", -10, -8)

    karte.text = karte:CreateFontString(nil, "OVERLAY", "GameFontHighlight")
    karte.text:SetJustifyH("LEFT")
    karte.text:SetJustifyV("TOP")
    karte.text:SetSpacing(3)

    karte.kopfL = karte:CreateFontString(nil, "OVERLAY", "GameFontDisableSmall")
    karte.kopfR = karte:CreateFontString(nil, "OVERLAY", "GameFontDisableSmall")
    karte.kopfR:SetJustifyH("RIGHT")

    -- Klickfläche für einklappbare Karten (nur die Titelzeile)
    karte.klick = CreateFrame("Button", nil, karte)
    karte.klick:SetPoint("TOPLEFT", karte, "TOPLEFT", 0, 0)
    karte.klick:SetPoint("TOPRIGHT", karte, "TOPRIGHT", 0, 0)
    karte.klick:SetHeight(26)
    karte.klick:SetScript("OnClick", function()
        local spec = karte.spec
        if not (spec and spec.einklappbar and spec.id) then return end
        local db = DB()
        db.eingeklappt = db.eingeklappt or {}
        db.eingeklappt[spec.id] = not db.eingeklappt[spec.id]
        K.Layout()
    end)

    karte.zeilen = {}
    K.Karten[i] = karte
    return karte
end

local function HoleZeile(karte, j)
    local z = karte.zeilen[j]
    if z then return z end
    z = {}
    z.links = karte:CreateFontString(nil, "OVERLAY", "GameFontHighlight")
    z.links:SetJustifyH("LEFT")
    z.links:SetWordWrap(false)
    z.rechts = karte:CreateFontString(nil, "OVERLAY", "GameFontHighlight")
    z.rechts:SetJustifyH("RIGHT")
    karte.zeilen[j] = z
    return z
end

local function IstZu(spec)
    local db = DB()
    return spec.einklappbar and spec.id and db.eingeklappt and db.eingeklappt[spec.id]
end

-- Baut alle Karten neu aus einer Liste von Specs
function K.Zeige(specs)
    if not K.Inhalt then return end
    K.Specs = specs or {}
    local teile = {}
    for _, s in ipairs(K.Specs) do
        if s.titel then teile[#teile + 1] = s.titel end
        if s.kopfzeile then teile[#teile + 1] = (s.kopfzeile.links or "") .. " " .. (s.kopfzeile.rechts or "") end
        for _, z in ipairs(s.zeilen or {}) do teile[#teile + 1] = (z.links or "") .. " " .. (z.rechts or "") end
        if s.text and s.text ~= "" then teile[#teile + 1] = s.text end
    end
    K.FlachText = (K.KopfText or "") .. table.concat(teile, "\n")
    if BSG_MatIcons and BSG_MatIcons.InitialisiereIcon then BSG_MatIcons.InitialisiereIcon() end
    -- Nur bei neuem Beruf/Schritt nach oben scrollen - nicht bei reinen
    -- Aktualisierungen (z.B. Rezeptfarbe oder Bestand ändert sich).
    local schluessel = (K.KopfText or "") .. ((K.Specs[1] and K.Specs[1].titel) or "")
    if schluessel ~= K.LetzterSchluessel and K.Scroll and K.Scroll.SetVerticalScroll then
        K.Scroll:SetVerticalScroll(0)
    end
    K.LetzterSchluessel = schluessel
    K.Layout()
end

function K.Layout()
    if not K.Inhalt or not K.Specs then return end
    local f = K.Frame
    local breite = ((f and f:GetWidth()) or STD_B) - 44
    K.Inhalt:SetWidth(breite)
    K.LayoutKopf()

    local y, iconNr = 0, 1
    local wegpunktKarte = nil
    for i, spec in ipairs(K.Specs) do
        local karte = HoleKarte(i)
        karte.spec = spec
        local farbe = K.AKZENT[spec.art or "info"] or K.AKZENT.info
        karte.kante:SetColorTexture(farbe[1], farbe[2], farbe[3], 1)
        karte:ClearAllPoints()
        karte:SetPoint("TOPLEFT", K.Inhalt, "TOPLEFT", 0, -y)
        karte:SetWidth(breite)

        local zu = IstZu(spec)
        local h = 8
        if spec.titel then
            karte.titel:SetText(spec.titel)
            karte.titel:SetTextColor(farbe[1], farbe[2], farbe[3])
            karte.titel:SetWidth(breite - (spec.wegpunkt and 120 or 40))
            karte.titel:Show()
            h = h + math.max(14, karte.titel:GetStringHeight() or 14) + 6
        else
            karte.titel:Hide()
        end
        karte.pfeil:SetText(spec.einklappbar and (zu and "+" or "-") or "")
        karte.klick:SetShown(spec.einklappbar and true or false)

        -- Spaltenköpfe
        if spec.kopfzeile and not zu then
            karte.kopfL:ClearAllPoints(); karte.kopfR:ClearAllPoints()
            karte.kopfL:SetPoint("TOPLEFT", karte, "TOPLEFT", 12, -h)
            karte.kopfR:SetPoint("TOPRIGHT", karte, "TOPRIGHT", -12, -h)
            karte.kopfL:SetText(spec.kopfzeile.links or ""); karte.kopfR:SetText(spec.kopfzeile.rechts or "")
            karte.kopfL:Show(); karte.kopfR:Show()
            h = h + 16
        else
            karte.kopfL:Hide(); karte.kopfR:Hide()
        end

        -- Material-Zeilen mit Icon
        local zeilen = (not zu) and spec.zeilen or {}
        for j, zd in ipairs(zeilen) do
            local z = HoleZeile(karte, j)
            local xText = 12
            if zd.mat and BSG_MatIcons and BSG_MatIcons.HoleIcon then
                local icon = BSG_MatIcons.HoleIcon(iconNr, karte, zd.mat)
                iconNr = iconNr + 1
                icon:ClearAllPoints()
                icon:SetPoint("TOPLEFT", karte, "TOPLEFT", 12, -(h + 1))
                xText = 34
            end
            z.links:ClearAllPoints(); z.rechts:ClearAllPoints()
            z.rechts:SetPoint("TOPRIGHT", karte, "TOPRIGHT", -12, -(h + 3))
            z.links:SetPoint("TOPLEFT", karte, "TOPLEFT", xText, -(h + 3))
            z.links:SetPoint("RIGHT", z.rechts, "LEFT", -8, 0)
            z.links:SetText(zd.links or ""); z.rechts:SetText(zd.rechts or "")
            z.links:Show(); z.rechts:Show()
            h = h + ZEILE_H
        end
        for j = #zeilen + 1, #karte.zeilen do
            karte.zeilen[j].links:Hide(); karte.zeilen[j].rechts:Hide()
        end
        if #zeilen > 0 then h = h + 4 end

        -- Fließtext
        if spec.text and spec.text ~= "" and not zu then
            karte.text:ClearAllPoints()
            karte.text:SetPoint("TOPLEFT", karte, "TOPLEFT", 12, -h)
            karte.text:SetWidth(breite - 24)
            karte.text:SetText(spec.text)
            karte.text:Show()
            local th = karte.text:GetStringHeight()
            if not th or th <= 0 then
                -- Schätzung, falls der Client die Höhe noch nicht kennt
                local zeilenAnz = 0
                for zeile in (Roh(spec.text) .. "\n"):gmatch("(.-)\n") do
                    zeilenAnz = zeilenAnz + math.max(1, math.ceil(#zeile * 6.5 / math.max(100, breite - 24)))
                end
                th = zeilenAnz * 15
            end
            h = h + th + 4
        else
            karte.text:Hide()
        end

        h = h + 8
        karte:SetHeight(h)
        karte:Show()
        if spec.wegpunkt then wegpunktKarte = karte end
        y = y + h + ABSTAND
    end
    for i = #K.Specs + 1, #K.Karten do K.Karten[i]:Hide() end
    K.Inhalt:SetHeight(math.max(1, y))

    -- Wegpunkt-Button in die passende Karte (oben rechts) setzen
    local btn = BSG_Wegpunkt and BSG_Wegpunkt.HoleButton and BSG_Wegpunkt.HoleButton()
    if btn then
        local ziel = wegpunktKarte or K.Karten[#K.Specs]
        if ziel and #K.Specs > 0 then
            btn:SetParent(ziel)
            btn:ClearAllPoints()
            btn:SetPoint("TOPRIGHT", ziel, "TOPRIGHT", -6, -4)
            btn:SetSize(96, 20)
            btn:SetFrameLevel((ziel:GetFrameLevel() or 1) + 5)
        end
        if BSG_Wegpunkt.Ziel then btn:Show() else btn:Hide() end
    end
end

-- ----------------------------------------------------------------------------
-- EINFACHER TEXT (Kompatibilität: infoTextDisplay:SetText)
-- ----------------------------------------------------------------------------
function K.ZeigeText(text, titel, art)
    K.ZeigeKopf(nil)
    K.KopfText = ""
    K.Zeige({ { art = art or "info", titel = titel, text = text } })
end

-- Objekt, das sich wie der alte FontString verhält
function K.ErstelleTextShim()
    return {
        SetText = function(self, t) K.ZeigeText(t or "") end,
        GetText = function(self) return K.FlachText or "" end,
        Show = function() end, Hide = function() end,
        SetPoint = function() end, ClearAllPoints = function() end,
        SetWidth = function() end, SetJustifyH = function() end, SetSpacing = function() end,
    }
end
