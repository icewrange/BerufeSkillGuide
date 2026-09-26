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
    -- (v2.1) Aliase aus BSG_Berufe.lua ("alchemie", "kraeuterkunde", ...)
    local alias = BSG_Berufe and BSG_Berufe.ALIASE[eingabeKlein]
    if alias then eingabeKlein = alias:lower() end

    for key, _ in pairs(BerufeGuideDB) do
        if key:lower() == eingabeKlein then
            return key
        end
    end
    return nil
end

-- Prüft genau einen Beruf und gibt die Ergebnisse im Chat aus.
function BSG_Inspector.PruefeBeruf(berufEingabe)
    local berufName = FindeBerufsKey(berufEingabe)

    if not berufName then
        print(string.format("|cffff5500[BSG-Check]:|r Kein Beruf namens '%s' gefunden.", tostring(berufEingabe)))
        return
    end

    local eintraege = BerufeGuideDB[berufName]

    -- Sortierte Kopie nach minSkill, damit die Prüfung auch dann korrekt
    -- läuft, wenn die Einträge in der Datei nicht streng aufsteigend
    -- sortiert wurden.
    local sortiert = {}
    for _, eintrag in ipairs(eintraege) do
        table.insert(sortiert, eintrag)
    end
    table.sort(sortiert, function(a, b) return a.minSkill < b.minSkill end)

    print(string.format("|cff00ffff[BSG-Check]:|r Prüfe %s (%d Einträge)...", berufName, #sortiert))

    local problemeGefunden = false

    for i, eintrag in ipairs(sortiert) do
        -- MATS FEHLEN
        -- Sammelberufe haben absichtlich keine Materialien
        if (not eintrag.mats or eintrag.mats == "") and not (BSG_Berufe and BSG_Berufe.IstSammelberuf(berufName)) then
            problemeGefunden = true
            print(string.format(
                "|cffff0000[MATS FEHLEN]|r Skill %d-%d (\"%s\") hat keine Materialien hinterlegt.",
                eintrag.minSkill, eintrag.maxSkill, tostring(eintrag.item)
            ))
        end

        -- LÜCKE / ÜBERLAPPUNG zum jeweils nächsten Eintrag
        local naechster = sortiert[i + 1]
        if naechster then
            if eintrag.maxSkill < naechster.minSkill then
                problemeGefunden = true
                print(string.format(
                    "|cffff8800[LÜCKE GEFUNDEN]|r Zwischen Skill %d und %d gibt es kein Rezept.",
                    eintrag.maxSkill, naechster.minSkill
                ))
            elseif eintrag.maxSkill > naechster.minSkill then
                problemeGefunden = true
                print(string.format(
                    "|cffff8800[ÜBERLAPPUNG]|r Skill %d-%d überschneidet sich mit %d-%d.",
                    eintrag.minSkill, eintrag.maxSkill, naechster.minSkill, naechster.maxSkill
                ))
            end
        end
    end

    if not problemeGefunden then
        print(string.format("|cff00ff00[DATENBANK REIN]|r %s: Keine Probleme gefunden.", berufName))
    end
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
