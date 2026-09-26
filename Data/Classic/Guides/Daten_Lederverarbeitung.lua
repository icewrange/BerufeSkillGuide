-- ============================================================================
-- DATABASE: LEDERVERARBEITUNG SKILL GUIDE (1 - 300)
-- ============================================================================
-- FIX: "mats" speicherte bisher die bereits für die GESAMTE Stückzahl aus
-- "item" aufsummierte Menge (z.B. 90 Verdorbene Lederfetzen für 30 Leichtes
-- Leder). Search.lua multiplizierte diese Summe aber ZUSÄTZLICH mit den
-- verbleibenden Skillpunkten -> absurd überhöhte Gesamtbedarfs-Anzeige.
-- "mats" nennt jetzt durchgängig den Materialbedarf für EINE EINZELNE
-- Fertigung (mit Wowheads deutschem Lederverarbeitung-Guide gegengeprüft).
BerufeGuideDB = BerufeGuideDB or {}

-- Nur auf deutschen Clients laden - siehe Daten_Lederverarbeitung_EN.lua für Englisch
if GetLocale() == "deDE" then
BerufeGuideDB["Lederverarbeitung"] = {
    -- ------------------------------------------------------------------------
    -- BILD 1 & 2: LEHRLING & GESELLE (SKILL 1 - 150)
    -- ------------------------------------------------------------------------
    { minSkill = 1, maxSkill = 30, item = "30 Leichtes Leder", mats = "3 Verdorbene Lederfetzen" },
    { minSkill = 30, maxSkill = 45, item = "ca. 18 Leichtes Rüstungsset", mats = "1 Leichtes Leder" },
    { minSkill = 45, maxSkill = 55, item = "10 Geschmeidiger leichter Balg", mats = "1 Leichter Balg, 1 Salz" },
    { minSkill = 55, maxSkill = 85, item = "30 Geprägte Lederhandschuhe", mats = "3 Leichtes Leder, 2 Grober Faden" },
    { minSkill = 85, maxSkill = 100, item = "15 Feiner Ledergürtel", mats = "6 Leichtes Leder, 2 Grober Faden" },
    { minSkill = 100, maxSkill = 115, item = "15 Geschmeidiger mittlerer Balg", mats = "1 Mittlerer Balg, 1 Salz" },
    { minSkill = 115, maxSkill = 125, item = "10 Dunkle Lederstiefel", mats = "4 Mittleres Leder, 2 Feiner Faden, 1 Grauer Farbstoff" },
    { minSkill = 125, maxSkill = 135, item = "ca. 12 Dunkle Lederstiefel", mats = "4 Mittleres Leder, 2 Feiner Faden, 1 Grauer Farbstoff" },
    { minSkill = 135, maxSkill = 150, item = "15 Dunkler Ledergürtel", mats = "1 Feiner Ledergürtel, 1 Geschmeidiger mittlerer Balg, 2 Feiner Faden, 1 Grauer Farbstoff" },

    -- ------------------------------------------------------------------------
    -- BILD 3: EXPERTE (SKILL 150 - 220)
    -- ------------------------------------------------------------------------
    { minSkill = 150, maxSkill = 155, item = "5 Schweres Leder", mats = "5 Mittleres Leder" },
    { minSkill = 155, maxSkill = 160, item = "5 Geschmeidiger schwerer Balg", mats = "1 Schwerer Balg, 3 Salz" },
    { minSkill = 160, maxSkill = 180, item = "ca. 22 Schweres Rüstungsset", mats = "5 Schweres Leder, 1 Feiner Faden" },
    { minSkill = 180, maxSkill = 190, item = "10 Barbarische Schultern", mats = "8 Schweres Leder, 1 Geschmeidiger schwerer Balg, 2 Feiner Faden" },
    { minSkill = 190, maxSkill = 200, item = "10 Wächterhandschuhe", mats = "4 Schweres Leder, 1 Geschmeidiger schwerer Balg, 1 Seidenfaden" },
    { minSkill = 200, maxSkill = 220, item = "20 Dickes Rüstungsset", mats = "5 Dickes Leder, 1 Seidenfaden" },

    -- ------------------------------------------------------------------------
    -- BILD 4: FACHMANN (SKILL 220 - 300)
    -- ------------------------------------------------------------------------
    { minSkill = 220, maxSkill = 230, item = "ca. 11 Stirnband des Nachtschleichers", mats = "5 Dickes Leder, 2 Seidenfaden" },
    { minSkill = 230, maxSkill = 250, item = "20 Hose des Nachtschleichers", mats = "14 Dickes Leder, 4 Seidenfaden" },
    { minSkill = 250, maxSkill = 260, item = "ca. 12 Unverwüstliches Rüstungsset", mats = "5 Unverwüstliches Leder" },
    { minSkill = 260, maxSkill = 290, item = "ca. 32 Tückische Lederstulpen", mats = "8 Unverwüstliches Leder, 1 Schwarzer Farbstoff, 1 Runenfaden" },
    { minSkill = 290, maxSkill = 300, item = "10 Tückisches Lederstirnband", mats = "12 Unverwüstliches Leder, 1 Schwarzer Farbstoff, 1 Runenfaden" },
}
end
