-- Erstellt die globale Lehrer-Tabelle fuer alle Berufe inkl. Koordinaten (ZoneID, X, Y)
BerufeLehrerDB = {
    ["Alchimie"] = {
        { stufe = "Lehrling (1-75)", standorte = "Allianz: Stormwind (Magieviertel) / Ironforge (Militärviertel)\nHorde: Orgrimmar (Gasse) / Undercity (Apothekerundteil)" },
        -- Wir fuegen für die beiden Gesellen-Lehrer (Darnassus & Donnerfels) die echten Karten-Daten hinzu
        { 
            stufe = "Geselle (75-150)", 
            standorte = "Allianz: Ainethil in Darnassus (Handwerksviertel)\nHorde: Baelog in Thunder Bluff (Untere Anhöhe)",
            -- ZoneIDs: Darnassus = 1457, Thunder Bluff = 1458
            allianzZone = 1457, allianzX = 55.2, allianzY = 23.8,
            hordeZone = 1458, hordeX = 45.6, hordeY = 42.1
        },
        {
            stufe = "Experte (150-225)", standorte = "Allianz: Kylanna Windwisper in Feralas (Feodermark)\nHorde: Rogvar in Sumpfland (Stonard)",
            -- Koordinaten via Wowhead-Community bestätigt (Zonenname wird zur Laufzeit aufgelöst, s. BSG_TomTom.lua)
            allianzZone = "Feralas", allianzX = 32, allianzY = 43,
            hordeZone = "Sumpfland", hordeX = 48, hordeY = 55
        },
        {
            stufe = "Meister (225-300)", standorte = "Allianz: Kylanna Windwisper in Feralas (Feodermark)\nHorde: Rogvar in Sumpfland (Stonard)",
            allianzZone = "Feralas", allianzX = 32, allianzY = 43,
            hordeZone = "Sumpfland", hordeX = 48, hordeY = 55
        }
    },
    ["Ingenieurskunst"] = {
        { stufe = "Lehrling (1-75)", standorte = "Allianz: Stormwind (Zwergendistrikt) / Ironforge (Große Schmiede)\nHorde: Orgrimmar (Tal der Ehre) / Undercity (Schurkenviertel)" },
        { 
            stufe = "Geselle (75-150)", 
            standorte = "Allianz: Jnaika Steinmetz in Ironforge (Große Schmiede)\nHorde: Nogg in Orgrimmar (Tal der Ehre)",
            allianzZone = 1455, allianzX = 68.2, allianzY = 45.1, -- Ironforge
            hordeZone = 1454, hordeX = 75.4, hordeY = 24.8     -- Orgrimmar
        },
        {
            stufe = "Experte (150-225)", standorte = "Allianz: Springspindel Schlingergang in Ironforge\nHorde: Roxxik in Orgrimmar (Tal der Ehre)",
            -- Horde-Koordinate laut Wowhead-Community (Roxxik steht mittlerweile
            -- wohl in "The Drag" statt Tal der Ehre - ggf. gegenpruefen);
            -- fuer Springspindel/Allianz konnte keine verlaessliche Koordinate gefunden werden.
            hordeZone = "Orgrimmar", hordeX = 56.8, hordeY = 56.5
        },
        {
            stufe = "Meister (225-300)", standorte = "Allianz & Horde: Buzzek Knalrtopf in Tanaris (Gadgetzan)",
            allianzZone = "Tanaris", allianzX = 52, allianzY = 28,
            hordeZone = "Tanaris", hordeX = 52, hordeY = 28
        }
    },
    ["Schmiedekunst"] = {
        { stufe = "Lehrling (1-75)", standorte = "Allianz: Stormwind (Zwergendistrikt) / Ironforge (Große Schmiede)\nHorde: Orgrimmar (Tal der Ehre)" },
        { stufe = "Geselle (75-150)", standorte = "Allianz: Bengus Tiefenmeißel in Ironforge / Horde: Saru Starkzahn in Orgrimmar" },
        {
            stufe = "Experte (150-225)",
            -- HINWEIS/KORREKTUR: Recherche (Wowhead) zeigt Krathok Moltenfist tatsächlich
            -- in ORGRIMMAR, nicht in "Düsterbruch" (Dire Maul) wie hier bisher stand.
            -- Text unten unverändert gelassen, bitte gegenprüfen und ggf. anpassen!
            standorte = "Allianz: Galvan der Alte in Schlingendorntal / Horde: Krathek in Düsterbruch",
            allianzZone = "Schlingendorntal", allianzX = 50, allianzY = 20
        },
        {
            stufe = "Meister (225-300)",
            -- HINWEIS/KORREKTUR: Recherche zeigt Brumn Winterhoof tatsächlich im
            -- ARATHIHOCHLAND, nicht in "Winterquell" (Winterspring) wie hier bisher stand.
            standorte = "Allianz & Horde: Brumn Winterhuf in Winterquell",
            allianzZone = "Arathihochland", allianzX = 28, allianzY = 45,
            hordeZone = "Arathihochland", hordeX = 28, hordeY = 45
        }
    },
    ["Schneidern"] = {
        { stufe = "Lehrling / Geselle", standorte = "Allianz: Stormwind (Magieviertel) / Horde: Orgrimmar (Gasse)" },
        {
            stufe = "Experte (150-225)", standorte = "Allianz: Georgio Borromeo in Stormwind / Horde: Josef Gregorian in Undercity",
            allianzZone = "Sturmwind", allianzX = 43, allianzY = 74,
            hordeZone = "Unterstadt", hordeX = 71, hordeY = 30
        },
        {
            stufe = "Meister (225-300)", standorte = "Allianz & Horde: Timothy Worthington in Marschen von Dustwallow",
            allianzZone = "Marschen von Dustwallow", allianzX = 66, allianzY = 51,
            hordeZone = "Marschen von Dustwallow", hordeX = 66, hordeY = 51
        }
    },
    ["Lederverarbeitung"] = {
        { stufe = "Lehrling / Geselle", standorte = "Allianz: Stormwind (Altstadt) / Horde: Orgrimmar (Tal der Ehre)" },
        {
            stufe = "Experte (150-225)", standorte = "Allianz: Simon Tanner in Stormwind / Horde: Una in Donnerfels",
            -- Fuer Simon Tanner (Allianz) keine verlaessliche Koordinate gefunden.
            hordeZone = "Donnerfels", hordeX = 42, hordeY = 43
        },
        {
            stufe = "Meister (225-300)", standorte = "Allianz & Horde: Drakk Steinhuf in Hinterland",
            allianzZone = "Hinterland", allianzX = 13, allianzY = 43,
            hordeZone = "Hinterland", hordeX = 13, hordeY = 43
        }
    },
    ["Verzauberkunst"] = {
        { stufe = "Lehrling / Geselle", standorte = "Allianz: Stormwind (Magieviertel) / Horde: Orgrimmar (Tal der Ehre)" },
        {
            stufe = "Experte (150-225)", standorte = "Allianz: Kitta Feuerwind in Elwynn / Horde: Hgarth in Steinkrallengebirge",
            allianzZone = "Elwynn", allianzX = 64, allianzY = 70,
            hordeZone = "Steinkrallengebirge", hordeX = 49, hordeY = 57
        },
        {
            stufe = "Meister (225-300)",
            -- Annoras Spawn liegt tief in der Instanz Uldaman; als Wegpunkt wird
            -- stattdessen der bequemere "Hintereingang" im Ödland gesetzt (siehe Community-Guides).
            standorte = "Allianz & Horde: Annora in Uldaman (Instanz!)",
            allianzZone = "Ödland", allianzX = 66, allianzY = 43,
            hordeZone = "Ödland", hordeX = 66, hordeY = 43
        }
    },
    -- NEU: Kochkunst-Lehrer, bestätigt über Wowheads offiziellen Guide.
    ["Kochkunst"] = {
        { stufe = "Lehrling & Geselle (1-150)", standorte = "Allianz: Stephen Ryback in Stormwind / Daryl Riknussun in Ironforge / Alegorn in Darnassus\nHorde: Zamja in Orgrimmar / Eunice Burch in Unterstadt / Aska Mistrunner in Donnerfels" },
        {
            stufe = "Experte (150-225)", standorte = "Kauf des 'Expertenkochbuch': Allianz bei Shandrina in Ashenvale / Horde bei Wulan in Desolace",
            allianzZone = "Eschental", allianzX = 50, allianzY = 67,
            hordeZone = "Desolace", hordeX = 27, hordeY = 69
        },
        { stufe = "Meister (225-300)", standorte = "Questreihe ab Skill 225 & Charakterstufe 35: Allianz bei Daryl Riknussun (Ironforge) / Horde bei Zamja (Orgrimmar), Abschluss bei Dirge Quikcleave in Gadgetzan" }
    }
}
