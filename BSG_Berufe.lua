-- ============================================================================
-- CORE: BERUFE - ZENTRALE BERUFSLISTE V1.0
-- ============================================================================
-- EINE Stelle für alle unterstützten Berufe. Vorher stand die Liste
-- mehrfach (Sidebar.lua, API.lua, Simulation.lua, SlashCommands.lua) und
-- musste bei jedem neuen Beruf an vier Stellen gepflegt werden.
--
--   name    : interner, kanonischer (deutscher) Name = Schlüssel in
--             BerufeGuideDB / BerufeLehrerDB
--   en      : englischer Client-Name (für die Skill-Erkennung)
--   spellId : Grundfertigkeit (Classic)
--   icon    : Sidebar-Icon
--   typ     : "herstellen" (Rezepte + Material) oder "sammeln" (Gebiete)
--   aliase  : zusätzliche Schreibweisen für /bsg sim
--
-- Reihenfolge = Reihenfolge in der Sidebar.

BSG_Berufe = BSG_Berufe or {}
local B = BSG_Berufe

B.LISTE = {
    { name = "Alchimie",          en = "Alchemy",        spellId = 2259, typ = "herstellen", icon = "Interface\\Icons\\Trade_Alchemy",              aliase = { "alchemie" } },
    { name = "Schmiedekunst",     en = "Blacksmithing",  spellId = 2018, typ = "herstellen", icon = "Interface\\Icons\\Trade_BlackSmithing" },
    { name = "Ingenieurskunst",   en = "Engineering",    spellId = 4036, typ = "herstellen", icon = "Interface\\Icons\\Trade_Engineering" },
    { name = "Lederverarbeitung", en = "Leatherworking", spellId = 2108, typ = "herstellen", icon = "Interface\\Icons\\Trade_LeatherWorking" },
    { name = "Schneidern",        en = "Tailoring",      spellId = 3908, typ = "herstellen", icon = "Interface\\Icons\\Trade_Tailoring",            aliase = { "schneiderei" } },
    { name = "Verzauberkunst",    en = "Enchanting",     spellId = 7411, typ = "herstellen", icon = "Interface\\Icons\\Spell_Nature_Lightning",     aliase = { "vz" } },
    { name = "Kochkunst",         en = "Cooking",        spellId = 2550, typ = "herstellen", icon = "Interface\\Icons\\INV_Misc_Food_15",           aliase = { "kochen" } },
    -- NEU (v2.1)
    { name = "Erste Hilfe",       en = "First Aid",      spellId = 3273, typ = "herstellen", icon = "Interface\\Icons\\Spell_Holy_SealOfSacrifice", aliase = { "erstehilfe", "firstaid", "eh" } },
    { name = "Bergbau",           en = "Mining",         spellId = 2575, typ = "sammeln",    icon = "Interface\\Icons\\Trade_Mining" },
    { name = "Kräuterkunde",      en = "Herbalism",      spellId = 2366, typ = "sammeln",    icon = "Interface\\Icons\\Spell_Nature_NatureTouchGrow", aliase = { "kraeuterkunde", "kraeuter", "kräuter" } },
    { name = "Kürschnerei",       en = "Skinning",       spellId = 8613, typ = "sammeln",    icon = "Interface\\Icons\\INV_Misc_Pelt_Wolf_01",      aliase = { "kuerschnerei", "kürschnern", "kuerschnern" } },
}

-- Schnellzugriff per Name
B.NACH_NAME = {}
for _, b in ipairs(B.LISTE) do B.NACH_NAME[b.name] = b end

function B.Info(name)
    return B.NACH_NAME[name]
end

function B.Anzahl()
    return #B.LISTE
end

function B.IstSammelberuf(name)
    local b = B.NACH_NAME[name]
    return b ~= nil and b.typ == "sammeln"
end

function B.Icon(name)
    local b = B.NACH_NAME[name]
    return b and b.icon or "Interface\\Icons\\INV_Misc_QuestionMark"
end

-- Client-Name (deutsch ODER englisch) -> kanonischer Name
B.KANONISCH = {}
for _, b in ipairs(B.LISTE) do
    B.KANONISCH[b.name] = b.name
    B.KANONISCH[b.en] = b.name
end

-- Chat-Eingabe (klein, auch ohne Umlaute) -> kanonischer Name
B.ALIASE = {}
for _, b in ipairs(B.LISTE) do
    B.ALIASE[b.name:lower()] = b.name
    B.ALIASE[b.en:lower():gsub("%s", "")] = b.name
    B.ALIASE[b.name:lower():gsub("%s", "")] = b.name
    for _, a in ipairs(b.aliase or {}) do B.ALIASE[a] = b.name end
end

-- Anzeigename in der Client-Sprache (intern bleibt der deutsche Name)
function B.Anzeigename(name)
    local b = B.NACH_NAME[name]
    if b and GetLocale and GetLocale() ~= "deDE" then return b.en end
    return name
end

-- Großbuchstaben inkl. Umlaute (string.upper kennt keine UTF-8-Umlaute:
-- aus "Kräuterkunde" würde sonst "KRäUTERKUNDE")
function B.Gross(text)
    text = (text or ""):gsub("ä", "Ä"):gsub("ö", "Ö"):gsub("ü", "Ü")
    return (text:upper())
end
