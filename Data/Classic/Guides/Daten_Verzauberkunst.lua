-- ============================================================================
-- DATABASE: VERZAUBERUNGSKUNST SKILL GUIDE (1 - 300)
-- ============================================================================
-- FIX: "mats" speicherte bisher die bereits für die GESAMTE Stückzahl aus
-- "item" aufsummierte Menge (z.B. 48 Seltsamer Staub für 48 Armschienen).
-- Search.lua multiplizierte diese Summe aber ZUSÄTZLICH mit den
-- verbleibenden Skillpunkten -> absurd überhöhte Gesamtbedarfs-Anzeige.
-- "mats" nennt jetzt durchgängig den Materialbedarf für EINE EINZELNE
-- Verzauberung (mit Wowheads deutschem Verzauberkunst-Guide gegengeprüft).
BerufeGuideDB = BerufeGuideDB or {}

-- Nur auf deutschen Clients laden - siehe Daten_Verzauberkunst_EN.lua für Englisch
if GetLocale() == "deDE" then
BerufeGuideDB["Verzauberkunst"] = {
    -- ------------------------------------------------------------------------
    -- ANFANG: LEVEL 1 - 50 (AUS OFFIZIELLEN CLASSIC-DATEN ERGÄNZT)
    -- ------------------------------------------------------------------------
    { minSkill = 1, maxSkill = 2, item = "1 Runenverzierte Kupferrute", mats = "1 Kupferrute, 1 Seltsamer Staub, 1 Geringe Magieessenz" },
    -- FIX: Rezeptname war falsch ("Brust - Geringe Gesundheit" existiert
    -- in diesem Skillbereich nicht) - laut Wowhead ist der korrekte
    -- zweite Verzauberkunst-Schritt "Armschiene - Schwache Gesundheit".
    { minSkill = 2, maxSkill = 50, item = "ca. 48 Armschiene - Schwache Gesundheit", mats = "1 Seltsamer Staub" },

    -- ------------------------------------------------------------------------
    -- BILD 1: EXPERTE ANFANG (SKILL 50 - 135)
    -- ------------------------------------------------------------------------
    { minSkill = 50, maxSkill = 90, item = "ca. 60 Armschiene - Schwache Gesundheit", mats = "1 Seltsamer Staub" },
    { minSkill = 90, maxSkill = 100, item = "10 Armschiene - Schwache Ausdauer", mats = "3 Seltsamer Staub" },
    { minSkill = 100, maxSkill = 101, item = "1 Runenverzierte Silberrute", mats = "1 Silberrute, 6 Seltsamer Staub, 3 Große Magieessenz, 1 Schattenedelstein" },
    { minSkill = 101, maxSkill = 110, item = "9 Großer Magiezauberstab", mats = "1 Einfaches Holz, 1 Große Magieessenz" },
    { minSkill = 110, maxSkill = 135, item = "25 Umhang - Schwache Beweglichkeit", mats = "1 Geringe Astralessenz" },

    -- ------------------------------------------------------------------------
    -- BILD 2: EXPERTE ENDE & FACHMANN ANFANG (SKILL 135 - 225)
    -- ------------------------------------------------------------------------
    { minSkill = 135, maxSkill = 155, item = "20 Armschiene - Geringe Ausdauer", mats = "2 Seelenstaub" },
    { minSkill = 155, maxSkill = 156, item = "1 Runenverzierte Goldrute", mats = "1 Goldrute, 1 Schillernde Perle, 2 Große Astralessenz, 2 Seelenstaub" },
    { minSkill = 156, maxSkill = 185, item = "ca. 40 Armschiene - Geringe Stärke", mats = "2 Seelenstaub" },
    { minSkill = 185, maxSkill = 200, item = "15 Armschiene - Stärke", mats = "1 Visionenstaub" },
    { minSkill = 200, maxSkill = 201, item = "1 Runenverzierte Echtsilberrute", mats = "1 Echtsilberrute, 1 Schwarze Perle, 2 Große Mystikeressenz, 2 Visionenstaub" },
    { minSkill = 201, maxSkill = 220, item = "ca. 25 Armschiene - Stärke", mats = "1 Visionenstaub" },
    { minSkill = 220, maxSkill = 225, item = "5 Umhang - Große Verteidigung", mats = "3 Visionenstaub" },

    -- ------------------------------------------------------------------------
    -- BILD 3: FACHMANN ENDE (SKILL 225 - 300)
    -- ------------------------------------------------------------------------
    { minSkill = 225, maxSkill = 230, item = "5 Handschuhe - Beweglichkeit", mats = "1 Geringe Netheressenz, 1 Visionenstaub" },
    { minSkill = 230, maxSkill = 235, item = "5 Stiefel - Ausdauer", mats = "5 Visionenstaub" },
    { minSkill = 235, maxSkill = 250, item = "ca. 25 Brust - Überragende Gesundheit", mats = "6 Visionenstaub" },
    { minSkill = 250, maxSkill = 265, item = "ca. 20 Geringes Manaöl", mats = "3 Traumstaub, 2 Lila Lotus, 1 Kristallphiole" },
    { minSkill = 265, maxSkill = 294, item = "ca. 30 Schild - Große Ausdauer", mats = "10 Traumstaub" },
    { minSkill = 294, maxSkill = 295, item = "1 Runenverzierte Arkanitrute", mats = "1 Arkanitrute, 1 Goldene Perle, 10 Illusionsstaub, 4 Große ewige Essenz, 4 Kleiner glänzender Splitter, 2 Großer glänzender Splitter" },
    { minSkill = 295, maxSkill = 300, item = "5 Umhang - Überragende Verteidigung", mats = "8 Illusionsstaub" },
}
end

-- ============================================================================
-- VERZAUBERKUNST FUNDORTE (RARE FORMELN & POPULÄRE KLASSIKER)
-- ============================================================================
-- Läuft bewusst AUSSERHALB der Sprachprüfung oben, damit diese
-- Zusatzinfos auch auf englischen Clients zumindest auf Deutsch
-- geladen werden, statt komplett zu fehlen (noch nicht übersetzt).
BerufeFundorteDB = BerufeFundorteDB or {}

-- (v2.1) "Feurige Waffe" steht jetzt korrekt geschrieben in
-- Data\Classic\Fundorte\Daten_Fundorte.lua ("Waffe - Feurige Waffe").


-- (v2.1) "Schild - Große Ausdauer" und "Brust - Erhebliche Gesundheit" stehen
-- jetzt korrigiert in Data\Classic\Fundorte\Daten_Fundorte.lua.

-- WEITERE POPULÄRE REZEPTE
