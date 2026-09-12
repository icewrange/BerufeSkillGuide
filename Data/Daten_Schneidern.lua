-- ============================================================================
-- DATABASE: SCHNEIDERN SKILL GUIDE (1 - 300)
-- ============================================================================
BerufeGuideDB = BerufeGuideDB or {}
BerufeGuideDB["Schneidern"] = {
    -- ------------------------------------------------------------------------
    -- BILD 1 & 2: LEHRLING & GESELLE (SKILL 1 - 125)
    -- ------------------------------------------------------------------------
    { minSkill = 1, maxSkill = 45, item = "95 Leinenstoffballen", mats = "190 Leinenstoff" },
    { minSkill = 45, maxSkill = 70, item = "25 Leinengürtel", mats = "25 Leinenstoffballen, 25 Grober Faden" },
    { minSkill = 70, maxSkill = 75, item = "5 Verstärktes Leinencape", mats = "10 Leinenstoffballen, 15 Grober Faden" },
    { minSkill = 75, maxSkill = 100, item = "45 Wollstoffballen", mats = "135 Wollstoff" },
    { minSkill = 100, maxSkill = 110, item = "15 Einfacher Kilt", mats = "60 Leinenstoffballen, 15 Feiner Faden" },
    { minSkill = 110, maxSkill = 125, item = "15 Doppeltgenähte Wollschultern", mats = "45 Wollstoffballen, 30 Feiner Faden" },

    -- ------------------------------------------------------------------------
    -- BILD 3: EXPERTE (SKILL 125 - 220)
    -- ------------------------------------------------------------------------
    { minSkill = 125, maxSkill = 145, item = "205 Seidenstoffballen", mats = "820 Seidenstoff" },
    { minSkill = 145, maxSkill = 160, item = "20 Azurblaue Seidenkapuze", mats = "40 Seidenstoffballen, 20 Feiner Faden, 40 Blauer Farbstoff" },
    { minSkill = 160, maxSkill = 170, item = "10 Seidenes Stirnband", mats = "30 Seidenstoffballen, 20 Feiner Faden" },
    { minSkill = 170, maxSkill = 175, item = "5 Formelles weißes Hemd", mats = "15 Seidenstoffballen, 5 Feiner Faden, 10 Bleiche" },
    { minSkill = 175, maxSkill = 185, item = "100 Magiestoffballen", mats = "500 Magiestoff" },
    { minSkill = 185, maxSkill = 205, item = "20 Purpurrote Seidenweste", mats = "80 Seidenstoffballen, 40 Feiner Faden, 40 Roter Farbstoff" },
    { minSkill = 205, maxSkill = 215, item = "10 Purpurrote Seidenpantalons", mats = "40 Seidenstoffballen, 20 Seidenfaden, 20 Roter Farbstoff" },
    { minSkill = 215, maxSkill = 220, item = "5 Oranges Magiestoffhemd", mats = "5 Magiestoffballen, 5 Schwerer Seidenfaden, 5 Oranger Farbstoff" },

    -- ------------------------------------------------------------------------
    -- BILD 4: MEISTER (SKILL 220 - 300)
    -- ------------------------------------------------------------------------
    { minSkill = 220, maxSkill = 230, item = "10 Schwarze Magiestoffhandschuhe", mats = "20 Magiestoffballen, 20 Schwerer Seidenfaden" },
    { minSkill = 230, maxSkill = 250, item = "25 Schwarzes Magiestoffstirnband", mats = "75 Magiestoffballen, 50 Schwerer Seidenfaden" },
    { minSkill = 250, maxSkill = 260, item = "155 Runenstoffballen", mats = "775 Runenstoff" },
    { minSkill = 260, maxSkill = 280, item = "25 Runenstoffgürtel", mats = "75 Runenstoffballen, 25 Runenfaden" },
    { minSkill = 280, maxSkill = 300, item = "20 Runenstoffhandschuhe", mats = "80 Runenstoffballen, 80 Unverwüstliches Leder, 20 Runenfaden" },
}
