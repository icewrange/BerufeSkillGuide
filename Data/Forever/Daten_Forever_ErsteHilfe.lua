-- ============================================================================
-- WOW FOREVER: ERSTE HILFE (Lehrer, Rezepte, Hinweise)
-- ============================================================================
-- Quelle: Wowhead "First Aid Overview" (Forever, EN + DE, Stand 25.09.2026,
-- Beta). Eine Skill-Route gibt es dort noch nicht ("Leveling section coming
-- soon"), auch keine Zutaten - der Guide zeigt deshalb weiter die Classic-
-- Verband-Route, dazu hier Lehrer, alle Forever-Rezepte (Suche) und Hinweise.
BerufeLehrerDB_Forever   = BerufeLehrerDB_Forever   or {}
BerufeFundorteDB_Forever = BerufeFundorteDB_Forever or {}
BerufeHinweisDB_Forever  = BerufeHinweisDB_Forever  or {}

if GetLocale() == "deDE" then
BerufeHinweisDB_Forever["Alchimie"] = "ACHTUNG Forever: Heiltränke werden hier mit ERSTER HILFE hergestellt, nicht mit Alchimie! Die Heiltrank-Schritte dieser Classic-Route funktionieren in Forever nicht."
BerufeHinweisDB_Forever["Erste Hilfe"] = "Forever: Erste Hilfe stellt zusätzlich Heiltränke (ab 1), Schlammpackungen gegen Krankheiten (ab 90), Abschnürbinden gegen Blutungen (ab 120) und Gegengift (ab 215) her. Rezept-Namen per Suche."
BerufeLehrerDB_Forever["Erste Hilfe"] = {
    { stufe = "Lehrling / Geselle (1-125)",
      standorte = "Allianz: Shaina Fuller (Sturmwind), Nissa Firestone (Eisenschmiede), Dannelor (Darnassus)\nHorde: Arnok (Orgrimmar), Mary Edras (Unterstadt), Pand Stonebinder (Donnerfels)\nNeu in Forever: Naleeia Tattermend (Shen'dar) und Melasa Fairmend (Valanaar) auf der Insel Zephras" },
    { stufe = "Experte (125-225)",
      standorte = "Buch 'Erste Hilfe für Experten' kaufen:\nAllianz: Deneb Walker, Burg Stromgarde, Arathihochland\nHorde: Balai Lok'Wein, Brackenwall, Düstermarschen",
      allianzZone = 1417, allianzX = 27.2, allianzY = 58.8,
      hordeZone = 1445, hordeX = 36.4, hordeY = 30.4 },
    { stufe = "Fachmann (225-300)",
      standorte = "Ab Skill 225 und Stufe 35:\nVorquest 'Traumachirurg der Allianz' bei Nissa Firestone (Eisenschmiede) bzw. 'Traumachirurg der Horde' bei Arnok (Orgrimmar),\ndann 'Triage' bei Doktor Gustaf VanHowzen (Theramore) bzw. Doktor Gregory Victor (Hammerfall)." },
}

BerufeFundorteDB_Forever["Schwacher Heiltrank"] = "|cff59ccff[Forever]|r Erste Hilfe - Heiltrank\nBenötigt Erste Hilfe 1.\nWird beim Erste-Hilfe-Lehrer gelernt.\n|cff888888(Forever-Beta, Angaben ohne Gewähr)|r"
BerufeFundorteDB_Forever["Geringer Heiltrank"] = "|cff59ccff[Forever]|r Erste Hilfe - Heiltrank\nBenötigt Erste Hilfe 55.\nWird beim Erste-Hilfe-Lehrer gelernt.\n|cff888888(Forever-Beta, Angaben ohne Gewähr)|r"
BerufeFundorteDB_Forever["Heiltrank"] = "|cff59ccff[Forever]|r Erste Hilfe - Heiltrank\nBenötigt Erste Hilfe 110.\nWird beim Erste-Hilfe-Lehrer gelernt.\n|cff888888(Forever-Beta, Angaben ohne Gewähr)|r"
BerufeFundorteDB_Forever["Großer Heiltrank"] = "|cff59ccff[Forever]|r Erste Hilfe - Heiltrank\nBenötigt Erste Hilfe 155.\nHandbuch vom Händler (welcher Händler, nennt Wowhead noch nicht).\n|cff888888(Forever-Beta, Angaben ohne Gewähr)|r"
BerufeFundorteDB_Forever["Überragender Heiltrank"] = "|cff59ccff[Forever]|r Erste Hilfe - Heiltrank\nBenötigt Erste Hilfe 215.\nHandbuch vom Händler (welcher Händler, nennt Wowhead noch nicht).\n|cff888888(Forever-Beta, Angaben ohne Gewähr)|r"
BerufeFundorteDB_Forever["Erheblicher Heiltrank"] = "|cff59ccff[Forever]|r Erste Hilfe - Heiltrank\nBenötigt Erste Hilfe 275.\nHandbuch vom Händler (welcher Händler, nennt Wowhead noch nicht).\n|cff888888(Forever-Beta, Angaben ohne Gewähr)|r"
BerufeFundorteDB_Forever["Einfache Schlammpackung"] = "|cff59ccff[Forever]|r Erste Hilfe - Schlammpackung (heilt Krankheit)\nBenötigt Erste Hilfe 90.\nWird beim Erste-Hilfe-Lehrer gelernt.\n|cff888888(Forever-Beta, Angaben ohne Gewähr)|r"
BerufeFundorteDB_Forever["Schlaue Schlammpackung"] = "|cff59ccff[Forever]|r Erste Hilfe - Schlammpackung (heilt Krankheit)\nBenötigt Erste Hilfe 140.\nHandbuch vom Händler (welcher Händler, nennt Wowhead noch nicht).\n|cff888888(Forever-Beta, Angaben ohne Gewähr)|r"
BerufeFundorteDB_Forever["Überragende Schlammpackung"] = "|cff59ccff[Forever]|r Erste Hilfe - Schlammpackung (heilt Krankheit)\nBenötigt Erste Hilfe 210.\nHandbuch vom Händler (welcher Händler, nennt Wowhead noch nicht).\n|cff888888(Forever-Beta, Angaben ohne Gewähr)|r"
BerufeFundorteDB_Forever["Starke Schlammpackung"] = "|cff59ccff[Forever]|r Erste Hilfe - Schlammpackung (heilt Krankheit)\nBenötigt Erste Hilfe 280.\nHandbuch vom Händler (welcher Händler, nennt Wowhead noch nicht).\n|cff888888(Forever-Beta, Angaben ohne Gewähr)|r"
BerufeFundorteDB_Forever["Wirksames Gegengift"] = "|cff59ccff[Forever]|r Erste Hilfe - Gegengift\nBenötigt Erste Hilfe 215.\nHandbuch vom Händler (welcher Händler, nennt Wowhead noch nicht).\n|cff888888(Forever-Beta, Angaben ohne Gewähr)|r"
BerufeFundorteDB_Forever["Wollabschnürbinde"] = "|cff59ccff[Forever]|r Erste Hilfe - Abschnürbinde (stoppt Blutungen)\nBenötigt Erste Hilfe 120.\nWird beim Erste-Hilfe-Lehrer gelernt.\n|cff888888(Forever-Beta, Angaben ohne Gewähr)|r"
BerufeFundorteDB_Forever["Lederabschnürbinde"] = "|cff59ccff[Forever]|r Erste Hilfe - Abschnürbinde (stoppt Blutungen)\nBenötigt Erste Hilfe 200.\nHandbuch vom Händler (welcher Händler, nennt Wowhead noch nicht).\n|cff888888(Forever-Beta, Angaben ohne Gewähr)|r"
BerufeFundorteDB_Forever["Chirurgische Abschnürbinde"] = "|cff59ccff[Forever]|r Erste Hilfe - Abschnürbinde (stoppt Blutungen)\nBenötigt Erste Hilfe 265.\nHandbuch vom Händler (welcher Händler, nennt Wowhead noch nicht).\n|cff888888(Forever-Beta, Angaben ohne Gewähr)|r"
BerufeFundorteDB_Forever["Verbandtasche"] = "|cff59ccff[Forever]|r Erste Hilfe - Lagerfeuer-Objekt (Stufe 1)\nBenötigt Erste Hilfe 20.\nWird beim Erste-Hilfe-Lehrer gelernt.\n|cff888888(Forever-Beta, Angaben ohne Gewähr)|r"
BerufeFundorteDB_Forever["Studierzimmer für Gifte"] = "|cff59ccff[Forever]|r Erste Hilfe - Lagerfeuer-Objekt (Stufe 2)\nBenötigt Erste Hilfe 140.\nBauplan vom Händler (welcher Händler, nennt Wowhead noch nicht).\n|cff888888(Forever-Beta, Angaben ohne Gewähr)|r"
BerufeFundorteDB_Forever["Labor des Seuchenarztes"] = "|cff59ccff[Forever]|r Erste Hilfe - Lagerfeuer-Objekt (Stufe 3)\nBenötigt Erste Hilfe 300.\nBauplan vom Händler (welcher Händler, nennt Wowhead noch nicht).\n|cff888888(Forever-Beta, Angaben ohne Gewähr)|r"
else
BerufeHinweisDB_Forever["Alchimie"] = "NOTE Forever: healing potions are made with FIRST AID here, not Alchemy! The healing potion steps of this Classic route do not work in Forever."
BerufeHinweisDB_Forever["Erste Hilfe"] = "Forever: First Aid also makes healing potions (from 1), poultices against disease (from 90), tourniquets against bleeding (from 120) and anti-venom (from 215). Search for the recipe names."
BerufeLehrerDB_Forever["Erste Hilfe"] = {
    { stufe = "Apprentice / Journeyman (1-125)",
      standorte = "Alliance: Shaina Fuller (Stormwind), Nissa Firestone (Ironforge), Dannelor (Darnassus)\nHorde: Arnok (Orgrimmar), Mary Edras (Undercity), Pand Stonebinder (Thunder Bluff)\nNew in Forever: Naleeia Tattermend (Shen'dar Village) and Melasa Fairmend (Valanaar) on Zephras Isle" },
    { stufe = "Expert (125-225)",
      standorte = "Buy the book 'Expert First Aid':\nAlliance: Deneb Walker, Stromgarde Keep, Arathi Highlands\nHorde: Balai Lok'Wein, Brackenwall Village, Dustwallow Marsh",
      allianzZone = 1417, allianzX = 27.2, allianzY = 58.8,
      hordeZone = 1445, hordeX = 36.4, hordeY = 30.4 },
    { stufe = "Artisan (225-300)",
      standorte = "From skill 225 and level 35:\nBreadcrumb 'Alliance Trauma' from Nissa Firestone (Ironforge) or 'Horde Trauma' from Arnok (Orgrimmar),\nthen 'Triage' from Doctor Gustaf VanHowzen (Theramore) or Doctor Gregory Victor (Hammerfall)." },
}

BerufeFundorteDB_Forever["Minor Healing Potion"] = "|cff59ccff[Forever]|r First Aid - Healing potion\nRequires First Aid 1.\nLearned from the First Aid trainer.\n|cff888888(Forever beta, subject to change)|r"
BerufeFundorteDB_Forever["Lesser Healing Potion"] = "|cff59ccff[Forever]|r First Aid - Healing potion\nRequires First Aid 55.\nLearned from the First Aid trainer.\n|cff888888(Forever beta, subject to change)|r"
BerufeFundorteDB_Forever["Healing Potion"] = "|cff59ccff[Forever]|r First Aid - Healing potion\nRequires First Aid 110.\nLearned from the First Aid trainer.\n|cff888888(Forever beta, subject to change)|r"
BerufeFundorteDB_Forever["Greater Healing Potion"] = "|cff59ccff[Forever]|r First Aid - Healing potion\nRequires First Aid 155.\nManual from a vendor (Wowhead does not name the vendor yet).\n|cff888888(Forever beta, subject to change)|r"
BerufeFundorteDB_Forever["Superior Healing Potion"] = "|cff59ccff[Forever]|r First Aid - Healing potion\nRequires First Aid 215.\nManual from a vendor (Wowhead does not name the vendor yet).\n|cff888888(Forever beta, subject to change)|r"
BerufeFundorteDB_Forever["Major Healing Potion"] = "|cff59ccff[Forever]|r First Aid - Healing potion\nRequires First Aid 275.\nManual from a vendor (Wowhead does not name the vendor yet).\n|cff888888(Forever beta, subject to change)|r"
BerufeFundorteDB_Forever["Simple Poultice"] = "|cff59ccff[Forever]|r First Aid - Poultice (cures disease)\nRequires First Aid 90.\nLearned from the First Aid trainer.\n|cff888888(Forever beta, subject to change)|r"
BerufeFundorteDB_Forever["Clever Poultice"] = "|cff59ccff[Forever]|r First Aid - Poultice (cures disease)\nRequires First Aid 140.\nManual from a vendor (Wowhead does not name the vendor yet).\n|cff888888(Forever beta, subject to change)|r"
BerufeFundorteDB_Forever["Superior Poultice"] = "|cff59ccff[Forever]|r First Aid - Poultice (cures disease)\nRequires First Aid 210.\nManual from a vendor (Wowhead does not name the vendor yet).\n|cff888888(Forever beta, subject to change)|r"
BerufeFundorteDB_Forever["Powerful Poultice"] = "|cff59ccff[Forever]|r First Aid - Poultice (cures disease)\nRequires First Aid 280.\nManual from a vendor (Wowhead does not name the vendor yet).\n|cff888888(Forever beta, subject to change)|r"
BerufeFundorteDB_Forever["Potent Anti-Venom"] = "|cff59ccff[Forever]|r First Aid - Anti-venom\nRequires First Aid 215.\nManual from a vendor (Wowhead does not name the vendor yet).\n|cff888888(Forever beta, subject to change)|r"
BerufeFundorteDB_Forever["Woolen Tourniquet"] = "|cff59ccff[Forever]|r First Aid - Tourniquet (stops bleeding)\nRequires First Aid 120.\nLearned from the First Aid trainer.\n|cff888888(Forever beta, subject to change)|r"
BerufeFundorteDB_Forever["Leather Tourniquet"] = "|cff59ccff[Forever]|r First Aid - Tourniquet (stops bleeding)\nRequires First Aid 200.\nManual from a vendor (Wowhead does not name the vendor yet).\n|cff888888(Forever beta, subject to change)|r"
BerufeFundorteDB_Forever["Surgical Tourniquet"] = "|cff59ccff[Forever]|r First Aid - Tourniquet (stops bleeding)\nRequires First Aid 265.\nManual from a vendor (Wowhead does not name the vendor yet).\n|cff888888(Forever beta, subject to change)|r"
BerufeFundorteDB_Forever["First Aid Kit"] = "|cff59ccff[Forever]|r First Aid - Campsite object (tier 1)\nRequires First Aid 20.\nLearned from the First Aid trainer.\n|cff888888(Forever beta, subject to change)|r"
BerufeFundorteDB_Forever["Toxin Study"] = "|cff59ccff[Forever]|r First Aid - Campsite object (tier 2)\nRequires First Aid 140.\nBlueprint from a vendor (Wowhead does not name the vendor yet).\n|cff888888(Forever beta, subject to change)|r"
BerufeFundorteDB_Forever["Plague Doctor's Laboratory"] = "|cff59ccff[Forever]|r First Aid - Campsite object (tier 3)\nRequires First Aid 300.\nBlueprint from a vendor (Wowhead does not name the vendor yet).\n|cff888888(Forever beta, subject to change)|r"
end
