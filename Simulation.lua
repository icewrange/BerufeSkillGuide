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
        -- FIX: Ohne diesen Aufruf blieb der zuletzt simulierte Guide-Text
        -- stehen, bis der Spieler manuell neu ausgewählt hat. Jetzt wird
        -- beim Beenden sofort wieder der echte Beruf des Charakters geladen.
        if BSG_Search and BSG_Search.ScanneCharakterBerufe then
            BSG_Search.ScanneCharakterBerufe()
        end
        return
    end

    -- Icon aus der zentralen Berufsliste (BSG_Berufe.lua)
    local icon = BSG_Berufe.Icon(berufName)

    local rank = tonumber(skillLevel) or 1

    -- Wir befüllen die Fake-Tabelle
    BerufeSkillGuideDB.isSimulating = true
    BerufeSkillGuideDB.simulatedProfessions = {
        {
            name = berufName,
            dbName = berufName,
            rank = rank,
            maxRank = BSG_Skillstufen.MaxSkill(),
            icon = icon
        }
    }

    print(string.format("|cffff5500[BSG-Dev]:|r Simulation gestartet! Spiegele vor: |cffffff00%s (Stufe %d)|r", berufName, rank))

    -- FIX: Bisher wurde hier nur die DB befüllt, aber nie das Guide-Fenster
    -- aktualisiert - "/bsg sim" hat also nichts sichtbar verändert. Jetzt
    -- wird der Guide sofort mit dem simulierten Beruf/Skill neu berechnet.
    if BSG_Search and BSG_Search.BerechneMaterialBedarf then
        BSG_Search.BerechneMaterialBedarf(berufName, rank)
    end
end
