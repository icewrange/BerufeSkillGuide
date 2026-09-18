BerufeFundorteDB = BerufeFundorteDB or {}

-- ============================================================================
-- VERZAUBERKUNST FUNDORTE (WEITERE SELTENE FORMELN)
-- ============================================================================
-- Ergänzt die bereits in Daten_Fundorte.lua vorhandenen Verzauberkunst-
-- Einträge (Kreuzfahrer, Heilkraft, Zauberkraft, Schild Erhebliche Ausdauer,
-- Brust Erhebliche Gesundheit, Überragende Schlageffizienz, Stiefel
-- Willenskraft, Handschuhe Bergbau, Handschuhe Kräuterkunde) um weitere
-- Classic-Era-Formeln. Quellen: Wowhead Classic, Wowpedia/Warcraft Wiki.
-- "Waffe verzaubern - Mächtige Intelligenz" wurde in einer automatisierten
-- Quelle fälschlich als "Mighty Versatility" bezeichnet (das ist ein
-- TBC/Retail-Stat); über Wowhead-Item-ID 19448 verifiziert, dass die
-- korrekte Honored-Stufe "Enchant Weapon - Mighty Spirit" (Große
-- Willenskraft) heißt - hier entsprechend korrigiert übernommen.
BerufeFundorteDB["Waffe verzaubern - Feurige Waffe"] = "Drop von: Pyromancer Loregrain\nOrt: Schwarzfelstiefen (Arrestblock).\nChance: Selten (Erfahrungsberichte schwanken stark)."
BerufeFundorteDB["Waffe verzaubern - Lebensraub"] = "Drop von: Spectral Researcher\nOrt: Scholomance (erster Raum).\nChance: Selten."
BerufeFundorteDB["Waffe verzaubern - Unheilig"] = "Drop von: Untote Elite-Gegner (u.a. Thuzadin-Schattenbeschwörer)\nOrt: Stratholme (Totenkopfseite).\nChance: Selten, stark schwankende Berichte."
BerufeFundorteDB["Armschienen - Überragende Stärke"] = "Drop von: Deadwind-Hexenmeister\nOrt: Geisterwald / Deadwind-Pass (Höhlen).\nChance: Sehr selten (teils 1000+ Kills ohne Drop berichtet); alternativ Auktionshaus."
BerufeFundorteDB["Zweihandwaffe verzaubern - Große Intelligenz"] = "Drop von: Crimson Sorcerer\nOrt: Stratholme (Kathedralenseite, im Gebäude der Scharlachroten hinter Timmy).\nChance: Selten, aber mehrere Stück pro Run möglich."
-- HINWEIS: Feiertagsverfügbarkeit bitte gegenprüfen (nur während Winterveil aktiv).
BerufeFundorteDB["Waffe verzaubern - Macht des Winters"] = "Erhältlich als Zufallsgeschenk von Väterchen Winter (Fest von Winterveil).\nNur saisonal während des Feiertags verfügbar, kein regulärer Drop oder Händler."
BerufeFundorteDB["Waffe verzaubern - Stärke"] = "Verkauft von: Lokhtos Dunkelfels (Bruderschaft des Thoriums)\nOrt: Schwarzfelstiefen (Grimmiger Schlund).\nErhältlich ab Ruf: Freundlich zur Bruderschaft des Thoriums."
BerufeFundorteDB["Waffe verzaubern - Große Willenskraft"] = "Verkauft von: Lokhtos Dunkelfels (Bruderschaft des Thoriums)\nOrt: Schwarzfelstiefen (Grimmiger Schlund).\nErhältlich ab Ruf: Ehrfürchtig zur Bruderschaft des Thoriums."
BerufeFundorteDB["Umhang - Erhebliche Feuerresistenz"] = "Verkauft von: Kania\nOrt: Cenarius-Feste, Silithus (im Gasthaus, oberes Stockwerk).\nErhältlich ab Ruf: Freundlich zum Zirkel des Cenarius."
BerufeFundorteDB["Umhang - Erhebliche Naturresistenz"] = "Verkauft von: Kania\nOrt: Cenarius-Feste, Silithus (im Gasthaus, oberes Stockwerk).\nErhältlich ab Ruf: Freundlich zum Zirkel des Cenarius."
-- HINWEIS: Formel-Item-Name im deutschen Client bitte gegenprüfen, könnte
-- abweichend benannt sein.
BerufeFundorteDB["Brillantes Manaöl (Formel)"] = "Verkauft von: Rin'wosho der Händler\nOrt: Zul'Gurub (Insel Yojamba).\nErhältlich ab Ruf: Freundlich zum Stamm der Zandalar (Skill 300 zum Herstellen nötig)."
-- HINWEIS: Herkunft (AQ-Bosse allgemein, kein spezifischer Boss dokumentiert) bitte gegenprüfen.
BerufeFundorteDB["Handschuhe - Feuerkraft"] = "Drop von: diversen Bossen\nOrt: Tempel von Ahn'Qiraj (AQ40).\nChance: Seltener Raid-Drop."
