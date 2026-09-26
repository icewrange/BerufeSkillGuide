-- ============================================================================
-- CENTRAL MATERIAL DATABASE: ALL ADDON RESSOURCES (Skill 1-300)
-- ============================================================================
-- FIX: "Grüner Farbstoff" (2324->2605), "Verdichteter Stein"
-- (12654->12365), "Blauer Machtkristall" (11188->11184, 11188 ist
-- tatsächlich "Gelber Machtkristall") und "Herz des Feuers" (7078->7077)
-- hatten falsche IDs. Gegengeprüft mit Wowheads offiziellem deutschen
-- Schmiedekunst-Leveling-Guide.

BSG_ItemDB = BSG_ItemDB or {}
local DB = BSG_ItemDB
-- -- 1. ALCHIMIE & KRÄUTERKUNDE (Vereinfachtes Zahlenformat)
DB["Friedensblume"] = 2447
DB["Silberblatt"] = 765
DB["Erdwurzel"] = 2449
DB["Leere Phiole"] = 3371
-- FIX: "Wilddorndistel" war ein falscher Name für ID 2450 - laut Wowheads
-- deutscher Lokalisierung heißt dieses Kraut "Wilddornrose" (so wird es
-- auch in den Alchimie-Rezepten verwendet, passte also bisher nicht zum
-- DB-Key -> Icon-Lookup schlug fehl).
DB["Wilddornrose"] = 2450
-- FIX (v2.1): heißt laut Wowhead "Beulengras", nicht "Beulenbeere"
DB["Beulengras"] = 2453
DB["Königsblut"] = 3356
-- FIX: "Würgetang" (Stranglekelp) und "Golddorn" (Goldthorn) hatten
-- vertauschte Item-IDs - dadurch zeigte der Icon-Lookup für jede der
-- beiden Pflanzen das Bild der jeweils anderen an.
-- Bestätigt über Wowhead: ID 3820 = Stranglekelp, ID 3821 = Goldthorn.
DB["Würgetang"] = 3820
DB["Maguskönigskraut"] = 785
DB["Blassblatt"] = 3818
-- NEU: Fehlte komplett, wird aber im Alchimie-Rezept "Elixier der großen
-- Verteidigung" gebraucht. Bestätigt über Wowhead: ID 3355 = Fadeleaf =
-- deutsch "Wildstahlblume" (nicht zu verwechseln mit "Blassblatt"/ID 3818,
-- das trotz des Namens tatsächlich "Wild Steelbloom" entspricht).
DB["Wildstahlblume"] = 3355
DB["Lebenswurz"] = 3357
DB["Golddorn"] = 3821
-- FIX (v2.1): 3819 ist "Winterbiss"; Khadgars Schnurrbart = 3358
DB["Khadgars Schnurrbart"] = 3358
DB["Winterbiss"] = 3819
DB["Kristallphiole"] = 8925
DB["Sonnengras"] = 8838
DB["Blindkraut"] = 8839
DB["Geisterpilz"] = 8845
DB["Gromsblut"] = 8846
-- FIX: "Traumblatt" (Dreamfoil) hatte dieselbe ID wie "Bergsilbersalbei"
-- (Mountain Silversage) - beide zeigten dasselbe Icon. Bestätigt über
-- Wowhead: ID 13463 = Dreamfoil, ID 13465 = Mountain Silversage.
DB["Traumblatt"] = 13463
DB["Bergsilbersalbei"] = 13465
DB["Pestblüte"] = 13466
DB["Eiskappe"] = 13467
DB["Schwarzer Lotus"] = 13468
-- NEU: Fehlten komplett, werden aber in den Meister-Alchimie-Rezepten
-- gebraucht (Icon-Lookup zeigte bisher ein Fragezeichen). Alle über
-- Wowheads deutsche Itemseiten bestätigt.
DB["Goldener Sansam"] = 13464
DB["Arthas Tränen"] = 8836
DB["Lila Lotus"] = 8831
DB["Feuerblüte"] = 4625
DB["Schwarzes Vitriol"] = 9262
DB["Verbleite Phiole"] = 3372

BSG_ItemDB = BSG_ItemDB or {}
local DB = BSG_ItemDB
-- 2 Schmiedekunst
DB["Rauer Stein"] = 2835
DB["Grober Stein"] = 2836
DB["Schwerer Stein"] = 2838
DB["Robuster Stein"] = 7912
DB["Verdichteter Stein"] = 12365
-- NEU: Diese beiden werden in Daten_Schmiedekunst.lua als Zutat für
-- spätere Rezepte verwendet (nicht nur als Endergebnis), fehlten hier
-- aber komplett -> Icon-Lookup zeigte ein Fragezeichen.
-- Bestätigt über Wowhead: ID 3478 = Coarse Grinding Stone,
-- ID 3486 = Heavy Grinding Stone.
DB["Grober Schleifstein"] = 3478
DB["Schwerer Schleifstein"] = 3486
-- NEU: Ebenfalls als Zutat verwendet, fehlten bisher komplett.
-- Bestätigt über Wowhead: ID 3470 = Rough Grinding Stone,
-- ID 7966 = Solid Grinding Stone.
DB["Rauer Schleifstein"] = 3470
DB["Robuster Schleifstein"] = 7966
DB["Kupferbarren"] = 2840
DB["Silberbarren"] = 2842
DB["Bronzebarren"] = 2841
DB["Eisenbarren"] = 3575
DB["Goldbarren"] = 3577
DB["Stahlbarren"] = 3859
DB["Mithrilbarren"] = 3860
DB["Thoriumbarren"] = 12359
DB["Grüner Farbstoff"] = 2605
DB["Magiestoff"] = 4338
DB["Dickes Leder"] = 4304
DB["Unverwüstliches Leder"] = 8170
DB["Roter Machtkristall"] = 11186
DB["Blauer Machtkristall"] = 11184
DB["Grüner Machtkristall"] = 11185
DB["Sternrubin"] = 7910
DB["Aquamarin"] = 7909
DB["Herz des Feuers"] = 7077

BSG_ItemDB = BSG_ItemDB or {}
local DB = BSG_ItemDB
-- -- 3. VERZAUBERKUNST
DB["Seltsamer Staub"] = 10940
-- FIX (v2.1): IDs mit Große Astralessenz vertauscht
DB["Seelenstaub"] = 11083
DB["Visionenstaub"] = 11137
DB["Traumstaub"] = 11176
DB["Illusionsstaub"] = 16204
DB["Geringe Magieessenz"] = 10938
DB["Große Magieessenz"] = 10939
DB["Geringe Astralessenz"] = 10998
-- FIX (v2.1): IDs mit Seelenstaub vertauscht
DB["Große Astralessenz"] = 11082
DB["Geringe Mystikeressenz"] = 11134
DB["Große Mystikeressenz"] = 11135
DB["Geringe Netheressenz"] = 11174
DB["Große ewige Essenz"] = 16203
-- FIX (v2.1): 11177 ist der Kleine strahlende Splitter
DB["Kleiner glänzender Splitter"] = 14343
-- FIX (v2.1): 11178 ist der Große strahlende Splitter
DB["Großer glänzender Splitter"] = 14344
-- FIX (v2.1): 6218 ist die Runenverzierte Kupferrute
DB["Kupferrute"] = 6217
DB["Silberrute"] = 6338
DB["Goldrute"] = 11128
DB["Echtsilberrute"] = 11144
DB["Arkanitrute"] = 16206
DB["Schattenedelstein"] = 1210
DB["Schillernde Perle"] = 5500
-- FIX (v2.1): 5523 ist eine andere Perle
DB["Schwarze Perle"] = 7971
DB["Goldene Perle"] = 13926
-- FIX: Hatte dieselbe ID wie "Leichtes Leder" (Kopierfehler). Korrekte ID
-- für "Einfaches Holz" (Simple Wood) laut Wowhead: 4470.
DB["Einfaches Holz"] = 4470

BSG_ItemDB = BSG_ItemDB or {}
local DB = BSG_ItemDB
-- -- 4. INGENIEURSKUNST
DB["Leinenstoff"] = 2589
DB["Wollstoff"] = 2592
DB["Runenstoff"] = 14047
-- FIX: Hatte dieselbe ID wie "Grober Faden" (Kopierfehler). Echte ID für
-- "Schwacher Fluxus" (Weak Flux) laut Wowhead ist 2880.
DB["Schwacher Fluxus"] = 2880
DB["Moosachat"] = 1206
DB["Mittleres Leder"] = 2319
-- FIX: Die folgenden 6 IDs bildeten eine Verkettung von Vertauschungen -
-- jedes Item zeigte auf die ID des "nächsten" Items in der Liste statt
-- auf seine eigene. Alle gegen Wowheads Reagenzien-Tabelle korrigiert:
DB["Eine Hand voll Kupferbolzen"] = 4359
DB["Raues Sprengpulver"] = 4357
DB["Bronzeröhre"] = 4371
DB["Grobes Sprengpulver"] = 4364
DB["Surrendes bronzenes Dingsda"] = 4375
DB["Bronzegerüst"] = 4382
DB["Schweres Sprengpulver"] = 4377
DB["Robustes Sprengpulver"] = 10505
DB["Instabiler Auslöser"] = 10560
DB["Mithrilgehäuse"] = 10561
-- NEU: Fehlte komplett (auch in der EN-Sektion), wird aber im letzten
-- Meister-Rezept gebraucht. Bestätigt über Wowhead: ID 15992.
DB["Dichtes Sprengpulver"] = 15992

BSG_ItemDB = BSG_ItemDB or {}
local DB = BSG_ItemDB
-- -- 5. LEDERVERARBEITUNG
-- FIX: "Verdorbene Lederfetzen" hatte dieselbe ID wie "Feiner Faden"
-- (Kopierfehler). Korrekte ID laut Wowhead: 2934.
DB["Verdorbene Lederfetzen"] = 2934
DB["Leichtes Leder"] = 2318
DB["Leichter Balg"] = 783
-- FIX: Falsche ID, korrekt ist 4289.
DB["Salz"] = 4289
DB["Grober Faden"] = 2320
-- FIX: "Mittlerer Balg" und "Schwerer Balg" hatten vertauschte/falsche
-- IDs zueinander. Korrekt laut Wowhead: Mittlerer Balg=4232,
-- Schwerer Balg=4235.
DB["Mittlerer Balg"] = 4232
DB["Feiner Faden"] = 2321
-- FIX: Falsche ID, korrekt ist 4340.
DB["Grauer Farbstoff"] = 4340
-- FIX: "Schweres Leder" hatte dieselbe ID wie "Dickes Leder"
-- (Kopierfehler) - beide sind unterschiedliche Leder-Stufen. Korrekte
-- ID für "Schweres Leder" (Heavy Leather) laut Wowhead: 4234.
DB["Schweres Leder"] = 4234
DB["Schwerer Balg"] = 4235
-- FIX: "Seidenfaden" hatte dieselbe ID wie "Magiestoff" (Kopierfehler).
-- Korrekte ID laut Wowhead: 4291.
DB["Seidenfaden"] = 4291
-- FIX: Falsche ID, korrekt ist 2325.
DB["Schwarzer Farbstoff"] = 2325
DB["Runenfaden"] = 14341

BSG_ItemDB = BSG_ItemDB or {}
local DB = BSG_ItemDB
-- -- 6. SCHNEIDERN
DB["Leinenstoffballen"] = 2996
DB["Wollstoffballen"] = 2997
-- FIX: "Seidenstoffballen" und "Magiestoffballen" hatten vertauschte/
-- falsche IDs. Korrekt laut Wowhead: Seidenstoffballen=4305,
-- Magiestoffballen=4339.
DB["Seidenstoffballen"] = 4305
DB["Magiestoffballen"] = 4339
DB["Runenstoffballen"] = 14048
DB["Seidenstoff"] = 4306
-- FIX: Hatte dieselbe ID wie "Feiner Faden" (Kopierfehler). Korrekte ID
-- für "Bleiche" (Bleach) laut Wowhead: 2324.
DB["Bleiche"] = 2324
-- NEU: Fehlte komplett, wird aber für "Azurblaue Seidenkapuze" gebraucht.
DB["Blauer Farbstoff"] = 6260
-- FIX: "Roter Farbstoff" und "Oranger Farbstoff" hatten vertauschte IDs.
-- Korrekt laut Wowhead: Roter Farbstoff=2604, Oranger Farbstoff=6261.
DB["Roter Farbstoff"] = 2604
DB["Oranger Farbstoff"] = 6261
DB["Schwerer Seidenfaden"] = 8343

BSG_ItemDB = BSG_ItemDB or {}
local DB = BSG_ItemDB
-- -- 7. KOCHKUNST (bestätigt über Wowheads offiziellen Fischerei-Leveling-Pfad)
DB["Roher glänzender Kleinfisch"] = 6291
DB["Roher Langzahniger Matschschnapper"] = 6289
DB["Roher Stoppelfühlerwels"] = 6308
DB["Rohe Mithrilkopfforelle"] = 8365
DB["Roher Tüpfelgelbschwanz"] = 4603
DB["Großer roher Machtfisch"] = 13893
DB["Scharfe Gewürze"] = 2692
DB["Feine Gewürze"] = 3713

-- ============================================================================
-- ENGLISCHE ITEM-NAMEN (für englische Clients, siehe Daten_*_EN.lua)
-- ============================================================================
-- Zeigen auf dieselben Item-IDs wie oben - keine Konflikte möglich, da es
-- sich um andere String-Keys handelt. Übersetzung aus eigenem Wissen über
-- Classic-WoW-Itemnamen, NICHT einzeln gegen Wowhead gegengeprüft (anders
-- als die deutschen Daten). Bei falschen Namen bitte melden.
BSG_ItemDB = BSG_ItemDB or {}
local DB = BSG_ItemDB
-- Alchemy & Herbalism
DB["Peacebloom"] = 2447
DB["Silverleaf"] = 765
DB["Earthroot"] = 2449
DB["Empty Vial"] = 3371
DB["Leaded Vial"] = 3372
DB["Briarthorn"] = 2450
DB["Bruiseweed"] = 2453
DB["Kingsblood"] = 3356
DB["Stranglekelp"] = 3820
DB["Mageroyal"] = 785
-- FIX (v2.1): Wild Steelbloom/Fadeleaf-IDs waren vertauscht
DB["Wild Steelbloom"] = 3355
DB["Liferoot"] = 3357
DB["Goldthorn"] = 3821
DB["Khadgar's Whisker"] = 3358
DB["Crystal Vial"] = 8925
DB["Sungrass"] = 8838
DB["Blindweed"] = 8839
DB["Ghost Mushroom"] = 8845
DB["Gromsblood"] = 8846
-- FIX: had the same ID as Mountain Silversage. Confirmed via Wowhead:
-- 13463 = Dreamfoil, 13465 = Mountain Silversage.
DB["Dreamfoil"] = 13463
DB["Mountain Silversage"] = 13465
DB["Plaguebloom"] = 13466
DB["Icecap"] = 13467
DB["Black Lotus"] = 13468
DB["Fadeleaf"] = 3818
DB["Arthas' Tears"] = 8836
DB["Golden Sansam"] = 13464
DB["Black Vitriol"] = 9262
DB["Purple Lotus"] = 8831
DB["Firebloom"] = 4625

-- Blacksmithing & Mining
DB["Rough Stone"] = 2835
DB["Coarse Stone"] = 2836
DB["Heavy Stone"] = 2838
DB["Solid Stone"] = 7912
DB["Dense Stone"] = 12365
DB["Coarse Grinding Stone"] = 3478
DB["Heavy Grinding Stone"] = 3486
DB["Rough Grinding Stone"] = 3470
DB["Solid Grinding Stone"] = 7966
DB["Copper Bar"] = 2840
DB["Silver Bar"] = 2842
DB["Bronze Bar"] = 2841
DB["Iron Bar"] = 3575
DB["Gold Bar"] = 3577
DB["Steel Bar"] = 3859
DB["Mithril Bar"] = 3860
DB["Thorium Bar"] = 12359
DB["Green Dye"] = 2605
DB["Mageweave Cloth"] = 4338
DB["Thick Leather"] = 4304
DB["Rugged Leather"] = 8170
DB["Red Power Crystal"] = 11186
DB["Blue Power Crystal"] = 11184
DB["Green Power Crystal"] = 11185
DB["Star Ruby"] = 7910
DB["Aquamarine"] = 7909
DB["Heart of Fire"] = 7077

-- Enchanting
DB["Strange Dust"] = 10940
DB["Soul Dust"] = 11083
DB["Vision Dust"] = 11137
DB["Dream Dust"] = 11176
DB["Illusion Dust"] = 16204
DB["Lesser Magic Essence"] = 10938
DB["Greater Magic Essence"] = 10939
DB["Lesser Astral Essence"] = 10998
DB["Greater Astral Essence"] = 11082
DB["Lesser Mystic Essence"] = 11134
DB["Greater Mystic Essence"] = 11135
DB["Lesser Nether Essence"] = 11174
DB["Greater Eternal Essence"] = 16203
DB["Small Brilliant Shard"] = 14343
DB["Large Brilliant Shard"] = 14344
DB["Copper Rod"] = 6217
DB["Silver Rod"] = 6338
DB["Golden Rod"] = 11128
DB["Truesilver Rod"] = 11144
DB["Arcanite Rod"] = 16206
DB["Shadowgem"] = 1210
DB["Iridescent Pearl"] = 5500
DB["Black Pearl"] = 7971
DB["Golden Pearl"] = 13926
DB["Simple Wood"] = 4470

-- Engineering
DB["Linen Cloth"] = 2589
DB["Wool Cloth"] = 2592
DB["Runecloth"] = 14047
DB["Weak Flux"] = 2880
DB["Moss Agate"] = 1206
DB["Medium Leather"] = 2319
DB["Handful of Copper Bolts"] = 4359
DB["Rough Blasting Powder"] = 4357
DB["Bronze Tube"] = 4371
DB["Coarse Blasting Powder"] = 4364
DB["Whirring Bronze Gizmo"] = 4375
DB["Bronze Framework"] = 4382
DB["Heavy Blasting Powder"] = 4377
DB["Solid Blasting Powder"] = 10505
DB["Unstable Trigger"] = 10560
DB["Mithril Casing"] = 10561
-- NEU: was missing entirely, needed for the final master-level recipe.
DB["Dense Blasting Powder"] = 15992

-- Leatherworking
DB["Ruined Leather Scraps"] = 2934
DB["Light Leather"] = 2318
DB["Light Hide"] = 783
DB["Salt"] = 4289
DB["Coarse Thread"] = 2320
DB["Medium Hide"] = 4232
DB["Fine Thread"] = 2321
DB["Gray Dye"] = 4340
DB["Heavy Leather"] = 4234
DB["Heavy Hide"] = 4235
DB["Silken Thread"] = 4291
DB["Black Dye"] = 2325
DB["Rune Thread"] = 14341

-- Tailoring
DB["Bolt of Linen Cloth"] = 2996
DB["Bolt of Woolen Cloth"] = 2997
DB["Bolt of Silk Cloth"] = 4305
DB["Bolt of Mageweave"] = 4339
DB["Bolt of Runecloth"] = 14048
DB["Silk Cloth"] = 4306
DB["Bleach"] = 2324
DB["Blue Dye"] = 6260
DB["Red Dye"] = 2604
DB["Orange Dye"] = 6261
DB["Heavy Silken Thread"] = 8343

-- Cooking
DB["Raw Brilliant Smallfish"] = 6291
DB["Raw Longjaw Mud Snapper"] = 6289
DB["Raw Bristle Whisker Catfish"] = 6308
DB["Raw Mithril Head Trout"] = 8365
DB["Raw Spotted Yellowtail"] = 4603
-- FIX (v2.1): ID 13893 = Large Raw Mightfish
DB["Large Raw Mightfish"] = 13893
-- FIX (v2.1): ID 2692 = Hot Spices
DB["Hot Spices"] = 2692
-- FIX (v2.1): ID 3713 = Soothing Spices
DB["Soothing Spices"] = 3713

-- ============================================================================
-- NEU (v2.1): ERSTE HILFE & SAMMELBERUFE
-- ============================================================================
DB["Grabmoos"] = 3369
DB["Kupfererz"] = 2770
DB["Zinnerz"] = 2771
DB["Eisenerz"] = 2772
DB["Silbererz"] = 2775
DB["Golderz"] = 2776
DB["Mithrilerz"] = 3858
DB["Echtsilbererz"] = 7911
DB["Thoriumerz"] = 10620
DB["Dunkeleisenerz"] = 11370
DB["Leinenverband"] = 1251
DB["Schwerer Leinenverband"] = 2581
DB["Wollverband"] = 3530
DB["Schwerer Wollverband"] = 3531
DB["Seidenverband"] = 6450
DB["Schwerer Seidenverband"] = 6451
DB["Magiestoffverband"] = 8544
DB["Schwerer Magiestoffverband"] = 8545
DB["Runenstoffverband"] = 14529
DB["Schwerer Runenstoffverband"] = 14530

DB["Grave Moss"] = 3369
DB["Wintersbite"] = 3819
DB["Copper Ore"] = 2770
DB["Tin Ore"] = 2771
DB["Iron Ore"] = 2772
DB["Silver Ore"] = 2775
DB["Gold Ore"] = 2776
DB["Mithril Ore"] = 3858
DB["Truesilver Ore"] = 7911
DB["Thorium Ore"] = 10620
DB["Dark Iron Ore"] = 11370
DB["Linen Bandage"] = 1251
DB["Heavy Linen Bandage"] = 2581
DB["Wool Bandage"] = 3530
DB["Heavy Wool Bandage"] = 3531
DB["Silk Bandage"] = 6450
DB["Heavy Silk Bandage"] = 6451
DB["Mageweave Bandage"] = 8544
DB["Heavy Mageweave Bandage"] = 8545
DB["Runecloth Bandage"] = 14529
DB["Heavy Runecloth Bandage"] = 14530

-- ============================================================================
-- NEU (v2.1): FEHLENDE GUIDE-MATERIALIEN + STRAHLENDE SPLITTER
-- ============================================================================
DB["Kleiner strahlender Splitter"] = 11177
DB["Großer strahlender Splitter"] = 11178
DB["Small Radiant Shard"] = 11177
DB["Large Radiant Shard"] = 11178
DB["Schwacher Heiltrank"] = 118
DB["Minor Healing Potion"] = 118
DB["Geschmeidiger leichter Balg"] = 4231
DB["Cured Light Hide"] = 4231
DB["Geschmeidiger mittlerer Balg"] = 4233
DB["Cured Medium Hide"] = 4233
DB["Geschmeidiger schwerer Balg"] = 4236
DB["Cured Heavy Hide"] = 4236
DB["Feiner Ledergürtel"] = 4246
DB["Fine Leather Belt"] = 4246
