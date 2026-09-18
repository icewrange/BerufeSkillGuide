-- Globales API-Objekt erstellen
BSG_API = {}

-- 1. Funktion: Zählt die Gegenstände in den Taschen (Classic-sicher)
function BSG_API.GetItemCount(itemName)
    if not itemName then return 0 end
    return GetItemCount(itemName) or 0
end

-- 2. Funktion: Holt alle gelernten Hauptberufe des Charakters via Zauberbuch (Absolut krisensicher)
function BSG_API.GetGelernteBerufe()
    local gelernte = {}
    
    -- Liste der Berufe mit ihren echten Classic Zauber-IDs (Spell IDs) und Max-Skills
    local moeglicheBerufe = {
        { name = "Alchimie", id = 2259, icon = "Interface\\Icons\\Trade_Alchemy" },
        { name = "Schmiedekunst", id = 2018, icon = "Interface\\Icons\\Trade_BlackSmithing" },
        { name = "Ingenieurskunst", id = 4036, icon = "Interface\\Icons\\Trade_Engineering" },
        { name = "Lederverarbeitung", id = 2108, icon = "Interface\\Icons\\Trade_LeatherWorking" },
        { name = "Schneidern", id = 3908, icon = "Interface\\Icons\\Trade_Tailoring" },
        { name = "Verzauberkunst", id = 7411, icon = "Interface\\Icons\\Spell_Nature_Lightning" },
        -- NEU: Kochkunst (Sekundärberuf). Spell-ID 2550 = "Kochkunst"
        -- (Grundfertigkeit, bestätigt über Wowhead), analog zu den
        -- anderen Berufen als Erkennungs-Spell genutzt.
        { name = "Kochkunst", id = 2550, icon = "Interface\\Icons\\INV_Misc_Food_15" },
        -- NEU: Erste Hilfe (Sekundärberuf). Spell-ID 3273 = "Erste Hilfe"
        -- Lehrlingsstufe (erlaubt Verbände bis Skill 75), über Wowhead
        -- gegengeprüft. WICHTIG: "name" MUSS hier exakt "Erste Hilfe" (mit
        -- Leerzeichen) sein, weil GetSkillLineInfo() diesen String genau so
        -- zurückgibt - siehe Hinweis in Data/Daten_ErsteHilfe.lua.
        { name = "Erste Hilfe", id = 3273, icon = "Interface\\Icons\\Spell_Holy_SealOfSacrifice" }
    }

    -- Wir pruefen direkt im Zauberbuch, ob der Spieler den Beruf beherrscht
    for _, beruf in ipairs(moeglicheBerufe) do
        if IsSpellKnown(beruf.id) then
            -- Wenn gelernt, holen wir den aktuellen Skill-Stand aus dem Classic-System
            local skillRank, skillMaxRank = 1, 75 -- Standard-Fallback

            -- FIX: "GetSkillInfo" existiert in der WoW-API nicht - das führte
            -- zu "attempt to call global 'GetSkillInfo' (a nil value)" bei
            -- jedem Klick auf einen Berufs-Button. Korrekt ist
            -- GetSkillLineInfo (wird z.B. auch so in Search.lua verwendet).
            for i = 1, GetNumSkillLines() do
                local sName, _, _, sRank, _, _, sMaxRank = GetSkillLineInfo(i)
                if sName == beruf.name then
                    skillRank = sRank
                    skillMaxRank = sMaxRank
                    break
                end
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
