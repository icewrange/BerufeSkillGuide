-- ============================================================================
-- WOW FOREVER: KRÄUTERKUNDE (Hinweise, Lagerfeuer-Objekte, neue Kräuter)
-- ============================================================================
-- Quelle: Wowhead "Herbalism Overview & Leveling" (Forever, DE + EN, Stand
-- 25.09.2026, Beta) und classicwow.gg (Effekte der Lagerfeuer-Objekte).
-- Wowhead hat noch keine Route und - anders als bei Bergbau - keine Tabelle
-- mit Skillbereichen/Gebieten. Der Guide zeigt deshalb weiter die Classic-
-- Route; hier kommen Hinweise und die Forever-Rezepte für die Suche dazu.
BerufeFundorteDB_Forever = BerufeFundorteDB_Forever or {}
BerufeHinweisDB_Forever  = BerufeHinweisDB_Forever  or {}

local function F(text) return "|cff59ccff[Forever]|r " .. text end

if GetLocale() == "deDE" then
local BETA = "\n|cff888888(Forever-Beta, Angaben ohne Gewähr)|r"
BerufeHinweisDB_Forever["Kräuterkunde"] = "Forever: Beim Sammeln gibt es zusätzlich Kräutersamen (gewöhnlich bis rar) und seltene Zusatzfunde (Gekräuselte Flechte, Rosenkappe, Würgerebe). Neue Endgame-Kräuter: Mahrblatt, Dämonensalbei, Todeslotus (Fundorte noch unbekannt). Tauren-Volksfähigkeit 'Grüner Daumen' verdoppelt jetzt ein Kraut statt Skillbonus. Lagerfeuer-Objekte: Räucherkerze (20), Gewächshaus (140), Saatenkreuzer (300) - per Suche."

BerufeFundorteDB_Forever["Räucherkerze"] = F("Kräuterkunde - Lagerfeuer-Objekt (Stufe 1)\nBenötigt Kräuterkunde 20.\nEffekt: Intelligenz für Spieler in der Nähe." .. BETA)
BerufeFundorteDB_Forever["Gewächshaus"] = F("Kräuterkunde - Lagerfeuer-Objekt (Stufe 2)\nBenötigt Kräuterkunde 140.\nEffekt: lässt gepflanzte Samen mit der Zeit zu Kräutern wachsen, plus Effekt der Räucherkerze.\nQuelle nennt Wowhead noch nicht." .. BETA)
BerufeFundorteDB_Forever["Saatenkreuzer"] = F("Kräuterkunde - Lagerfeuer-Objekt (Stufe 3)\nBenötigt Kräuterkunde 300.\nEffekt: vermehrt Samen oder kreuzt sie zu selteneren Stufen, plus Effekt der Räucherkerze.\nQuelle nennt Wowhead noch nicht." .. BETA)
BerufeFundorteDB_Forever["Mahrblatt"] = F("Kräuterkunde - neues Endgame-Kraut\nFundort und benötigter Skill noch unbekannt." .. BETA)
BerufeFundorteDB_Forever["Dämonensalbei"] = F("Kräuterkunde - neues Endgame-Kraut\nFundort und benötigter Skill noch unbekannt." .. BETA)
BerufeFundorteDB_Forever["Todeslotus"] = F("Kräuterkunde - neues Endgame-Kraut\nFundort und benötigter Skill noch unbekannt." .. BETA)
else
local BETA = "\n|cff888888(Forever beta, subject to change)|r"
BerufeHinweisDB_Forever["Kräuterkunde"] = "Forever: gathering also yields herb seeds (Commonplace to Scarce) and scarce bonus materials (Frilled Lichen, Rosecap, Stranglevine). New endgame herbs: Marefoil, Demonsage, Death Lotus (locations not known yet). The Tauren racial 'Cultivation' now duplicates a herb instead of a skill bonus. Campsite objects: Incense Candle (20), Greenhouse (140), Seed Hybridizer (300) - use the search."

BerufeFundorteDB_Forever["Incense Candle"] = F("Herbalism - Campsite object (tier 1)\nRequires Herbalism 20.\nEffect: Intellect for nearby players." .. BETA)
BerufeFundorteDB_Forever["Greenhouse"] = F("Herbalism - Campsite object (tier 2)\nRequires Herbalism 140.\nEffect: grows herbs over time from planted seeds, plus the candle's effect.\nSource not listed on Wowhead yet." .. BETA)
BerufeFundorteDB_Forever["Seed Hybridizer"] = F("Herbalism - Campsite object (tier 3)\nRequires Herbalism 300.\nEffect: multiplies seeds or combines them into rarer tiers, plus the candle's effect.\nSource not listed on Wowhead yet." .. BETA)
BerufeFundorteDB_Forever["Marefoil"] = F("Herbalism - new endgame herb\nLocation and required skill not known yet." .. BETA)
BerufeFundorteDB_Forever["Demonsage"] = F("Herbalism - new endgame herb\nLocation and required skill not known yet." .. BETA)
BerufeFundorteDB_Forever["Death Lotus"] = F("Herbalism - new endgame herb\nLocation and required skill not known yet." .. BETA)
end
