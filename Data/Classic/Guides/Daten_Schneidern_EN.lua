-- ============================================================================
-- DATABASE: TAILORING SKILL GUIDE (1 - 300) - ENGLISH
-- ============================================================================
-- FIX: "mats" now states the material needed for ONE SINGLE craft (see
-- Daten_Schneidern.lua for why - it used to store an already-totaled
-- amount, which Search.lua then multiplied again by remaining skill
-- points, producing wildly inflated totals).
BerufeGuideDB = BerufeGuideDB or {}

if GetLocale() ~= "deDE" then
BerufeGuideDB["Schneidern"] = {
    { minSkill = 1, maxSkill = 45, item = "95 Bolt of Linen Cloth", mats = "2 Linen Cloth" },
    { minSkill = 45, maxSkill = 70, item = "25 Linen Belt", mats = "1 Bolt of Linen Cloth, 1 Coarse Thread" },
    { minSkill = 70, maxSkill = 75, item = "5 Reinforced Linen Cape", mats = "2 Bolt of Linen Cloth, 3 Coarse Thread" },
    { minSkill = 75, maxSkill = 100, item = "45 Bolt of Woolen Cloth", mats = "3 Wool Cloth" },
    { minSkill = 100, maxSkill = 110, item = "15 Simple Kilt", mats = "4 Bolt of Linen Cloth, 1 Fine Thread" },
    { minSkill = 110, maxSkill = 125, item = "15 Double-Stitched Woolen Shoulders", mats = "3 Bolt of Woolen Cloth, 2 Fine Thread" },
    { minSkill = 125, maxSkill = 145, item = "205 Bolt of Silk Cloth", mats = "4 Silk Cloth" },
    { minSkill = 145, maxSkill = 160, item = "20 Azure Silk Hood", mats = "2 Bolt of Silk Cloth, 1 Fine Thread, 2 Blue Dye" },
    { minSkill = 160, maxSkill = 170, item = "10 Silk Headband", mats = "3 Bolt of Silk Cloth, 2 Fine Thread" },
    { minSkill = 170, maxSkill = 175, item = "5 Formal White Shirt", mats = "3 Bolt of Silk Cloth, 1 Fine Thread, 2 Bleach" },
    { minSkill = 175, maxSkill = 185, item = "100 Bolt of Mageweave", mats = "5 Mageweave Cloth" },
    { minSkill = 185, maxSkill = 205, item = "20 Crimson Silk Vest", mats = "4 Bolt of Silk Cloth, 2 Fine Thread, 2 Red Dye" },
    { minSkill = 205, maxSkill = 215, item = "10 Crimson Silk Pantaloons", mats = "4 Bolt of Silk Cloth, 2 Silken Thread, 2 Red Dye" },
    { minSkill = 215, maxSkill = 220, item = "5 Orange Mageweave Shirt", mats = "1 Bolt of Mageweave, 1 Heavy Silken Thread, 1 Orange Dye" },
    { minSkill = 220, maxSkill = 230, item = "10 Black Mageweave Gloves", mats = "2 Bolt of Mageweave, 2 Heavy Silken Thread" },
    { minSkill = 230, maxSkill = 250, item = "25 Black Mageweave Headband", mats = "3 Bolt of Mageweave, 2 Heavy Silken Thread" },
    { minSkill = 250, maxSkill = 260, item = "155 Bolt of Runecloth", mats = "5 Runecloth" },
    { minSkill = 260, maxSkill = 280, item = "25 Runecloth Belt", mats = "3 Bolt of Runecloth, 1 Rune Thread" },
    { minSkill = 280, maxSkill = 300, item = "20 Runecloth Gloves", mats = "4 Bolt of Runecloth, 4 Rugged Leather, 1 Rune Thread" },
}
end
