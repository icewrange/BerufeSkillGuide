-- ============================================================================
-- MODUL: COMPAT - API-BRÜCKE CLASSIC ERA  <->  WOW FOREVER V1.0
-- ============================================================================
-- WoW Forever (Client 1.60.x, Interface 16001) läuft auf der MODERNEN
-- Retail-API, nicht auf der Classic-API. Einige alte globale Funktionen, die
-- dieses Addon bisher direkt aufgerufen hat, gibt es dort nicht mehr:
--   - GetItemInfo / GetItemCount / GetItemIcon  -> C_Item.*
--   - GetNumSkillLines / GetSkillLineInfo       -> GetProfessions / GetProfessionInfo
--   - GetNumAuctionItems / GetAuctionItemInfo   -> komplett anderes AH (C_AuctionHouse)
-- Diese Datei kapselt alle betroffenen Aufrufe. Die übrigen Module rufen nur
-- noch BSG_Compat.* auf und funktionieren dadurch auf BEIDEN Clients.
-- WICHTIG: Es werden bewusst KEINE globalen Blizzard-Funktionen
-- überschrieben (das würde andere Addons beeinflussen / "tainten").

BSG_Compat = BSG_Compat or {}
local C = BSG_Compat

-- ----------------------------------------------------------------------------
-- CLIENT-ERKENNUNG
-- ----------------------------------------------------------------------------
-- Forever meldet eine Classic-artige Build-Nummer (1.60.1 -> 16001), nutzt
-- aber die Retail-API. Eine reine Build-Nummern-Prüfung würde Forever daher
-- fälschlich als Classic Era einstufen.
local _, _, _, tocVersion = GetBuildInfo()
C.TOC_VERSION = tocVersion or 0

C.IST_MODERNE_API = (WOW_PROJECT_ID ~= nil and WOW_PROJECT_MAINLINE ~= nil
    and WOW_PROJECT_ID == WOW_PROJECT_MAINLINE) or false

C.IST_FOREVER_CLIENT = C.IST_MODERNE_API and C.TOC_VERSION >= 16000 and C.TOC_VERSION < 20000

-- ----------------------------------------------------------------------------
-- ITEMS
-- ----------------------------------------------------------------------------
function C.GetItemInfo(item)
    if not item then return nil end
    if C_Item and C_Item.GetItemInfo then
        return C_Item.GetItemInfo(item)
    elseif GetItemInfo then
        return GetItemInfo(item)
    end
    return nil
end

function C.GetItemCount(item, inklusiveBank)
    if not item then return 0 end
    local anzahl
    if C_Item and C_Item.GetItemCount then
        anzahl = C_Item.GetItemCount(item, inklusiveBank)
    elseif GetItemCount then
        anzahl = GetItemCount(item, inklusiveBank)
    end
    return anzahl or 0
end

function C.GetItemIcon(itemID)
    if not itemID then return nil end
    if C_Item and C_Item.GetItemIconByID then
        return C_Item.GetItemIconByID(itemID)
    elseif GetItemIcon then
        return GetItemIcon(itemID)
    end
    return nil
end

-- Liefert nur die Textur (10. Rückgabewert von GetItemInfo), mit Icon-
-- Fallback über die Item-ID.
function C.GetItemTexture(item)
    local _, _, _, _, _, _, _, _, _, tex = C.GetItemInfo(item)
    if not tex and type(item) == "number" then
        tex = C.GetItemIcon(item)
    end
    return tex
end

-- ----------------------------------------------------------------------------
-- BERUFS-SKILLS
-- ----------------------------------------------------------------------------
-- Liefert eine Liste { {name=, rank=, maxRank=}, ... } aller Skill-Linien
-- (Classic) bzw. aller Berufe (moderne API). Der Name ist - wie bisher -
-- in der Sprache des Clients und wird von BSG_API.KanonischerBerufsname
-- auf den internen deutschen Namen abgebildet.
function C.HoleSkillLinien()
    local liste = {}

    if GetNumSkillLines and GetSkillLineInfo then
        -- Classic Era / SoD
        for i = 1, GetNumSkillLines() do
            local sName, istHeader, _, sRank, _, _, sMaxRank = GetSkillLineInfo(i)
            if sName and not istHeader then
                table.insert(liste, { name = sName, rank = sRank or 0, maxRank = sMaxRank or 0 })
            end
        end
    elseif GetProfessions and GetProfessionInfo then
        -- Moderne API (WoW Forever): GetProfessions() liefert je nach Client
        -- unterschiedlich viele Indizes (Haupt-, Neben-, Erste Hilfe ...),
        -- daher werden ALLE Rückgabewerte generisch durchlaufen.
        local indizes = { GetProfessions() }
        for n = 1, select("#", GetProfessions()) do
            local idx = indizes[n]
            if idx then
                local ok, pName, _, pRank, pMaxRank = pcall(GetProfessionInfo, idx)
                if ok and pName then
                    table.insert(liste, { name = pName, rank = pRank or 0, maxRank = pMaxRank or 0 })
                end
            end
        end
    end

    return liste
end

-- Sucht den aktuellen Skill eines Berufs anhand des kanonischen (deutschen)
-- Namens. Gibt (rank, maxRank) oder nil zurück.
function C.HoleBerufsSkill(kanonischerName)
    for _, linie in ipairs(C.HoleSkillLinien()) do
        local kanonisch = BSG_API and BSG_API.KanonischerBerufsname and BSG_API.KanonischerBerufsname(linie.name)
        if kanonisch == kanonischerName then
            return linie.rank, linie.maxRank
        end
    end
    return nil
end

-- ----------------------------------------------------------------------------
-- EVENTS SICHER REGISTRIEREN
-- ----------------------------------------------------------------------------
-- RegisterEvent wirft einen Fehler, wenn ein Event im aktuellen Client nicht
-- existiert. Unterschiedliche Clients -> unterschiedliche Event-Listen.
function C.RegisterEventSicher(frame, eventName)
    local ok = pcall(frame.RegisterEvent, frame, eventName)
    return ok
end

-- ----------------------------------------------------------------------------
-- AUKTIONSHAUS
-- ----------------------------------------------------------------------------
-- Altes Classic-AH (AuctionFrame) ODER neues AH (AuctionHouseFrame).
function C.IstAuktionshausOffen()
    if AuctionFrame and AuctionFrame:IsVisible() then return true end
    if AuctionHouseFrame and AuctionHouseFrame:IsVisible() then return true end
    return false
end

-- Nur das alte Classic-AH erlaubt das direkte Auslesen der Such-Liste.
function C.HatKlassischesAHBrowse()
    return (GetNumAuctionItems ~= nil) and (GetAuctionItemInfo ~= nil)
        and AuctionFrame ~= nil and AuctionFrame:IsVisible()
end
