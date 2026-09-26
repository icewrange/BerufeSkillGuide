-- Trainer location database for all professions - ENGLISH
-- Keys stay as the canonical (German) profession identifiers used
-- internally throughout the addon - only the displayed text is English.
-- NOTE: Skill tier above "Expert" is officially called "Artisan" in
-- English (not "Master" - that's the German term "Meister").
if GetLocale() ~= "deDE" then
BerufeLehrerDB = {
    -- (v2.1) Verified with Wowhead Classic leveling guide + Icy Veins / wow-professions.com
    ["Alchimie"] = {
        { stufe = "Apprentice / Journeyman (1-150)", standorte = "Alliance: Lilyssia Nightbreeze (Stormwind, Mage Quarter), Tally Berryfizz (Ironforge, Tinker Town), Ainethil (Darnassus)\nHorde: Yelmak (Orgrimmar, The Drag), Doctor Herbert Halsey (Undercity, Apothecarium), Bena Winterhoof (Thunder Bluff)\nJourneyman from skill 50 and level 10.",
          allianzZone = 1453, allianzX = 46.4, allianzY = 79.6,
          hordeZone = 1454, hordeX = 56.6, hordeY = 33.2 },
        { stufe = "Expert (150-225)", standorte = "From skill 125 and level 20.\nAlliance: Ainethil (Darnassus), Kylanna Windwhisper (Feathermoon Stronghold, Feralas)\nHorde: Doctor Herbert Halsey (Undercity, Apothecarium), Rogvar (Stonard, Swamp of Sorrows)",
          allianzZone = 1457, allianzX = 55.0, allianzY = 24.0,
          hordeZone = 1458, hordeX = 48.2, hordeY = 72.2 },
        { stufe = "Artisan (225-300)", standorte = "From skill 225 and level 35.\nAlliance: Kylanna Windwhisper (Feathermoon Stronghold, Feralas)\nHorde: Rogvar (Stonard, Swamp of Sorrows)",
          allianzZone = 1444, allianzX = 32.6, allianzY = 43.8,
          hordeZone = 1435, hordeX = 48.4, hordeY = 55.6 },
    },
    -- (v2.1) Verified with Wowhead Classic leveling guide + Icy Veins / wow-professions.com
    ["Ingenieurskunst"] = {
        { stufe = "Apprentice / Journeyman (1-150)", standorte = "Alliance: Jemma Quikswitch (Ironforge, Tinker Town), Sprite Jumpsprocket (Stormwind, Dwarven District)\nHorde: Thund (Orgrimmar, Valley of Honor), Graham Van Talen (Undercity, Rogues' Quarter)\nNeutral: Tinkerwiz (Ratchet, The Barrens)\nJourneyman from skill 50 and level 10.",
          allianzZone = 1455, allianzX = 67.8, allianzY = 44.0,
          hordeZone = 1454, hordeX = 75.8, hordeY = 24.6 },
        { stufe = "Expert (150-225)", standorte = "From skill 125 and level 20.\nAlliance: Trixie Quikswitch (Ironforge, Tinker Town), Lilliam Sparkspindle (Stormwind, Dwarven District)\nHorde: Nogg (Orgrimmar, Valley of Honor), Franklin Lloyd (Undercity, Rogues' Quarter)\nNeutral: Buzzek Bracketswing (Gadgetzan, Tanaris)",
          allianzZone = 1455, allianzX = 67.8, allianzY = 43.2,
          hordeZone = 1454, hordeX = 75.8, hordeY = 25.2 },
        { stufe = "Artisan (225-300)", standorte = "From skill 225 and level 35.\nAlliance: Springspindle Fizzlegear (Ironforge, Tinker Town)\nHorde: Roxxik (Orgrimmar, Valley of Honor)\nNeutral: Buzzek Bracketswing (Gadgetzan, Tanaris)\nSpecialization: Gnomish - Tinkmaster Overspark (Ironforge) / Oglethorpe Obnoticus (Booty Bay); Goblin - Nixx Sprocketspring (Gadgetzan) / Vazario Linkgrease (Ratchet)",
          allianzZone = 1455, allianzX = 68.6, allianzY = 44.0,
          hordeZone = 1454, hordeX = 76.0, hordeY = 25.0 },
    },
    -- (v2.1) Verified with Wowhead Classic leveling guide + Icy Veins / wow-professions.com
    ["Schmiedekunst"] = {
        { stufe = "Apprentice / Journeyman (1-150)", standorte = "In every capital city, plus e.g.:\nAlliance: Smith Argus (Goldshire, Elwynn Forest), Tognus Flintfire (Kharanos, Dun Morogh)\nHorde: Dwukk (Razor Hill, Durotar)\nJourneyman from skill 50 and level 10.",
          allianzZone = 1429, allianzX = 41.0, allianzY = 65.0,
          hordeZone = 1411, hordeX = 52.0, hordeY = 40.6 },
        { stufe = "Expert (150-225)", standorte = "From skill 125 and level 20.\nAlliance: Bengus Deepforge (Ironforge, Great Forge), Therum Deepforge (Stormwind, Old Town), Clarise Gnarltree (Duskwood)\nHorde: Saru Steelfury (Orgrimmar, Valley of Honor), James Van Brunt (Undercity, War Quarter), Karn Stonehoof (Thunder Bluff), Traugh (Crossroads, The Barrens)",
          allianzZone = 1455, allianzX = 52.0, allianzY = 40.0,
          hordeZone = 1454, hordeX = 82.2, hordeY = 23.0 },
        { stufe = "Artisan (225-300)", standorte = "From skill 225 and level 35.\nOnly from: Brikk Keencraft (Booty Bay, Stranglethorn Vale) - for Alliance and Horde.",
          allianzZone = 1434, allianzX = 29.0, allianzY = 75.4,
          hordeZone = 1434, hordeX = 29.0, hordeY = 75.4 },
    },
    -- (v2.1) Verified with Wowhead Classic leveling guide + Icy Veins / wow-professions.com
    ["Schneidern"] = {
        { stufe = "Apprentice / Journeyman (1-150)", standorte = "Alliance: Lawrence Schneider / Sellandus (Stormwind, Mage Quarter), Uthrar Threx / Jormund Stonebrow (Ironforge, Great Forge), Trianna (Darnassus, Craftsmen's Terrace)\nHorde: Snang / Magar (Orgrimmar, The Drag), Victor Ward / Rhiannon Davis (Undercity, Magic Quarter), Vhan / Tepa (Thunder Bluff)\nJourneyman from skill 50 and level 10.",
          allianzZone = 1453, allianzX = 43.6, allianzY = 73.8,
          hordeZone = 1454, hordeX = 63.0, hordeY = 49.6 },
        { stufe = "Expert (150-225)", standorte = "From skill 125 and level 20.\nAlliance: Georgio Bolero (Stormwind, Mage Quarter)\nHorde: Josef Gregorian (Undercity, Magic Quarter)",
          allianzZone = 1453, allianzX = 43.2, allianzY = 73.6,
          hordeZone = 1458, hordeX = 70.6, hordeY = 30.6 },
        { stufe = "Artisan (225-300)", standorte = "From skill 225 and level 35.\nAlliance: Timothy Worthington (Theramore Isle, Dustwallow Marsh)\nHorde: Daryl Stack (Tarren Mill, Hillsbrad Foothills)",
          allianzZone = 1445, allianzX = 66.2, allianzY = 51.6,
          hordeZone = 1424, hordeX = 63.6, hordeY = 20.8 },
    },
    -- (v2.1) Verified with Wowhead Classic leveling guide + Icy Veins / wow-professions.com
    ["Lederverarbeitung"] = {
        { stufe = "Apprentice / Journeyman (1-150)", standorte = "Alliance: Randal Worth (Stormwind), Adele Fielder (Elwynn Forest), Nadyia Maneweaver (Teldrassil)\nHorde: Chaw Stronghide (Mulgore), Shelene Rhobart (Tirisfal Glades)\nJourneyman from skill 50 and level 10.",
          allianzZone = 1453, allianzX = 68.0, allianzY = 49.0,
          hordeZone = 1412, hordeX = 45.0, hordeY = 57.0 },
        { stufe = "Expert (150-225)", standorte = "From skill 125 and level 20.\nAlliance: Telonis (Darnassus), Fimble Finespindle (Ironforge)\nHorde: Una (Thunder Bluff), Karolek (Orgrimmar), Arthur Moore (Undercity)",
          allianzZone = 1457, allianzX = 64.0, allianzY = 21.0,
          hordeZone = 1456, hordeX = 41.0, hordeY = 42.0 },
        { stufe = "Artisan (225-300)", standorte = "From skill 225 and level 35.\nAlliance: Drakk Stonehand (Aerie Peak, The Hinterlands)\nHorde: Hahrana Ironhide (Camp Mojache, Feralas)\nSpecialization from level 40: Dragonscale (e.g. Peter Galen, Azshara), Elemental (e.g. Brumn Winterhoof, Arathi Highlands), Tribal (e.g. Caryssia Moonhunter, Feralas).",
          allianzZone = 1425, allianzX = 13.0, allianzY = 43.0,
          hordeZone = 1444, hordeX = 74.0, hordeY = 43.0 },
    },
    ["Verzauberkunst"] = {
        { stufe = "Apprentice / Journeyman (1-150)", standorte = "In every capital city.\nJourneyman from skill 50 and level 10.",
          allianzZone = 1453, allianzX = 43.0, allianzY = 64.0,
          hordeZone = 1454, hordeX = 53.6, hordeY = 38.2 },
        { stufe = "Expert (150-225)", standorte = "From skill 125 and level 20.\nAlliance: Lucan Cordell (Stormwind), Gimble Thistlefuzz (Ironforge), Xylinnia Starshine (Feathermoon, Feralas)\nHorde: Teg Dawnstrider (Thunder Bluff), Godan (Orgrimmar), Lavinia Crowe (Undercity)",
          allianzZone = 1453, allianzX = 43.0, allianzY = 64.2,
          hordeZone = 1454, hordeX = 53.8, hordeY = 38.4 },
        { stufe = "Artisan (225-300)", standorte = "From skill 225 and level 35.\nAlliance: Kitta Firewind (Tower of Azora, Elwynn Forest)\nHorde: Hgarth (Sun Rock Retreat, Stonetalon Mountains)\nAlternative for both: Annora in Uldaman (instance, from skill 200)",
          allianzZone = 1429, allianzX = 64.8, allianzY = 70.6,
          hordeZone = 1442, hordeX = 49.2, hordeY = 57.2 }
    },
    ["Kochkunst"] = {
        { stufe = "Apprentice & Journeyman (1-150)", standorte = "Alliance: Stephen Ryback in Stormwind / Daryl Riknussun in Ironforge / Alegorn in Darnassus\nHorde: Zamja in Orgrimmar / Eunice Burch in Undercity / Aska Mistrunner in Thunder Bluff",
          allianzZone = 1453, allianzX = 77.0, allianzY = 53.0,
          hordeZone = 1454, hordeX = 57.0, hordeY = 53.0 },
        { stufe = "Expert (150-225)", standorte = "Buy the 'Expert Cookbook': Alliance from Shandrina in Ashenvale / Horde from Wulan in Desolace",
          allianzZone = 1440, allianzX = 50.0, allianzY = 65.0,
          hordeZone = 1443, hordeX = 26.0, hordeY = 69.0 },
        { stufe = "Artisan (225-300)", standorte = "Quest chain from skill 225 & character level 35: Alliance via Daryl Riknussun (Ironforge) / Horde via Zamja (Orgrimmar), finished by Dirge Quikcleave in Gadgetzan",
          allianzZone = 1455, allianzX = 60.0, allianzY = 36.0,
          hordeZone = 1454, hordeX = 57.0, hordeY = 53.0 }
    }
}
end
