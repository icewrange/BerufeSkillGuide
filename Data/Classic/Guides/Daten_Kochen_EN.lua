-- ============================================================================
-- DATABASE: COOKING SKILL GUIDE (1 - 300) - ENGLISH
-- ============================================================================
-- NOTE: The last tier's item name/materials (275-300) have lower
-- translation confidence than the rest - please report if incorrect.
BerufeGuideDB = BerufeGuideDB or {}

if GetLocale() ~= "deDE" then
BerufeGuideDB["Kochkunst"] = {
    { minSkill = 1,   maxSkill = 50,  item = "50 Brilliant Smallfish", mats = "1 Raw Brilliant Smallfish" },
    { minSkill = 50,  maxSkill = 100, item = "50 Longjaw Mud Snapper", mats = "1 Raw Longjaw Mud Snapper" },
    { minSkill = 100, maxSkill = 150, item = "50 Bristle Whisker Catfish", mats = "1 Raw Bristle Whisker Catfish" },
    { minSkill = 150, maxSkill = 175, item = "70 Bristle Whisker Catfish", mats = "1 Raw Bristle Whisker Catfish" },
    { minSkill = 175, maxSkill = 225, item = "60 Mithril Headed Trout", mats = "1 Raw Mithril Head Trout" },
    { minSkill = 225, maxSkill = 275, item = "70 Spotted Yellowtail", mats = "1 Raw Spotted Yellowtail" },
    { minSkill = 275, maxSkill = 300, item = "25 Mightfish Steak", mats = "1 Large Raw Mightfish, 1 Hot Spices, 1 Soothing Spices" },
}
end
