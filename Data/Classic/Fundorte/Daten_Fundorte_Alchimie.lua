-- ============================================================================
-- REZEPT-FUNDORTE CLASSIC: ALCHIMIE (DEUTSCH)
-- ============================================================================
-- v2.1: Komplett neu geprüft mit Wowhead Classic (deutsche + englische
-- Item-Seiten) und dem Warcraft Wiki (Stand 25.09.2026). Namen = exakte
-- deutsche Spielnamen ohne "Rezept:/Formel:/Muster:"-Präfix.
-- Englische Gegner-Namen in Klammern, wo der deutsche Name nicht bestätigt ist.
BerufeFundorteDB = BerufeFundorteDB or {}

if GetLocale() == "deDE" then
BerufeFundorteDB["Fläschchen mit oberster Macht"] = "Rezept: Fläschchen mit oberster Macht\nDrop von: Ras Frostflüsterer (Endboss)\nOrt: Scholomance (Westliche Pestländer).\nBenötigt Alchimie 300. Herstellen nur an einem Alchimielabor."
BerufeFundorteDB["Fläschchen mit destillierter Weisheit"] = "Rezept: Fläschchen mit destillierter Weisheit\nDrop von: Balnazzar (Endboss)\nOrt: Stratholme (lebende Seite).\nBenötigt Alchimie 300."
BerufeFundorteDB["Fläschchen der Titanen"] = "Rezept: Fläschchen der Titanen\nDrop von: General Drakkisath (Endboss, selten)\nOrt: Obere Schwarzfelsspitze (UBRS).\nBenötigt Alchimie 300."
BerufeFundorteDB["Erheblicher Manatrank"] = "Rezept: Erheblicher Manatrank\nVerkauft von: Magnus Frostwake (Caer Darrow, Westliche Pestländer, 68.1 77.8) - erst sichtbar nach der Questreihe 'Doktor Theolen Krastinov, der Schlächter'.\nAuch Drop von Dunkelmeister Gandling (Scholomance, ca. 6%).\nBenötigt Alchimie 295."
BerufeFundorteDB["Erheblicher Heiltrank"] = "Rezept: Erheblicher Heiltrank\nVerkauft von: Evie Whirlbrew (Ewige Warte, Winterquell)\nBegrenzter Vorrat - erscheint nur ca. einmal pro Stunde.\nBenötigt Alchimie 275."
BerufeFundorteDB["Überragender Manatrank"] = "Rezept: Überragender Manatrank\nVerkauft von: Algernon (Unterstadt, Apothekarium, Horde) / Ulthir (Darnassus, Handwerkerterrasse, Allianz)\nBegrenzter Vorrat.\nBenötigt Alchimie 260."
BerufeFundorteDB["Großer Heiltrank"] = "Wird direkt beim Alchimie-Lehrer gelernt (ab Skill 155)."
BerufeFundorteDB["Großer Frostschutztrank"] = "Rezept: Großer Frostschutztrank\nDrop von: Frostmaul-Riesen (engl. Frostmaul Giant), laut Kommentaren auch Frostmaul-Bewahrern (engl. Frostmaul Preserver)\nOrt: Frostflüsterschlucht, Winterquell.\nSeltener Drop. Benötigt Alchimie 290."
BerufeFundorteDB["Großer Feuerschutztrank"] = "Rezept: Großer Feuerschutztrank\nDrop von: Herbeirufern und Pyromanten der Feuerbrand (engl. Firebrand Invoker/Pyromancer)\nOrt: Untere Schwarzfelsspitze (LBRS).\nBenötigt Alchimie 290."
BerufeFundorteDB["Großer Naturschutztrank"] = "Rezept: Großer Naturschutztrank\nDrop von: Verwesenden Schrecken und Verrottenden Behemoths (engl. Decaying Horror / Rotting Behemoth)\nOrt: Weeping Cave, Westliche Pestländer.\nSehr seltener Drop (ca. 1-2%). Benötigt Alchimie 290."
BerufeFundorteDB["Reinigungstrank"] = "Rezept: Reinigungstrank\nWelt-Drop (kein fester Fundort).\nBenötigt Alchimie 285."
BerufeFundorteDB["Elixier des Mungos"] = "Rezept: Elixier des Mungos\nDrop von: Legashi-Schurken (Azshara) und Jadefeuer-Schurken (Teufelswald)\nNebenbei beim Teufelsstoff-Farmen häufig.\nBenötigt Alchimie 280."
-- v2.1: Rezepte aus dem Leveling-Guide (Quelle: Wowhead Classic Leveling-Guide)
BerufeFundorteDB["Stein der Weisen"] = "Rezept: Stein der Weisen\nVerkauft von: Alchemist Pestlezugg (Gadgetzan, Tanaris)\nWird im Guide für Skill 230-231 gebraucht."
end
