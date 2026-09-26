-- ============================================================================
-- DATABASE: INGENIEURSKUNST SKILL GUIDE (1 - 300)
-- ============================================================================
-- FIX: "mats" speicherte bisher die bereits für die GESAMTE Stückzahl aus
-- "item" aufsummierte Menge (z.B. 60 Rauer Stein für 60 Sprengpulver).
-- Search.lua multiplizierte diese Summe aber ZUSÄTZLICH mit den
-- verbleibenden Skillpunkten -> absurd überhöhte Gesamtbedarfs-Anzeige.
-- "mats" nennt jetzt durchgängig den Materialbedarf für EINE EINZELNE
-- Fertigung (mit Wowheads deutschem Ingenieurskunst-Guide und WoWs echten
-- Rezept-Reagenzien gegengeprüft).
BerufeGuideDB = BerufeGuideDB or {}

-- Nur auf deutschen Clients laden - siehe Daten_Ingenieurskunst_EN.lua für Englisch
if GetLocale() == "deDE" then
BerufeGuideDB["Ingenieurskunst"] = {
    -- ------------------------------------------------------------------------
    -- BILD 1: LEHRLING (SKILL 1 - 75)
    -- ------------------------------------------------------------------------
    { minSkill = 1, maxSkill = 30, item = "60 Raues Sprengpulver", mats = "1 Rauer Stein" },
    { minSkill = 30, maxSkill = 50, item = "30 Eine Hand voll Kupferbolzen", mats = "1 Kupferbarren" },
    { minSkill = 50, maxSkill = 51, item = "1 Bogenlichtschraubenschlüssel", mats = "6 Kupferbarren" },
    { minSkill = 51, maxSkill = 75, item = "ca. 30 Raue Kupferbombe", mats = "1 Kupferbarren, 1 Eine Hand voll Kupferbolzen, 2 Raues Sprengpulver, 1 Leinenstoff" },

    -- ------------------------------------------------------------------------
    -- BILD 2: GESELLE (SKILL 75 - 135)
    -- ------------------------------------------------------------------------
    { minSkill = 75, maxSkill = 90, item = "ca. 60 Grobes Sprengpulver", mats = "1 Grober Stein" },
    { minSkill = 90, maxSkill = 100, item = "ca. 20 Grobes Dynamit", mats = "3 Grobes Sprengpulver, 1 Leinenstoff" },
    { minSkill = 100, maxSkill = 105, item = "5 Silberkontakt", mats = "1 Silberbarren" },
    { minSkill = 105, maxSkill = 125, item = "25 Bronzeröhre", mats = "2 Bronzebarren, 1 Schwacher Fluxus" },
    { minSkill = 125, maxSkill = 135, item = "10 Standardzielfernrohr", mats = "1 Bronzeröhre, 1 Moosachat" },

    -- ------------------------------------------------------------------------
    -- BILD 3: EXPERTE (SKILL 135 - 200)
    -- ------------------------------------------------------------------------
    -- FIX: minSkill der beiden folgenden Einträge überlappte sich bisher
    -- (beide bei 135), wodurch je nach Tabellen-Reihenfolge einer der
    -- Schritte im Guide nie angezeigt wurde. Jetzt lückenlos aufeinander
    -- aufbauend: 135-140 -> 140-150.
    { minSkill = 135, maxSkill = 140, item = "30 Schweres Sprengpulver", mats = "1 Schwerer Stein" },
    { minSkill = 140, maxSkill = 150, item = "15 Surrendes bronzenes Dingsda", mats = "2 Bronzebarren, 1 Wollstoff" },
    { minSkill = 150, maxSkill = 160, item = "15 Bronzegerüst", mats = "2 Bronzebarren, 1 Mittleres Leder, 1 Wollstoff" },
    { minSkill = 160, maxSkill = 175, item = "15 Explodierendes Schaf", mats = "1 Bronzegerüst, 1 Surrendes bronzenes Dingsda, 2 Schweres Sprengpulver, 2 Wollstoff" },
    { minSkill = 175, maxSkill = 176, item = "1 Gyromatischer Mikroregler", mats = "4 Stahlbarren" },
    { minSkill = 176, maxSkill = 195, item = "60 Robustes Sprengpulver", mats = "2 Robuster Stein" },
    { minSkill = 195, maxSkill = 200, item = "ca. 7 Mithrilrohr", mats = "3 Mithrilbarren" },

    -- ------------------------------------------------------------------------
    -- BILD 4: FACHMANN (SKILL 200 - 300)
    -- ------------------------------------------------------------------------
    { minSkill = 200, maxSkill = 215, item = "20 Instabiler Auslöser", mats = "1 Mithrilbarren, 1 Magiestoff, 1 Robustes Sprengpulver" },
    { minSkill = 215, maxSkill = 238, item = "40 Mithrilgehäuse", mats = "3 Mithrilbarren" },
    { minSkill = 238, maxSkill = 250, item = "20 Hochexplosive Bombe", mats = "2 Mithrilgehäuse, 1 Instabiler Auslöser, 2 Robustes Sprengpulver" },
    { minSkill = 250, maxSkill = 260, item = "ca. 30 Dichtes Sprengpulver", mats = "2 Verdichteter Stein" },
    { minSkill = 260, maxSkill = 285, item = "ca. 35 Thoriumapparat", mats = "3 Thoriumbarren, 1 Runenstoff" },
    { minSkill = 285, maxSkill = 300, item = "15 Thoriumpatronen", mats = "2 Thoriumbarren, 1 Dichtes Sprengpulver" },
}
end
