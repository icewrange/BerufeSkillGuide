-- ============================================================================
-- MODUL: SIDEBAR - VERTICAL PROFESSION SWITCHER V4.5 (MERGED: HITBOX + PERF)
-- ============================================================================
-- Diese Datei ersetzt sowohl die alte "Sidebar.lua" (Performance-Fix) als
-- auch "BerufeSkillGuide.lua" (Hitbox/Strata-Fix). Beide Dateien definierten
-- dasselbe globale Modul BSG_Sidebar mit denselben Frame-Namen - je nach
-- Ladereihenfolge im .toc hat eine Version die andere überschrieben, ohne
-- Fehlermeldung. NUR DIESE DATEI SOLLTE IM .toc STEHEN.
--
-- Zusammengeführte Änderungen:
--   * FIX (Hitbox/Interaktion, aus BerufeSkillGuide.lua V4.4):
--       - bgFrame/tBtn/Buttons auf Strata "DIALOG" angehoben, damit die
--         Sidebar zuverlässig klickbar über dem Hauptfenster liegt.
--       - Unsichtbare Hit-Textur auf bgFrame, um Klicks im Hintergrund
--         sicher abzufangen.
--       - btn:RegisterForClicks("LeftButtonUp") für präzisere Klick-
--         Registrierung.
--   * FIX (Performance, aus Sidebar.lua V4.4):
--       - OnUpdate-Handler gedrosselt (nicht mehr jeden Frame, sondern alle
--         UPDATE_INTERVAL Sekunden).
-- ============================================================================

if not _G["BSG_Sidebar"] then
    _G["BSG_Sidebar"] = {}
end

local BSG_Sidebar = _G["BSG_Sidebar"]

BSG_Sidebar.Buttons = BSG_Sidebar.Buttons or {}
BSG_Sidebar.IstAusgeklappt = true
-- NEU: Filter-Zustand für den "Nur gelernte Berufe"-Toggle.
BSG_Sidebar.NurGelernteAnzeigen = false

-- Wie oft (in Sekunden) die Sidebar-Position neu berechnet wird.
local UPDATE_INTERVAL = 0.1

-- ============================================================================
-- BERUFE
-- ============================================================================

local berufsListe = {
    { name = "Alchimie",          icon = "interface\\icons\\trade_alchemy" },
    { name = "Schmiedekunst",     icon = "interface\\icons\\trade_blacksmithing" },
    { name = "Ingenieurskunst",   icon = "interface\\icons\\trade_engineering" },
    { name = "Lederverarbeitung", icon = "interface\\icons\\trade_leatherworking" },
    { name = "Schneidern",        icon = "interface\\icons\\trade_tailoring" },
    { name = "Verzauberkunst",    icon = "interface\\icons\\spell_nature_lightning" },
    { name = "Kochkunst",         icon = "interface\\icons\\inv_misc_food_15" }
}

-- ============================================================================
-- ECHTER SKILL & "GELERNT"-PRÜFUNG ÜBER GetSkillLineInfo (NICHT IsSpellKnown)
-- ============================================================================
-- FIX: Nutzte vorher BSG_API.GetGelernteBerufe() (IsSpellKnown-basiert) für
-- sowohl die "Nur gelernte"-Filterung als auch den beim Sidebar-Klick
-- angezeigten echten Skill. Das führte dazu, dass beim Klicken zwischen
-- Berufen und zurück auf einen bereits erlernten Beruf (z.B. Alchimie mit
-- Skill 212) plötzlich wieder Skill 1 angezeigt wurde - die IsSpellKnown-
-- Abfrage erkannte den erlernten Beruf offenbar nicht zuverlässig.
-- ScanneCharakterBerufe() in Search.lua nutzt für den automatischen Scan
-- beim Login bereits erfolgreich GetSkillLineInfo() (Namens-Abgleich statt
-- Spell-ID). Hier wird jetzt exakt dieselbe, bewährte Methode verwendet.
local function ErmittleEchtenSkill(berufName)
    for i = 1, GetNumSkillLines() do
        local sName, _, _, sRank = GetSkillLineInfo(i)
        if not sName then break end
        if sName == berufName or (berufName == "Alchimie" and sName == "Alchemie") then
            return sRank or 1
        end
    end
    return nil
end

local function IstBerufGelernt(berufName)
    return ErmittleEchtenSkill(berufName) ~= nil
end

-- Wendet sowohl den Ein-/Ausklapp-Zustand als auch den "Nur gelernte"-Filter
-- auf alle Berufs-Buttons an. Zentrale Stelle, damit ToggleLeiste() und der
-- Filter-Button dieselbe Logik benutzen.
function BSG_Sidebar.AktualisiereButtonSichtbarkeit()
    for berufName, btn in pairs(BSG_Sidebar.Buttons) do
        if not BSG_Sidebar.IstAusgeklappt then
            btn:Hide()
        elseif BSG_Sidebar.NurGelernteAnzeigen and not IstBerufGelernt(berufName) then
            btn:Hide()
        else
            btn:Show()
        end
    end
end

-- ============================================================================
-- SIDEBAR EIN-/AUSKLAPPEN
-- ============================================================================

function BSG_Sidebar.ToggleLeiste()
    BSG_Sidebar.IstAusgeklappt = not BSG_Sidebar.IstAusgeklappt

    if BSG_Sidebar.ToggleButton and BSG_Sidebar.ToggleButton.text then
        BSG_Sidebar.ToggleButton.text:SetText(
            BSG_Sidebar.IstAusgeklappt and ">" or "<"
        )
    end

    if BSG_Sidebar.Hintergrund then
        if BSG_Sidebar.IstAusgeklappt then
            BSG_Sidebar.Hintergrund:Show()
        else
            BSG_Sidebar.Hintergrund:Hide()
        end
    end

    -- FIX/NEU: Nutzt jetzt die zentrale Sichtbarkeits-Funktion, damit der
    -- "Nur gelernte"-Filter auch beim Ein-/Ausklappen erhalten bleibt
    -- (vorher wurden hier alle Buttons pauschal gezeigt, unabhängig vom
    -- Filter-Zustand).
    BSG_Sidebar.AktualisiereButtonSichtbarkeit()
end

-- ============================================================================
-- SIDEBAR INITIALISIEREN
-- ============================================================================

function BSG_Sidebar.InitialisiereSidebar(mainFrame)

    if not mainFrame or BSG_Sidebar.LeisteErstellt then
        return
    end

    BSG_Sidebar.Buttons = {}

    -- ========================================================================
    -- 1. HINTERGRUND DER SIDEBAR (Mit physischer Mauserkennung)
    -- ========================================================================

    local bgFrame = CreateFrame(
        "Frame",
        "BSG_Sidebar_Background",
        UIParent,
        "BackdropTemplate"
    )

    -- Höhe vergrößert: Platz für Filter-Button oben + jetzt 7 statt 6
    -- Berufs-Icons (Kochkunst neu hinzugekommen).
    bgFrame:SetSize(40, 300)

    bgFrame:SetBackdrop({
        bgFile = "Interface\\ChatFrame\\ChatFrameBackground",
        edgeFile = "Interface\\ChatFrame\\ChatFrameBackground",
        edgeSize = 1
    })

    bgFrame:SetBackdropColor(0.05, 0.05, 0.07, 0.95)
    bgFrame:SetBackdropBorderColor(0.18, 0.18, 0.22, 1)

    -- Hohe Schichtung + Mauseingabe erzwingen, damit die Sidebar zuverlässig
    -- über dem Hauptfenster liegt und klickbar bleibt.
    bgFrame:SetFrameStrata("DIALOG")
    bgFrame:SetFrameLevel(150)
    bgFrame:EnableMouse(true)

    -- Unsichtbare Hintergrundtextur, um Klicks physikalisch abzufangen.
    local hitBoxTex = bgFrame:CreateTexture(nil, "BACKGROUND")
    hitBoxTex:SetAllPoints(bgFrame)
    hitBoxTex:SetColorTexture(0.05, 0.05, 0.07, 0.01)

    BSG_Sidebar.Hintergrund = bgFrame

    -- ========================================================================
    -- 2. TOGGLE-BUTTON
    -- ========================================================================

    local tBtn = CreateFrame(
        "Button",
        "BSG_Sidebar_ToggleBtn",
        UIParent,
        "BackdropTemplate"
    )

    tBtn:SetSize(16, 26)

    tBtn:SetBackdrop({
        bgFile = "Interface\\ChatFrame\\ChatFrameBackground",
        edgeFile = "Interface\\ChatFrame\\ChatFrameBackground",
        edgeSize = 1
    })

    tBtn:SetBackdropColor(0.12, 0.12, 0.15, 1)
    tBtn:SetBackdropBorderColor(0.22, 0.22, 0.26, 1)
    tBtn:SetFrameStrata("DIALOG")
    tBtn:SetFrameLevel(160)
    tBtn:EnableMouse(true)

    tBtn.text = tBtn:CreateFontString(nil, "OVERLAY", "GameFontNormalSmall")
    tBtn.text:SetPoint("CENTER", 0, 0)
    tBtn.text:SetText(">")
    tBtn.text:SetTextColor(0.8, 0.8, 0.8)

    tBtn:SetScript("OnEnter", function(self)
        self:SetBackdropBorderColor(1, 0.82, 0, 1)
        self.text:SetTextColor(1, 1, 1)
    end)

    tBtn:SetScript("OnLeave", function(self)
        self:SetBackdropBorderColor(0.22, 0.22, 0.26, 1)
        self.text:SetTextColor(0.8, 0.8, 0.8)
    end)

    tBtn:SetScript("OnClick", function()
        BSG_Sidebar.ToggleLeiste()
    end)

    BSG_Sidebar.ToggleButton = tBtn

    -- ========================================================================
    -- NEU: FILTER-BUTTON - "Alle" vs. "Gelernt" (nur tatsächlich erlernte
    -- Berufe anzeigen, via BSG_API.GetGelernteBerufe(), nicht die manuell
    -- per Sidebar-Klick angezeigten)
    -- ========================================================================

    local filterBtn = CreateFrame(
        "Button",
        "BSG_Sidebar_FilterBtn",
        bgFrame,
        "BackdropTemplate"
    )

    filterBtn:SetSize(32, 20)
    filterBtn:SetPoint("TOPLEFT", bgFrame, "TOPLEFT", 4, -4)
    filterBtn:SetFrameStrata("DIALOG")
    filterBtn:SetFrameLevel(bgFrame:GetFrameLevel() + 5)
    filterBtn:EnableMouse(true)
    filterBtn:RegisterForClicks("LeftButtonUp")

    filterBtn:SetBackdrop({
        bgFile = "Interface\\ChatFrame\\ChatFrameBackground",
        edgeFile = "Interface\\ChatFrame\\ChatFrameBackground",
        edgeSize = 1
    })
    filterBtn:SetBackdropColor(0.12, 0.12, 0.15, 1)
    filterBtn:SetBackdropBorderColor(0.22, 0.22, 0.26, 1)

    filterBtn.text = filterBtn:CreateFontString(nil, "OVERLAY", "GameFontNormalSmall")
    filterBtn.text:SetPoint("CENTER", 0, 0)
    filterBtn.text:SetText("Alle")
    filterBtn.text:SetTextColor(0.8, 0.8, 0.8)

    filterBtn:SetScript("OnEnter", function(self)
        self:SetBackdropBorderColor(1, 0.82, 0, 1)
        GameTooltip:SetOwner(self, "ANCHOR_RIGHT")
        if BSG_Sidebar.NurGelernteAnzeigen then
            GameTooltip:SetText("Zeigt nur erlernte Berufe.\nKlicken, um alle 6 Berufe zu zeigen.", 1, 1, 1)
        else
            GameTooltip:SetText("Zeigt alle 6 Berufe.\nKlicken, um nur erlernte Berufe zu zeigen.", 1, 1, 1)
        end
        GameTooltip:Show()
    end)
    filterBtn:SetScript("OnLeave", function(self)
        self:SetBackdropBorderColor(0.22, 0.22, 0.26, 1)
        GameTooltip:Hide()
    end)

    filterBtn:SetScript("OnClick", function(self)
        BSG_Sidebar.NurGelernteAnzeigen = not BSG_Sidebar.NurGelernteAnzeigen
        self.text:SetText(BSG_Sidebar.NurGelernteAnzeigen and "Gelernt" or "Alle")
        BSG_Sidebar.AktualisiereButtonSichtbarkeit()
    end)

    BSG_Sidebar.FilterButton = filterBtn

    -- ========================================================================
    -- MAGNET-LOGIK: Heftet die Sidebar an das Hauptfenster an
    -- ========================================================================

    local function PositioniereSidebar()
        bgFrame:ClearAllPoints()
        bgFrame:SetPoint("TOPLEFT", mainFrame, "TOPRIGHT", 2, -64)

        tBtn:ClearAllPoints()
        tBtn:SetPoint("TOPLEFT", mainFrame, "TOPRIGHT", 2, -38)

        if BSG_Sidebar.IstAusgeklappt then bgFrame:Show() else bgFrame:Hide() end
        tBtn:Show()
    end

    local function UpdateSidebarPosition()
        if mainFrame:IsVisible() then
            PositioniereSidebar()
        else
            bgFrame:Hide()
            tBtn:Hide()
        end
    end

    -- FIX (Performance): OnUpdate gedrosselt statt bei jedem einzelnen Frame.
    local updateTimer = 0
    mainFrame:HookScript("OnUpdate", function(self, elapsed)
        updateTimer = updateTimer + (elapsed or 0)
        if updateTimer < UPDATE_INTERVAL then
            return
        end
        updateTimer = 0
        UpdateSidebarPosition()
    end)

    -- Beim Ein-/Ausblenden sofort reagieren, ohne auf den nächsten
    -- gedrosselten Tick zu warten.
    mainFrame:HookScript("OnShow", UpdateSidebarPosition)
    mainFrame:HookScript("OnHide", UpdateSidebarPosition)

    -- ========================================================================
    -- 3. POSITIONEN DER BERUFSBUTTONS
    -- ========================================================================

    -- startY nach unten verschoben (-6 -> -30), damit Platz für den neuen
    -- Filter-Button oben in der Leiste bleibt.
    local startX = 4
    local startY = -30
    local abstandY = 38

    -- ========================================================================
    -- 4. BERUFSBUTTONS SCHLEIFE
    -- ========================================================================

    for index, beruf in ipairs(berufsListe) do

        local btn = CreateFrame(
            "Button",
            "BSG_Sidebar_Btn_" .. beruf.name,
            bgFrame,
            "BackdropTemplate"
        )

        btn:SetSize(32, 32)
        btn:SetPoint(
            "TOPLEFT",
            bgFrame,
            "TOPLEFT",
            startX,
            startY - ((index - 1) * abstandY)
        )

        -- Buttons ebenfalls auf DIALOG-Strata, damit sie über allem liegen.
        btn:SetFrameStrata("DIALOG")
        btn:SetFrameLevel(bgFrame:GetFrameLevel() + 5)
        btn:EnableMouse(true)
        btn:RegisterForClicks("LeftButtonUp")

        -- ICON TEXTUR
        btn.texture = btn:CreateTexture(nil, "OVERLAY")
        btn.texture:SetTexture(beruf.icon)
        btn.texture:SetAllPoints(btn)
        btn.texture:SetTexCoord(0.07, 0.93, 0.07, 0.93)

        btn:SetBackdrop({
            bgFile = "Interface\\ChatFrame\\ChatFrameBackground",
            edgeFile = "Interface\\ChatFrame\\ChatFrameBackground",
            edgeSize = 1
        })
        btn:SetBackdropColor(0, 0, 0, 0.01)
        btn:SetBackdropBorderColor(0.2, 0.2, 0.25, 1)

        -- MOUSEOVER
        btn:SetScript("OnEnter", function(self)
            self:SetBackdropBorderColor(1, 0.82, 0, 1)
            GameTooltip:SetOwner(self, "ANCHOR_RIGHT")
            GameTooltip:SetText(beruf.name, 1, 1, 1)
            GameTooltip:Show()
        end)

        btn:SetScript("OnLeave", function(self)
            if mainFrame.aktuellAusgewaehlterBeruf == beruf.name then
                self:SetBackdropBorderColor(1, 0.82, 0, 1)
            else
                self:SetBackdropBorderColor(0.2, 0.2, 0.25, 1)
            end
            GameTooltip:Hide()
        end)

        -- BUTTON-KLICK
        btn:SetScript("OnClick", function(self)
            mainFrame.aktuellAusgewaehlterBeruf = beruf.name

            for _, alterBtn in pairs(BSG_Sidebar.Buttons) do
                alterBtn:SetBackdropBorderColor(0.2, 0.2, 0.25, 1)
            end

            self:SetBackdropBorderColor(1, 0.82, 0, 1)

            -- FIX: Nutzt jetzt ErmittleEchtenSkill (GetSkillLineInfo-Scan)
            -- statt der fragilen IsSpellKnown-basierten BSG_API-Abfrage.
            local aktuellerSkill = ErmittleEchtenSkill(beruf.name) or 1

            if BSG_Sidebar.SkillInputBox then
                BSG_Sidebar.SkillInputBox:SetText(aktuellerSkill)
            end

            if _G["BSG_Search"] and _G["BSG_Search"].BerechneMaterialBedarf then
                _G["BSG_Search"].BerechneMaterialBedarf(beruf.name, aktuellerSkill)
            end
            -- FIX: Hier stand vorher zusätzlich ein Aufruf von
            -- BSG_Search.ScanneCharakterBerufe(). Das liest den ECHTEN,
            -- tatsächlich erlernten Beruf des Charakters aus und hat damit
            -- die Zeile direkt darüber (den geklickten Beruf) sofort wieder
            -- überschrieben - ein Klick auf einen Beruf, den der Charakter
            -- nicht gelernt hat, zeigte dadurch nie etwas an. Klicks auf
            -- die Sidebar sollen den geklickten Beruf anzeigen, nicht den
            -- echten Charakter-Beruf erneut erzwingen.
        end)

        btn:Show()
        BSG_Sidebar.Buttons[beruf.name] = btn
    end

    BSG_Sidebar.LeisteErstellt = true
    UpdateSidebarPosition()
    BSG_Sidebar.AktualisiereButtonSichtbarkeit()
end
