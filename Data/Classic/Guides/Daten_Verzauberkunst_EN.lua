-- ============================================================================
-- DATABASE: ENCHANTING SKILL GUIDE (1 - 300) - ENGLISH
-- ============================================================================
-- FIX: "mats" now states the material needed for ONE SINGLE craft (see
-- Daten_Verzauberkunst.lua for why - it used to store an already-totaled
-- amount, which Search.lua then multiplied again by remaining skill
-- points, producing wildly inflated totals).
BerufeGuideDB = BerufeGuideDB or {}

if GetLocale() ~= "deDE" then
BerufeGuideDB["Verzauberkunst"] = {
    { minSkill = 1, maxSkill = 2, item = "1 Runed Copper Rod", mats = "1 Copper Rod, 1 Strange Dust, 1 Lesser Magic Essence" },
    { minSkill = 2, maxSkill = 50, item = "ca. 48 Bracer - Minor Health", mats = "1 Strange Dust" },
    { minSkill = 50, maxSkill = 90, item = "ca. 60 Bracer - Minor Health", mats = "1 Strange Dust" },
    { minSkill = 90, maxSkill = 100, item = "10 Bracer - Minor Stamina", mats = "3 Strange Dust" },
    { minSkill = 100, maxSkill = 101, item = "1 Runed Silver Rod", mats = "1 Silver Rod, 6 Strange Dust, 3 Greater Magic Essence, 1 Shadowgem" },
    { minSkill = 101, maxSkill = 110, item = "9 Greater Magic Wand", mats = "1 Simple Wood, 1 Greater Magic Essence" },
    { minSkill = 110, maxSkill = 135, item = "25 Cloak - Minor Agility", mats = "1 Lesser Astral Essence" },
    { minSkill = 135, maxSkill = 155, item = "20 Bracer - Lesser Stamina", mats = "2 Soul Dust" },
    { minSkill = 155, maxSkill = 156, item = "1 Runed Golden Rod", mats = "1 Golden Rod, 1 Iridescent Pearl, 2 Greater Astral Essence, 2 Soul Dust" },
    { minSkill = 156, maxSkill = 185, item = "ca. 40 Bracer - Lesser Strength", mats = "2 Soul Dust" },
    { minSkill = 185, maxSkill = 200, item = "15 Bracer - Strength", mats = "1 Vision Dust" },
    { minSkill = 200, maxSkill = 201, item = "1 Runed Truesilver Rod", mats = "1 Truesilver Rod, 1 Black Pearl, 2 Greater Mystic Essence, 2 Vision Dust" },
    { minSkill = 201, maxSkill = 220, item = "ca. 25 Bracer - Strength", mats = "1 Vision Dust" },
    { minSkill = 220, maxSkill = 225, item = "5 Cloak - Greater Defense", mats = "3 Vision Dust" },
    { minSkill = 225, maxSkill = 230, item = "5 Gloves - Agility", mats = "1 Lesser Nether Essence, 1 Vision Dust" },
    { minSkill = 230, maxSkill = 235, item = "5 Boots - Stamina", mats = "5 Vision Dust" },
    { minSkill = 235, maxSkill = 250, item = "ca. 25 Chest - Superior Health", mats = "6 Vision Dust" },
    { minSkill = 250, maxSkill = 265, item = "ca. 20 Lesser Mana Oil", mats = "3 Dream Dust, 2 Purple Lotus, 1 Crystal Vial" },
    { minSkill = 265, maxSkill = 294, item = "ca. 30 Shield - Greater Stamina", mats = "10 Dream Dust" },
    { minSkill = 294, maxSkill = 295, item = "1 Runed Arcanite Rod", mats = "1 Arcanite Rod, 1 Golden Pearl, 10 Illusion Dust, 4 Greater Eternal Essence, 4 Small Brilliant Shard, 2 Large Brilliant Shard" },
    { minSkill = 295, maxSkill = 300, item = "5 Cloak - Superior Defense", mats = "8 Illusion Dust" },
}
end
