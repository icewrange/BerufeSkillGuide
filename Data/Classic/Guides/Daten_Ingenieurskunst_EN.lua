-- ============================================================================
-- DATABASE: ENGINEERING SKILL GUIDE (1 - 300) - ENGLISH
-- ============================================================================
-- FIX: "mats" now states the material needed for ONE SINGLE craft (see
-- Daten_Ingenieurskunst.lua for why - it used to store an already-totaled
-- amount, which Search.lua then multiplied again by remaining skill
-- points, producing wildly inflated totals).
BerufeGuideDB = BerufeGuideDB or {}

if GetLocale() ~= "deDE" then
BerufeGuideDB["Ingenieurskunst"] = {
    { minSkill = 1, maxSkill = 30, item = "60 Rough Blasting Powder", mats = "1 Rough Stone" },
    { minSkill = 30, maxSkill = 50, item = "30 Handful of Copper Bolts", mats = "1 Copper Bar" },
    { minSkill = 50, maxSkill = 51, item = "1 Arclight Spanner", mats = "6 Copper Bar" },
    { minSkill = 51, maxSkill = 75, item = "ca. 30 Rough Copper Bomb", mats = "1 Copper Bar, 1 Handful of Copper Bolts, 2 Rough Blasting Powder, 1 Linen Cloth" },
    { minSkill = 75, maxSkill = 90, item = "ca. 60 Coarse Blasting Powder", mats = "1 Coarse Stone" },
    { minSkill = 90, maxSkill = 100, item = "ca. 20 Coarse Dynamite", mats = "3 Coarse Blasting Powder, 1 Linen Cloth" },
    { minSkill = 100, maxSkill = 105, item = "5 Silver Contact", mats = "1 Silver Bar" },
    { minSkill = 105, maxSkill = 125, item = "25 Bronze Tube", mats = "2 Bronze Bar, 1 Weak Flux" },
    { minSkill = 125, maxSkill = 135, item = "10 Standard Scope", mats = "1 Bronze Tube, 1 Moss Agate" },
    -- FIX: overlapping minSkill (both were 135) meant one of these two
    -- steps could be skipped in the guide depending on table order. Now
    -- forms a continuous chain: 135-140 -> 140-150.
    { minSkill = 135, maxSkill = 140, item = "30 Heavy Blasting Powder", mats = "1 Heavy Stone" },
    { minSkill = 140, maxSkill = 150, item = "15 Whirring Bronze Gizmo", mats = "2 Bronze Bar, 1 Wool Cloth" },
    { minSkill = 150, maxSkill = 160, item = "15 Bronze Framework", mats = "2 Bronze Bar, 1 Medium Leather, 1 Wool Cloth" },
    { minSkill = 160, maxSkill = 175, item = "15 Explosive Sheep", mats = "1 Bronze Framework, 1 Whirring Bronze Gizmo, 2 Heavy Blasting Powder, 2 Wool Cloth" },
    { minSkill = 175, maxSkill = 176, item = "1 Gyromatic Micro-Adjustor", mats = "4 Steel Bar" },
    { minSkill = 176, maxSkill = 195, item = "60 Solid Blasting Powder", mats = "2 Solid Stone" },
    { minSkill = 195, maxSkill = 200, item = "ca. 7 Mithril Tube", mats = "3 Mithril Bar" },
    { minSkill = 200, maxSkill = 215, item = "20 Unstable Trigger", mats = "1 Mithril Bar, 1 Mageweave Cloth, 1 Solid Blasting Powder" },
    { minSkill = 215, maxSkill = 238, item = "40 Mithril Casing", mats = "3 Mithril Bar" },
    { minSkill = 238, maxSkill = 250, item = "20 Hi-Explosive Bomb", mats = "2 Mithril Casing, 1 Unstable Trigger, 2 Solid Blasting Powder" },
    { minSkill = 250, maxSkill = 260, item = "ca. 30 Dense Blasting Powder", mats = "2 Dense Stone" },
    { minSkill = 260, maxSkill = 285, item = "ca. 35 Thorium Widget", mats = "3 Thorium Bar, 1 Runecloth" },
    { minSkill = 285, maxSkill = 300, item = "15 Thorium Shells", mats = "2 Thorium Bar, 1 Dense Blasting Powder" },
}
end
