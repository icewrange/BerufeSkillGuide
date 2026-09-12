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
3. DATENBANK-INSPECTOR (QUALITÄTSKONTROLLE)
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
4. ADDON-STRUKTUR & ARCHITEKTUR
----------------------------------------------------------------------------
BerufeSkillGuide/
 ├── BerufeSkillGuide.toc    - Registrierung aller Dateien und SavedVariables.
 ├── BerufeSkillGuide.lua    - Hauptdatei (Interface, Logik & Berechnungen).
 ├── Debug.lua               - Modul für den Inspector und die Sandbox.
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
