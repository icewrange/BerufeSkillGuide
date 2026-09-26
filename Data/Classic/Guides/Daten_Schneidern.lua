-- ============================================================================
-- DATABASE: SCHNEIDERN SKILL GUIDE (1 - 300)
-- ============================================================================
-- FIX: "mats" speicherte bisher die bereits für die GESAMTE Stückzahl aus
-- "item" aufsummierte Menge (z.B. 190 Leinenstoff für 95 Leinenstoffballen).
-- Search.lua multiplizierte diese Summe aber ZUSÄTZLICH mit den
-- verbleibenden Skillpunkten -> absurd überhöhte Gesamtbedarfs-Anzeige
-- (z.B. 8360x Leinenstoff statt korrekt ca. 190x). "mats" nennt jetzt
-- durchgängig den Materialbedarf für EINE EINZELNE Fertigung (mit Wowheads
-- deutschem Schneidern-Guide gegengeprüft).
BerufeGuideDB = BerufeGuideDB or {}

-- Nur auf deutschen Clients laden - siehe Daten_Schneidern_EN.lua für Englisch
if GetLocale() == "deDE" then
BerufeGuideDB["Schneidern"] = {
    -- ------------------------------------------------------------------------
    -- BILD 1 & 2: LEHRLING & GESELLE (SKILL 1 - 125)
    -- ------------------------------------------------------------------------
    { minSkill = 1, maxSkill = 45, item = "95 Leinenstoffballen", mats = "2 Leinenstoff" },
    { minSkill = 45, maxSkill = 70, item = "25 Leinengürtel", mats = "1 Leinenstoffballen, 1 Grober Faden" },
    { minSkill = 70, maxSkill = 75, item = "5 Verstärktes Leinencape", mats = "2 Leinenstoffballen, 3 Grober Faden" },
    { minSkill = 75, maxSkill = 100, item = "45 Wollstoffballen", mats = "3 Wollstoff" },
    { minSkill = 100, maxSkill = 110, item = "15 Einfacher Kilt", mats = "4 Leinenstoffballen, 1 Feiner Faden" },
    { minSkill = 110, maxSkill = 125, item = "15 Doppeltgenähte Wollschultern", mats = "3 Wollstoffballen, 2 Feiner Faden" },

    -- ------------------------------------------------------------------------
    -- BILD 3: EXPERTE (SKILL 125 - 220)
    -- ------------------------------------------------------------------------
    { minSkill = 125, maxSkill = 145, item = "205 Seidenstoffballen", mats = "4 Seidenstoff" },
    { minSkill = 145, maxSkill = 160, item = "20 Azurblaue Seidenkapuze", mats = "2 Seidenstoffballen, 1 Feiner Faden, 2 Blauer Farbstoff" },
    { minSkill = 160, maxSkill = 170, item = "10 Seidenes Stirnband", mats = "3 Seidenstoffballen, 2 Feiner Faden" },
    { minSkill = 170, maxSkill = 175, item = "5 Formelles weißes Hemd", mats = "3 Seidenstoffballen, 1 Feiner Faden, 2 Bleiche" },
    { minSkill = 175, maxSkill = 185, item = "100 Magiestoffballen", mats = "5 Magiestoff" },
    { minSkill = 185, maxSkill = 205, item = "20 Purpurrote Seidenweste", mats = "4 Seidenstoffballen, 2 Feiner Faden, 2 Roter Farbstoff" },
    { minSkill = 205, maxSkill = 215, item = "10 Purpurrote Seidenpantalons", mats = "4 Seidenstoffballen, 2 Seidenfaden, 2 Roter Farbstoff" },
    { minSkill = 215, maxSkill = 220, item = "5 Oranges Magiestoffhemd", mats = "1 Magiestoffballen, 1 Schwerer Seidenfaden, 1 Oranger Farbstoff" },

    -- ------------------------------------------------------------------------
    -- BILD 4: FACHMANN (SKILL 220 - 300)
    -- ------------------------------------------------------------------------
    { minSkill = 220, maxSkill = 230, item = "10 Schwarze Magiestoffhandschuhe", mats = "2 Magiestoffballen, 2 Schwerer Seidenfaden" },
    { minSkill = 230, maxSkill = 250, item = "25 Schwarzes Magiestoffstirnband", mats = "3 Magiestoffballen, 2 Schwerer Seidenfaden" },
    { minSkill = 250, maxSkill = 260, item = "155 Runenstoffballen", mats = "5 Runenstoff" },
    { minSkill = 260, maxSkill = 280, item = "25 Runenstoffgürtel", mats = "3 Runenstoffballen, 1 Runenfaden" },
    { minSkill = 280, maxSkill = 300, item = "20 Runenstoffhandschuhe", mats = "4 Runenstoffballen, 4 Unverwüstliches Leder, 1 Runenfaden" },
}
end
