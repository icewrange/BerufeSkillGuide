-- ============================================================================
-- MODUL: SCROLLFRAME - DESIGN & SCROLL ENGINE V1.0
-- ============================================================================
if not _G["BSG_ScrollFrame"] then _G["BSG_ScrollFrame"] = {} end
local BSG_SF = _G["BSG_ScrollFrame"]

BSG_SF.Frame = nil
BSG_SF.Child = nil

-- Diese Funktion baut das Scrollfenster krisensicher zusammen
function BSG_SF.ErstelleScrollBereich(parentFrame)
    if not parentFrame or BSG_SF.Frame then return BSG_SF.Frame, BSG_SF.Child end

    -- 1. Das äußere ScrollFrame (Das Fenster mit der Scrollbar)
    local sf = CreateFrame("ScrollFrame", "BerufeSkillGuideScrollFrame", parentFrame, "UIPanelScrollFrameTemplate")
    sf:SetPoint("TOPLEFT", parentFrame, "TOPLEFT", 20, -145) -- Setzt perfekt unter deiner Überschrift an
    sf:SetPoint("BOTTOMRIGHT", parentFrame, "BOTTOMRIGHT", -35, 30)

    -- 2. Das innere Inhaltsfenster (Das sich bewegt und Text + Icons hält)
    local child = CreateFrame("Frame", "BerufeSkillGuideScrollChild", sf)
    child:SetSize(340, 1000) -- Bietet Platz für sehr lange Listen
    sf:SetScrollChild(child)

    BSG_SF.Frame = sf
    BSG_SF.Child = child

    return sf, child
end

-- Hilfsfunktion: Passt die Scroll-Höhe dynamisch an, wenn neuer Text kommt
function BSG_SF.SetzeInhaltsHoehe(hoehe)
    if BSG_SF.Child then
        BSG_SF.Child:SetHeight(math.max(200, hoehe))
    end
end
