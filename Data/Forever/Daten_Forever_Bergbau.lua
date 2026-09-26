-- ============================================================================
-- WOW FOREVER: BERGBAU (vorläufige Route, Hinweise, Lagerfeuer-Objekte)
-- ============================================================================
-- Quelle: Wowhead "Mining Overview & Leveling" (Forever, DE, Stand 25.09.2026,
-- Beta). Eine fertige Route gibt es dort noch nicht ("Leveling section coming
-- soon"). Die Schritte unten sind aus Wowheads Vorkommen-Tabelle (Skillbereich
-- + Gebiete je Vorkommen) abgeleitet und damit VORLÄUFIG.
-- Die englische Forever-Seite war nicht abrufbar: die EN-Namen der neuen
-- Materialien und Lagerfeuer-Objekte sind vorläufig (Lodestone, Rock Garden,
-- Molten Foundry, Pyrite, Bauxite, Pitchblende).
BerufeGuideDB_Forever    = BerufeGuideDB_Forever    or {}
BerufeFundorteDB_Forever = BerufeFundorteDB_Forever or {}
BerufeHinweisDB_Forever  = BerufeHinweisDB_Forever  or {}

if GetLocale() == "deDE" then
BerufeGuideDB_Forever["Bergbau"] = {
    { minSkill = 1, maxSkill = 65, typ = "sammeln", item = "Kupfererz", mats = "",
      allianz = "Wald von Elwynn, Dun Morogh, Westfall, Loch Modan", horde = "Durotar, Mulgore, Tirisfal, Brachland", beide = nil,
      hinweis = "Kupfervorkommen (25-50). Erz verhütten gibt ebenfalls Skillpunkte." },
    { minSkill = 65, maxSkill = 125, typ = "sammeln", item = "Zinnerz, Silbererz", mats = "",
      allianz = nil, horde = nil, beide = "Eschental, Tiefschwarze Grotte, Sumpfland",
      hinweis = "Zinnvorkommen (65-115), Silbervorkommen ab 75 nebenbei mitnehmen." },
    { minSkill = 125, maxSkill = 175, typ = "sammeln", item = "Eisenerz, Golderz", mats = "",
      allianz = nil, horde = nil, beide = "Ödland, Düstermarschen, Tanaris, Feralas, Sengende Schlucht",
      hinweis = "Eisenvorkommen (125-225), Goldvorkommen ab 155 (Azshara, Brennende Steppe, Winterquell)." },
    { minSkill = 175, maxSkill = 245, typ = "sammeln", item = "Mithrilerz, Echtsilbererz, Dunkeleisenerz", mats = "",
      allianz = nil, horde = nil, beide = "Feralas, Krater von Un'Goro, Winterquell, Azshara, Brennende Steppe",
      hinweis = "Mithrilablagerung (175-275). Ab 230 Echtsilber (Azshara, Brennende Steppe, Silithus) und Dunkeleisen (nur Schwarzfelstiefen und Geschmolzener Kern)." },
    { minSkill = 245, maxSkill = 300, typ = "sammeln", item = "Thoriumerz", mats = "",
      allianz = nil, horde = nil, beide = "Silithus, Krater von Un'Goro, Winterquell",
      hinweis = "Thoriumvorkommen (245-345)." },
}
BerufeHinweisDB_Forever["Bergbau"] = "Forever (vorläufig): Route aus Wowheads Vorkommen-Tabelle, eine offizielle Leveling-Route fehlt noch. Neu in Forever: Pyrit, Bauxit und Pechblende als Zusatzfunde sowie neue Barren (Legionitbarren, Schwerer Thoriumbarren, Azerothiumbarren). Lagerfeuer-Objekte: Leitstein (20), Felsgarten (140), Geschmolzene Gießerei (300) - per Suche."

BerufeFundorteDB_Forever["Leitstein"] = "|cff59ccff[Forever]|r Bergbau - Lagerfeuer-Objekt (Stufe 1)\nBenötigt Bergbau 20.\nWird beim Bergbau-Lehrer gelernt (vermutlich).\n|cff888888(Forever-Beta, Angaben ohne Gewähr)|r"
BerufeFundorteDB_Forever["Felsgarten"] = "|cff59ccff[Forever]|r Bergbau - Lagerfeuer-Objekt (Stufe 2)\nBenötigt Bergbau 140.\nQuelle nennt Wowhead noch nicht.\n|cff888888(Forever-Beta, Angaben ohne Gewähr)|r"
BerufeFundorteDB_Forever["Geschmolzene Gießerei"] = "|cff59ccff[Forever]|r Bergbau - Lagerfeuer-Objekt (Stufe 3)\nBenötigt Bergbau 300.\nQuelle nennt Wowhead noch nicht.\n|cff888888(Forever-Beta, Angaben ohne Gewähr)|r"
else
BerufeGuideDB_Forever["Bergbau"] = {
    { minSkill = 1, maxSkill = 65, typ = "sammeln", item = "Copper Ore", mats = "",
      allianz = "Elwynn Forest, Dun Morogh, Westfall, Loch Modan", horde = "Durotar, Mulgore, Tirisfal Glades, The Barrens", beide = nil,
      hinweis = "Copper Vein (25-50). Smelting your ore also gives skill points." },
    { minSkill = 65, maxSkill = 125, typ = "sammeln", item = "Tin Ore, Silver Ore", mats = "",
      allianz = nil, horde = nil, beide = "Ashenvale, Blackfathom Deeps, Wetlands",
      hinweis = "Tin Vein (65-115), grab Silver Veins from 75 along the way." },
    { minSkill = 125, maxSkill = 175, typ = "sammeln", item = "Iron Ore, Gold Ore", mats = "",
      allianz = nil, horde = nil, beide = "Badlands, Dustwallow Marsh, Tanaris, Feralas, Searing Gorge",
      hinweis = "Iron Deposit (125-225), Gold Vein from 155 (Azshara, Burning Steppes, Winterspring)." },
    { minSkill = 175, maxSkill = 245, typ = "sammeln", item = "Mithril Ore, Truesilver Ore, Dark Iron Ore", mats = "",
      allianz = nil, horde = nil, beide = "Feralas, Un'Goro Crater, Winterspring, Azshara, Burning Steppes",
      hinweis = "Mithril Deposit (175-275). From 230 Truesilver (Azshara, Burning Steppes, Silithus) and Dark Iron (only Blackrock Depths and Molten Core)." },
    { minSkill = 245, maxSkill = 300, typ = "sammeln", item = "Thorium Ore", mats = "",
      allianz = nil, horde = nil, beide = "Silithus, Un'Goro Crater, Winterspring",
      hinweis = "Thorium Vein (245-345)." },
}
BerufeHinweisDB_Forever["Bergbau"] = "Forever (provisional): route built from Wowhead's deposit table, an official leveling route is not out yet. New in Forever: Pyrite, Bauxite and Pitchblende as bonus finds plus new bars (Legionite, Heavy Thorium, Azerothium). Campsite objects: Lodestone (20), Rock Garden (140), Molten Foundry (300) - use the search. English names are provisional."

BerufeFundorteDB_Forever["Lodestone"] = "|cff59ccff[Forever]|r Mining - Campsite object (tier 1)\nRequires Mining 20.\nProbably learned from the Mining trainer.\n|cff888888(Forever beta, subject to change)|r"
BerufeFundorteDB_Forever["Rock Garden"] = "|cff59ccff[Forever]|r Mining - Campsite object (tier 2)\nRequires Mining 140.\nSource not listed on Wowhead yet.\n|cff888888(Forever beta, subject to change)|r"
BerufeFundorteDB_Forever["Molten Foundry"] = "|cff59ccff[Forever]|r Mining - Campsite object (tier 3)\nRequires Mining 300.\nSource not listed on Wowhead yet.\n|cff888888(Forever beta, subject to change)|r"
end
