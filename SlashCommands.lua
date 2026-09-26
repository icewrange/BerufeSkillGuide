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
-- (v2.1) Aliase kommen aus der zentralen Liste BSG_Berufe.lua
-- (deutsch, englisch, ohne Umlaute/Leerzeichen, Kurzformen).
local BERUF_ALIASE = BSG_Berufe.ALIASE

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

    -- "Beruf Zahl" oder "BerufZahl" - der Beruf darf jetzt auch Leerzeichen
    -- und Umlaute enthalten ("Erste Hilfe 120", "Kräuterkunde150").
    local berufTeil, zahlTeil = rest:match("^(.-)%s*(%d+)$")
    if berufTeil then berufTeil = berufTeil:gsub("%s+$", "") end
    if berufTeil == "" then berufTeil = nil end

    if not berufTeil or not zahlTeil then
        return nil, nil
    end

    local berufKey = BERUF_ALIASE[berufTeil:lower()] or BERUF_ALIASE[(berufTeil:lower():gsub("%s", ""))]
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

    elseif befehl == "version" then
        -- NEU: /bsg version [classic|forever] - gleiche Funktion wie der
        -- Spielversions-Button in der Titelleiste.
        local ziel = (rest or ""):lower():gsub("%s", "")
        if ziel == "classic" or ziel == "forever" then
            BSG_Spielversion.Setze(ziel)
        elseif ziel == "" then
            BSG_Spielversion.Setze(BSG_Spielversion.IstForever() and "classic" or "forever")
        else
            print("|cffff5500[BSG]:|r Nutzung: |cffffd100/bsg version|r (umschalten) oder |cffffd100/bsg version classic|forever|r")
        end

    elseif befehl == "auswahl" or befehl == "autoselect" then
        -- NEU (v2.1): Auto-Auswahl des Guide-Rezepts im Berufefenster an/aus
        if BSG_Berufefenster and BSG_Berufefenster.ToggleAutoAuswahl then
            BSG_Berufefenster.ToggleAutoAuswahl()
        end

    elseif befehl == "gold" then
        -- NEU: Berechnet die AH-Gesamtkosten für ALLE Materialien, die der
        -- aktuell im Guide-Fenster angezeigte Skill-Schritt noch braucht
        -- (BSG_Search.LetzteGesamtBedarf, wird bei jeder Guide-Anzeige neu
        -- befüllt). Muss bei geöffnetem Auktionshaus ausgeführt werden.
        if BSG_GoldPlaner and BSG_GoldPlaner.BerechneGesamtkosten then
            BSG_GoldPlaner.BerechneGesamtkosten(BSG_Search and BSG_Search.LetzteGesamtBedarf)
        end

    elseif befehl == "wo" then
        -- NEU: Zeigt für ein beliebiges Material den Cross-Char-Bestand im
        -- Chat an (nutzt denselben Datensatz wie der Tooltip auf den
        -- Material-Icons, funktioniert aber für JEDES Material, nicht nur
        -- für die des aktuell angezeigten Guide-Schritts).
        if not rest or not rest:match("%S") then
            print("|cffff5500[BSG]:|r Nutzung: |cffffd100/bsg wo <Materialname>|r (z.B. /bsg wo Leinenstoff)")
        elseif BSG_API and BSG_API.GetItemCountByCharacter then
            local materialName = rest:gsub("^%l", string.upper)
            local verteilung = BSG_API.GetItemCountByCharacter(materialName)
            local charNamen = {}
            local gesamt = 0
            for charName, anzahl in pairs(verteilung) do
                table.insert(charNamen, charName)
                gesamt = gesamt + anzahl
            end

            if gesamt > 0 then
                table.sort(charNamen, function(a, b) return verteilung[a] > verteilung[b] end)
                print(string.format("|cff00ff00[BSG]:|r %s - Gesamtbestand: %d", materialName, gesamt))
                for _, charName in ipairs(charNamen) do
                    print(string.format("   |cffcccccc%s:|r %d", charName, verteilung[charName]))
                end
            else
                print(string.format("|cffff5500[BSG]:|r %s liegt auf keinem gescannten Charakter.", materialName))
            end
        end

    elseif befehl == "bugreport" then
        -- NEU: Öffnet ein Fenster mit einem fertigen, kopierbaren Diagnose-
        -- Text (Version, Build, Locale, zuletzt erfasste Lua-Fehler, sowie
        -- optional die nach "bugreport" eingegebene Beschreibung).
        if BSG_BugReport and BSG_BugReport.OeffneReport then
            BSG_BugReport.OeffneReport(rest)
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
