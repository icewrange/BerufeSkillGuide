-- ============================================================================
-- MODUL: DEBUGLOG - LIVE-LOGGER FÜR DEN DEBUG-MODUS V1.0
-- ============================================================================
-- Wertet BerufeSkillGuideDB.debugMode aus (wird über "/bsg debug" umgeschaltet,
-- siehe SlashCommands.lua). Andere Module rufen bereits
-- BSG_DebugLog.Print(...) auf (z.B. AccountScanner.lua beim Taschen-/
-- Bank-Scan) - bisher lief das ins Leere, weil dieses Modul fehlte.

BSG_DebugLog = {}

-- Gibt eine Meldung NUR aus, wenn der Debug-Modus aktiv ist.
-- Der übergebene Text darf bereits eigene Farbcodes enthalten (wie es
-- AccountScanner.lua tut) - die werden hier nicht verändert, nur der
-- gemeinsame "[BSG-Debug]"-Präfix wird vorangestellt.
function BSG_DebugLog.Print(nachricht)
    if not (BerufeSkillGuideDB and BerufeSkillGuideDB.debugMode) then
        return
    end
    print("|cffff8800[BSG-Debug]|r " .. tostring(nachricht))
end

-- Praktischer Helfer für formatierte Meldungen, analog zu string.format,
-- damit Aufrufer nicht jedes Mal selbst string.format(...) schreiben müssen.
function BSG_DebugLog.Printf(format, ...)
    if not (BerufeSkillGuideDB and BerufeSkillGuideDB.debugMode) then
        return
    end
    local ok, ergebnis = pcall(string.format, format, ...)
    if ok then
        print("|cffff8800[BSG-Debug]|r " .. ergebnis)
    else
        -- Falls das Format nicht zu den Argumenten passt, lieber eine
        -- unformatierte Meldung zeigen als im Debug-Modus zu crashen.
        print("|cffff8800[BSG-Debug]|r " .. tostring(format))
    end
end
