-- ============================================================================
-- DATABASE: INGENIEURSKUNST SKILL GUIDE (1 - 300)
-- ============================================================================
BerufeGuideDB = BerufeGuideDB or {}
BerufeGuideDB["Ingenieurskunst"] = {
    -- ------------------------------------------------------------------------
    -- BILD 1: LEHRLING (SKILL 1 - 75)
    -- ------------------------------------------------------------------------
    { minSkill = 1, maxSkill = 30, item = "60 Raues Sprengpulver", mats = "60 Rauer Stein" },
    { minSkill = 30, maxSkill = 50, item = "30 Eine Hand voll Kupferbolzen", mats = "30 Kupferbarren" },
    { minSkill = 50, maxSkill = 51, item = "1 Bogenlichtschraubenschlüssel", mats = "6 Kupferbarren" },
    { minSkill = 51, maxSkill = 75, item = "ca. 30 Raue Kupferbombe", mats = "30 Kupferbarren, 30 Eine Hand voll Kupferbolzen, 60 Raues Sprengpulver, 30 Leinenstoff" },

    -- ------------------------------------------------------------------------
    -- BILD 2: GESELLE (SKILL 75 - 135)
    -- ------------------------------------------------------------------------
    { minSkill = 75, maxSkill = 90, item = "ca. 60 Grobes Sprengpulver", mats = "60 Grober Stein" },
    { minSkill = 90, maxSkill = 100, item = "ca. 20 Grobes Dynamit", mats = "60 Grobes Sprengpulver, 20 Leinenstoff" },
    { minSkill = 100, maxSkill = 105, item = "5 Silberkontakt", mats = "5 Silberbarren" },
    { minSkill = 105, maxSkill = 125, item = "25 Bronzeröhre", mats = "50 Bronzebarren, 25 Schwacher Fluxus" },
    { minSkill = 125, maxSkill = 135, item = "10 Standardzielfernrohr", mats = "10 Bronzeröhre, 10 Moosachat" },

    -- ------------------------------------------------------------------------
    -- BILD 3: EXPERTE (SKILL 135 - 200)
    -- ------------------------------------------------------------------------
    { minSkill = 135, maxSkill = 145, item = "30 Schweres Sprengpulver", mats = "30 Schwerer Stein" },
    { minSkill = 145, maxSkill = 150, item = "15 Surrendes bronzenes Dingsda", mats = "30 Bronzebarren, 15 Wollstoff" },
    { minSkill = 150, maxSkill = 160, item = "15 Bronzegerüst", mats = "30 Bronzebarren, 15 Mittleres Leder, 15 Wollstoff" },
    { minSkill = 160, maxSkill = 175, item = "15 Explodierendes Schaf", mats = "15 Bronzegerüst, 15 Surrendes bronzenes Dingsda, 30 Schweres Sprengpulver, 30 Wollstoff" },
    { minSkill = 175, maxSkill = 176, item = "1 Gyromatischer Mikroregler", mats = "4 Stahlbarren" },
    { minSkill = 176, maxSkill = 195, item = "60 Robustes Sprengpulver", mats = "120 Robuster Stein" },
    { minSkill = 195, maxSkill = 200, item = "ca. 7 Mithrilrohr", mats = "21 Mithrilbarren" },

    -- ------------------------------------------------------------------------
    -- BILD 4: MEISTER (SKILL 200 - 300)
    -- ------------------------------------------------------------------------
    { minSkill = 200, maxSkill = 215, item = "20 Instabiler Auslöser", mats = "20 Mithrilbarren, 20 Magiestoff, 20 Robustes Sprengpulver" },
    { minSkill = 215, maxSkill = 238, item = "40 Mithrilgehäuse", mats = "120 Mithrilbarren" },
    { minSkill = 238, maxSkill = 250, item = "20 Hochexplosive Bombe", mats = "40 Mithrilgehäuse, 20 Instabiler Auslöser, 40 Robustes Sprengpulver" },
    { minSkill = 250, maxSkill = 260, item = "ca. 30 Dichtes Sprengpulver", mats = "60 Verdichteter Stein" },
    { minSkill = 260, maxSkill = 285, item = "ca. 35 Thoriumapparat", mats = "105 Thoriumbarren, 35 Runenstoff" },
    { minSkill = 285, maxSkill = 300, item = "15 Thoriumpatronen", mats = "30 Thoriumbarren, 15 Dichtes Sprengpulver" },
}
