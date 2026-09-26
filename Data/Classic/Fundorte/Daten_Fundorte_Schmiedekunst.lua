-- ============================================================================
-- REZEPT-FUNDORTE CLASSIC: SCHMIEDEKUNST (DEUTSCH)
-- ============================================================================
-- v2.1: Komplett neu geprüft mit Wowhead Classic (deutsche + englische
-- Item-Seiten) und dem Warcraft Wiki (Stand 25.09.2026). Namen = exakte
-- deutsche Spielnamen ohne "Rezept:/Formel:/Muster:"-Präfix.
-- Englische Gegner-Namen in Klammern, wo der deutsche Name nicht bestätigt ist.
BerufeFundorteDB = BerufeFundorteDB or {}

if GetLocale() == "deDE" then
BerufeFundorteDB["Dunkeleisenstiefel"] = "Pläne: Dunkeleisenstiefel\nVerkauft von: Lokhtos Darkbargainer (Bar in den Schwarzfelstiefen)\nBenötigt Ruf 'Ehrfürchtig' bei der Thoriumbruderschaft.\nBenötigt Schmiedekunst 300."
BerufeFundorteDB["Elementarwetzstein"] = "Pläne: Elementarwetzstein\nDrop von: Bossen im Geschmolzenen Kern (u. a. Magmadar, Lucifron)\nOrt: Geschmolzener Kern (Raid). Selten.\nBenötigt Schmiedekunst 300."
BerufeFundorteDB["Arkanitschnitter"] = "Pläne: Arkanitschnitter\nDrop von: Bannok Grimmaxt (seltener Elite-Gegner)\nOrt: Untere Schwarzfelsspitze (LBRS).\nIn Classic nur für Axtschmiede."
-- v2.1: Rezepte aus dem Leveling-Guide (Quelle: Wowhead Classic Leveling-Guide)
BerufeFundorteDB["Thoriumgürtel"] = "Pläne: Thoriumgürtel\nDrop von Gegnern (handelbar, oft im Auktionshaus).\nWird im Guide für Skill 260-270 gebraucht."
BerufeFundorteDB["Thoriumarmschienen"] = "Pläne: Thoriumarmschienen\nDrop von Gegnern (handelbar, oft im Auktionshaus).\nWird im Guide für Skill 270-275 gebraucht."
BerufeFundorteDB["Imperiale Plattenarmschienen"] = "Pläne: Imperiale Plattenarmschienen\nQuestbelohnung in Beutebucht (Schlingendorntal).\nWird im Guide für Skill 275-290 gebraucht."
BerufeFundorteDB["Thoriumstiefel"] = "Pläne: Thoriumstiefel\nDrop von Gegnern (handelbar, oft im Auktionshaus).\nWird im Guide für Skill 290-300 gebraucht."
end
