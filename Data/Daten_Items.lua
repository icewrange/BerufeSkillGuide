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
DB["Kristallphiose"] = 3371
DB["Leere Phiole"] = 3371
DB["Wilddorndistel"] = 2450
DB["Beulenbeere"] = 2453
DB["Königsblut"] = 3356
-- FIX: "Würgetang" (Stranglekelp) und "Golddorn" (Goldthorn) hatten
-- vertauschte Item-IDs - dadurch zeigte der Icon-Lookup für jede der
-- beiden Pflanzen das Bild der jeweils anderen an.
-- Bestätigt über Wowhead: ID 3820 = Stranglekelp, ID 3821 = Goldthorn.
DB["Würgetang"] = 3820
DB["Maguskönigskraut"] = 785
DB["Blassblatt"] = 3818
DB["Lebenswurz"] = 3357
DB["Golddorn"] = 3821
DB["Khadgars Schnurrbart"] = 3819
DB["Kristallphiole"] = 8925
DB["Sonnengras"] = 8838
DB["Blindkraut"] = 8839
DB["Geisterpilz"] = 8845
DB["Gromsblut"] = 8846
DB["Traumblatt"] = 13465
DB["Bergsilbersalbei"] = 13465
DB["Pestblüte"] = 13466
DB["Eiskappe"] = 13467
DB["Schwarzer Lotus"] = 13468

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
DB["Seelenstaub"] = 11082
DB["Visionenstaub"] = 11137
DB["Traumstaub"] = 11176
DB["Illusionsstaub"] = 16204
DB["Geringe Magieessenz"] = 10938
DB["Große Magieessenz"] = 10939
DB["Geringe Astralessenz"] = 10998
DB["Große Astralessenz"] = 11083
DB["Geringe Mystikeressenz"] = 11134
DB["Große Mystikeressenz"] = 11135
DB["Geringe Netheressenz"] = 11174
DB["Große ewige Essenz"] = 16203
DB["Kleiner glänzender Splitter"] = 11177
DB["Großer glänzender Splitter"] = 11178
DB["Kupferrute"] = 6218
DB["Silberrute"] = 6338
DB["Goldrute"] = 11128
DB["Echtsilberrute"] = 11144
DB["Arkanitrute"] = 16206
DB["Schattenedelstein"] = 1210
DB["Schillernde Perle"] = 5500
DB["Schwarze Perle"] = 5523
DB["Goldene Perle"] = 13926
DB["Einfaches Holz"] = 2318

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
