-- ============================================================================
-- DATABASE: LEATHERWORKING SKILL GUIDE (1 - 300) - ENGLISH
-- ============================================================================
-- FIX: "mats" now states the material needed for ONE SINGLE craft (see
-- Daten_Lederverarbeitung.lua for why - it used to store an already-totaled
-- amount, which Search.lua then multiplied again by remaining skill
-- points, producing wildly inflated totals).
BerufeGuideDB = BerufeGuideDB or {}

if GetLocale() ~= "deDE" then
BerufeGuideDB["Lederverarbeitung"] = {
    { minSkill = 1, maxSkill = 30, item = "30 Light Leather", mats = "3 Ruined Leather Scraps" },
    { minSkill = 30, maxSkill = 45, item = "ca. 18 Light Armor Kit", mats = "1 Light Leather" },
    { minSkill = 45, maxSkill = 55, item = "10 Cured Light Hide", mats = "1 Light Hide, 1 Salt" },
    { minSkill = 55, maxSkill = 85, item = "30 Embossed Leather Gloves", mats = "3 Light Leather, 2 Coarse Thread" },
    { minSkill = 85, maxSkill = 100, item = "15 Fine Leather Belt", mats = "6 Light Leather, 2 Coarse Thread" },
    { minSkill = 100, maxSkill = 115, item = "15 Cured Medium Hide", mats = "1 Medium Hide, 1 Salt" },
    { minSkill = 115, maxSkill = 125, item = "10 Dark Leather Boots", mats = "4 Medium Leather, 2 Fine Thread, 1 Gray Dye" },
    { minSkill = 125, maxSkill = 135, item = "ca. 12 Dark Leather Boots", mats = "4 Medium Leather, 2 Fine Thread, 1 Gray Dye" },
    { minSkill = 135, maxSkill = 150, item = "15 Dark Leather Belt", mats = "1 Fine Leather Belt, 1 Cured Medium Hide, 2 Fine Thread, 1 Gray Dye" },
    { minSkill = 150, maxSkill = 155, item = "5 Heavy Leather", mats = "5 Medium Leather" },
    { minSkill = 155, maxSkill = 160, item = "5 Cured Heavy Hide", mats = "1 Heavy Hide, 3 Salt" },
    { minSkill = 160, maxSkill = 180, item = "ca. 22 Heavy Armor Kit", mats = "5 Heavy Leather, 1 Fine Thread" },
    { minSkill = 180, maxSkill = 190, item = "10 Barbaric Shoulders", mats = "8 Heavy Leather, 1 Cured Heavy Hide, 2 Fine Thread" },
    { minSkill = 190, maxSkill = 200, item = "10 Guardian Gloves", mats = "4 Heavy Leather, 1 Cured Heavy Hide, 1 Silken Thread" },
    { minSkill = 200, maxSkill = 220, item = "20 Thick Armor Kit", mats = "5 Thick Leather, 1 Silken Thread" },
    { minSkill = 220, maxSkill = 230, item = "ca. 11 Nightscape Headband", mats = "5 Thick Leather, 2 Silken Thread" },
    { minSkill = 230, maxSkill = 250, item = "20 Nightscape Pants", mats = "14 Thick Leather, 4 Silken Thread" },
    { minSkill = 250, maxSkill = 260, item = "ca. 12 Rugged Armor Kit", mats = "5 Rugged Leather" },
    { minSkill = 260, maxSkill = 290, item = "ca. 32 Wicked Leather Gauntlets", mats = "8 Rugged Leather, 1 Black Dye, 1 Rune Thread" },
    { minSkill = 290, maxSkill = 300, item = "10 Wicked Leather Headband", mats = "12 Rugged Leather, 1 Black Dye, 1 Rune Thread" },
}
end
