-- ============================================================================
-- REZEPT-FUNDORTE CLASSIC: LEDERVERARBEITUNG (DEUTSCH)
-- ============================================================================
-- v2.1: Komplett neu geprüft mit Wowhead Classic (deutsche + englische
-- Item-Seiten) und dem Warcraft Wiki (Stand 25.09.2026). Namen = exakte
-- deutsche Spielnamen ohne "Rezept:/Formel:/Muster:"-Präfix.
-- Englische Gegner-Namen in Klammern, wo der deutsche Name nicht bestätigt ist.
BerufeFundorteDB = BerufeFundorteDB or {}

if GetLocale() == "deDE" then
BerufeFundorteDB["Barbarische Schultern"] = "Wird direkt beim Lederverarbeitungs-Lehrer gelernt."
BerufeFundorteDB["Gurt der Einsicht"] = "Muster: Gurt der Einsicht\nMögliche Beute aus Knot Thimblejacks Kiste (Düsterbruch Nord, nach dem Befreien von Knot beim Tribut-Run).\nBenötigt Lederverarbeitung 300."
BerufeFundorteDB["Onyxiaschuppenumhang"] = "Es gibt kein Muster als Gegenstand - das Rezept wird laut Warcraft-Wiki über eine Quest gelehrt.\nBenötigt Lederverarbeitung 300 und eine Schuppe von Onyxia."
BerufeFundorteDB["Lavagürtel"] = "Muster: Lavagürtel\nVerkauft von: Lokhtos Darkbargainer (Bar in den Schwarzfelstiefen)\nBenötigt Ruf 'Wohlwollend' bei der Thoriumbruderschaft.\nBenötigt Lederverarbeitung 300."
BerufeFundorteDB["Schmelzhelm"] = "Muster: Schmelzhelm\nVerkauft von: Lokhtos Darkbargainer (Bar in den Schwarzfelstiefen)\nBenötigt Ruf 'Freundlich' bei der Thoriumbruderschaft.\nBenötigt Lederverarbeitung 300."
BerufeFundorteDB["Kernhundgürtel"] = "Muster: Kernhundgürtel\nVerkauft von: Lokhtos Darkbargainer (Bar in den Schwarzfelstiefen)\nBenötigt Ruf 'Respektvoll' bei der Thoriumbruderschaft.\nBenötigt Lederverarbeitung 300."
BerufeFundorteDB["Geschmolzener Gürtel"] = "Muster: Geschmolzener Gürtel\nVerkauft von: Lokhtos Darkbargainer (Bar in den Schwarzfelstiefen)\nBenötigt Ruf 'Respektvoll' bei der Thoriumbruderschaft.\nBenötigt Lederverarbeitung 300."
BerufeFundorteDB["Urzeitliches Fledermaushautwams"] = "Muster: Urzeitliches Fledermaushautwams\nVerkauft von: Rin'wosho der Händler (Insel Yojamba, Schlingendorntal)\nBenötigt Ruf 'Respektvoll' beim Stamm der Zandalar.\nBenötigt Lederverarbeitung 300."
BerufeFundorteDB["Urzeitliche Fledermaushautarmschienen"] = "Muster: Urzeitliche Fledermaushautarmschienen\nVerkauft von: Rin'wosho der Händler (Insel Yojamba, Schlingendorntal)\nBenötigt Ruf 'Freundlich' beim Stamm der Zandalar.\nBenötigt Lederverarbeitung 300."
-- v2.1: Rezepte aus dem Leveling-Guide (Quelle: Wowhead Classic Leveling-Guide)
BerufeFundorteDB["Tückische Lederstulpen"] = "Muster: Tückische Lederstulpen\nVerkauft von: Leonard Porter (Westliche Pestländer, Allianz) / Werg Thickblade (Tirisfal, Horde)\nWird im Guide für Skill 260-290 gebraucht."
BerufeFundorteDB["Tückisches Lederstirnband"] = "Muster: Tückisches Lederstirnband\nWelt-Drop, u. a. von Jadefeuer-Schwindlern (engl. Jadefire Trickster, Teufelswald). Seltener Drop - Alternative: andere Tückisches-Leder-Teile.\nWird im Guide für Skill 290-300 gebraucht."
end
