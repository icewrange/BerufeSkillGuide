-- ============================================================================
-- TOMTOM-INTEGRATION (OPTIONAL, KONFLIKTFREI MIT RESTEDXP & CO.)
-- ============================================================================
-- HINTERGRUND ZUM PROBLEM:
-- TomTom kennt intern nur EINEN aktiven "Crazy Arrow" (den Navigationspfeil
-- auf dem Bildschirm) gleichzeitig - egal welches Addon ihn zuletzt gesetzt
-- hat. RestedXP bringt einen komplett eigenen, unabhängigen Pfeil mit
-- (steuert also gar nicht über TomTom). Wenn BSG automatisch
-- TomTom:SetCrazyArrow() aufruft, entsteht dadurch entweder ein zweiter,
-- konkurrierender Pfeil auf dem Bildschirm, oder - falls der Spieler
-- zusätzlich eine RestedXP<->TomTom-Bruecke installiert hat - ein staendiges
-- Hin- und Herspringen des EINEN TomTom-Pfeils zwischen RestedXP-Ziel und
-- BSG-Ziel, weil beide Addons abwechselnd SetCrazyArrow() aufrufen.
--
-- LÖSUNG: BSG setzt nur einen stillen PIN auf Minimap/Weltkarte (persistent
-- = false, KEIN SetCrazyArrow-Aufruf). TomTom bietet dafür serienmäßig einen
-- Rechtsklick-Menüpunkt "Als Wegpunkt-Pfeil setzen" auf jedem Pin - der
-- Spieler kann den Pfeil also jederzeit selbst (bewusst) aktivieren, ohne
-- dass BSG ihm das aufzwingt oder mit RestedXP in Konflikt gerät.
-- ============================================================================

BerufeSkillGuide = BerufeSkillGuide or {}
local BSG = BerufeSkillGuide
BSG_TomTom = {}

local aktuellerWegpunkt = nil
local restedXPHinweisGezeigt = false
local zoneNameCache = {}

local function HoleTomTom()
    return _G.TomTom
end

-- Löst einen ZONENNAMEN (String, z.B. "Feralas" oder "Sturmwind" - so wie er
-- im aktuellen Client-Locale angezeigt wird) live über die Karten-Datenbank
-- des Spiels in eine UiMapID auf. Wird EINMAL pro Zonenname berechnet und
-- dann gecacht. Vorteil ggü. fest eingetragenen Zahlen-IDs: Ein falscher/
-- abweichender Name führt nur dazu, dass kein Wegpunkt gesetzt wird (sicherer
-- Fehlschlag) statt einen falschen Ort anzuzeigen.
function BSG_TomTom.FindeZoneID(zoneName)
    if not zoneName then return nil end
    local cached = zoneNameCache[zoneName]
    if cached ~= nil then
        if cached == false then return nil end
        return cached
    end
    if not C_Map or not C_Map.GetMapInfo then return nil end
    for id = 1, 2600 do
        local ok, info = pcall(C_Map.GetMapInfo, id)
        if ok and info and info.name == zoneName then
            zoneNameCache[zoneName] = id
            return id
        end
    end
    zoneNameCache[zoneName] = false
    return nil
end

-- Zeigt EINMALIG pro Sitzung einen Hinweis im Chat, falls RestedXP erkannt
-- wird, damit klar ist, warum BSG keinen eigenen Pfeil aktiviert.
local function PruefeRestedXP()
    if restedXPHinweisGezeigt then return end
    restedXPHinweisGezeigt = true
    if _G.RXPGuides then
        print("|cff33ff99BerufeSkillGuide:|r RestedXP erkannt - BSG setzt Wegpunkte nur als Kartenpin (kein automatischer Pfeil), um Konflikte mit RestedXPs eigenem Pfeil zu vermeiden. Rechtsklick auf den Pin aktiviert bei Bedarf manuell den TomTom-Pfeil.")
    end
end

-- Setzt (und ersetzt) den aktuellen BSG-Wegpunkt.
-- mapID = UiMapID (z.B. Darnassus = 1457), x/y in Prozent (0-100), so wie
-- sie in Data\Daten_Lehrer.lua hinterlegt sind.
-- mapRef darf entweder eine fertige UiMapID (Zahl) oder ein Zonenname
-- (String, wird über FindeZoneID aufgelöst) sein.
function BSG_TomTom.SetzeWegpunkt(mapRef, x, y, titel)
    local TomTom = HoleTomTom()
    if not TomTom or not mapRef or not x or not y then return end

    local mapID = mapRef
    if type(mapRef) == "string" then
        mapID = BSG_TomTom.FindeZoneID(mapRef)
        if not mapID then
            if BSG_DebugLog then
                BSG_DebugLog.Log("BSG_TomTom: Zone '" .. mapRef .. "' nicht in der Kartendatenbank gefunden - Wegpunkt übersprungen")
            end
            return
        end
    end

    PruefeRestedXP()

    -- Alten BSG-Pin zuerst entfernen, damit sich keine Pins ansammeln
    BSG_TomTom.EntferneWegpunkt()

    local optionen = {
        title = titel or "Berufe Skill Guide",
        persistent = false, -- verschwindet automatisch nach Logout/Reload
        minimap = true,     -- Punkt auf der Minimap
        world = true,       -- Punkt auf der Weltkarte
        -- WICHTIG: hier bewusst KEIN "crazy = true" und KEIN SetCrazyArrow()
        -- -> kein automatischer Navigationspfeil, keine Konkurrenz zu RestedXP
    }

    local ok, uidOderFehler
    if TomTom.AddWaypoint then
        ok, uidOderFehler = pcall(TomTom.AddWaypoint, TomTom, mapID, x / 100, y / 100, optionen)
    end
    if not ok and TomTom.AddMFWaypoint then
        ok, uidOderFehler = pcall(TomTom.AddMFWaypoint, TomTom, mapID, 0, x / 100, y / 100, optionen)
    end

    if ok then
        aktuellerWegpunkt = uidOderFehler
    elseif BSG_DebugLog then
        BSG_DebugLog.Log("BSG_TomTom: Wegpunkt konnte nicht gesetzt werden (" .. tostring(uidOderFehler) .. ")")
    end
end

-- Entfernt den aktuell gesetzten BSG-Wegpunkt (z.B. wenn kein Lehrer-Eintrag
-- mehr passt oder das Hauptfenster geschlossen wird).
function BSG_TomTom.EntferneWegpunkt()
    local TomTom = HoleTomTom()
    if TomTom and aktuellerWegpunkt and TomTom.RemoveWaypoint then
        pcall(TomTom.RemoveWaypoint, TomTom, aktuellerWegpunkt)
    end
    aktuellerWegpunkt = nil
end
