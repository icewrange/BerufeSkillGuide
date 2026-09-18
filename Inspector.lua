-- ============================================================================
-- MODUL: INSPECTOR - DATENBANK-PRÜFUNG FÜR /bsg check V1.0
-- ============================================================================
-- Scannt BerufeGuideDB[berufName] auf drei Fehlerklassen:
--   [LÜCKE GEFUNDEN]  - zwischen zwei Skill-Stufen fehlt ein Rezept
--   [ÜBERLAPPUNG]     - zwei Skill-Stufen überschneiden sich
--   [MATS FEHLEN]     - ein Rezept hat keine Materialien hinterlegt
-- Ohne Probleme: [DATENBANK REIN]

BSG_Inspector = {}

-- Findet den tatsächlichen Datenbank-Key zu einer Nutzereingabe
-- (Groß-/Kleinschreibung egal, "Alchemie" wird wie "Alchimie" behandelt).
local function FindeBerufsKey(eingabe)
    if not eingabe or eingabe == "" or not BerufeGuideDB then
        return nil
    end

    local eingabeKlein = eingabe:lower()
    if eingabeKlein == "alchemie" then
        eingabeKlein = "alchimie"
    end

    for key, _ in pairs(BerufeGuideDB) do
        if key:lower() == eingabeKlein then
            return key
        end
    end
    return nil
end

-- Prüft genau einen Beruf. Bei stumm=true wird NICHTS in den Chat
-- geschrieben (für den automatischen Check beim Login), es wird nur die
-- Anzahl gefundener Probleme zurückgegeben. Bei stumm=false verhält sich
-- die Funktion wie bisher und gibt alles im Chat aus.
local function PruefeUndZaehle(berufName, stumm)
    local eintraege = BerufeGuideDB[berufName]

    -- Sortierte Kopie nach minSkill, damit die Prüfung auch dann korrekt
    -- läuft, wenn die Einträge in der Datei nicht streng aufsteigend
    -- sortiert wurden.
    local sortiert = {}
    for _, eintrag in ipairs(eintraege) do
        table.insert(sortiert, eintrag)
    end
    table.sort(sortiert, function(a, b) return a.minSkill < b.minSkill end)

    if not stumm then
        print(string.format("|cff00ffff[BSG-Check]:|r Prüfe %s (%d Einträge)...", berufName, #sortiert))
    end

    local anzahlProbleme = 0

    for i, eintrag in ipairs(sortiert) do
        -- MATS FEHLEN
        if not eintrag.mats or eintrag.mats == "" then
            anzahlProbleme = anzahlProbleme + 1
            if not stumm then
                print(string.format(
                    "|cffff0000[MATS FEHLEN]|r Skill %d-%d (\"%s\") hat keine Materialien hinterlegt.",
                    eintrag.minSkill, eintrag.maxSkill, tostring(eintrag.item)
                ))
            end
        end

        -- LÜCKE / ÜBERLAPPUNG zum jeweils nächsten Eintrag
        local naechster = sortiert[i + 1]
        if naechster then
            if eintrag.maxSkill < naechster.minSkill then
                anzahlProbleme = anzahlProbleme + 1
                if not stumm then
                    print(string.format(
                        "|cffff8800[LÜCKE GEFUNDEN]|r Zwischen Skill %d und %d gibt es kein Rezept.",
                        eintrag.maxSkill, naechster.minSkill
                    ))
                end
            elseif eintrag.maxSkill > naechster.minSkill then
                anzahlProbleme = anzahlProbleme + 1
                if not stumm then
                    print(string.format(
                        "|cffff8800[ÜBERLAPPUNG]|r Skill %d-%d überschneidet sich mit %d-%d.",
                        eintrag.minSkill, eintrag.maxSkill, naechster.minSkill, naechster.maxSkill
                    ))
                end
            end
        end
    end

    if not stumm and anzahlProbleme == 0 then
        print(string.format("|cff00ff00[DATENBANK REIN]|r %s: Keine Probleme gefunden.", berufName))
    end

    return anzahlProbleme
end

-- Prüft genau einen Beruf und gibt die Ergebnisse im Chat aus.
function BSG_Inspector.PruefeBeruf(berufEingabe)
    local berufName = FindeBerufsKey(berufEingabe)

    if not berufName then
        print(string.format("|cffff5500[BSG-Check]:|r Kein Beruf namens '%s' gefunden.", tostring(berufEingabe)))
        return
    end

    PruefeUndZaehle(berufName, false)
end

-- Prüft alle Berufe, die aktuell in BerufeGuideDB registriert sind.
function BSG_Inspector.PruefeAlle()
    if not BerufeGuideDB then
        print("|cffff5500[BSG-Check]:|r Keine Berufs-Datenbank geladen.")
        return
    end

    for berufName, _ in pairs(BerufeGuideDB) do
        BSG_Inspector.PruefeBeruf(berufName)
    end
end

-- NEU: Stiller Gesamt-Check für den automatischen Start beim Login
-- (siehe BSG_Core.lua). Schreibt NICHTS in den Chat, sondern speichert das
-- Ergebnis in BSG_Inspector.LetzterCheck, damit die UI (MainUI.lua) ein
-- kleines "Datenbank geprüft"-Badge anzeigen kann. Bei Problemen bleibt
-- der Spieler nicht im Dunkeln - er sieht das Badge und kann per Klick
-- bzw. /bsg check die Details nachschauen.
function BSG_Inspector.PruefeAlleStumm()
    local ergebnis = { ok = true, anzahlProbleme = 0, anzahlBerufe = 0, zeitstempel = time() }

    if not BerufeGuideDB then
        ergebnis.ok = false
        BSG_Inspector.LetzterCheck = ergebnis
        return ergebnis
    end

    for berufName, _ in pairs(BerufeGuideDB) do
        ergebnis.anzahlBerufe = ergebnis.anzahlBerufe + 1
        ergebnis.anzahlProbleme = ergebnis.anzahlProbleme + PruefeUndZaehle(berufName, true)
    end

    ergebnis.ok = (ergebnis.anzahlProbleme == 0)
    BSG_Inspector.LetzterCheck = ergebnis
    return ergebnis
end
