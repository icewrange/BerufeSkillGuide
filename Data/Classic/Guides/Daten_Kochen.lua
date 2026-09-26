-- ============================================================================
-- DATABASE: KOCHKUNST SKILL GUIDE (1 - 300)
-- ============================================================================
-- Basiert auf dem offiziellen Wowhead-Fischerei-Leveling-Pfad, da dieser
-- durchgängig 1:1-Rezepte (1 Fisch pro Fertigung) und lückenlose
-- Skill-Bereiche bietet - unabhängig von Fraktion.
BerufeGuideDB = BerufeGuideDB or {}

-- Nur auf deutschen Clients laden - siehe Daten_Kochkunst_EN.lua für Englisch
if GetLocale() == "deDE" then
BerufeGuideDB["Kochkunst"] = {
    { minSkill = 1,   maxSkill = 50,  item = "50 Glänzender Kleinfisch", mats = "1 Roher glänzender Kleinfisch" },
    { minSkill = 50,  maxSkill = 100, item = "50 Langzahniger Matschschnapper", mats = "1 Roher Langzahniger Matschschnapper" },
    { minSkill = 100, maxSkill = 150, item = "50 Stoppelfühlerwels", mats = "1 Roher Stoppelfühlerwels" },
    { minSkill = 150, maxSkill = 175, item = "70 Stoppelfühlerwels", mats = "1 Roher Stoppelfühlerwels" },
    { minSkill = 175, maxSkill = 225, item = "60 Mithrilkopfforelle", mats = "1 Rohe Mithrilkopfforelle" },
    { minSkill = 225, maxSkill = 275, item = "70 Tüpfelgelbschwanz", mats = "1 Roher Tüpfelgelbschwanz" },
    { minSkill = 275, maxSkill = 300, item = "25 Machtfischsteak", mats = "1 Großer roher Machtfisch, 1 Scharfe Gewürze, 1 Feine Gewürze" },
}
end
