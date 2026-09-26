-- ============================================================================
-- DATABASE: FIRST AID SKILL GUIDE (1 - 300) - ENGLISH
-- ============================================================================
-- Same ranges/quantities as Daten_ErsteHilfe.lua. From 125 you need the
-- book "Expert First Aid - Under Wraps", from 225 the quest "Triage".
BerufeGuideDB = BerufeGuideDB or {}

if GetLocale() ~= "deDE" then
BerufeGuideDB["Erste Hilfe"] = {
    { minSkill = 1,   maxSkill = 40,  item = "ca. 45 Linen Bandage",             mats = "1 Linen Cloth" },
    { minSkill = 40,  maxSkill = 80,  item = "ca. 50 Heavy Linen Bandage",       mats = "2 Linen Cloth" },
    { minSkill = 80,  maxSkill = 115, item = "ca. 40 Wool Bandage",              mats = "1 Wool Cloth" },
    { minSkill = 115, maxSkill = 150, item = "ca. 40 Heavy Wool Bandage",        mats = "2 Wool Cloth" },
    { minSkill = 150, maxSkill = 180, item = "ca. 35 Silk Bandage",              mats = "1 Silk Cloth" },
    { minSkill = 180, maxSkill = 210, item = "ca. 35 Heavy Silk Bandage",        mats = "2 Silk Cloth" },
    { minSkill = 210, maxSkill = 240, item = "ca. 35 Mageweave Bandage",         mats = "1 Mageweave Cloth" },
    { minSkill = 240, maxSkill = 260, item = "ca. 25 Heavy Mageweave Bandage",   mats = "2 Mageweave Cloth" },
    { minSkill = 260, maxSkill = 290, item = "ca. 35 Runecloth Bandage",         mats = "1 Runecloth" },
    { minSkill = 290, maxSkill = 300, item = "ca. 10 Heavy Runecloth Bandage",   mats = "2 Runecloth" },
}
end
