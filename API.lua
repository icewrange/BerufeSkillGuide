-- Globales API-Objekt erstellen
BSG_API = {}

-- ============================================================================
-- NEU: KANONISCHE BERUFSNAMEN (SPRACHUNABHÄNGIG)
-- ============================================================================
-- FIX: GetSkillLineInfo() liefert den Berufsnamen IMMER in der Sprache des
-- WoW-Clients zurück ("Alchemy" auf Englisch, "Alchimie" auf Deutsch). Die
-- gesamte automatische Skill-Erkennung (Search.lua, Sidebar.lua) verglich
-- bisher stur gegen die fest einprogrammierten DEUTSCHEN Namen - auf einem
-- englischen Client hätte das NIE gematcht, die komplette Auto-Erkennung
-- des echten Charakter-Skills wäre komplett ausgefallen.
-- Diese Funktion bildet JEDEN unterstützten Sprachnamen (Deutsch ODER
-- Englisch) auf unseren internen, kanonischen (deutschen) Berufsnamen ab,
-- unter dem die Rezeptdatenbanken (BerufeGuideDB) weiterhin gespeichert
-- sind - dadurch mussten die Datenbank-Schlüssel selbst nicht angefasst
-- werden.
-- (v2.1) Die Zuordnung kommt jetzt aus der zentralen Liste BSG_Berufe.lua.

function BSG_API.KanonischerBerufsname(skillLineName)
    return BSG_Berufe.KANONISCH[skillLineName]
end

-- 1. Funktion: Zählt die Gegenstände in den Taschen (Classic-sicher)
function BSG_API.GetItemCount(itemName)
    if not itemName then return 0 end
    return BSG_Compat.GetItemCount(itemName)
end

-- 2. Funktion: Holt alle gelernten Hauptberufe des Charakters via Zauberbuch (Absolut krisensicher)
function BSG_API.GetGelernteBerufe()
    local gelernte = {}
    
    -- Liste der Berufe mit ihren echten Classic Zauber-IDs (Spell IDs) und Max-Skills
    -- (v2.1) Zentrale Liste aus BSG_Berufe.lua
    local moeglicheBerufe = {}
    for _, b in ipairs(BSG_Berufe.LISTE) do
        table.insert(moeglicheBerufe, { name = b.name, id = b.spellId, icon = b.icon })
    end

    -- Wir pruefen direkt im Zauberbuch, ob der Spieler den Beruf beherrscht
    for _, beruf in ipairs(moeglicheBerufe) do
        if IsSpellKnown(beruf.id) then
            -- Wenn gelernt, holen wir den aktuellen Skill-Stand aus dem Classic-System
            local skillRank, skillMaxRank = 1, 75 -- Standard-Fallback

            -- FIX: "GetSkillInfo" existiert in der WoW-API nicht - das führte
            -- zu "attempt to call global 'GetSkillInfo' (a nil value)" bei
            -- jedem Klick auf einen Berufs-Button. Korrekt ist
            -- GetSkillLineInfo (wird z.B. auch so in Search.lua verwendet).
            -- Forever-kompatibel über BSG_Compat (Compat.lua)
            local r, mr = BSG_Compat.HoleBerufsSkill(beruf.name)
            if r then
                skillRank = r
                skillMaxRank = mr
            end

            table.insert(gelernte, {
                name = beruf.name,
                dbName = beruf.name, -- Nutzt jetzt einheitlich das Classic-i
                rank = skillRank,
                maxRank = skillMaxRank,
                icon = beruf.icon
            })
        end
    end
    return gelernte
end
