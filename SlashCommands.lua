-- ============================================================================
-- MODUL: SLASH-COMMANDS - VERBINDET /bsg MIT DEN BESTEHENDEN MODULEN V1.0
-- ============================================================================
-- Registriert /bsg im Chat und leitet an die bereits vorhandenen Module
-- weiter (BSG_Core.lua, Debug.lua, Options.lua, Simulation.lua). Ohne diese
-- Datei war KEINER der in Befehlsliste.txt/README.txt beschriebenen Befehle
-- tatsächlich erreichbar.

BerufeSkillGuide = BerufeSkillGuide or {}
local BSG = BerufeSkillGuide

-- Berufsnamen-Normalisierung: "Alchemie" (wie in Befehlsliste.txt erwähnt)
-- wird auf den tatsächlichen Datenbank-Key "Alchimie" abgebildet.
local BERUF_ALIASE = {
    ["alchimie"] = "Alchimie",
    ["alchemie"] = "Alchimie",
    ["schmiedekunst"] = "Schmiedekunst",
    ["ingenieurskunst"] = "Ingenieurskunst",
    ["lederverarbeitung"] = "Lederverarbeitung",
    ["schneidern"] = "Schneidern",
    ["verzauberkunst"] = "Verzauberkunst",
    ["kochkunst"] = "Kochkunst",
    ["kochen"] = "Kochkunst",
}

-- Versucht "sim Schneidern 150" UND "sim Schneidern150" (ohne Leerzeichen)
-- zu erkennen, wie in Befehlsliste.txt als Schnellschreibweise beschrieben.
local function ParseSimArgument(rest)
    if not rest or rest:match("^%s*$") then
        return nil, nil
    end

    rest = rest:gsub("^%s+", ""):gsub("%s+$", "")

    -- "off" schaltet die Simulation aus
    if rest:lower() == "off" then
        return "off", nil
    end

    -- Variante 1: "Beruf Zahl" (mit Leerzeichen getrennt)
    local berufTeil, zahlTeil = rest:match("^(%a+)%s+(%d+)$")

    -- Variante 2: "BerufZahl" (ohne Leerzeichen, Zahl direkt angehängt)
    if not berufTeil then
        berufTeil, zahlTeil = rest:match("^(%a+)(%d+)$")
    end

    if not berufTeil or not zahlTeil then
        return nil, nil
    end

    local berufKey = BERUF_ALIASE[berufTeil:lower()]
    if not berufKey then
        return nil, nil
    end

    return berufKey, tonumber(zahlTeil)
end

SLASH_BSG1 = "/bsg"
SlashCmdList["BSG"] = function(msg)
    msg = msg or ""
    local befehl, rest = msg:match("^(%S*)%s*(.-)$")
    befehl = (befehl or ""):lower()

    if befehl == "" then
        -- /bsg (ohne Zusatz) -> Hauptfenster öffnen/schließen
        if BSG.ToggleFenster then
            BSG.ToggleFenster()
        end

    elseif befehl == "help" then
        if BSG.ToggleHilfeFenster then
            BSG.ToggleHilfeFenster()
        end

    elseif befehl == "optionen" then
        if BSG_Options and BSG_Options.ToggleOptionen then
            BSG_Options.ToggleOptionen()
        end

    elseif befehl == "debug" then
        BerufeSkillGuideDB = BerufeSkillGuideDB or {}
        BerufeSkillGuideDB.debugMode = not BerufeSkillGuideDB.debugMode
        if BerufeSkillGuideDB.debugMode then
            print("|cff00ff00[BSG]:|r Debug-Modus |cff00ff00aktiviert|r.")
        else
            print("|cff00ff00[BSG]:|r Debug-Modus |cffff0000deaktiviert|r.")
        end

    elseif befehl == "sim" or befehl == "sin" then
        -- "sin" ist laut Befehlsliste.txt die fehlertolerante Variante von "sim"
        local berufKey, skillLevel = ParseSimArgument(rest)

        if berufKey == "off" then
            if BSG_Simulation and BSG_Simulation.SetFakeBeruf then
                BSG_Simulation.SetFakeBeruf(nil)
            end
        elseif berufKey and skillLevel then
            if BSG_Simulation and BSG_Simulation.SetFakeBeruf then
                BSG_Simulation.SetFakeBeruf(berufKey, skillLevel)
            end
        else
            print("|cffff5500[BSG]:|r Ungültige Eingabe. Nutzung: |cffffd100/bsg sim <Beruf> <Skill>|r oder |cffffd100/bsg sim off|r")
        end

    elseif befehl == "check" then
        -- NEU: Ruft jetzt den echten Datenbank-Inspector auf (Inspector.lua),
        -- statt wie zuvor nur "noch nicht implementiert" auszugeben.
        if BSG_Inspector then
            if rest and rest:match("%S") then
                BSG_Inspector.PruefeBeruf(rest)
            else
                BSG_Inspector.PruefeAlle()
            end
        else
            print("|cffff5500[BSG]:|r Der Datenbank-Inspector ist nicht geladen.")
        end

    else
        print("|cffff5500[BSG]:|r Unbekannter Befehl. Nutze |cffffd100/bsg help|r für eine Übersicht.")
    end
end
