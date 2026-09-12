-- Registriert die deutschen Texte, falls der Spieler einen deutschen Client nutzt
if GetLocale() == "deDE" then
    BSG_Locale = {
        TITLE = "Berufe Skill Guide",
        OPTIONS = "Optionen",
        SEARCH_PLACEHOLDER = "Rezept suchen...",
        SEARCH_BUTTON = "Suchen",
        NO_PROFESSIONS = "Keine gelernten Hauptberufe gefunden.",
        CURRENT_STEP = "Aktueller Schritt (Skill %d-%d):",
        PRODUCE = "Stelle her: |cffffff00%s|r",
        MATS_PER_ITEM = "Material pro Gegenstand:",
        MISSING_POINTS = "Fehlende Punkte bis %d:",
        TOTAL_NEED = "Gesamt-Bedarf bis %d:",
        NEXT_TEACHER = "Nächster Lehrer (%s):",
        MAX_LEVEL = "Maximum von 300 erreicht!",
        NO_GUIDE = "Kein Guide hinterlegt."
    }
end
