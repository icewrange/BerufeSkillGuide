-- ============================================================================
-- DATABASE: ERSTE HILFE SKILL GUIDE (1 - 300)
-- ============================================================================
-- Route nach Wowheads deutschem Erste-Hilfe-Guide (Classic). "mats" = Stoff
-- für EINEN Verband, "item" = empfohlene Gesamt-Stückzahl der Spanne.
-- WICHTIG: Ab 125 braucht man das Buch "Erste Hilfe für Experten", ab 225
-- die Quest "Triage" (siehe Lehrer-Anzeige im Guide).
BerufeGuideDB = BerufeGuideDB or {}

if GetLocale() == "deDE" then
BerufeGuideDB["Erste Hilfe"] = {
    { minSkill = 1,   maxSkill = 40,  item = "ca. 45 Leinenverband",            mats = "1 Leinenstoff" },
    { minSkill = 40,  maxSkill = 80,  item = "ca. 50 Schwerer Leinenverband",   mats = "2 Leinenstoff" },
    { minSkill = 80,  maxSkill = 115, item = "ca. 40 Wollverband",              mats = "1 Wollstoff" },
    { minSkill = 115, maxSkill = 150, item = "ca. 40 Schwerer Wollverband",     mats = "2 Wollstoff" },
    { minSkill = 150, maxSkill = 180, item = "ca. 35 Seidenverband",            mats = "1 Seidenstoff" },
    { minSkill = 180, maxSkill = 210, item = "ca. 35 Schwerer Seidenverband",   mats = "2 Seidenstoff" },
    { minSkill = 210, maxSkill = 240, item = "ca. 35 Magiestoffverband",        mats = "1 Magiestoff" },
    { minSkill = 240, maxSkill = 260, item = "ca. 25 Schwerer Magiestoffverband", mats = "2 Magiestoff" },
    { minSkill = 260, maxSkill = 290, item = "ca. 35 Runenstoffverband",        mats = "1 Runenstoff" },
    { minSkill = 290, maxSkill = 300, item = "ca. 10 Schwerer Runenstoffverband", mats = "2 Runenstoff" },
}
end
