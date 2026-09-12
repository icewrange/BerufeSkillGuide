-- ============================================================================
-- DATABASE: LEDERVERARBEITUNG SKILL GUIDE (1 - 300)
-- ============================================================================
BerufeGuideDB = BerufeGuideDB or {}
BerufeGuideDB["Lederverarbeitung"] = {
    -- ------------------------------------------------------------------------
    -- BILD 1 & 2: LEHRLING & GESELLE (SKILL 1 - 150)
    -- ------------------------------------------------------------------------
    { minSkill = 1, maxSkill = 30, item = "30 Leichtes Leder", mats = "90 Verdorbene Lederfetzen" },
    { minSkill = 30, maxSkill = 45, item = "ca. 18 Leichtes Rüstungsset", mats = "18 Leichtes Leder" },
    { minSkill = 45, maxSkill = 55, item = "10 Geschmeidiger leichter Balg", mats = "10 Leichter Balg, 10 Salz" },
    { minSkill = 55, maxSkill = 85, item = "30 Geprägte Lederhandschuhe", mats = "90 Leichtes Leder, 60 Grober Faden" },
    { minSkill = 85, maxSkill = 100, item = "15 Feiner Ledergürtel", mats = "90 Leichtes Leder, 30 Grober Faden" },
    { minSkill = 100, maxSkill = 115, item = "15 Geschmeidiger mittlerer Balg", mats = "15 Mittlerer Balg, 15 Salz" },
    { minSkill = 115, maxSkill = 125, item = "10 Dunkle Lederstiefel", mats = "40 Mittleres Leder, 20 Feiner Faden, 10 Grauer Farbstoff" },
    { minSkill = 125, maxSkill = 135, item = "ca. 12 Dunkle Lederstiefel", mats = "48 Mittleres Leder, 24 Feiner Faden, 12 Grauer Farbstoff" },
    { minSkill = 135, maxSkill = 150, item = "15 Dunkler Ledergürtel", mats = "15 Feiner Ledergürtel, 15 Geschmeidiger mittlerer Balg, 30 Feiner Faden, 15 Grauer Farbstoff" },

    -- ------------------------------------------------------------------------
    -- BILD 3: EXPERTE (SKILL 150 - 220)
    -- ------------------------------------------------------------------------
    { minSkill = 150, maxSkill = 155, item = "5 Schweres Leder", mats = "25 Mittleres Leder" },
    { minSkill = 155, maxSkill = 160, item = "5 Geschmeidiger schwerer Balg", mats = "5 Schwerer Balg, 15 Salz" },
    { minSkill = 160, maxSkill = 180, item = "ca. 22 Schweres Rüstungsset", mats = "110 Schweres Leder, 22 Feiner Faden" },
    { minSkill = 180, maxSkill = 190, item = "10 Barbarische Schultern", mats = "80 Schweres Leder, 10 Geschmeidiger schwerer Balg, 20 Feiner Faden" },
    { minSkill = 190, maxSkill = 200, item = "10 Wächterhandschuhe", mats = "40 Schweres Leder, 10 Geschmeidiger schwerer Balg, 10 Seidenfaden" },
    { minSkill = 200, maxSkill = 220, item = "20 Dickes Rüstungsset", mats = "100 Dickes Leder, 20 Seidenfaden" },

    -- ------------------------------------------------------------------------
    -- BILD 4: MEISTER (SKILL 220 - 300)
    -- ------------------------------------------------------------------------
    { minSkill = 220, maxSkill = 230, item = "ca. 11 Stirnband des Nachtschleichers", mats = "55 Dickes Leder, 22 Seidenfaden" },
    { minSkill = 230, maxSkill = 250, item = "20 Hose des Nachtschleichers", mats = "280 Dickes Leder, 80 Seidenfaden" },
    { minSkill = 250, maxSkill = 260, item = "ca. 12 Unverwüstliches Rüstungsset", mats = "60 Unverwüstliches Leder" },
    { minSkill = 260, maxSkill = 290, item = "ca. 32 Tückische Lederstulpen", mats = "256 Unverwüstliches Leder, 32 Schwarzer Farbstoff, 32 Runenfaden" },
    { minSkill = 290, maxSkill = 300, item = "10 Tückisches Lederstirnband", mats = "120 Unverwüstliches Leder, 10 Schwarzer Farbstoff, 10 Runenfaden" },
}
