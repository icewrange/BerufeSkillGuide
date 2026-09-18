-- ============================================================================
-- DATABASE: ERSTE HILFE SKILL GUIDE (1 - 300)
-- ============================================================================
-- WICHTIG: Der Datenbank-Key ist bewusst "Erste Hilfe" MIT Leerzeichen,
-- weil das exakt dem Namen entspricht, den GetSkillLineInfo() im Spiel für
-- diesen Skill zurückgibt (siehe API.lua). Anders als bei den restigen
-- Berufen (z.B. "Schmiedekunst") ist der deutsche Skill-Name hier zwei
-- Wörter lang - für /bsg sim gibt es dafür den Alias "erstehilfe" in
-- SlashCommands.lua.
--
-- Quellen (Skill-Stufen, Item- & Materialnamen mehrfach querverglichen):
-- wow-professions.com First Aid Leveling Guide, buffed.de 1-300 Erste-
-- Hilfe-Levelguide, classic.goldgoblin.net Erste-Hilfe-Guide. Alle drei
-- stimmen bei den Skill-Grenzen exakt überein (1/40/80/115/150/180/210/
-- 240/260/290/300); Mengenangaben sind ca.-Werte wie bei den anderen
-- Berufen auch (echter Skill-Fortschritt ist zufallsbasiert).
BerufeGuideDB = BerufeGuideDB or {}
BerufeGuideDB["Erste Hilfe"] = {
    -- ------------------------------------------------------------------------
    -- LEHRLING / GESELLE (SKILL 1 - 150)
    -- ------------------------------------------------------------------------
    { minSkill = 1, maxSkill = 40, item = "ca. 50 Leinenverband", mats = "50 Leinenstoff" },
    { minSkill = 40, maxSkill = 80, item = "ca. 60 Schwerer Leinenverband", mats = "120 Leinenstoff" },
    { minSkill = 80, maxSkill = 115, item = "ca. 60 Wollverband", mats = "60 Wollstoff" },
    { minSkill = 115, maxSkill = 150, item = "ca. 60 Schwerer Wollverband", mats = "120 Wollstoff" },

    -- ------------------------------------------------------------------------
    -- EXPERTE (SKILL 150 - 225)
    -- ------------------------------------------------------------------------
    { minSkill = 150, maxSkill = 180, item = "ca. 50 Seidenverband", mats = "50 Seidenstoff" },
    { minSkill = 180, maxSkill = 210, item = "ca. 50 Schwerer Seidenverband", mats = "100 Seidenstoff" },
    { minSkill = 210, maxSkill = 240, item = "ca. 60 Magiestoffverband", mats = "60 Magiestoff" },

    -- ------------------------------------------------------------------------
    -- MEISTER (SKILL 240 - 300, Questreihe "Triage" ab Skill 225 + Stufe 35)
    -- ------------------------------------------------------------------------
    { minSkill = 240, maxSkill = 260, item = "ca. 30 Schwerer Magiestoffverband", mats = "60 Magiestoff" },
    { minSkill = 260, maxSkill = 290, item = "ca. 50 Runenstoffverband", mats = "50 Runenstoff" },
    { minSkill = 290, maxSkill = 300, item = "ca. 15 Schwerer Runenstoffverband", mats = "30 Runenstoff" },
}
