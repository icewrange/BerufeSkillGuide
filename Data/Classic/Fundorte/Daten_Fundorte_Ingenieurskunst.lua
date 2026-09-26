-- ============================================================================
-- REZEPT-FUNDORTE CLASSIC: INGENIEURSKUNST (DEUTSCH)
-- ============================================================================
-- v2.1: Komplett neu geprüft mit Wowhead Classic (deutsche + englische
-- Item-Seiten) und dem Warcraft Wiki (Stand 25.09.2026). Namen = exakte
-- deutsche Spielnamen ohne "Rezept:/Formel:/Muster:"-Präfix.
-- Englische Gegner-Namen in Klammern, wo der deutsche Name nicht bestätigt ist.
BerufeFundorteDB = BerufeFundorteDB or {}

if GetLocale() == "deDE" then
BerufeFundorteDB["Feldreparaturbot-74A"] = "Bauplan: Feldreparaturbot-74A\nLiegt als anklickbares Pergament auf dem Boden im Raum von Golemlord Argelmach.\nOrt: Schwarzfelstiefen (BRD).\nBenötigt Ingenieurskunst 300."
BerufeFundorteDB["Arkanitdrachling"] = "Bauplan: Arkanitdrachling\nDrop von: Kobaltblauen Magiewirkern (Elite, Stufe 57-58)\nOrt: Winterquell.\nBenötigt Ingenieurskunst 300."
BerufeFundorteDB["Thoriumgranate"] = "Wird beim Ingenieurskunst-Lehrer gelernt (ab Skill 260)."
BerufeFundorteDB["Goblin-Pioniersprengladung"] = "Wird beim Goblin-Ingenieurskunst-Lehrer gelernt (Spezialisierung Goblin, ab Skill 205)."
BerufeFundorteDB["Gnomentodesstrahl"] = "Wird beim Gnomen-Ingenieurskunst-Lehrer gelernt (Spezialisierung Gnom, ab Skill 240)."
BerufeFundorteDB["Salzstreuer"] = "Wird beim Ingenieurskunst-Lehrer gelernt (ab Skill 250). Wichtig für Lederverarbeiter!"
-- v2.1: Rezepte aus dem Leveling-Guide (Quelle: Wowhead Classic Leveling-Guide)
BerufeFundorteDB["Thoriumapparat"] = "Bauplan: Thoriumapparat\nVerkauft von: Sovik (Orgrimmar, Horde) / Gearcutter Cogspinner (Eisenschmiede, Allianz)\nWird im Guide für Skill 260-285 gebraucht."
BerufeFundorteDB["Thoriumpatronen"] = "Bauplan: Thoriumpatronen\nWelt-Drop (handelbar, oft im Auktionshaus).\nWird im Guide für Skill 285-300 gebraucht."
end
