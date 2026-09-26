============================================================================
                     BERUFE SKILL GUIDE - README & DOCS
============================================================================
Dieses Addon ist ein mächtiges All-in-One-Werkzeug für WoW Classic (Era/SoD),
das kompakte Level-Guides, einen Echtzeit-Taschen-Scanner, eine dynamische
Ressourcen-Hochrechnung sowie eingebaute Entwickler-Tools bietet.

----------------------------------------------------------------------------
1. ALLGEMEINE BEFEHLE
----------------------------------------------------------------------------
/bsg             - Öffnet oder schließt das Hauptfenster.
/bsg debug       - Aktiviert/Deaktiviert das Live-Hintergrundprotokoll im Chat.

----------------------------------------------------------------------------
2. ENTWICKLER-SANDBOX (SIMULATION)
----------------------------------------------------------------------------
Mit der Simulation kannst du jeden Guide auf jeder Stufe testen, ohne den
Charakter wechseln zu müssen. Die Eingabe trennt Zahlen automatisch ab.

Befehl:          /bsg sim [Berufsname] [Stufe]
Fehlertolerant:  /bsg sin [Berufsname][Stufe] (ohne Leerzeichen möglich!)

Beispiele:
  /bsg sim Schmiedekunst 110
  /bsg sin Ingenieurskunst45
  /bsg sim Schneidern 150
  /bsg sim Verzauberkunst 2
  /bsg sim Kochkunst 200

Simulation beenden:
  /bsg sim off   - Zeigt wieder die echten Berufe deines Charakters.

Verfügbare Berufsnamen für die Simulation:
  Alchimie (oder Alchemie), Schmiedekunst, Ingenieurskunst,
  Lederverarbeitung, Schneidern, Verzauberkunst, Kochkunst

----------------------------------------------------------------------------
3. GOLD-PLANER (AUKTIONSHAUS-PREISSCAN)
----------------------------------------------------------------------------
Berechnet, was die noch fehlenden Materialien des aktuell angezeigten
Guide-Schritts im Auktionshaus kosten würden. Braucht ein geöffnetes
Auktionshaus-Fenster (erst mit einem Auktionator sprechen!).

Einzelnes Material:
  Klick auf das kleine Material-Icon im Guide-Fenster -> scannt den
  günstigsten Sofortkauf-Preis für die noch fehlende Gesamtmenge.
  Shift-Klick auf dasselbe Icon durchsucht stattdessen das Auktionshaus
  nach dem Namen (wie bisher).

Alle Materialien auf einmal:
  Befehl:        /bsg gold
  -> Scannt und summiert die Kosten für JEDES Material, das der aktuelle
     Guide-Schritt noch benötigt, und gibt eine Gesamtsumme im Chat aus.

Ist ein Material im offenen AH-Suchfenster nicht gelistet, wird - falls
installiert - automatisch TSM als Sicherheitsnetz genutzt, sonst ein
grober Schätzwert verwendet.

----------------------------------------------------------------------------
4. CROSS-CHAR-BESTAND (KONTOWEITE MATERIAL-ÜBERSICHT)
----------------------------------------------------------------------------
Das Addon scannt automatisch die Taschen (und bei geöffneter Bank auch das
Bankfach) JEDES Charakters, den du einloggst, und merkt sich den Bestand
kontoweit. Die "Gesamt-Bedarf"-Anzeige im Guide zählt dadurch bereits den
Bestand ALLER deiner Charaktere zusammen, nicht nur den des aktuell
gespielten.

Um zu sehen, AUF WELCHEM Charakter ein Material liegt (z.B. um es per Post
zu verschicken):

Im Guide-Fenster:
  Bewege die Maus über ein Material-Icon -> der Tooltip zeigt den Bestand
  aufgeschlüsselt nach Charakter.

Für ein beliebiges Material (auch außerhalb des aktuellen Guide-Schritts):
  Befehl:        /bsg wo <Materialname>
  Beispiel:      /bsg wo Leinenstoff

----------------------------------------------------------------------------
5. DATENBANK-INSPECTOR (QUALITÄTSKONTROLLE)
----------------------------------------------------------------------------
Scannt die Datenbanken im 'Data'-Ordner in Echtzeit auf Fehler und Lücken.

Befehl:          /bsg check [Berufsname]

Beispiele:
  /bsg check Alchimie
  /bsg check Ingenieurskunst

Prüfberichte im Chat:
  [LÜCKE GEFUNDEN]   - Zeigt an, dass zwischen zwei Skillstufen Rezepte fehlen.
  [ÜBERLAPPUNG]      - Zeigt an, dass zwei Skill-Schritte sich überschneiden.
  [MATS FEHLEN]      - Zeigt an, dass ein Rezept keine Materialien besitzt.
  [DATENBANK REIN]   - Grünes Licht: Der Guide ist zu 100% fehlerfrei.

----------------------------------------------------------------------------
6. BUG-REPORT ERSTELLEN
----------------------------------------------------------------------------
Da WoW-Addons keine Netzwerkanfragen senden dürfen, kann dieses Addon einen
Fehlerbericht nicht automatisch irgendwohin schicken. Stattdessen erstellt
es dir einen fertigen, reinen Text-Report zum Kopieren.

Befehl:          /bsg bugreport [optionale Beschreibung]

Beispiel:
  /bsg bugreport Die Gesamtmenge für Schneidern wird falsch angezeigt

Der Report enthält Addon-Version, WoW-Build, Sprache, Debug-Status und alle
seit dem letzten Login erkannten Lua-Fehler dieses Addons. Das Textfeld im
sich öffnenden Fenster ist bereits markiert - einfach Strg+C drücken und den
Text z.B. in ein GitHub-Issue, Discord oder einen CurseForge-Kommentar
einfügen.

----------------------------------------------------------------------------
7. ADDON-STRUKTUR & ARCHITEKTUR
----------------------------------------------------------------------------
BerufeSkillGuide/
 ├── BerufeSkillGuide.toc    - Registrierung aller Dateien und SavedVariables.
 ├── BerufeSkillGuide.lua    - Hauptdatei (Interface, Logik & Berechnungen).
 ├── Debug.lua               - Modul für den Inspector und die Sandbox.
 ├── BugReport.lua           - Fehlererfassung & kopierbarer Bug-Report.
 ├── AccountScanner.lua      - Kontoweiter Taschen-/Bank-Scan (Cross-Char-Bestand).
 ├── README.txt              - Diese Dokumentation.
 └── Data/                   - Ordner für alle Berufs-Datenbanken.
      ├── Daten_Alchimie.lua
      ├── Daten_Schmiedekunst.lua
      ├── Daten_Ingenieurskunst.lua
      ├── Daten_Lederverarbeitung.lua
      ├── Daten_Schneidern.lua
      ├── Daten_Verzauberkunst.lua
      ├── Daten_Kochen.lua
      ├── Daten_Fundorte.lua
      └── Daten_Lehrer.lua

============================================================================
                   DEVELOPED WITH PASSION FOR AZEROTH!
============================================================================
