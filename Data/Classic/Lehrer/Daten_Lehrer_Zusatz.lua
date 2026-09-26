-- ============================================================================
-- DATABASE: LEHRER FÜR ERSTE HILFE & SAMMELBERUFE (v2.1)
-- ============================================================================
-- Muss NACH Daten_Lehrer.lua geladen werden (dort wird die Tabelle angelegt).
-- Koordinaten (Zone = uiMapID) ermöglichen den Wegpunkt-Button im Guide.
BerufeLehrerDB = BerufeLehrerDB or {}

if GetLocale() == "deDE" then
BerufeLehrerDB["Erste Hilfe"] = {
    { stufe = "Lehrling / Geselle (1-125)",
      standorte = "Allianz: Shaina Fuller (Sturmwind), Nissa Firestone (Eisenschmiede), Dannelor (Darnassus)\nHorde: Arnok (Orgrimmar), Mary Edras (Unterstadt), Pand Stonebinder (Donnerfels)" },
    { stufe = "Experte (125-225)",
      standorte = "Buch 'Erste Hilfe für Experten - Verbinden, aber richtig' beim Händler kaufen:\nAllianz: Deneb Walker, Burg Stromgarde, Arathihochland (27.2, 58.8)\nHorde: Balai Lok'Wein, Brackenwall, Düstermarschen (36.4, 30.4)\nDort auch: Handbuch: Schwerer Seidenverband + Handbuch: Magiestoffverband",
      allianzZone = 1417, allianzX = 27.2, allianzY = 58.8,
      hordeZone = 1445, hordeX = 36.4, hordeY = 30.4 },
    { stufe = "Fachmann (225-300)",
      standorte = "Quest 'Triage' (ab Stufe 35):\nAllianz: Doktor Gustaf VanHowzen, Theramore (Düstermarschen)\nHorde: Doktor Gregory Victor, Hammerfall (Arathihochland)\nVorher beim Erste-Hilfe-Lehrer ansprechen (Eisenschmiede / Orgrimmar)." },
}

local SAMMEL_LEHRER = "Lehrer in allen Hauptstädten und vielen Dörfern.\nNächste Stufe lernen ab Skill 50 (Geselle), 125 (Experte) und 200 (Fachmann)."
BerufeLehrerDB["Bergbau"]      = { { stufe = "Alle Stufen", standorte = SAMMEL_LEHRER } }
BerufeLehrerDB["Kräuterkunde"] = { { stufe = "Alle Stufen", standorte = SAMMEL_LEHRER } }
BerufeLehrerDB["Kürschnerei"]  = { { stufe = "Alle Stufen", standorte = SAMMEL_LEHRER } }
end
