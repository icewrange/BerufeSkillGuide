-- ============================================================================
-- MODUL: BERUFEFENSTER - REZEPTFARBE + AUTO-AUSWAHL V1.0
-- ============================================================================
-- Sobald das Berufefenster (z.B. Schmiedekunst) offen ist:
--   1. REZEPTFARBE: Alle Rezepte werden mit ihrer Schwierigkeit gemerkt
--      (orange/gelb/grün/grau). Der Guide zeigt den Rezeptnamen danach in
--      genau dieser Farbe an - auch wenn das Fenster wieder zu ist.
--      "(?)" hinter dem Namen = Rezept nicht im Fenster gefunden (noch nicht
--      gelernt, oder der Name im Guide weicht vom Spielnamen ab).
--   2. AUTO-AUSWAHL: Das Rezept des aktuellen Guide-Schritts wird im Fenster
--      automatisch markiert und ins Bild gescrollt. Passiert nur beim Öffnen
--      des Fensters bzw. wenn der Guide-Schritt wechselt - der Spieler kann
--      danach frei etwas anderes auswählen. Abschaltbar: /bsg auswahl
--
-- Unterstützt:
--   Classic Era : TradeSkillFrame (GetTradeSkillInfo) + CraftFrame für
--                 Verzauberkunst (GetCraftInfo)
--   WoW Forever : moderne API (C_TradeSkillUI) - Auswahl über OpenRecipe

BSG_Berufefenster = BSG_Berufefenster or {}
local BF = BSG_Berufefenster

-- Schwierigkeit -> Farbe (Blizzards TradeSkillTypeColor)
local FARBEN = {
    optimal = "ff8040",  -- orange: garantierter Skillpunkt
    medium  = "ffff00",  -- gelb
    easy    = "40bf40",  -- grün
    trivial = "808080",  -- grau: kein Skillpunkt mehr
}
-- Moderne API: Enum.TradeskillRelativeDifficulty (0..3)
local MODERN_SCHWIERIGKEIT = { [0] = "optimal", [1] = "medium", [2] = "easy", [3] = "trivial" }

-- Cache: BF.Rezepte[beruf][rezeptNameKlein] = { typ = "optimal", index = i, recipeID = id }
BF.Rezepte = {}
BF.OffenerBeruf = nil     -- kanonischer Name des aktuell offenen Fensters
BF.OffeneArt = nil        -- "trade", "craft" oder "modern"
local letzteAuswahl = nil -- verhindert, dass wir die Auswahl des Spielers überschreiben

local function AutoAuswahlAn()
    return not (BerufeSkillGuideDB and BerufeSkillGuideDB.autoAuswahl == false)
end

-- ----------------------------------------------------------------------------
-- NAMEN AUS DEM GUIDE-TEXT
-- ----------------------------------------------------------------------------
-- "ca. 60 Grobes Sprengpulver" -> { "grobes sprengpulver" }
-- "20 Leinengürtel / Leinenstiefel" -> { "leinengürtel", "leinenstiefel" }
local function RezeptKandidaten(itemText)
    local t = (itemText or ""):gsub("|c%x%x%x%x%x%x%x%x", ""):gsub("|r", "")
    t = t:gsub("^%s*[Cc][Aa]%.%s*", ""):gsub("^%s*%d+%s*[xX]?%s*", "")
    local liste = {}
    for teil in (t .. "/"):gmatch("(.-)%s*/%s*") do
        for teil2 in (teil .. " oder "):gmatch("(.-)%s+oder%s+") do
            local n = teil2:gsub("^%s+", ""):gsub("%s+$", "")
            if n ~= "" then
                table.insert(liste, n:lower())
                -- Englischer Client: Verzauberungen heißen im Berufefenster
                -- "Enchant Bracer - Minor Health", im Guide "Bracer - ...".
                if n:find(" %- ") and not n:lower():find("^enchant ") then
                    table.insert(liste, "enchant " .. n:lower())
                end
            end
        end
    end
    return liste
end

-- Sucht einen Guide-Eintrag im Cache eines Berufs
local function FindeRezept(beruf, itemText)
    local cache = BF.Rezepte[beruf]
    if not cache then return nil end
    local kandidaten = RezeptKandidaten(itemText)
    -- Bewusst NUR exakte Treffer (Groß-/Kleinschreibung egal): ein
    -- Teilstring-Vergleich würde z.B. "Heiltrank" fälschlich mit
    -- "Schwacher Heiltrank" verwechseln und das falsche Rezept markieren.
    for _, k in ipairs(kandidaten) do
        if cache[k] then return cache[k], k end
    end
    return nil
end

-- ----------------------------------------------------------------------------
-- FENSTER AUSLESEN
-- ----------------------------------------------------------------------------
local function Kanonisch(name)
    return name and BSG_Berufe and BSG_Berufe.KANONISCH[name]
end

local function ScanneTradeSkill()
    if not (GetTradeSkillLine and GetNumTradeSkills and GetTradeSkillInfo) then return nil end
    local beruf = Kanonisch((GetTradeSkillLine()))
    if not beruf then return nil end
    local cache = {}
    for i = 1, GetNumTradeSkills() do
        local name, typ = GetTradeSkillInfo(i)
        if name and typ and typ ~= "header" then
            cache[name:lower()] = { typ = typ, index = i }
        end
    end
    return beruf, cache, "trade"
end

local function ScanneCraft()
    if not (GetCraftDisplaySkillLine and GetNumCrafts and GetCraftInfo) then return nil end
    local beruf = Kanonisch((GetCraftDisplaySkillLine()))
    if not beruf then return nil end
    local cache = {}
    for i = 1, GetNumCrafts() do
        local name, _, typ = GetCraftInfo(i)
        if name and typ and typ ~= "header" then
            cache[name:lower()] = { typ = typ, index = i }
        end
    end
    return beruf, cache, "craft"
end

local function ScanneModern()
    if not (C_TradeSkillUI and C_TradeSkillUI.GetAllRecipeIDs and C_TradeSkillUI.GetRecipeInfo) then return nil end
    local ok, info = pcall(function()
        return (C_TradeSkillUI.GetBaseProfessionInfo and C_TradeSkillUI.GetBaseProfessionInfo())
            or (C_TradeSkillUI.GetChildProfessionInfo and C_TradeSkillUI.GetChildProfessionInfo())
    end)
    local beruf = ok and info and Kanonisch(info.professionName)
    if not beruf then return nil end
    local cache = {}
    local okIds, ids = pcall(C_TradeSkillUI.GetAllRecipeIDs)
    if not okIds or not ids then return nil end
    for _, id in ipairs(ids) do
        local okR, r = pcall(C_TradeSkillUI.GetRecipeInfo, id)
        if okR and r and r.name and r.learned then
            cache[r.name:lower()] = { typ = MODERN_SCHWIERIGKEIT[r.relativeDifficulty] or "trivial", recipeID = id }
        end
    end
    return beruf, cache, "modern"
end

-- ----------------------------------------------------------------------------
-- AUTO-AUSWAHL
-- ----------------------------------------------------------------------------
local function ScrolleZu(scrollBar, index, anzahlSichtbar, zeilenHoehe)
    if not (scrollBar and index and anzahlSichtbar and zeilenHoehe) then return end
    local offset = math.max(0, index - 1 - math.floor(anzahlSichtbar / 2))
    pcall(scrollBar.SetValue, scrollBar, offset * zeilenHoehe)
end

function BF.WaehleAktuellesRezept(erzwingen)
    if not AutoAuswahlAn() or not BF.OffenerBeruf then return end
    local schritt = BSG_Search and BSG_Search.AktuellerSchritt
    if not schritt or schritt.typ == "sammeln" or schritt.beruf ~= BF.OffenerBeruf then return end

    local schluessel = schritt.beruf .. "|" .. (schritt.item or "")
    if letzteAuswahl == schluessel and not erzwingen then return end

    local info = FindeRezept(schritt.beruf, schritt.item)
    if not info then return end
    letzteAuswahl = schluessel

    if BF.OffeneArt == "trade" and info.index and TradeSkillFrame_SetSelection then
        pcall(TradeSkillFrame_SetSelection, info.index)
        ScrolleZu(TradeSkillListScrollFrameScrollBar, info.index, TRADE_SKILLS_DISPLAYED, TRADE_SKILL_HEIGHT)
        if TradeSkillFrame_Update then pcall(TradeSkillFrame_Update) end
    elseif BF.OffeneArt == "craft" and info.index and CraftFrame_SetSelection then
        pcall(CraftFrame_SetSelection, info.index)
        ScrolleZu(CraftListScrollFrameScrollBar, info.index, CRAFTS_DISPLAYED, CRAFT_SKILL_HEIGHT)
        if CraftFrame_Update then pcall(CraftFrame_Update) end
    elseif BF.OffeneArt == "modern" and info.recipeID and C_TradeSkillUI and C_TradeSkillUI.OpenRecipe then
        pcall(C_TradeSkillUI.OpenRecipe, info.recipeID)
    end
end

-- ----------------------------------------------------------------------------
-- ANZEIGE IM GUIDE
-- ----------------------------------------------------------------------------
-- Gibt den Rezeptnamen in seiner Schwierigkeitsfarbe zurück (oder unverändert,
-- solange das Berufefenster dieses Berufs noch nie offen war).
function BF.FaerbeItem(beruf, itemText)
    if not BF.Rezepte[beruf] then return itemText end
    local info = FindeRezept(beruf, itemText)
    if info and FARBEN[info.typ] then
        return "|cff" .. FARBEN[info.typ] .. itemText .. "|r"
    end
    return itemText .. " |cffff5500(?)|r"
end

-- Aktualisiert den Guide, wenn sich die Farbe des angezeigten Rezepts
-- geändert hat (z.B. orange -> gelb nach einem Skill-Up).
local letzteFarbe = nil
local function AktualisiereGuideFallsNoetig()
    local schritt = BSG_Search and BSG_Search.AktuellerSchritt
    if not schritt or schritt.beruf ~= BF.OffenerBeruf then return end
    local info = FindeRezept(schritt.beruf, schritt.item)
    local farbe = info and info.typ or "?"
    if farbe ~= letzteFarbe then
        letzteFarbe = farbe
        if BSG_Search.BerechneMaterialBedarf and BSG_Search.HoleLetztenStand then
            local beruf, skill = BSG_Search.HoleLetztenStand()
            if beruf == schritt.beruf and skill then
                BSG_Search.BerechneMaterialBedarf(beruf, skill)
            end
        end
    end
end

-- ----------------------------------------------------------------------------
-- EVENTS
-- ----------------------------------------------------------------------------
local scanGeplant = false
local function Scanne(quelle)
    local beruf, cache, art
    if quelle == "craft" then
        beruf, cache, art = ScanneCraft()
    elseif quelle == "modern" then
        beruf, cache, art = ScanneModern()
    else
        beruf, cache, art = ScanneTradeSkill()
        if not beruf then beruf, cache, art = ScanneModern() end
    end
    if not beruf then return end

    local neuGeoeffnet = (BF.OffenerBeruf ~= beruf)
    BF.Rezepte[beruf] = cache
    BF.OffenerBeruf, BF.OffeneArt = beruf, art

    AktualisiereGuideFallsNoetig()
    if neuGeoeffnet then
        BF.WaehleAktuellesRezept(true)
    end
end

local function PlaneScan(quelle)
    if scanGeplant then return end
    scanGeplant = true
    C_Timer.After(0.2, function()
        scanGeplant = false
        Scanne(quelle)
    end)
end

local ev = CreateFrame("Frame")
for _, e in ipairs({ "TRADE_SKILL_SHOW", "TRADE_SKILL_UPDATE", "TRADE_SKILL_LIST_UPDATE",
                     "CRAFT_SHOW", "CRAFT_UPDATE", "TRADE_SKILL_CLOSE", "CRAFT_CLOSE" }) do
    BSG_Compat.RegisterEventSicher(ev, e)
end
ev:SetScript("OnEvent", function(self, event)
    if event == "TRADE_SKILL_CLOSE" or event == "CRAFT_CLOSE" then
        BF.OffenerBeruf, BF.OffeneArt = nil, nil
        letzteAuswahl, letzteFarbe = nil, nil
    elseif event == "CRAFT_SHOW" or event == "CRAFT_UPDATE" then
        PlaneScan("craft")
    else
        PlaneScan("trade")
    end
end)

-- /bsg auswahl
function BF.ToggleAutoAuswahl()
    BerufeSkillGuideDB = BerufeSkillGuideDB or {}
    BerufeSkillGuideDB.autoAuswahl = not AutoAuswahlAn()
    local L = BSG_Locale or {}
    print("|cff00ff00[BSG]:|r " .. (BerufeSkillGuideDB.autoAuswahl
        and (L.AUTOSELECT_ON or "Auto-Auswahl im Berufefenster |cff00ff00aktiviert|r.")
        or (L.AUTOSELECT_OFF or "Auto-Auswahl im Berufefenster |cffff0000deaktiviert|r.")))
end
