-- Registriert die englischen Texte (Greift bei enUS und enGB Clients)
if GetLocale() == "enUS" or GetLocale() == "enGB" or not BSG_Locale then
    BSG_Locale = {
        TITLE = "Profession Skill Guide",
        OPTIONS = "Options",
        SEARCH_PLACEHOLDER = "Search recipe...",
        SEARCH_BUTTON = "Search",
        NO_PROFESSIONS = "No primary professions found.",
        CURRENT_STEP = "Current Step (Skill %d-%d):",
        PRODUCE = "Craft: |cffffff00%s|r",
        MATS_PER_ITEM = "Materials per item:",
        MISSING_POINTS = "Missing points until %d:",
        TOTAL_NEED = "Total shopping list until %d:",
        NEXT_TEACHER = "Next Trainer (%s):",
        MAX_LEVEL = "Maximum of 300 reached!",
        NO_GUIDE = "No guide found."
    }
end
