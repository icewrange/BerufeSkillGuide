-- ============================================================================
-- DATABASE: VERZAUBERUNGSKUNST SKILL GUIDE (1 - 300)
-- ============================================================================
BerufeGuideDB = BerufeGuideDB or {}
BerufeGuideDB["Verzauberkunst"] = {
    -- ------------------------------------------------------------------------
    -- ANFANG: LEVEL 1 - 50 (AUS OFFIZIELLEN CLASSIC-DATEN ERGÄNZT)
    -- ------------------------------------------------------------------------
    { minSkill = 1, maxSkill = 2, item = "1 Runenverzierte Kupferrute", mats = "1 Kupferrute, 1 Seltsamer Staub, 1 Geringe Magieessenz" },
    -- FIX: Rezeptname war falsch ("Brust - Geringe Gesundheit" existiert
    -- in diesem Skillbereich nicht) - laut Wowhead ist der korrekte
    -- zweite Verzauberkunst-Schritt "Armschiene - Schwache Gesundheit".
    -- Menge und Material (48 Seltsamer Staub) waren bereits korrekt.
    { minSkill = 2, maxSkill = 50, item = "ca. 48 Armschiene - Schwache Gesundheit", mats = "48 Seltsamer Staub" },

    -- ------------------------------------------------------------------------
    -- BILD 1: EXPERTE ANFANG (SKILL 50 - 135)
    -- ------------------------------------------------------------------------
    { minSkill = 50, maxSkill = 90, item = "ca. 60 Armschiene - Schwache Gesundheit", mats = "60 Seltsamer Staub" },
    { minSkill = 90, maxSkill = 100, item = "10 Armschiene - Schwache Ausdauer", mats = "30 Seltsamer Staub" },
    { minSkill = 100, maxSkill = 101, item = "1 Runenverzierte Silberrute", mats = "1 Silberrute, 6 Seltsamer Staub, 3 Große Magieessenz, 1 Schattenedelstein" },
    { minSkill = 101, maxSkill = 110, item = "9 Großer Magiezauberstab", mats = "9 Einfaches Holz, 9 Große Magieessenz" },
    { minSkill = 110, maxSkill = 135, item = "25 Umhang - Schwache Beweglichkeit", mats = "25 Geringe Astralessenz" },

    -- ------------------------------------------------------------------------
    -- BILD 2: EXPERTE ENDE & MEISTER ANFANG (SKILL 135 - 225)
    -- ------------------------------------------------------------------------
    { minSkill = 135, maxSkill = 155, item = "20 Armschiene - Geringe Ausdauer", mats = "40 Seelenstaub" },
    { minSkill = 155, maxSkill = 156, item = "1 Runenverzierte Goldrute", mats = "1 Goldrute, 1 Schillernde Perle, 2 Große Astralessenz, 2 Seelenstaub" },
    { minSkill = 156, maxSkill = 185, item = "ca. 40 Armschiene - Geringe Stärke", mats = "80 Seelenstaub" },
    { minSkill = 185, maxSkill = 200, item = "15 Armschiene - Stärke", mats = "15 Visionenstaub" },
    { minSkill = 200, maxSkill = 201, item = "1 Runenverzierte Echtsilberrute", mats = "1 Echtsilberrute, 1 Schwarze Perle, 2 Große Mystikeressenz, 2 Visionenstaub" },
    { minSkill = 201, maxSkill = 220, item = "ca. 25 Armschiene - Stärke", mats = "25 Visionenstaub" },
    { minSkill = 220, maxSkill = 225, item = "5 Umhang - Große Verteidigung", mats = "15 Visionenstaub" },

    -- ------------------------------------------------------------------------
    -- BILD 3: MEISTER ENDE (SKILL 225 - 300)
    -- ------------------------------------------------------------------------
    { minSkill = 225, maxSkill = 230, item = "5 Handschuhe - Beweglichkeit", mats = "5 Geringe Netheressenz, 5 Visionenstaub" },
    { minSkill = 230, maxSkill = 235, item = "5 Stiefel - Ausdauer", mats = "25 Visionenstaub" },
    { minSkill = 235, maxSkill = 250, item = "ca. 25 Brust - Überragende Gesundheit", mats = "150 Visionenstaub" },
    { minSkill = 250, maxSkill = 265, item = "ca. 20 Geringes Manaöl", mats = "60 Traumstaub, 40 Lila Lotus, 20 Kristallphiole" },
    { minSkill = 265, maxSkill = 294, item = "ca. 30 Schild - Große Ausdauer", mats = "300 Traumstaub" },
    { minSkill = 294, maxSkill = 295, item = "1 Runenverzierte Arkanitrute", mats = "1 Arkanitrute, 1 Goldene Perle, 10 Illusionsstaub, 4 Große ewige Essenz, 4 Kleiner glänzender Splitter, 2 Großer glänzender Splitter" },
    { minSkill = 295, maxSkill = 300, item = "5 Umhang - Überragende Verteidigung", mats = "40 Illusionsstaub" },
}

-- ============================================================================
-- VERZAUBERKUNST FUNDORTE (RARE FORMELN & POPULÄRE KLASSIKER)
-- ============================================================================
BerufeFundorteDB = BerufeFundorteDB or {}

BerufeFundorteDB["Waffe verzaubern - Feurige waffe"] = "Drop von: Pyromant Weiskorn (Pyromancer Loregrain)\nOrt: Schwarzfelstiefen (BRD), direkt vor dem Tresorraum.\nChance: Selten (ca. 5-9% Dropchance)!"
BerufeFundorteDB["Feurige waffe"] = "Siehe: 'Waffe verzaubern - Feurige waffe'\nEinzigartiger Drop von Boss: Pyromant Weiskorn in den Schwarzfelstiefen (BRD)."

BerufeFundorteDB["Waffe verzaubern - Kreuzfahrer"] = "Drop von: Scharlachrote Zauberinnen (Stufe 53-54 Elite)\nOrt: In den Westlichen Pestländern (Scharlachrote Festung / Herdweiler).\nChance: Extrem selten (ca. 0.6% Dropchance)!"
BerufeFundorteDB["Kreuzfahrer"] = "Siehe: 'Waffe verzaubern - Kreuzfahrer'\nDrop von: Scharlachrote Zauberinnen in Herdweiler (Westliche Pestländer)."

BerufeFundorteDB["Waffe verzaubern - Heilkraft"] = "Drop von: Bossen im Geschmolzenen Kern (MC)\nOrt: Geschmolzener Kern (Raid-Instanz)."
BerufeFundorteDB["Waffe verzaubern - Zauberkraft"] = "Drop von: Bossen im Geschmolzenen Kern (MC)\nOrt: Geschmolzener Kern (Raid-Instanz)."
BerufeFundorteDB["Schild - Erhebliche Ausdauer"] = "Verkauft von: Daniel Bartlett (Horde, Unterstadt) / Mythrin'dir (Allianz, Darnassus)\nErhältlich ab Skill 265."
BerufeFundorteDB["Brust - Erhebliche Gesundheit"] = "Verkawft von: Kania (Silithus, Burg Cenarius)\nBenötigt einen wohlwollenden Ruf beim Zirkel des Cenarius."
BerufeFundorteDB["Waffe verzaubern - Überragende Schlageffizienz"] = "Drop von: Elite-Gegnern in Instanzen wie Scholomance und Stratholme."

-- WEITERE POPULÄRE REZEPTE
BerufeFundorteDB["Waffe verzaubern - Eisige waffe"] = "Drop von: Frostbeißer-Gegnern im Alteractal (AV) oder Winterquell."
BerufeFundorteDB["Zweihand-Waffe - Geringe agilitaet"] = "Verkauft von: Holzschlundfeste-Rüstmeister\nOrt: Teufelswald/Winterquell (Tunnel). Benötigt freundlichen Ruf."
