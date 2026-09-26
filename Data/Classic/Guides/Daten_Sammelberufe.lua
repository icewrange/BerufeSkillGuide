-- ============================================================================
-- DATABASE: SAMMELBERUFE (BERGBAU, KRÄUTERKUNDE, KÜRSCHNEREI) 1 - 300
-- ============================================================================
-- v2.1: Skillstufen und Bergbau-/Kürschnerei-Gebiete mit Wowheads Classic-
-- Guides abgeglichen (Mining/Herbalism/Skinning 1-300). Die Kräuterkunde-
-- Gebiete nennt Wowhead nicht - sie stammen aus allgemeinem Classic-Wissen.
-- typ = "sammeln": Guide zeigt WAS man sammelt und in welchen GEBIETEN.
BerufeGuideDB = BerufeGuideDB or {}

if GetLocale() == "deDE" then
BerufeGuideDB["Bergbau"] = {
    { minSkill = 1, maxSkill = 65, typ = "sammeln", item = "Kupfererz", mats = "",
      allianz = "Dun Morogh, Wald von Elwynn, Westfall, Loch Modan, Rotkammgebirge, Dunkelküste, Eschental", horde = "Durotar, Mulgore, Tirisfal, Silberwald, Brachland, Eschental", beide = nil, hinweis = "Kupfer auch verhütten - Schmelzen gibt Skillpunkte (lohnt bis ca. Skill 185)." },
    { minSkill = 65, maxSkill = 125, typ = "sammeln", item = "Zinnerz, Silbererz", mats = "",
      allianz = nil, horde = nil, beide = "Alteracgebirge, Vorgebirge des Hügellands, Sumpfland, Arathihochland, Schlingendorntal", hinweis = "Zinn ab 65, Silber ab 75 (selten - nebenbei mitnehmen)." },
    { minSkill = 125, maxSkill = 175, typ = "sammeln", item = "Eisenerz, Golderz", mats = "",
      allianz = nil, horde = nil, beide = "Ödland, Sengende Schlucht, Düstermarschen, Feralas, Sümpfe des Elends", hinweis = "Eisen ab 125, Gold ab 155." },
    { minSkill = 175, maxSkill = 245, typ = "sammeln", item = "Mithrilerz, Echtsilbererz", mats = "",
      allianz = nil, horde = nil, beide = "Azshara, Brennende Steppe, Östliche Pestländer, Teufelswald, Winterquell", hinweis = "Mithril ab 175, Echtsilber ab 230." },
    { minSkill = 245, maxSkill = 300, typ = "sammeln", item = "Thoriumerz", mats = "",
      allianz = nil, horde = nil, beide = "Silithus, Krater von Un'Goro, Westliche Pestländer", hinweis = "Kleine Thoriumadern ab 245, reiche ab 275." },
}
BerufeGuideDB["Kräuterkunde"] = {
    { minSkill = 1, maxSkill = 50, typ = "sammeln", item = "Friedensblume, Silberblatt, Erdwurzel", mats = "",
      allianz = "Wald von Elwynn, Dun Morogh, Teldrassil, Westfall", horde = "Durotar, Mulgore, Tirisfal", beide = nil, hinweis = "Friedensblume und Silberblatt ab 1, Erdwurzel ab 15." },
    { minSkill = 50, maxSkill = 100, typ = "sammeln", item = "Maguskönigskraut, Wilddornrose, Würgetang", mats = "",
      allianz = "Westfall, Loch Modan, Dunkelküste", horde = "Brachland, Silberwald", beide = nil, hinweis = "Maguskönigskraut ab 50, Wilddornrose ab 70, Würgetang ab 85 (im Wasser)." },
    { minSkill = 100, maxSkill = 150, typ = "sammeln", item = "Beulengras, Wildstahlblume, Grabmoos, Königsblut", mats = "",
      allianz = "Rotkammgebirge, Sumpfland, Dämmerwald, Eschental", horde = "Brachland, Steinkrallengebirge, Vorgebirge des Hügellands, Eschental", beide = nil, hinweis = "Beulengras ab 100, Wildstahlblume ab 115, Grabmoos ab 120, Königsblut ab 125." },
    { minSkill = 150, maxSkill = 205, typ = "sammeln", item = "Lebenswurz, Blassblatt, Golddorn, Khadgars Schnurrbart, Winterbiss", mats = "",
      allianz = nil, horde = nil, beide = "Arathihochland, Schlingendorntal, Düstermarschen, Sümpfe des Elends, Alteracgebirge", hinweis = "Lebenswurz ab 150, Blassblatt 160, Golddorn 170, Khadgars Schnurrbart 185, Winterbiss 195." },
    { minSkill = 205, maxSkill = 250, typ = "sammeln", item = "Feuerblüte, Lila Lotus, Arthas Tränen, Sonnengras, Blindkraut, Geisterpilz", mats = "",
      allianz = nil, horde = nil, beide = "Sengende Schlucht, Ödland, Tanaris, Feralas, Hinterland, Teufelswald", hinweis = "Feuerblüte ab 205, Lila Lotus 210, Arthas' Tränen 220, Sonnengras 230, Blindkraut 235, Geisterpilz 245." },
    { minSkill = 250, maxSkill = 300, typ = "sammeln", item = "Gromsblut, Goldener Sansam, Traumblatt, Bergsilbersalbei, Pestblüte, Eiskappe", mats = "",
      allianz = nil, horde = nil, beide = "Krater von Un'Goro, Teufelswald, Azshara, Östliche Pestländer, Westliche Pestländer, Winterquell, Silithus", hinweis = "Gromsblut ab 250, Goldener Sansam 260, Traumblatt 270, Bergsilbersalbei 280, Pestblüte 285, Eiskappe 290." },
}
BerufeGuideDB["Kürschnerei"] = {
    { minSkill = 1, maxSkill = 100, typ = "sammeln", item = "Leichtes Leder", mats = "",
      allianz = "Wald von Elwynn, Teldrassil", horde = "Mulgore", beide = nil, hinweis = "Tiere Stufe 6-20. Faustregel bis Skill 100: max. Tierstufe = Skill / 10 + 10." },
    { minSkill = 100, maxSkill = 165, typ = "sammeln", item = "Mittleres Leder, Leichtes Leder", mats = "",
      allianz = "Steinkrallengebirge, Sumpfland", horde = "Schlingendorntal, Arathihochland", beide = nil, hinweis = "Tiere Stufe 21-30 sind ideal. Ab Skill 100: max. Tierstufe = Skill / 5." },
    { minSkill = 165, maxSkill = 225, typ = "sammeln", item = "Schweres Leder, Dickes Leder", mats = "",
      allianz = "Tanaris, Feralas", horde = "Tanaris, Feralas, Teufelswald", beide = nil, hinweis = "Schweres Leder von Tieren Stufe 25-45, Dickes Leder ab ca. Stufe 36 (ideal 41-50)." },
    { minSkill = 225, maxSkill = 300, typ = "sammeln", item = "Unverwüstliches Leder", mats = "",
      allianz = nil, horde = nil, beide = "Krater von Un'Goro, Östliche Pestländer, Winterquell", hinweis = "Tiere Stufe 51-60 sind ideal." },
}
end
