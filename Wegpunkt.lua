-- ============================================================================
-- MODUL: WEGPUNKT - LEHRER / FUNDORT PER KLICK ANSTEUERN V1.0
-- ============================================================================
-- Unten links im Guide-Fenster erscheint ein "Wegpunkt"-Button, sobald der
-- angezeigte Lehrer oder Rezept-Fundort Koordinaten hat.
--   1. TomTom installiert  -> TomTom-Pfeil + Karten-/Minimap-Markierung
--   2. sonst               -> Blizzard-Kartenmarkierung (Map Pin), falls der
--                             Client sie unterstützt
--   3. sonst               -> Koordinaten im Chat (für /way)
--
-- Datenquellen:
--   Lehrer   (BerufeLehrerDB):   allianzZone/allianzX/allianzY,
--                                hordeZone/hordeX/hordeY
--   Fundorte (BerufeFundorteDB): "<Name>_Zone"/"_X"/"_Y"      (beide Fraktionen)
--                                "<Name>_AZone"/"_AX"/"_AY"   (nur Allianz)
--                                "<Name>_HZone"/"_HX"/"_HY"   (nur Horde)
-- Zone = uiMapID, X/Y in Prozent (wie /way).

BSG_Wegpunkt = BSG_Wegpunkt or {}
local W = BSG_Wegpunkt

local function L(key, fallback)
    return (BSG_Locale and BSG_Locale[key]) or fallback
end

local function IstHorde()
    return UnitFactionGroup and UnitFactionGroup("player") == "Horde"
end

W.Ziel = nil  -- { zone =, x =, y =, titel = }

-- ----------------------------------------------------------------------------
-- EIGENE KARTEN-MARKIERUNG (Stern auf der Weltkarte)
-- ----------------------------------------------------------------------------
-- Ein Stern-Symbol auf der Leinwand der Weltkarte. Er ist nur sichtbar,
-- solange genau die Karte des Ziels angezeigt wird. Rechtsklick auf den Stern
-- entfernt die Markierung wieder.
local pin, pinZiel
local function AktualisierePin()
    if not pin or not pinZiel or not WorldMapFrame then return end
    local aktuelleKarte = WorldMapFrame.GetMapID and WorldMapFrame:GetMapID()
    if WorldMapFrame:IsShown() and aktuelleKarte == pinZiel.zone then
        local canvas = WorldMapFrame:GetCanvas()
        local b, h = canvas:GetWidth(), canvas:GetHeight()
        if b and h and b > 0 and h > 0 then
            local groesse = math.max(24, b * 0.025)
            pin:SetSize(groesse, groesse)
            pin:ClearAllPoints()
            pin:SetPoint("CENTER", canvas, "TOPLEFT", pinZiel.x / 100 * b, -pinZiel.y / 100 * h)
            pin:Show()
            return
        end
    end
    pin:Hide()
end

function W.ZeigeKartenPin(zone, x, y, titel)
    if not (WorldMapFrame and WorldMapFrame.GetCanvas and WorldMapFrame.SetMapID) then return false end
    local canvas = WorldMapFrame:GetCanvas()
    if not canvas then return false end

    if not pin then
        pin = CreateFrame("Button", "BSG_KartenPin", canvas)
        -- Strata vom Kartenfenster erben (nicht fest setzen, sonst könnte der
        -- Stern je nach Client unter der Karte liegen), nur Ebene anheben.
        pin:SetFrameLevel((canvas:GetFrameLevel() or 1) + 100)
        pin.tex = pin:CreateTexture(nil, "OVERLAY")
        pin.tex:SetAllPoints(pin)
        pin.tex:SetTexture("Interface\\TargetingFrame\\UI-RaidTargetingIcon_1") -- gelber Stern
        pin:RegisterForClicks("RightButtonUp")
        pin:SetScript("OnClick", function() pinZiel = nil; pin:Hide() end)
        pin:SetScript("OnEnter", function(self)
            if not pinZiel then return end
            GameTooltip:SetOwner(self, "ANCHOR_RIGHT")
            GameTooltip:SetText(pinZiel.titel or "Berufe Skill Guide", 1, 0.82, 0)
            GameTooltip:AddLine(string.format("%.1f, %.1f", pinZiel.x, pinZiel.y), 1, 1, 1)
            GameTooltip:AddLine(L("WAYPOINT_PIN_TT", "Rechtsklick: Markierung entfernen"), 0.7, 0.7, 0.7)
            GameTooltip:Show()
        end)
        pin:SetScript("OnLeave", function() GameTooltip:Hide() end)
        -- Position/Sichtbarkeit laufend an die angezeigte Karte anpassen
        local takt = 0
        local watcher = CreateFrame("Frame", nil, WorldMapFrame)
        watcher:SetScript("OnUpdate", function(_, el)
            takt = takt + (el or 0)
            if takt < 0.1 then return end
            takt = 0
            AktualisierePin()
        end)
    end

    pinZiel = { zone = zone, x = x, y = y, titel = titel }

    -- Karte öffnen und aufs Zielgebiet stellen (im Kampf gesperrt)
    if not (InCombatLockdown and InCombatLockdown()) then
        if not WorldMapFrame:IsShown() then
            if ToggleWorldMap then pcall(ToggleWorldMap) elseif ShowUIPanel then pcall(ShowUIPanel, WorldMapFrame) end
        end
        pcall(WorldMapFrame.SetMapID, WorldMapFrame, zone)
    end
    AktualisierePin()
    return true
end

-- ----------------------------------------------------------------------------
-- WEGPUNKT SETZEN
-- ----------------------------------------------------------------------------
function W.Setze(zone, x, y, titel)
    if not zone or not x or not y then return false end
    titel = titel or "Berufe Skill Guide"
    local ortText = string.format("%s (%.1f, %.1f)", titel, x, y)

    -- 1. TomTom
    if TomTom and TomTom.AddWaypoint then
        local ok = pcall(TomTom.AddWaypoint, TomTom, zone, x / 100, y / 100, {
            title = titel, persistent = false, minimap = true, world = true, from = "BerufeSkillGuide",
        })
        if ok then
            print("|cff00ff00[BSG]:|r " .. L("WAYPOINT_SET", "Wegpunkt gesetzt:") .. " " .. ortText .. " |cff888888(TomTom)|r")
            return true
        end
    end

    -- 2. Blizzard-Kartenmarkierung
    if C_Map and C_Map.SetUserWaypoint and UiMapPoint and UiMapPoint.CreateFromCoordinates then
        local erlaubt = true
        if C_Map.CanSetUserWaypointOnMap then
            local okC, res = pcall(C_Map.CanSetUserWaypointOnMap, zone)
            erlaubt = okC and res
        end
        if erlaubt then
            local ok = pcall(function()
                C_Map.SetUserWaypoint(UiMapPoint.CreateFromCoordinates(zone, x / 100, y / 100))
                if C_SuperTrack and C_SuperTrack.SetSuperTrackedUserWaypoint then
                    C_SuperTrack.SetSuperTrackedUserWaypoint(true)
                end
            end)
            if ok then
                print("|cff00ff00[BSG]:|r " .. L("WAYPOINT_SET", "Wegpunkt gesetzt:") .. " " .. ortText .. " |cff888888(Karte)|r")
                return true
            end
        end
    end

    -- 3. NEU (v2.1): Eigene Markierung auf der Weltkarte. Im Spiel-Test hat
    -- Classic Era weder TomTom noch eine Blizzard-Kartenmarkierung gesetzt
    -- (z.B. auf Stadtkarten wie Eisenschmiede nicht erlaubt) - deshalb öffnen
    -- wir die Karte selbst im richtigen Gebiet und setzen einen Stern.
    if W.ZeigeKartenPin(zone, x, y, titel) then
        print("|cff00ff00[BSG]:|r " .. L("WAYPOINT_SET", "Wegpunkt gesetzt:") .. " " .. ortText .. " |cff888888(" .. L("WAYPOINT_MAP", "Stern auf der Weltkarte") .. ")|r")
        return true
    end

    -- 4. Nur Chat-Ausgabe
    print("|cffffd100[BSG]:|r " .. ortText .. "  |cff888888/way " .. string.format("%.1f %.1f", x, y) .. "|r")
    return false
end

-- ----------------------------------------------------------------------------
-- ZIEL AUS DEN DATEN ERMITTELN
-- ----------------------------------------------------------------------------
function W.LoescheZiel()
    W.Ziel = nil
    W.AktualisiereButton()
end

function W.SetzeZielAusLehrer(eintrag, beruf)
    W.Ziel = nil
    if eintrag then
        local zone, x, y
        if IstHorde() then
            zone, x, y = eintrag.hordeZone, eintrag.hordeX, eintrag.hordeY
        else
            zone, x, y = eintrag.allianzZone, eintrag.allianzX, eintrag.allianzY
        end
        if zone and x and y then
            W.Ziel = { zone = zone, x = x, y = y, titel = (beruf or "") .. " - " .. (eintrag.stufe or "") }
        end
    end
    W.AktualisiereButton()
end

function W.SetzeZielAusFundort(name)
    W.Ziel = nil
    local db = BerufeFundorteDB
    if db and name then
        local praefix = IstHorde() and "_H" or "_A"
        local zone = db[name .. praefix .. "Zone"] or db[name .. "_Zone"]
        local x    = db[name .. praefix .. "X"]    or db[name .. "_X"]
        local y    = db[name .. praefix .. "Y"]    or db[name .. "_Y"]
        if type(zone) == "number" and type(x) == "number" and type(y) == "number" then
            W.Ziel = { zone = zone, x = x, y = y, titel = name }
        end
    end
    W.AktualisiereButton()
end

-- ----------------------------------------------------------------------------
-- BUTTON IM GUIDE-FENSTER
-- ----------------------------------------------------------------------------
local function ErstelleButton()
    local f = BerufeSkillGuideFrame
    if W.Button or not f then return W.Button end

    local btn = CreateFrame("Button", "BSG_WegpunktButton", f, "UIPanelButtonTemplate")
    btn:SetSize(96, 22)
    btn:SetPoint("BOTTOMLEFT", f, "BOTTOMLEFT", 12, 10)
    btn:SetText(L("WAYPOINT", "Wegpunkt"))

    btn:SetScript("OnClick", function()
        if W.Ziel then
            W.Setze(W.Ziel.zone, W.Ziel.x, W.Ziel.y, W.Ziel.titel)
        else
            print("|cffff5500[BSG]:|r " .. L("WAYPOINT_NONE", "Für diesen Eintrag sind (noch) keine Koordinaten hinterlegt."))
        end
    end)
    btn:SetScript("OnEnter", function(self)
        GameTooltip:SetOwner(self, "ANCHOR_TOP")
        GameTooltip:SetText(L("WAYPOINT", "Wegpunkt"), 1, 1, 1)
        if W.Ziel then
            GameTooltip:AddLine(string.format("%s (%.1f, %.1f)", W.Ziel.titel, W.Ziel.x, W.Ziel.y), 1, 0.82, 0, true)
        end
        GameTooltip:AddLine(L("WAYPOINT_TT", "Setzt einen Wegpunkt zum angezeigten Lehrer / Fundort."), 0.8, 0.8, 0.8, true)
        GameTooltip:Show()
    end)
    btn:SetScript("OnLeave", function() GameTooltip:Hide() end)
    btn:Hide()

    W.Button = btn
    return btn
end

-- Für das Karten-Layout (UI/Karten.lua): setzt den Button in die Karte des
-- Lehrers bzw. Rezept-Fundorts.
function W.HoleButton()
    return W.Button or ErstelleButton()
end

function W.AktualisiereButton()
    local btn = W.Button or ErstelleButton()
    if not btn then return end
    if W.Ziel then btn:Show() else btn:Hide() end
end
