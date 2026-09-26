-- ============================================================================
-- DATABASE: SCHMIEDEKUNST SKILL GUIDE (1 - 300)
-- ============================================================================
-- NEU AUFGEBAUT auf Basis von Wowheads offiziellem deutschen Leveling-Guide
-- (wowhead.com/classic/de/guide/blacksmithing-leveling-1-300-wow-classic).
-- Die vorherige Version enthielt mehrere erfundene/falsche Rezepte (z.B.
-- "Kupferner Runenreif", "Gezackte Bronzeklinge", "Goldene Skelettschluessel"),
-- die es in Classic so nicht gibt bzw. mit falschen Namen/Mengen.
BerufeGuideDB = BerufeGuideDB or {}

-- Nur auf deutschen Clients laden - siehe Daten_Schmiedekunst_EN.lua für Englisch
if GetLocale() == "deDE" then
BerufeGuideDB["Schmiedekunst"] = {
    -- FIX: "mats" speicherte bisher die bereits für die GESAMTE Stückzahl
    -- aus "item" aufsummierte Menge (z.B. 40 Rauer Stein für 40 Wetzsteine).
    -- Search.lua multiplizierte diese Summe aber ZUSÄTZLICH mit den
    -- verbleibenden Skillpunkten -> absurd überhöhte Gesamtbedarfs-Anzeige.
    -- "mats" nennt jetzt durchgängig den Materialbedarf für EINE EINZELNE
    -- Fertigung (mit Wowheads deutschem Schmiedekunst-Guide gegengeprüft).
    -- ------------------------------------------------------------------------
    -- LEHRLING (SKILL 1 - 75)
    -- ------------------------------------------------------------------------
    { minSkill = 1,   maxSkill = 30,  item = "ca. 40 Rauer Wetzstein", mats = "1 Rauer Stein" },
    { minSkill = 30,  maxSkill = 65,  item = "ca. 60 Rauer Schleifstein", mats = "2 Rauer Stein" },
    { minSkill = 65,  maxSkill = 75,  item = "ca. 25 Grober Wetzstein", mats = "1 Grober Stein" },

    -- ------------------------------------------------------------------------
    -- GESELLE (SKILL 75 - 125)
    -- ------------------------------------------------------------------------
    { minSkill = 75,  maxSkill = 90,  item = "ca. 35 Grober Schleifstein", mats = "2 Grober Stein" },
    { minSkill = 90,  maxSkill = 100, item = "10 Runenverzierter Kupfergürtel", mats = "10 Kupferbarren" },
    { minSkill = 100, maxSkill = 105, item = "5 Silberrute", mats = "1 Silberbarren, 2 Rauer Schleifstein" },
    { minSkill = 105, maxSkill = 110, item = "5 Runenverzierter Kupfergürtel", mats = "10 Kupferbarren" },
    { minSkill = 110, maxSkill = 125, item = "15 Raue bronzene Gamaschen", mats = "6 Bronzebarren" },

    -- ------------------------------------------------------------------------
    -- EXPERTE (SKILL 125 - 225)
    -- ------------------------------------------------------------------------
    { minSkill = 125, maxSkill = 140, item = "ca. 35 Schwerer Schleifstein", mats = "3 Schwerer Stein" },
    { minSkill = 140, maxSkill = 150, item = "10 Gemusterte bronzene Armschienen", mats = "5 Bronzebarren, 2 Grober Schleifstein" },
    { minSkill = 150, maxSkill = 155, item = "5 Goldrute", mats = "1 Goldbarren, 2 Grober Schleifstein" },
    { minSkill = 155, maxSkill = 165, item = "10 Grüne Eisengamaschen", mats = "8 Eisenbarren, 1 Schwerer Schleifstein, 1 Grüner Farbstoff" },
    { minSkill = 165, maxSkill = 190, item = "25 Grüne Eisenarmschienen", mats = "6 Eisenbarren, 1 Grüner Farbstoff" },
    { minSkill = 190, maxSkill = 200, item = "10 Goldene Schuppenarmschienen", mats = "5 Stahlbarren, 2 Schwerer Schleifstein" },
    { minSkill = 200, maxSkill = 210, item = "ca. 30 Robuster Schleifstein", mats = "4 Robuster Stein" },
    { minSkill = 210, maxSkill = 225, item = "15 Schwere Mithrilstulpen", mats = "6 Mithrilbarren, 4 Magiestoff" },

    -- ------------------------------------------------------------------------
    -- FACHMANN (SKILL 225 - 300)
    -- ------------------------------------------------------------------------
    { minSkill = 225, maxSkill = 235, item = "10 Stahlplattenhelm", mats = "14 Stahlbarren, 1 Robuster Schleifstein" },
    { minSkill = 235, maxSkill = 250, item = "15 Mithrilhelmkappe", mats = "10 Mithrilbarren, 6 Magiestoff" },
    { minSkill = 250, maxSkill = 260, item = "ca. 20 Verdichteter Wetzstein", mats = "1 Verdichteter Stein" },
    { minSkill = 260, maxSkill = 270, item = "10 Thoriumgürtel", mats = "12 Thoriumbarren, 4 Roter Machtkristall" },
    { minSkill = 270, maxSkill = 275, item = "5 Thoriumarmschienen", mats = "12 Thoriumbarren, 4 Blauer Machtkristall" },
    { minSkill = 275, maxSkill = 290, item = "15 Imperiale Plattenarmschienen", mats = "20 Thoriumbarren, 1 Sternrubin" },
    { minSkill = 290, maxSkill = 300, item = "10 Thoriumstiefel", mats = "20 Thoriumbarren, 8 Unverwüstliches Leder, 4 Grüner Machtkristall" },
}

-- ----------------------------------------------------------------------------
-- OPTIONALE ALTERNATIV-ROUTE FÜR 260-300 (laut Wowhead, falls die
-- Drop-/Quest-Rezepte oben schwer zu bekommen sind). Nur als Referenz
-- auskommentiert, nicht aktiv im Guide:
-- ----------------------------------------------------------------------------
-- { minSkill = 260, maxSkill = 265, item = "ca. 7 Schwere Mithrilstiefel", mats = "14 Mithrilbarren, 4 Dickes Leder" },
-- { minSkill = 265, maxSkill = 270, item = "5 Imperialer Plattengürtel", mats = "22 Thoriumbarren, 6 Unverwüstliches Leder, 1 Aquamarin" },
-- { minSkill = 270, maxSkill = 295, item = "ca. 27 Imperiale Plattenarmschienen", mats = "20 Thoriumbarren, 1 Sternrubin" },
-- { minSkill = 295, maxSkill = 300, item = "5 Imperiale Plattenstiefel", mats = "34 Thoriumbarren, 1 Sternrubin, 1 Aquamarin" },
-- { minSkill = 290, maxSkill = 300, item = "10 Strahlende Stiefel", mats = "14 Thoriumbarren, 4 Herz des Feuers" },
end
