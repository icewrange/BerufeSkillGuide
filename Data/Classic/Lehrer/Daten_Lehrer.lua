-- Erstellt die globale Lehrer-Tabelle fuer alle Berufe inkl. Koordinaten (ZoneID, X, Y)
-- Nur auf deutschen Clients - siehe Daten_Lehrer_EN.lua für Englisch
if GetLocale() == "deDE" then
BerufeLehrerDB = {
    -- (v2.1) Geprüft mit Wowhead Classic-Leveling-Guide + Icy Veins / wow-professions.com
    ["Alchimie"] = {
        { stufe = "Lehrling / Geselle (1-150)", standorte = "Allianz: Lilyssia Nightbreeze (Sturmwind, Magierviertel), Tally Berryfizz (Eisenschmiede, Tüftlerstadt), Ainethil (Darnassus)\nHorde: Yelmak (Orgrimmar, Gasse), Doctor Herbert Halsey (Unterstadt, Apothekarium), Bena Winterhoof (Donnerfels)\nGeselle ab Skill 50 und Stufe 10.",
          allianzZone = 1453, allianzX = 46.4, allianzY = 79.6,
          hordeZone = 1454, hordeX = 56.6, hordeY = 33.2 },
        { stufe = "Experte (150-225)", standorte = "Ab Skill 125 und Stufe 20.\nAllianz: Ainethil (Darnassus), Kylanna Windwhisper (Feathermoon, Feralas)\nHorde: Doctor Herbert Halsey (Unterstadt, Apothekarium), Rogvar (Stonard, Sümpfe des Elends)",
          allianzZone = 1457, allianzX = 55.0, allianzY = 24.0,
          hordeZone = 1458, hordeX = 48.2, hordeY = 72.2 },
        { stufe = "Fachmann (225-300)", standorte = "Ab Skill 225 und Stufe 35.\nAllianz: Kylanna Windwhisper (Feathermoon, Feralas)\nHorde: Rogvar (Stonard, Sümpfe des Elends)",
          allianzZone = 1444, allianzX = 32.6, allianzY = 43.8,
          hordeZone = 1435, hordeX = 48.4, hordeY = 55.6 },
    },
    -- (v2.1) Geprüft mit Wowhead Classic-Leveling-Guide + Icy Veins / wow-professions.com
    ["Ingenieurskunst"] = {
        { stufe = "Lehrling / Geselle (1-150)", standorte = "Allianz: Jemma Quikswitch (Eisenschmiede, Tüftlerstadt), Sprite Jumpsprocket (Sturmwind, Zwergendistrikt)\nHorde: Thund (Orgrimmar, Tal der Ehre), Graham Van Talen (Unterstadt, Schurkenviertel)\nNeutral: Tinkerwiz (Ratschet, Brachland)\nGeselle ab Skill 50 und Stufe 10.",
          allianzZone = 1455, allianzX = 67.8, allianzY = 44.0,
          hordeZone = 1454, hordeX = 75.8, hordeY = 24.6 },
        { stufe = "Experte (150-225)", standorte = "Ab Skill 125 und Stufe 20.\nAllianz: Trixie Quikswitch (Eisenschmiede, Tüftlerstadt), Lilliam Sparkspindle (Sturmwind, Zwergendistrikt)\nHorde: Nogg (Orgrimmar, Tal der Ehre), Franklin Lloyd (Unterstadt, Schurkenviertel)\nNeutral: Buzzek Bracketswing (Gadgetzan, Tanaris)",
          allianzZone = 1455, allianzX = 67.8, allianzY = 43.2,
          hordeZone = 1454, hordeX = 75.8, hordeY = 25.2 },
        { stufe = "Fachmann (225-300)", standorte = "Ab Skill 225 und Stufe 35.\nAllianz: Springspindle Fizzlegear (Eisenschmiede, Tüftlerstadt)\nHorde: Roxxik (Orgrimmar, Tal der Ehre)\nNeutral: Buzzek Bracketswing (Gadgetzan, Tanaris)\nSpezialisierung: Gnom - Tinkmaster Overspark (Eisenschmiede) / Oglethorpe Obnoticus (Beutebucht); Goblin - Nixx Sprocketspring (Gadgetzan) / Vazario Linkgrease (Ratschet)",
          allianzZone = 1455, allianzX = 68.6, allianzY = 44.0,
          hordeZone = 1454, hordeX = 76.0, hordeY = 25.0 },
    },
    -- (v2.1) Geprüft mit Wowhead Classic-Leveling-Guide + Icy Veins / wow-professions.com
    ["Schmiedekunst"] = {
        { stufe = "Lehrling / Geselle (1-150)", standorte = "In allen Hauptstädten, außerdem z. B.:\nAllianz: Smith Argus (Goldhain, Wald von Elwynn), Tognus Flintfire (Kharanos, Dun Morogh)\nHorde: Dwukk (Klingenhügel, Durotar)\nGeselle ab Skill 50 und Stufe 10.",
          allianzZone = 1429, allianzX = 41.0, allianzY = 65.0,
          hordeZone = 1411, hordeX = 52.0, hordeY = 40.6 },
        { stufe = "Experte (150-225)", standorte = "Ab Skill 125 und Stufe 20.\nAllianz: Bengus Deepforge (Eisenschmiede, Große Schmiede), Therum Deepforge (Sturmwind, Altstadt), Clarise Gnarltree (Dämmerwald)\nHorde: Saru Steelfury (Orgrimmar, Tal der Ehre), James Van Brunt (Unterstadt, Kriegsviertel), Karn Stonehoof (Donnerfels), Traugh (Wegekreuz, Brachland)",
          allianzZone = 1455, allianzX = 52.0, allianzY = 40.0,
          hordeZone = 1454, hordeX = 82.2, hordeY = 23.0 },
        { stufe = "Fachmann (225-300)", standorte = "Ab Skill 225 und Stufe 35.\nNur bei: Brikk Keencraft (Beutebucht, Schlingendorntal) - für Allianz und Horde.",
          allianzZone = 1434, allianzX = 29.0, allianzY = 75.4,
          hordeZone = 1434, hordeX = 29.0, hordeY = 75.4 },
    },
    -- (v2.1) Geprüft mit Wowhead Classic-Leveling-Guide + Icy Veins / wow-professions.com
    ["Schneidern"] = {
        { stufe = "Lehrling / Geselle (1-150)", standorte = "Allianz: Lawrence Schneider / Sellandus (Sturmwind, Magierviertel), Uthrar Threx / Jormund Stonebrow (Eisenschmiede, Große Schmiede), Trianna (Darnassus, Handwerkerterrasse)\nHorde: Snang / Magar (Orgrimmar, Gasse), Victor Ward / Rhiannon Davis (Unterstadt, Magierviertel), Vhan / Tepa (Donnerfels)\nGeselle ab Skill 50 und Stufe 10.",
          allianzZone = 1453, allianzX = 43.6, allianzY = 73.8,
          hordeZone = 1454, hordeX = 63.0, hordeY = 49.6 },
        { stufe = "Experte (150-225)", standorte = "Ab Skill 125 und Stufe 20.\nAllianz: Georgio Bolero (Sturmwind, Magierviertel)\nHorde: Josef Gregorian (Unterstadt, Magierviertel)",
          allianzZone = 1453, allianzX = 43.2, allianzY = 73.6,
          hordeZone = 1458, hordeX = 70.6, hordeY = 30.6 },
        { stufe = "Fachmann (225-300)", standorte = "Ab Skill 225 und Stufe 35.\nAllianz: Timothy Worthington (Theramore, Düstermarschen)\nHorde: Daryl Stack (Tarrens Mühle, Vorgebirge des Hügellands)",
          allianzZone = 1445, allianzX = 66.2, allianzY = 51.6,
          hordeZone = 1424, hordeX = 63.6, hordeY = 20.8 },
    },
    -- (v2.1) Geprüft mit Wowhead Classic-Leveling-Guide + Icy Veins / wow-professions.com
    ["Lederverarbeitung"] = {
        { stufe = "Lehrling / Geselle (1-150)", standorte = "Allianz: Randal Worth (Sturmwind), Adele Fielder (Wald von Elwynn), Nadyia Maneweaver (Teldrassil)\nHorde: Chaw Stronghide (Mulgore), Shelene Rhobart (Tirisfal)\nGeselle ab Skill 50 und Stufe 10.",
          allianzZone = 1453, allianzX = 68.0, allianzY = 49.0,
          hordeZone = 1412, hordeX = 45.0, hordeY = 57.0 },
        { stufe = "Experte (150-225)", standorte = "Ab Skill 125 und Stufe 20.\nAllianz: Telonis (Darnassus), Fimble Finespindle (Eisenschmiede)\nHorde: Una (Donnerfels), Karolek (Orgrimmar), Arthur Moore (Unterstadt)",
          allianzZone = 1457, allianzX = 64.0, allianzY = 21.0,
          hordeZone = 1456, hordeX = 41.0, hordeY = 42.0 },
        { stufe = "Fachmann (225-300)", standorte = "Ab Skill 225 und Stufe 35.\nAllianz: Drakk Stonehand (Nistgipfel, Hinterland)\nHorde: Hahrana Ironhide (Camp Mojache, Feralas)\nSpezialisierung ab Stufe 40: Drachenschuppe (u. a. Peter Galen, Azshara), Elementar (u. a. Brumn Winterhoof, Arathihochland), Stammes (u. a. Caryssia Moonhunter, Feralas).",
          allianzZone = 1425, allianzX = 13.0, allianzY = 43.0,
          hordeZone = 1444, hordeX = 74.0, hordeY = 43.0 },
    },
    ["Verzauberkunst"] = {
        -- (v2.1) Mit Wowheads Verzauberkunst-Guide abgeglichen: Kitta/Hgarth
        -- lehren Fachmann (nicht Experte).
        { stufe = "Lehrling / Geselle (1-150)", standorte = "In allen Hauptstädten.\nGeselle ab Skill 50 und Stufe 10.",
          allianzZone = 1453, allianzX = 43.0, allianzY = 64.0,
          hordeZone = 1454, hordeX = 53.6, hordeY = 38.2 },
        { stufe = "Experte (150-225)", standorte = "Ab Skill 125 und Stufe 20.\nAllianz: Lucan Cordell (Sturmwind), Gimble Thistlefuzz (Eisenschmiede), Xylinnia Starshine (Feathermoon, Feralas)\nHorde: Teg Dawnstrider (Donnerfels), Godan (Orgrimmar), Lavinia Crowe (Unterstadt)",
          allianzZone = 1453, allianzX = 43.0, allianzY = 64.2,
          hordeZone = 1454, hordeX = 53.8, hordeY = 38.4 },
        { stufe = "Fachmann (225-300)", standorte = "Ab Skill 225 und Stufe 35.\nAllianz: Kitta Firewind (Turm von Azora, Wald von Elwynn)\nHorde: Hgarth (Sonnenfels, Steinkrallengebirge)\nAlternative für beide: Annora in Uldaman (Instanz, schon ab Skill 200)",
          allianzZone = 1429, allianzX = 64.8, allianzY = 70.6,
          hordeZone = 1442, hordeX = 49.2, hordeY = 57.2 }
    },
    -- NEU: Kochkunst-Lehrer, bestätigt über Wowheads offiziellen Guide.
    ["Kochkunst"] = {
        { stufe = "Lehrling & Geselle (1-150)", standorte = "Allianz: Stephen Ryback in Sturmwind / Daryl Riknussun in Eisenschmiede / Alegorn in Darnassus\nHorde: Zamja in Orgrimmar / Eunice Burch in Unterstadt / Aska Mistrunner in Donnerfels",
          allianzZone = 1453, allianzX = 77.0, allianzY = 53.0,
          hordeZone = 1454, hordeX = 57.0, hordeY = 53.0 },
        { stufe = "Experte (150-225)", standorte = "Kauf des 'Expertenkochbuch': Allianz bei Shandrina in Eschental / Horde bei Wulan in Desolace",
          allianzZone = 1440, allianzX = 50.0, allianzY = 65.0,
          hordeZone = 1443, hordeX = 26.0, hordeY = 69.0 },
        { stufe = "Fachmann (225-300)", standorte = "Questreihe ab Skill 225 & Charakterstufe 35: Allianz bei Daryl Riknussun (Eisenschmiede) / Horde bei Zamja (Orgrimmar), Abschluss bei Dirge Quikcleave in Gadgetzan",
          allianzZone = 1455, allianzX = 60.0, allianzY = 36.0,
          hordeZone = 1454, hordeX = 57.0, hordeY = 53.0 }
    }
}
end
