-- ============================================================================
-- DATABASE: SCHMIEDEKUNST SKILL GUIDE (1 - 300)
-- ============================================================================
-- NEU AUFGEBAUT auf Basis von Wowheads offiziellem deutschen Leveling-Guide
-- (wowhead.com/classic/de/guide/blacksmithing-leveling-1-300-wow-classic).
-- Die vorherige Version enthielt mehrere erfundene/falsche Rezepte (z.B.
-- "Kupferner Runenreif", "Gezackte Bronzeklinge", "Goldene Skelettschluessel"),
-- die es in Classic so nicht gibt bzw. mit falschen Namen/Mengen.
BerufeGuideDB = BerufeGuideDB or {}
BerufeGuideDB["Schmiedekunst"] = {
    -- ------------------------------------------------------------------------
    -- LEHRLING (SKILL 1 - 75)
    -- ------------------------------------------------------------------------
    { minSkill = 1,   maxSkill = 30,  item = "ca. 40 Rauer Wetzstein", mats = "40 Rauer Stein" },
    { minSkill = 30,  maxSkill = 65,  item = "ca. 60 Rauer Schleifstein", mats = "120 Rauer Stein" },
    { minSkill = 65,  maxSkill = 75,  item = "ca. 25 Grober Wetzstein", mats = "25 Grober Stein" },

    -- ------------------------------------------------------------------------
    -- GESELLE (SKILL 75 - 125)
    -- ------------------------------------------------------------------------
    { minSkill = 75,  maxSkill = 90,  item = "ca. 35 Grober Schleifstein", mats = "70 Grober Stein" },
    { minSkill = 90,  maxSkill = 100, item = "10 Runenverzierter Kupfergürtel", mats = "100 Kupferbarren" },
    { minSkill = 100, maxSkill = 105, item = "5 Silberrute", mats = "5 Silberbarren, 10 Rauer Schleifstein" },
    { minSkill = 105, maxSkill = 110, item = "5 Runenverzierter Kupfergürtel", mats = "50 Kupferbarren" },
    { minSkill = 110, maxSkill = 125, item = "15 Raue bronzene Gamaschen", mats = "90 Bronzebarren" },

    -- ------------------------------------------------------------------------
    -- EXPERTE (SKILL 125 - 225)
    -- ------------------------------------------------------------------------
    { minSkill = 125, maxSkill = 140, item = "ca. 35 Schwerer Schleifstein", mats = "105 Schwerer Stein" },
    { minSkill = 140, maxSkill = 150, item = "10 Gemusterte bronzene Armschienen", mats = "50 Bronzebarren, 20 Grober Schleifstein" },
    { minSkill = 150, maxSkill = 155, item = "5 Goldrute", mats = "5 Goldbarren, 10 Grober Schleifstein" },
    { minSkill = 155, maxSkill = 165, item = "10 Grüne Eisengamaschen", mats = "80 Eisenbarren, 10 Schwerer Schleifstein, 10 Grüner Farbstoff" },
    { minSkill = 165, maxSkill = 190, item = "25 Grüne Eisenarmschienen", mats = "150 Eisenbarren, 25 Grüner Farbstoff" },
    { minSkill = 190, maxSkill = 200, item = "10 Goldene Schuppenarmschienen", mats = "50 Stahlbarren, 20 Schwerer Schleifstein" },
    { minSkill = 200, maxSkill = 210, item = "ca. 30 Robuster Schleifstein", mats = "120 Robuster Stein" },
    { minSkill = 210, maxSkill = 225, item = "15 Schwere Mithrilstulpen", mats = "90 Mithrilbarren, 60 Magiestoff" },

    -- ------------------------------------------------------------------------
    -- MEISTER (SKILL 225 - 300)
    -- ------------------------------------------------------------------------
    { minSkill = 225, maxSkill = 235, item = "10 Stahlplattenhelm", mats = "140 Stahlbarren, 10 Robuster Schleifstein" },
    { minSkill = 235, maxSkill = 250, item = "15 Mithrilhelmkappe", mats = "150 Mithrilbarren, 90 Magiestoff" },
    { minSkill = 250, maxSkill = 260, item = "ca. 20 Verdichteter Wetzstein", mats = "20 Verdichteter Stein" },
    { minSkill = 260, maxSkill = 270, item = "10 Thoriumgürtel", mats = "120 Thoriumbarren, 40 Roter Machtkristall" },
    { minSkill = 270, maxSkill = 275, item = "5 Thoriumarmschienen", mats = "60 Thoriumbarren, 20 Blauer Machtkristall" },
    { minSkill = 275, maxSkill = 290, item = "15 Imperiale Plattenarmschienen", mats = "300 Thoriumbarren, 15 Sternrubin" },
    { minSkill = 290, maxSkill = 300, item = "10 Thoriumstiefel", mats = "200 Thoriumbarren, 80 Unverwüstliches Leder, 40 Grüner Machtkristall" },
}

-- ----------------------------------------------------------------------------
-- OPTIONALE ALTERNATIV-ROUTE FÜR 260-300 (laut Wowhead, falls die
-- Drop-/Quest-Rezepte oben schwer zu bekommen sind). Nur als Referenz
-- auskommentiert, nicht aktiv im Guide:
-- ----------------------------------------------------------------------------
-- { minSkill = 260, maxSkill = 265, item = "ca. 7 Schwere Mithrilstiefel", mats = "98 Mithrilbarren, 28 Dickes Leder" },
-- { minSkill = 265, maxSkill = 270, item = "5 Imperialer Plattengürtel", mats = "110 Thoriumbarren, 30 Unverwüstliches Leder, 5 Aquamarin" },
-- { minSkill = 270, maxSkill = 295, item = "ca. 27 Imperiale Plattenarmschienen", mats = "540 Thoriumbarren, 27 Sternrubin" },
-- { minSkill = 295, maxSkill = 300, item = "5 Imperiale Plattenstiefel", mats = "170 Thoriumbarren, 5 Sternrubin, 5 Aquamarin" },
-- { minSkill = 290, maxSkill = 300, item = "10 Strahlende Stiefel", mats = "140 Thoriumbarren, 40 Herz des Feuers" },
