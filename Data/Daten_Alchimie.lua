-- ============================================================================
-- DATABASE: ALCHIMIE SKILL GUIDE (1 - 300)
-- ============================================================================
-- NEU AUFGEBAUT auf Basis von Wowheads offiziellem deutschen Leveling-Guide
-- (wowhead.com/classic/de/guide/alchemy-leveling-1-300-wow-classic).
-- Vorherige Version enthielt falsche Materialnamen, die nicht zu den
-- DB-Keys in Daten_Items.lua passten (z.B. "Beisswurz" statt "Beulenbeere",
-- "Wildbiberstaengel" statt "Wildstahlblume").
BerufeGuideDB = BerufeGuideDB or {}
BerufeGuideDB["Alchimie"] = {
    -- ------------------------------------------------------------------------
    -- LEHRLING (SKILL 1 - 60)
    -- ------------------------------------------------------------------------
    { minSkill = 1,   maxSkill = 60,  item = "ca. 59 Schwacher Heiltrank", mats = "1 Friedensblume, 1 Silberblatt, 1 Leere Phiole" },

    -- ------------------------------------------------------------------------
    -- GESELLE (SKILL 60 - 140)
    -- ------------------------------------------------------------------------
    { minSkill = 60,  maxSkill = 110, item = "ca. 59 Geringer Heiltrank", mats = "1 Schwacher Heiltrank, 1 Wilddornrose" },
    { minSkill = 110, maxSkill = 140, item = "30 Heiltrank", mats = "1 Beulenbeere, 1 Wilddornrose, 1 Verbleite Phiole" },

    -- ------------------------------------------------------------------------
    -- EXPERTE (SKILL 140 - 215)
    -- ------------------------------------------------------------------------
    { minSkill = 140, maxSkill = 155, item = "15 Geringer Manatrank", mats = "1 Maguskönigskraut, 1 Würgetang, 1 Leere Phiole" },
    { minSkill = 155, maxSkill = 185, item = "30 Großer Heiltrank", mats = "1 Lebenswurz, 1 Königsblut, 1 Verbleite Phiole" },
    { minSkill = 185, maxSkill = 210, item = "25 Elixier der Beweglichkeit", mats = "1 Würgetang, 1 Golddorn, 1 Verbleite Phiole" },
    { minSkill = 210, maxSkill = 215, item = "10 Elixier der großen Verteidigung", mats = "1 Wildstahlblume, 1 Golddorn, 1 Verbleite Phiole" },

    -- ------------------------------------------------------------------------
    -- MEISTER (SKILL 215 - 300)
    -- ------------------------------------------------------------------------
    { minSkill = 215, maxSkill = 230, item = "15 Überragender Heiltrank", mats = "1 Sonnengras, 1 Khadgars Schnurrbart, 1 Kristallphiole" },
    -- Einmaliger Zwischenschritt (kein wiederholbares Leveling-Rezept),
    -- aber notwendig für lückenlose Skill-Bereiche und für Transmutationen.
    { minSkill = 230, maxSkill = 231, item = "1 Stein der Weisen", mats = "4 Eisenbarren, 1 Schwarzes Vitriol, 4 Lila Lotus, 4 Feuerblüte" },
    { minSkill = 231, maxSkill = 250, item = "19 Elixier der Untotenentdeckung", mats = "1 Arthas Tränen, 1 Kristallphiole" },
    { minSkill = 250, maxSkill = 265, item = "15 Elixier der großen Beweglichkeit", mats = "1 Sonnengras, 1 Golddorn, 1 Kristallphiole" },
    { minSkill = 265, maxSkill = 285, item = "20 Überragender Manatrank", mats = "2 Sonnengras, 2 Blindkraut, 1 Kristallphiole" },
    { minSkill = 285, maxSkill = 300, item = "ca. 18 Erheblicher Heiltrank", mats = "2 Goldener Sansam, 1 Bergsilberweisling, 1 Kristallphiole" },
}
