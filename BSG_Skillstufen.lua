-- ============================================================================
-- CORE: SKILLSTUFEN - MAXIMALER SKILL & BERUFSSTUFEN JE SPIELVERSION V1.0
-- ============================================================================
-- Zentrale Stelle für ALLES, was vom Skill-Cap abhängt. Vorher stand "300"
-- fest verdrahtet in MainUI.lua, Search.lua, Simulation.lua und den
-- Sprachdateien. Kommt später eine Version mit höherem Cap dazu (z.B. TBC
-- mit 375), muss NUR hier ein neuer Block eingetragen werden - plus ein
-- Eintrag im Umschalter (SV.VERSIONEN in Spielversion.lua) mit derselben id.
--
-- stufen: von = ab diesem Skill braucht man diese Stufe beim Lehrer,
--         bis = Skill-Cap dieser Stufe.
--         Beispiel Geselle 75-150: bei genau 75 muss man zum Gesellen-Lehrer.

BSG_Skillstufen = BSG_Skillstufen or {}
local S = BSG_Skillstufen

local VANILLA_STUFEN = {
    { name = "Lehrling",  en = "Apprentice", von = 1,   bis = 75  },
    { name = "Geselle",   en = "Journeyman", von = 75,  bis = 150 },
    { name = "Experte",   en = "Expert",     von = 150, bis = 225 },
    { name = "Fachmann",  en = "Artisan",    von = 225, bis = 300 },
}

S.VERSIONEN = {
    classic = { maxSkill = 300, stufen = VANILLA_STUFEN },
    forever = { maxSkill = 300, stufen = VANILLA_STUFEN },

    -- VORLAGE für spätere Versionen (id muss zu SV.VERSIONEN passen):
    -- tbc = {
    --     maxSkill = 375,
    --     stufen = {
    --         { name = "Lehrling", en = "Apprentice", von = 1,   bis = 75  },
    --         { name = "Geselle",  en = "Journeyman", von = 75,  bis = 150 },
    --         { name = "Experte",  en = "Expert",     von = 150, bis = 225 },
    --         { name = "Fachmann", en = "Artisan",    von = 225, bis = 300 },
    --         { name = "Meister",  en = "Master",     von = 300, bis = 375 },
    --     },
    -- },
}

-- Daten der aktuell gewählten Spielversion (Fallback: classic)
function S.Aktuell()
    local id = (BSG_Spielversion and BSG_Spielversion.Aktiv and BSG_Spielversion.Aktiv()) or "classic"
    return S.VERSIONEN[id] or S.VERSIONEN.classic
end

function S.MaxSkill()
    return S.Aktuell().maxSkill
end

-- Begrenzt eine Eingabe auf 1 .. MaxSkill (ganze Zahl)
function S.Begrenze(skill)
    skill = math.floor(tonumber(skill) or 1)
    return math.max(1, math.min(S.MaxSkill(), skill))
end

-- Liefert die Stufe, die man bei diesem Skill beim Lehrer braucht.
-- Grenzwerte zählen zur NÄCHSTEN Stufe (75 -> Geselle), nur das absolute
-- Maximum bleibt in der letzten Stufe.
function S.StufeFuerSkill(skill)
    local stufen = S.Aktuell().stufen
    for _, st in ipairs(stufen) do
        if skill >= st.von and skill < st.bis then
            return st
        end
    end
    return stufen[#stufen]
end

-- Prüft, ob ein Skill in einer Spanne liegt - mit derselben Grenz-Regel:
-- "von" gehört dazu, "bis" nur, wenn es das absolute Maximum ist.
function S.InSpanne(skill, von, bis)
    if skill >= von and skill < bis then return true end
    return bis >= S.MaxSkill() and skill == bis
end
