-- Globales Simulations-Objekt für den Entwickler registrieren
BSG_Simulation = {}

-- Hier speichern wir die simulierten Berufe (Standardmäßig leer)
BerufeSkillGuideDB = BerufeSkillGuideDB or {}
if BerufeSkillGuideDB.simulatedProfessions == nil then BerufeSkillGuideDB.simulatedProfessions = {} end
if BerufeSkillGuideDB.isSimulating == nil then BerufeSkillGuideDB.isSimulating = false end

-- Zentrale Funktion: Aktiviert oder deaktiviert einen Fake-Beruf für den Test
function BSG_Simulation.SetFakeBeruf(berufName, skillLevel)
    if not berufName then
        -- Wenn kein Name übergeben wird, schalten wir die Simulation komplett aus
        BerufeSkillGuideDB.isSimulating = false
        BerufeSkillGuideDB.simulatedProfessions = {}
        print("|cff00ff00[BSG-Dev]:|r Simulation beendet. Zeige wieder deine echten Berufe an.")
        return
    end

    -- Wir weisen dem Fake-Beruf das passende Icon zu
    local icon = "Interface\\Icons\\Trade_Alchemy"
    if berufName == "Schmiedekunst" then icon = "Interface\\Icons\\Trade_BlackSmithing" end
    if berufName == "Ingenieurskunst" then icon = "Interface\\Icons\\Trade_Engineering" end
    if berufName == "Lederverarbeitung" then icon = "Interface\\Icons\\Trade_LeatherWorking" end
    if berufName == "Schneidern" then icon = "Interface\\Icons\\Trade_Tailoring" end
    if berufName == "Verzauberkunst" then icon = "Interface\\Icons\\Spell_Nature_Lightning" end
    if berufName == "Kochkunst" then icon = "Interface\\Icons\\INV_Misc_Food_15" end

    -- Wir befüllen die Fake-Tabelle
    BerufeSkillGuideDB.isSimulating = true
    BerufeSkillGuideDB.simulatedProfessions = {
        {
            name = berufName,
            dbName = berufName,
            rank = tonumber(skillLevel) or 1,
            maxRank = 300,
            icon = icon
        }
    }
    
    print(string.format("|cffff5500[BSG-Dev]:|r Simulation gestartet! Spiegele vor: |cffffff00%s (Stufe %d)|r", berufName, skillLevel))
end
