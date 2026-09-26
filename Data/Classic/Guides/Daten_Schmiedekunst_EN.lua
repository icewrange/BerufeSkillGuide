-- ============================================================================
-- DATABASE: BLACKSMITHING SKILL GUIDE (1 - 300) - ENGLISH
-- ============================================================================
-- Only loads on non-German clients. Same skill ranges/quantities as the
-- German version (Daten_Schmiedekunst.lua), only names translated.
-- FIX: "mats" now states the material needed for ONE SINGLE craft (see
-- Daten_Schmiedekunst.lua for why - it used to store an already-totaled
-- amount, which Search.lua then multiplied again by remaining skill
-- points, producing wildly inflated totals).
BerufeGuideDB = BerufeGuideDB or {}

if GetLocale() ~= "deDE" then
BerufeGuideDB["Schmiedekunst"] = {
    { minSkill = 1,   maxSkill = 30,  item = "ca. 40 Rough Sharpening Stone", mats = "1 Rough Stone" },
    { minSkill = 30,  maxSkill = 65,  item = "ca. 60 Rough Grinding Stone", mats = "2 Rough Stone" },
    { minSkill = 65,  maxSkill = 75,  item = "ca. 25 Coarse Sharpening Stone", mats = "1 Coarse Stone" },
    { minSkill = 75,  maxSkill = 90,  item = "ca. 35 Coarse Grinding Stone", mats = "2 Coarse Stone" },
    { minSkill = 90,  maxSkill = 100, item = "10 Runed Copper Belt", mats = "10 Copper Bar" },
    { minSkill = 100, maxSkill = 105, item = "5 Silver Rod", mats = "1 Silver Bar, 2 Rough Grinding Stone" },
    { minSkill = 105, maxSkill = 110, item = "5 Runed Copper Belt", mats = "10 Copper Bar" },
    { minSkill = 110, maxSkill = 125, item = "15 Rough Bronze Leggings", mats = "6 Bronze Bar" },
    { minSkill = 125, maxSkill = 140, item = "ca. 35 Heavy Grinding Stone", mats = "3 Heavy Stone" },
    { minSkill = 140, maxSkill = 150, item = "10 Patterned Bronze Bracers", mats = "5 Bronze Bar, 2 Coarse Grinding Stone" },
    { minSkill = 150, maxSkill = 155, item = "5 Golden Rod", mats = "1 Gold Bar, 2 Coarse Grinding Stone" },
    { minSkill = 155, maxSkill = 165, item = "10 Green Iron Leggings", mats = "8 Iron Bar, 1 Heavy Grinding Stone, 1 Green Dye" },
    { minSkill = 165, maxSkill = 190, item = "25 Green Iron Bracers", mats = "6 Iron Bar, 1 Green Dye" },
    { minSkill = 190, maxSkill = 200, item = "10 Golden Scale Bracers", mats = "5 Steel Bar, 2 Heavy Grinding Stone" },
    { minSkill = 200, maxSkill = 210, item = "ca. 30 Solid Grinding Stone", mats = "4 Solid Stone" },
    { minSkill = 210, maxSkill = 225, item = "15 Heavy Mithril Gauntlet", mats = "6 Mithril Bar, 4 Mageweave Cloth" },
    { minSkill = 225, maxSkill = 235, item = "10 Steel Plate Helm", mats = "14 Steel Bar, 1 Solid Grinding Stone" },
    { minSkill = 235, maxSkill = 250, item = "15 Mithril Coif", mats = "10 Mithril Bar, 6 Mageweave Cloth" },
    { minSkill = 250, maxSkill = 260, item = "ca. 20 Dense Sharpening Stone", mats = "1 Dense Stone" },
    { minSkill = 260, maxSkill = 270, item = "10 Thorium Belt", mats = "12 Thorium Bar, 4 Red Power Crystal" },
    { minSkill = 270, maxSkill = 275, item = "5 Thorium Bracers", mats = "12 Thorium Bar, 4 Blue Power Crystal" },
    { minSkill = 275, maxSkill = 290, item = "15 Imperial Plate Bracers", mats = "20 Thorium Bar, 1 Star Ruby" },
    { minSkill = 290, maxSkill = 300, item = "10 Thorium Boots", mats = "20 Thorium Bar, 8 Rugged Leather, 4 Green Power Crystal" },
}
end

-- ----------------------------------------------------------------------------
-- OPTIONAL ALTERNATIVE ROUTE FOR 260-300 (per Wowhead), commented out for
-- reference only, not active in the guide:
-- ----------------------------------------------------------------------------
-- { minSkill = 260, maxSkill = 265, item = "ca. 7 Heavy Mithril Boots", mats = "14 Mithril Bar, 4 Thick Leather" },
-- { minSkill = 265, maxSkill = 270, item = "5 Imperial Plate Belt", mats = "22 Thorium Bar, 6 Rugged Leather, 1 Aquamarine" },
-- { minSkill = 270, maxSkill = 295, item = "ca. 27 Imperial Plate Bracers", mats = "20 Thorium Bar, 1 Star Ruby" },
-- { minSkill = 295, maxSkill = 300, item = "5 Imperial Plate Boots", mats = "34 Thorium Bar, 1 Star Ruby, 1 Aquamarine" },
-- { minSkill = 290, maxSkill = 300, item = "10 Radiant Boots", mats = "14 Thorium Bar, 4 Heart of Fire" },
