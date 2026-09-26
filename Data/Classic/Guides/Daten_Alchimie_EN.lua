-- ============================================================================
-- DATABASE: ALCHEMY SKILL GUIDE (1 - 300) - ENGLISH
-- ============================================================================
-- Only loads on non-German clients. Same skill ranges/quantities as the
-- German version (Daten_Alchimie.lua), only names translated. Translated
-- from general Classic WoW knowledge, not independently re-verified
-- against Wowhead item-by-item like the German data was - please report
-- any incorrect names.
BerufeGuideDB = BerufeGuideDB or {}

if GetLocale() ~= "deDE" then
BerufeGuideDB["Alchimie"] = {
    { minSkill = 1,   maxSkill = 60,  item = "ca. 59 Minor Healing Potion", mats = "1 Peacebloom, 1 Silverleaf, 1 Empty Vial" },
    { minSkill = 60,  maxSkill = 110, item = "ca. 59 Lesser Healing Potion", mats = "1 Minor Healing Potion, 1 Briarthorn" },
    { minSkill = 110, maxSkill = 140, item = "30 Healing Potion", mats = "1 Bruiseweed, 1 Briarthorn, 1 Leaded Vial" },
    { minSkill = 140, maxSkill = 155, item = "15 Lesser Mana Potion", mats = "1 Mageroyal, 1 Stranglekelp, 1 Empty Vial" },
    { minSkill = 155, maxSkill = 185, item = "30 Greater Healing Potion", mats = "1 Liferoot, 1 Kingsblood, 1 Leaded Vial" },
    { minSkill = 185, maxSkill = 210, item = "25 Elixir of Agility", mats = "1 Stranglekelp, 1 Goldthorn, 1 Leaded Vial" },
    { minSkill = 210, maxSkill = 215, item = "10 Elixir of Greater Defense", mats = "1 Wild Steelbloom, 1 Goldthorn, 1 Leaded Vial" },
    { minSkill = 215, maxSkill = 230, item = "15 Superior Healing Potion", mats = "1 Sungrass, 1 Khadgar's Whisker, 1 Crystal Vial" },
    -- One-time checkpoint (not a repeatable levelling recipe), but
    -- needed for continuous skill ranges and to unlock transmutes.
    { minSkill = 230, maxSkill = 231, item = "1 Philosopher's Stone", mats = "4 Iron Bar, 1 Black Vitriol, 4 Purple Lotus, 4 Firebloom" },
    { minSkill = 231, maxSkill = 250, item = "19 Elixir of Detect Undead", mats = "1 Arthas' Tears, 1 Crystal Vial" },
    { minSkill = 250, maxSkill = 265, item = "15 Elixir of Greater Agility", mats = "1 Sungrass, 1 Goldthorn, 1 Crystal Vial" },
    { minSkill = 265, maxSkill = 285, item = "20 Superior Mana Potion", mats = "2 Sungrass, 2 Blindweed, 1 Crystal Vial" },
    { minSkill = 285, maxSkill = 300, item = "ca. 18 Major Healing Potion", mats = "2 Golden Sansam, 1 Mountain Silversage, 1 Crystal Vial" },
}
end
