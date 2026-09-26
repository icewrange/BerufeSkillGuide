-- ============================================================================
-- DATABASE: GATHERING PROFESSIONS (MINING, HERBALISM, SKINNING) - ENGLISH
-- ============================================================================
-- v2.1: skill levels and mining/skinning zones checked against Wowhead's
-- Classic guides. Herbalism zones are not listed by Wowhead (general knowledge).
BerufeGuideDB = BerufeGuideDB or {}

if GetLocale() ~= "deDE" then
BerufeGuideDB["Bergbau"] = {
    { minSkill = 1, maxSkill = 65, typ = "sammeln", item = "Copper Ore", mats = "",
      allianz = "Dun Morogh, Elwynn Forest, Westfall, Loch Modan, Redridge Mountains, Darkshore, Ashenvale", horde = "Durotar, Mulgore, Tirisfal Glades, Silverpine Forest, The Barrens, Ashenvale", beide = nil, hinweis = "Also smelt your ore - smelting gives skill points (worth it up to about skill 185)." },
    { minSkill = 65, maxSkill = 125, typ = "sammeln", item = "Tin Ore, Silver Ore", mats = "",
      allianz = nil, horde = nil, beide = "Alterac Mountains, Hillsbrad Foothills, Wetlands, Arathi Highlands, Stranglethorn Vale", hinweis = "Tin from 65, Silver from 75 (rare - grab it along the way)." },
    { minSkill = 125, maxSkill = 175, typ = "sammeln", item = "Iron Ore, Gold Ore", mats = "",
      allianz = nil, horde = nil, beide = "Badlands, Searing Gorge, Dustwallow Marsh, Feralas, Swamp of Sorrows", hinweis = "Iron from 125, Gold from 155." },
    { minSkill = 175, maxSkill = 245, typ = "sammeln", item = "Mithril Ore, Truesilver Ore", mats = "",
      allianz = nil, horde = nil, beide = "Azshara, Burning Steppes, Eastern Plaguelands, Felwood, Winterspring", hinweis = "Mithril from 175, Truesilver from 230." },
    { minSkill = 245, maxSkill = 300, typ = "sammeln", item = "Thorium Ore", mats = "",
      allianz = nil, horde = nil, beide = "Silithus, Un'Goro Crater, Western Plaguelands", hinweis = "Small Thorium Veins from 245, Rich Thorium Veins from 275." },
}
BerufeGuideDB["Kräuterkunde"] = {
    { minSkill = 1, maxSkill = 50, typ = "sammeln", item = "Peacebloom, Silverleaf, Earthroot", mats = "",
      allianz = "Elwynn Forest, Dun Morogh, Teldrassil, Westfall", horde = "Durotar, Mulgore, Tirisfal Glades", beide = nil, hinweis = "Peacebloom and Silverleaf from 1, Earthroot from 15." },
    { minSkill = 50, maxSkill = 100, typ = "sammeln", item = "Mageroyal, Briarthorn, Stranglekelp", mats = "",
      allianz = "Westfall, Loch Modan, Darkshore", horde = "The Barrens, Silverpine Forest", beide = nil, hinweis = "Mageroyal from 50, Briarthorn from 70, Stranglekelp from 85 (underwater)." },
    { minSkill = 100, maxSkill = 150, typ = "sammeln", item = "Bruiseweed, Wild Steelbloom, Grave Moss, Kingsblood", mats = "",
      allianz = "Redridge Mountains, Wetlands, Duskwood, Ashenvale", horde = "The Barrens, Stonetalon Mountains, Hillsbrad Foothills, Ashenvale", beide = nil, hinweis = "Bruiseweed from 100, Wild Steelbloom 115, Grave Moss 120, Kingsblood 125." },
    { minSkill = 150, maxSkill = 205, typ = "sammeln", item = "Liferoot, Fadeleaf, Goldthorn, Khadgar's Whisker, Wintersbite", mats = "",
      allianz = nil, horde = nil, beide = "Arathi Highlands, Stranglethorn Vale, Dustwallow Marsh, Swamp of Sorrows, Alterac Mountains", hinweis = "Liferoot from 150, Fadeleaf 160, Goldthorn 170, Khadgar's Whisker 185, Wintersbite 195." },
    { minSkill = 205, maxSkill = 250, typ = "sammeln", item = "Firebloom, Purple Lotus, Arthas' Tears, Sungrass, Blindweed, Ghost Mushroom", mats = "",
      allianz = nil, horde = nil, beide = "Searing Gorge, Badlands, Tanaris, Feralas, The Hinterlands, Felwood", hinweis = "Firebloom from 205, Purple Lotus 210, Arthas' Tears 220, Sungrass 230, Blindweed 235, Ghost Mushroom 245." },
    { minSkill = 250, maxSkill = 300, typ = "sammeln", item = "Gromsblood, Golden Sansam, Dreamfoil, Mountain Silversage, Plaguebloom, Icecap", mats = "",
      allianz = nil, horde = nil, beide = "Un'Goro Crater, Felwood, Azshara, Eastern Plaguelands, Western Plaguelands, Winterspring, Silithus", hinweis = "Gromsblood from 250, Golden Sansam 260, Dreamfoil 270, Mountain Silversage 280, Plaguebloom 285, Icecap 290." },
}
BerufeGuideDB["Kürschnerei"] = {
    { minSkill = 1, maxSkill = 100, typ = "sammeln", item = "Light Leather", mats = "",
      allianz = "Elwynn Forest, Teldrassil", horde = "Mulgore", beide = nil, hinweis = "Beasts level 6-20. Up to skill 100: max beast level = skill / 10 + 10." },
    { minSkill = 100, maxSkill = 165, typ = "sammeln", item = "Medium Leather, Light Leather", mats = "",
      allianz = "Stonetalon Mountains, Wetlands", horde = "Stranglethorn Vale, Arathi Highlands", beide = nil, hinweis = "Beasts level 21-30 are ideal. From skill 100: max beast level = skill / 5." },
    { minSkill = 165, maxSkill = 225, typ = "sammeln", item = "Heavy Leather, Thick Leather", mats = "",
      allianz = "Tanaris, Feralas", horde = "Tanaris, Feralas, Felwood", beide = nil, hinweis = "Heavy Leather from beasts level 25-45, Thick Leather from about level 36 (ideal 41-50)." },
    { minSkill = 225, maxSkill = 300, typ = "sammeln", item = "Rugged Leather", mats = "",
      allianz = nil, horde = nil, beide = "Un'Goro Crater, Eastern Plaguelands, Winterspring", hinweis = "Beasts level 51-60 are ideal." },
}
end
