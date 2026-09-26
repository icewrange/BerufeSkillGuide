# Changelog - Berufe Skill Guide

## 2.1

### Neue Features
- **Neues Design (Karten-Layout)**: Kopfbereich mit Berufs-Icon, Name,
  aktuellem Schritt und Fortschrittsbalken (heller Bereich = Ziel des
  Schritts). Darunter ein Scrollbereich mit farbigen Karten: Schritt,
  Material (Icon pro Zeile, Bestand/Bedarf rechts), Gebiete, Lehrer,
  Rezept-Fundort und Forever-Hinweise (einklappbar, Zustand gespeichert).
  Der Wegpunkt-Button sitzt direkt in der Lehrer- bzw. Fundort-Karte.
  Behebt, dass lange Texte unten aus dem Fenster liefen.
- Fenster in der Größe **ziehbar** (Ecke unten rechts, wird gespeichert;
  Rechtsklick auf die Ecke = Standardgröße 440x560).
- Spielversions-Umschalter im AtlasLoot-Stil: Logo-Button in der Titelleiste
  (links neben "Optionen"). Klick öffnet eine Auswahl "Classic" / "Forever";
  die gewählte Version wird pro Account gespeichert. Alternativ per
  `/bsg version` (umschalten) bzw. `/bsg version classic|forever`.
- Eigene Forever-Datenbank (`Data/Daten_Forever.lua`, Tabellen
  `BerufeGuideDB_Forever` / `BerufeLehrerDB_Forever`). Fehlt für einen Beruf
  ein Forever-Guide, wird automatisch die Classic-Route angezeigt (mit Hinweis).

- Erste Forever-Daten (Beta): 316 Rezept-Fundorte der Handelskommission von
  Azeroth für alle 6 Hauptberufe + Kochkunst (Smoothies) inkl. der 6
  Berufs-Zertifikate - deutsch UND englisch. Per Rezeptsuche auffindbar,
  wenn FOREVER aktiv ist. (Schmiedekunst/Schneidern/Lederverarbeitung/
  Kochkunst auf deutschen Clients vorerst mit englischen Namen.)
- Data-Ordner aufgeräumt: `Data/Classic/Guides`, `Data/Classic/Fundorte`,
  `Data/Classic/Lehrer`, `Data/Allgemein` (Item-IDs), `Data/Forever`.

- Neue Core-Datei `BSG_Skillstufen.lua`: maximaler Skill und Berufsstufen
  (Lehrling/Geselle/Experte/Fachmann) je Spielversion an EINER Stelle. Alle
  fest eingebauten "300" (Anzeige, Eingabeprüfung, Simulation, Texte) lesen
  jetzt von dort. Vorlage für Versionen mit höherem Cap (z.B. 375) enthalten.

- **Erste Hilfe** als neuer Beruf: Guide 1-300 (DE/EN) inkl. Experten-Buch
  (mit Wegpunkt) und Fachmann-Quest "Triage".
- **Sammelberufe** Bergbau, Kräuterkunde und Kürschnerei: statt Rezepten
  zeigt der Guide, was man sammelt und in welchen Gebieten (eigene Fraktion
  zuerst, die andere grau dahinter) plus Tipps ab welchem Skill.
- **Wegpunkt-Button** unten links: setzt einen Wegpunkt zum angezeigten
  Lehrer oder Rezept-Fundort (TomTom, sonst Blizzard-Kartenmarkierung, sonst
  Koordinaten im Chat). Forever-Händler: Lager Drei Ecken bzw. Durator.
- Wegpunkt ohne TomTom: Im Spiel-Test setzte Classic Era keine Blizzard-
  Kartenmarkierung (z.B. auf Stadtkarten). Jetzt öffnet der Button die
  Weltkarte im Zielgebiet und setzt einen eigenen Stern an die Position
  (Tooltip mit Koordinaten, Rechtsklick entfernt ihn).
- **Rezeptfarbe**: Sobald das Berufefenster einmal offen war, erscheint der
  Rezeptname im Guide in seiner Schwierigkeitsfarbe (orange/gelb/grün/grau);
  "(?)" = nicht im Fenster gefunden.
- **Auto-Auswahl**: Das Rezept des aktuellen Guide-Schritts wird im
  Berufefenster automatisch markiert (Classic inkl. Verzauberkunst-Fenster,
  Forever über die moderne API). Abschaltbar mit `/bsg auswahl`.
- Neue Core-Datei `BSG_Berufe.lua`: zentrale Berufsliste (Name, englischer
  Name, Zauber-ID, Icon, Typ). Sidebar, Erkennung, Simulation und Chat-
  Befehle lesen jetzt alle von dort; die Sidebar wächst automatisch mit.
- `/bsg sim` versteht jetzt auch Namen mit Leerzeichen/Umlauten
  ("/bsg sim Erste Hilfe 120", "/bsg sim Kräuterkunde150").
- TOC: Interface 11509 (Classic Era 1.15.9).
- **Zweisprachige Rezeptsuche**: Findet die Suche nichts, übersetzt sie den
  Begriff in die andere Sprache und sucht erneut - ein deutscher Client
  findet also auch "Fiery Weapon" oder "Linen Bandage", ein englischer auch
  "Feurige Waffe". Quellen: neue Namensliste `Data/Allgemein/
  Daten_Suchnamen.lua` (Rezepte inkl. 99 Forever-Paare) und automatisch
  alle Items aus `Daten_Items.lua` über ihre Item-ID.
- Guide-Schritte, deren Rezept man kaufen/finden muss, zeigen den Fundort
  jetzt direkt unten im Guide ("Rezept bekommst du hier:").
- Verzauberkunst mit Wowheads Guide 1-300 abgeglichen (Route identisch).
  Neu: Fundorte für Umhang - Schwache Beweglichkeit, Armschiene - Geringe
  Stärke, Geringes Manaöl, Runenverzierte Arkanitrute (DE + EN). Korrigiert:
  "Schild - Erhebliche Ausdauer" heißt "Schild - Große Ausdauer" (passte
  nicht zum Guide), "Brust - Erhebliche Gesundheit" gibt es bei Qia in
  Winterquell (nicht bei Kania). Englischer Client: Auto-Auswahl/Rezeptfarbe
  erkennen jetzt "Enchant ..."-Namen.
- **Alle Classic-Rezeptfundorte neu geprüft** (Wowhead Classic DE/EN +
  Warcraft Wiki): 57 Rezepte, jetzt nach Beruf sortiert in
  `Data/Classic/Fundorte/Daten_Fundorte_<Beruf>.lua` (+ `_EN`), englisch mit
  englischen Namen. Etwa die Hälfte der alten Einträge war falsch, z.B.:
  Großer Frost-/Feuer-/Naturschutztrank, Reinigungstrank, Elixier des Mungos,
  Bodenlose Tasche, Eisiger Hauch, Überragendes Schlagen, Hochentwickelter
  Bergbau, Arkanitdrachling, Flimmerkern-Rufstufen. Falsche deutsche Namen
  korrigiert (Flarecore -> Flimmerkern, Molten Helm -> Schmelzhelm, ...);
  alte Namen funktionieren in der Suche weiter.
- Entfernt, weil es sie in WoW nicht gibt: "Lichtsrickweste",
  "Paranoia-Brille", "Tasche von Jindo", "Großes Elixier des Löwenherzens",
  "Nachtlauerüstung", "Schmelzstiefel", "Primalstiefel", "Flarecore-Gürtel".
  Ersetzt durch die echten Muster (Geschmolzener Gürtel, Urzeitliches
  Fledermaushautwams/-armschienen, Flimmerkernmantel/-wickeltücher).
- **Alle 7 Herstellungs-Guides mit Wowheads Classic-Leveling-Guides
  abgeglichen**: Alchimie, Verzauberkunst, Ingenieurskunst, Lederverarbeitung,
  Schneidern stimmen Schritt für Schritt. Englische Fehler behoben:
  Schmiedekunst "Rough Copper Belt" -> "Runed Copper Belt", "Gold Rod" ->
  "Golden Rod", "Heavy Mithril Stirrups" -> "Heavy Mithril Gauntlet";
  Kochkunst "Mithril Head Trout" -> "Mithril Headed Trout", Machtfischsteak-
  Zutaten -> "Large Raw Mightfish, Hot Spices, Soothing Spices".
- 12 neue Fundorte für Rezepte, die man in den Guides kaufen/finden muss
  (Stein der Weisen, Thoriumapparat, Thoriumpatronen, Thorium-Pläne,
  Imperiale Plattenarmschienen, Tückisches Leder, Runenstoffhandschuhe,
  Tüpfelgelbschwanz, Machtfischsteak) - erscheinen direkt im Guide-Schritt.
- Rezeptsuche reicht Übersetzungen weiter (alter Name -> englisch -> neuer
  deutscher Name).
- **Item-Datenbank geprüft**: falsche IDs korrigiert (Kupferrute, Schwarze
  Perle, Kleiner/Großer glänzender Splitter, Seelenstaub <-> Große
  Astralessenz vertauscht), falsche englische Namen (Hot Spices, Soothing
  Spices, Large Raw Mightfish), fehlende Guide-Materialien ergänzt
  (Geschmeidige Bälge, Feiner Ledergürtel, Schwacher Heiltrank, strahlende
  Splitter). Jede ID hat jetzt genau einen deutschen + englischen Namen.
- **Sammelberufe mit Wowheads Classic-Guides abgeglichen**: Bergbau-Gebiete
  und Kürschnerei-Stufen/Gebiete (1-100, 100-165, 165-225, 225-300) nach
  Wowhead; Kräuterkunde um Würgetang (85) und Goldener Sansam (260) ergänzt.
- **Alle Lehrer der 7 Herstellungsberufe neu geprüft** (Wowhead Classic-
  Guides EN/DE, Icy Veins, wow-professions.com). Viele Einträge waren falsch
  oder erfunden, z.B.: Schmiedekunst-Fachmann gibt es NUR bei Brikk Keencraft
  (Beutebucht) - nicht "Brumn Winterhuf"; Ingenieurskunst-Geselle ist Jemma
  Quikswitch (Tüftlerstadt) - "Jnaika Steinmetz" gibt es nicht; Alchimie-
  Geselle Horde ist Bena Winterhoof - nicht "Baelog"; Schneidern-Fachmann
  Horde ist Daryl Stack (Tarrens Mühle); Lederverarbeitung-Fachmann sind
  Drakk Stonehand (Allianz) / Hahrana Ironhide (Horde). Deutsche Stadt- und
  Viertelnamen (Sturmwind, Eisenschmiede, Unterstadt, Donnerfels,
  Tüftlerstadt ...). Jede Stufe hat jetzt Koordinaten für beide Fraktionen
  -> Wegpunkt-Button überall.
- Lehrer: deutsche Stufe 225-300 heißt "Fachmann" (nicht "Meister", das gibt
  es erst ab TBC). Verzauberkunst: Kitta Firewind/Hgarth lehren Fachmann,
  nicht Experte - Experten-Lehrer ergänzt.
- Guide-Kopfzeile zeigt den Beruf in der Client-Sprache ("FIRST AID" statt
  "ERSTE HILFE" auf Englisch) und Umlaute korrekt groß ("KRÄUTERKUNDE").

- **WoW Forever - Erste Hilfe** (Wowhead Forever-Guide, Beta): Lehrer inkl.
  der neuen auf der Insel Zephras, Experten-Buch, Fachmann-Quest mit den
  Forever-Vorquests "Traumachirurg der Allianz/Horde"; alle 17 Forever-Rezepte
  (Heiltränke, Schlammpackungen, Abschnürbinden, Gegengift, Lagerfeuer-
  Objekte) per Suche (DE + EN). Eine Forever-Skill-Route gibt es bei Wowhead
  noch nicht.
- Forever-Hinweise pro Beruf: Im Forever-Modus warnt der Alchimie-Guide, dass
  Heiltränke dort mit Erster Hilfe hergestellt werden.
- **WoW Forever - Bergbau** (vorläufig): eigene Forever-Route 1-300 aus
  Wowheads Vorkommen-Tabelle (neue Gebiete, z.B. Zinn in Eschental/Tiefschwarze
  Grotte, Dunkeleisen ab 230). Hinweis auf die neuen Zusatzfunde Pyrit, Bauxit,
  Pechblende und die neuen Barren; Lagerfeuer-Objekte Leitstein, Felsgarten,
  Geschmolzene Gießerei per Suche (DE + EN, EN-Namen vorläufig).
- **WoW Forever - Kräuterkunde**: Forever-Hinweis (Kräutersamen, seltene
  Zusatzfunde, neue Kräuter Mahrblatt/Dämonensalbei/Todeslotus, geänderte
  Tauren-Fähigkeit). Lagerfeuer-Objekte Räucherkerze, Gewächshaus,
  Saatenkreuzer und die neuen Kräuter per Suche (DE + EN). Route bleibt die
  Classic-Route, da Wowhead für Forever noch keine Gebiete nennt.

### Korrekturen
- Material-Icons standen neben der falschen Zeile, wenn der blaue Forever-
  Hinweis angezeigt wurde - der Hinweis steht jetzt am Ende des Guides.
- Item-Daten: "Beulenbeere" heißt korrekt "Beulengras" (auch im Alchimie-
  Guide), "Khadgars Schnurrbart" hatte die ID von Winterbiss, englisch waren
  Wild Steelbloom/Fadeleaf vertauscht.
- Lehrer-Koordinaten: Donnerfels hatte die Karten-ID von Unterstadt.
- Rezept "Feurige Waffe": deutscher Eintrag hieß fälschlich "Feurige waffe"
  und stand in der Guide-Datei - jetzt als "Waffe - Feurige Waffe" bei den
  Fundorten (mit Skill 265 und Verzauberungs-Material). Neu auf Englisch:
  "Enchant Weapon - Fiery Weapon".
- Lehrer-Anzeige an Stufengrenzen: Bei genau Skill 75/150/225 wurde noch
  der Lehrer der alten Stufe angezeigt, jetzt der der nächsten.
- Berufe-Sidebar lag bei geöffneter Weltkarte VOR der Karte (fest auf Strata
  "DIALOG", an UIParent). Sie hängt jetzt am Hauptfenster und liegt immer auf
  derselben Ebene wie der Guide selbst.

### WoW-Forever-Kompatibilität
- TOC: `## Interface: 11508, 16001` (Classic Era + WoW Forever).
- Neue `Compat.lua`: kapselt Item-API (C_Item), Berufs-Skills
  (GetSkillLineInfo bzw. GetProfessions/GetProfessionInfo), Auktionshaus
  (altes und neues AH) und pcall-gesicherte Event-Registrierung.
- Gold-Planer: erkennt das neue AH; die Live-Suchliste kann dort nicht
  ausgelesen werden, es werden TSM bzw. der Schätzwert verwendet.

## Unveröffentlicht

### Neue Features
- Cross-Char-Bestand sichtbar gemacht: Der Materialbestand wurde intern
  bereits kontoweit gescannt (`AccountScanner.lua`), aber nirgends
  aufgeschlüsselt angezeigt. Der Tooltip auf jedem Material-Icon im Guide
  zeigt jetzt den Bestand je Charakter (z.B. "Charakter A: 8, Charakter B:
  4"), und `/bsg wo <Materialname>` liefert dieselbe Aufschlüsselung im
  Chat für ein beliebiges Material, unabhängig vom aktuell angezeigten
  Guide-Schritt.
- Bug-Report-Funktion hinzugefügt: `/bsg bugreport [Beschreibung]` öffnet ein
  Fenster mit einem fertigen, automatisch markierten Text-Report (Addon-
  Version, WoW-Build, Sprache, Debug-Status, sowie alle seit dem letzten
  Login erfassten Lua-Fehler dieses Addons). Ein neuer `seterrorhandler()`-
  Hook merkt sich addon-eigene Fehler in einem kleinen Ringpuffer
  (`BerufeSkillGuideDB.bugReportFehler`), ohne bestehende Fehler-Addons wie
  BugSack zu verdrängen (bestehender Handler wird weiterhin aufgerufen). Da
  WoW-Addons keine Netzwerkanfragen senden dürfen, muss der Text manuell
  (Strg+C) z.B. in ein GitHub-Issue oder Discord eingefügt werden. Auch über
  `/bsg help` erreichbar; die dortige Befehlsübersicht war zudem veraltet
  (fehlte `/bsg gold` und `/bsg check`) und wurde ergänzt.
- Gold-Planer aktiviert: Klick auf ein Material-Icon im Guide scannt den
  günstigsten AH-Preis für die fehlende Gesamtmenge dieses Materials;
  `/bsg gold` scannt und summiert die Kosten für alle Materialien des
  aktuellen Guide-Schritts auf einmal. Vorher war das Modul geladen, aber
  über keinen Button/Befehl erreichbar.

### Wichtige Korrekturen
- **Gesamtbedarf-Anzeige war für Schmiedekunst, Ingenieurskunst,
  Lederverarbeitung, Schneidern und Verzauberkunst massiv überhöht**
  (z.B. 8360x Leinenstoff statt korrekt ca. 190x für Schneidern 1-45).
  Ursache: Die Datenbanken speicherten in "mats" bereits die für die volle
  Wowhead-Stückzahl aufsummierte Materialmenge, Search.lua multiplizierte
  diese Summe aber zusätzlich mit den verbleibenden Skillpunkten. "mats"
  nennt jetzt durchgängig den Bedarf für EINE EINZELNE Fertigung (gegen
  Wowheads offizielle deutsche Leveling-Guides gegengeprüft), und
  Search.lua skaliert den Gesamtbedarf über einen neuen "craftFaktor"
  korrekt auf die von Wowhead empfohlene Gesamt-Stückzahl je Skill-Schritt
  hoch (betrifft nebenbei auch Kochkunst, das intern bereits korrekt
  gespeichert war, aber von derselben fehlenden Skalierung profitiert).
- `/bsg sim` (Entwickler-Simulation) aktualisierte bisher nur die
  Spieler-Datenbank, aber nie das sichtbare Guide-Fenster - der Befehl
  hatte optisch keine Wirkung. Zeigt jetzt sofort den simulierten
  Beruf/Skill an und lädt beim Beenden automatisch wieder den echten Beruf.
- Ingenieurskunst-Guide (DE + EN): zwei Skill-Schritte überlappten sich
  bei Skill 135, wodurch einer der beiden je nach Ladereihenfolge nie
  angezeigt wurde.
- Mehrere falsche/doppelte Item-IDs in der Material-Datenbank korrigiert
  (u.a. Traumblatt/Bergsilbersalbei, Einfaches Holz/Leichtes Leder,
  Wilddornrose) sowie fehlende Materialien ergänzt (Goldener Sansam,
  Arthas Tränen, Lila Lotus, Feuerblüte, Schwarzes Vitriol, Verbleite
  Phiole, Dichtes Sprengpulver).
- Automatische Berufserkennung zeigte bei nicht erkanntem Beruf fälschlich
  hart "Alchimie, Skill 158" an, statt eines neutralen Hinweistexts.
- Rezeptsuche (Fundorte) konnte durch interne Koordinaten-Einträge
  (`_Zone`/`_X`/`_Y`) eine nackte Zahl statt des Beschreibungstexts
  anzeigen.

## v1.7.05 (Erster öffentlicher Release)

### Neue Features
- Rezeptsuche im Hauptfenster (durchsucht Skill-Guide-Rezepte und Fundorte-Datenbank)
- Manuelle Skill-Eingabe: zeigt einen beliebigen Skill-Stand an, unabhängig vom
  tatsächlichen Charakter-Skill
- Sidebar-Filter „Nur gelernte Berufe" (blendet Berufe aus, die der Charakter
  nicht erlernt hat)
- Slash-Befehl `/bsg` mit Unterbefehlen: `help`, `optionen`, `debug`,
  `sim <Beruf> <Skill>`, `check <Beruf>`
- Datenbank-Inspector (`/bsg check`): prüft Skill-Bereiche auf Lücken,
  Überlappungen und fehlende Materialien
- Automatischer, account-weiter Taschen-/Bank-Scan (Ereignis-gesteuert)
- Eigenständiger Minimap-Button (siehe „Wichtige Korrekturen")

### Wichtige Korrekturen
- **Kompatibilität mit anderen Addons:** Die zuvor eingebundenen, handgeschriebenen
  Bibliotheken (LibStub, CallbackHandler-1.0, LibDataBroker-1.1, LibDBIcon-1.0)
  konnten mit anderen Addons (u.a. Questie) in Konflikt geraten. Der Minimap-Button
  wurde durch eine eigenständige Implementierung ohne geteilte Bibliotheken ersetzt.
- Sidebar-Icons für nicht erlernte Berufe reagierten nicht zuverlässig auf Klicks
- Mehrere vertauschte oder falsche Item-IDs in der Material-Datenbank korrigiert
  (u.a. Würgetang/Golddorn, diverse Verzauberkunst-Essenzen, Ingenieurskunst- und
  Lederverarbeitung-Materialien, Schneidern-Farbstoffe)
- Schmiedekunst- und Alchimie-Rezeptdatenbank anhand offizieller Referenzdaten
  überarbeitet (mehrere frühere Einträge enthielten falsche Rezepte/Mengen)
- Diverse Lua-Fehler beim Laden behoben (fehlende Datei-Einbindungen,
  Ladereihenfolge, ungeschützte Nil-Zugriffe)
- Mengen-Format in Materiallisten vereinheitlicht ("Zahl Name" und "Zahlx Name"
  werden beide korrekt erkannt)
