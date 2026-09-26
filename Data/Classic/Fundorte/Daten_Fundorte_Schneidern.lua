-- ============================================================================
-- REZEPT-FUNDORTE CLASSIC: SCHNEIDERN (DEUTSCH)
-- ============================================================================
-- v2.1: Komplett neu geprüft mit Wowhead Classic (deutsche + englische
-- Item-Seiten) und dem Warcraft Wiki (Stand 25.09.2026). Namen = exakte
-- deutsche Spielnamen ohne "Rezept:/Formel:/Muster:"-Präfix.
-- Englische Gegner-Namen in Klammern, wo der deutsche Name nicht bestätigt ist.
BerufeFundorteDB = BerufeFundorteDB or {}

if GetLocale() == "deDE" then
BerufeFundorteDB["Runenstofftasche"] = "Muster: Runenstofftasche\nVerkauft von: Qia (Ewige Warte, Winterquell)\nBegrenzter Vorrat - erscheint nur unregelmäßig (ca. einmal pro Stunde).\nBenötigt Schneiderei 260."
BerufeFundorteDB["Teufelsstofftasche"] = "Muster: Teufelsstofftasche\nKein normaler Drop: Nach dem Kampf gegen Jandice Barov erscheint ein Buch auf dem Boden, das Schneider anklicken und lernen können (wie der Reparaturbot-Bauplan in BRD).\nOrt: Scholomance (Westliche Pestländer). Erscheint nicht bei jedem Kill.\nBenötigt Schneiderei 285 (vorher kann man es nicht lernen)."
BerufeFundorteDB["Bodenlose Tasche"] = "Muster: Bodenlose Tasche\nSeltener Welt-Drop von Gegnern ab Stufe 61 (Elite/Raid), u. a. Azuregos (Azshara), Lord Kazzak (Verwüstete Lande), Onyxia, Gegner im Geschmolzenen Kern, in UBRS, Scholomance, Stratholme und Zul'Gurub - sowie aus Eterniumschließkassetten.\nBenötigt Schneiderei 300."
BerufeFundorteDB["Flimmerkernhandschuhe"] = "Muster: Flimmerkernhandschuhe\nVerkauft von: Lokhtos Darkbargainer (Bar in den Schwarzfelstiefen)\nBenötigt Ruf 'Freundlich' bei der Thoriumbruderschaft.\nBenötigt Schneiderei 300."
BerufeFundorteDB["Flimmerkernmantel"] = "Muster: Flimmerkernmantel\nVerkauft von: Lokhtos Darkbargainer (Bar in den Schwarzfelstiefen)\nBenötigt Ruf 'Wohlwollend' bei der Thoriumbruderschaft.\nBenötigt Schneiderei 300."
BerufeFundorteDB["Flimmerkernrobe"] = "Muster: Flimmerkernrobe\nVerkauft von: Lokhtos Darkbargainer (Bar in den Schwarzfelstiefen)\nBenötigt Ruf 'Wohlwollend' bei der Thoriumbruderschaft.\nBenötigt Schneiderei 300."
BerufeFundorteDB["Flimmerkerngamaschen"] = "Muster: Flimmerkerngamaschen\nVerkauft von: Lokhtos Darkbargainer (Bar in den Schwarzfelstiefen)\nBenötigt Ruf 'Respektvoll' bei der Thoriumbruderschaft.\nBenötigt Schneiderei 300."
BerufeFundorteDB["Flimmerkernwickeltücher"] = "Muster: Flimmerkernwickeltücher\nDrop von: Magmadar\nOrt: Geschmolzener Kern (Raid).\nBenötigt Schneiderei 300."
BerufeFundorteDB["Blutrebenweste"] = "Muster: Blutrebenweste\nVerkauft von: Rin'wosho der Händler (Insel Yojamba, Schlingendorntal)\nBenötigt Ruf 'Respektvoll' beim Stamm der Zandalar.\nBenötigt Schneiderei 300."
BerufeFundorteDB["Blutrebengamaschen"] = "Muster: Blutrebengamaschen\nVerkauft von: Rin'wosho der Händler (Insel Yojamba, Schlingendorntal)\nBenötigt Ruf 'Wohlwollend' beim Stamm der Zandalar.\nBenötigt Schneiderei 300."
BerufeFundorteDB["Blutrebenstiefel"] = "Muster: Blutrebenstiefel\nVerkauft von: Rin'wosho der Händler (Insel Yojamba, Schlingendorntal)\nBenötigt Ruf 'Freundlich' beim Stamm der Zandalar.\nBenötigt Schneiderei 300."
-- v2.1: Rezepte aus dem Leveling-Guide (Quelle: Wowhead Classic Leveling-Guide)
BerufeFundorteDB["Runenstoffhandschuhe"] = "Muster: Runenstoffhandschuhe\nVerkauft von: Qia (Ewige Warte, Winterquell)\nBegrenzter Vorrat - erscheint nach wenigen Minuten bis 1,5 Stunden wieder.\nWird im Guide für Skill 280-300 gebraucht."
end
