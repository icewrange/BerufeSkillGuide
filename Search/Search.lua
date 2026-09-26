-- ============================================================================
-- MODUL: SEARCH - COMPLETE CALCULATION ENGINE V1.5 (REZEPTSUCHE + UI-KOPPLUNG)
-- ============================================================================
if not _G["BSG_Search"] then _G["BSG_Search"] = {} end
local BSG_Search = _G["BSG_Search"]

local letzterBeruf = "Alchimie"
local letzterSkill = 1

-- Findet aus BerufeLehrerDB[beruf] den zum aktuellen Skill passenden
-- Eintrag, anhand der Zahlen im "stufe"-Text (z.B. "(150-225)"). Fehlt
-- ein Zahlenbereich (z.B. "Lehrling / Geselle" ohne Zahlen), wird dieser
-- Eintrag als Fallback vorgemerkt, falls kein besserer gefunden wird.
local function FindeLehrerEintrag(lehrerListe, skill)
    local fallback = nil
    for _, eintrag in ipairs(lehrerListe) do
        local von, bis = eintrag.stufe:match("%((%d+)%-(%d+)%)")
        if von and bis then
            von, bis = tonumber(von), tonumber(bis)
            -- FIX: Grenzwerte zählen zur NÄCHSTEN Stufe (bei Skill 75 wurde
            -- vorher noch der Lehrling- statt Gesellen-Lehrer angezeigt).
            -- Regel zentral in BSG_Skillstufen.InSpanne.
            if BSG_Skillstufen.InSpanne(skill, von, bis) then
                return eintrag
            end
        else
            fallback = fallback or eintrag
        end
    end
    return fallback or lehrerListe[1]
end

function BSG_Search.InitialisiereMenue(mainFrame)
    if not mainFrame then return end

    -- NEU (v2.1): Karten-Layout (UI/Karten.lua) statt eines langen Textblocks.
    -- infoTextDisplay bleibt als kompatibles Objekt (SetText/GetText) erhalten.
    if BSG_Karten and BSG_Karten.Initialisiere then
        BSG_Karten.Initialisiere(mainFrame)
        mainFrame.infoTextDisplay = BSG_Karten.ErstelleTextShim()
    end

    BSG_Search.ScanneCharakterBerufe()
end

function BSG_Search.ScanneCharakterBerufe()
    local gefundenerBeruf, aktuellerSkill = nil, 1
    -- Forever-kompatibel über BSG_Compat (Compat.lua)
    for _, linie in ipairs(BSG_Compat.HoleSkillLinien()) do
        local kanonisch = BSG_API and BSG_API.KanonischerBerufsname and BSG_API.KanonischerBerufsname(linie.name)
        if kanonisch and BerufeGuideDB and BerufeGuideDB[kanonisch] then
            gefundenerBeruf, aktuellerSkill = kanonisch, linie.rank
            break
        end
    end
    if gefundenerBeruf then
        BSG_Search.BerechneMaterialBedarf(gefundenerBeruf, aktuellerSkill)
    else
        -- FIX: Bisher wurde hier hart "Alchimie, Skill 158" simuliert, wenn
        -- kein unterstützter Beruf gefunden wurde (z.B. bei einem frischen
        -- Charakter ohne Berufe) - das zeigte falsche Daten statt eines
        -- leeren/neutralen Zustands an.
        if BerufeSkillGuideFrame and BerufeSkillGuideFrame.infoTextDisplay then
            BerufeSkillGuideFrame.infoTextDisplay:SetText(
                (BSG_Locale and BSG_Locale.NO_PROFESSIONS)
                or "Keine gelernten Hauptberufe gefunden."
            )
        end
        if BSG_MatIcons and BSG_MatIcons.InitialisiereIcon then BSG_MatIcons.InitialisiereIcon() end
    end
end

local function L(key, fallback) return (BSG_Locale and BSG_Locale[key]) or fallback end
local function OhneDoppelpunkt(t) return ((t or ""):gsub("%s*:%s*$", "")) end

function BSG_Search.BerechneMaterialBedarf(berufsName, spielerSkill)
    if not BerufeGuideDB or not BerufeGuideDB[berufsName] then return end
    letzterBeruf, letzterSkill = berufsName, spielerSkill

    -- Merkt den aktuell angezeigten Beruf zentral auf mainFrame, damit
    -- MainUI.lua (manuelle Skill-Eingabe) weiß, welchen Beruf eine
    -- eingegebene Skill-Zahl betreffen soll.
    if BerufeSkillGuideFrame then
        BerufeSkillGuideFrame.aktuellAusgewaehlterBeruf = berufsName
    end

    -- Gesamtbedarf (Materialname -> Menge bis zum Ende des Schritts) für den
    -- GoldPlaner; wird vor jeder Neuberechnung zurückgesetzt.
    BSG_Search.LetzteGesamtBedarf = {}
    BSG_Search.AktuellerSchritt = nil
    if BSG_Wegpunkt and BSG_Wegpunkt.LoescheZiel then BSG_Wegpunkt.LoescheZiel() end

    local maxSkill = BSG_Skillstufen.MaxSkill()
    local karten = {}
    local kopf = { beruf = berufsName, skill = spielerSkill, max = maxSkill }

    for _, daten in ipairs(BerufeGuideDB[berufsName]) do
        local istLetzterSchritt = (daten.maxSkill >= maxSkill)
        if spielerSkill >= daten.minSkill and (spielerSkill < daten.maxSkill or (istLetzterSchritt and spielerSkill == daten.maxSkill)) then
            kopf.von, kopf.bis = daten.minSkill, daten.maxSkill
            local schrittTitel = OhneDoppelpunkt(string.format(L("CURRENT_STEP", "Aktueller Schritt (Skill %d-%d):"), daten.minSkill, daten.maxSkill))
            local verbleibend = daten.maxSkill - spielerSkill
            local fehlendZeile = "|cffffd100" .. string.format(L("MISSING_POINTS", "Fehlende Punkte bis %d:"), daten.maxSkill) .. string.format("|r %d", verbleibend)

          if daten.typ == "sammeln" then
            -- SAMMELBERUFE: was sammeln + in welchen Gebieten.
            local text = string.format(L("GATHER", "Sammle: |cffffd100%s|r"), daten.item)
            if daten.hinweis then text = text .. "\n|cffcccccc" .. daten.hinweis .. "|r" end
            text = text .. "\n" .. fehlendZeile
            table.insert(karten, { art = "schritt", titel = schrittTitel, text = text })

            -- Gebiete: eigene Fraktion zuerst, andere Fraktion grau
            local fraktion = UnitFactionGroup and UnitFactionGroup("player")
            local eigene = (fraktion == "Horde") and daten.horde or daten.allianz
            local fremde = (fraktion == "Horde") and daten.allianz or daten.horde
            local zeilen = {}
            if daten.beide then zeilen[#zeilen + 1] = daten.beide end
            if eigene then zeilen[#zeilen + 1] = eigene end
            if fremde then
                zeilen[#zeilen + 1] = "|cff888888(" .. ((fraktion == "Horde") and L("ALLIANCE", "Allianz") or L("HORDE", "Horde")) .. ": " .. fremde .. ")|r"
            end
            table.insert(karten, { art = "gebiete", titel = OhneDoppelpunkt(L("AREAS", "Gebiete:")), text = table.concat(zeilen, "\n") })
          else
            -- Rezeptname in seiner Schwierigkeitsfarbe aus dem Berufefenster
            local itemAnzeige = (BSG_Berufefenster and BSG_Berufefenster.FaerbeItem and BSG_Berufefenster.FaerbeItem(berufsName, daten.item)) or daten.item
            table.insert(karten, { art = "schritt", titel = schrittTitel,
                text = string.format(L("PRODUCE", "Stelle her: |cffffd100%s|r"), itemAnzeige) .. "\n" .. fehlendZeile })

            -- "mats" = Bedarf für EINE Fertigung; "item" nennt Wowheads
            -- Gesamt-Stückzahl für die ganze Spanne -> craftFaktor rechnet
            -- die verbleibenden Punkte auf die nötigen Fertigungen hoch.
            local rangeBreite = daten.maxSkill - daten.minSkill
            local itemAnzahl = tonumber(daten.item:match("(%d+)"))
            local craftFaktor = (itemAnzahl and rangeBreite > 0) and (itemAnzahl / rangeBreite) or 1

            local zeilen = {}
            if daten.mats and daten.mats ~= "" then
                for teil in string.gmatch(daten.mats, "([^,]+)") do
                    teil = teil:gsub("^%s*(.-)%s*$", "%1")
                    local anzahl, materialName = string.match(teil, "(%d+)x?%s+(.+)")
                    if anzahl and materialName then
                        anzahl = tonumber(anzahl)
                        -- Bestand über ALLE Charaktere (AccountScanner.lua)
                        local imBesitz = (BSG_API and BSG_API.GetItemCount and BSG_API.GetItemCount(materialName)) or BSG_Compat.GetItemCount(materialName, true)
                        local gesamt = math.max(0, math.ceil(anzahl * verbleibend * craftFaktor))
                        BSG_Search.LetzteGesamtBedarf[materialName] = gesamt
                        local rechts
                        if imBesitz >= gesamt then
                            rechts = string.format("|cff00ff00%d / %d|r", imBesitz, gesamt)
                        else
                            rechts = string.format("|cffff4040%d / %d|r |cff888888(%s %d)|r", imBesitz, gesamt, L("MISSING_WORD", "fehlen"), gesamt - imBesitz)
                        end
                        local farbe = (imBesitz >= anzahl) and "|cffffffff" or "|cffff8080"
                        table.insert(zeilen, { mat = materialName, links = string.format("%s%dx %s|r", farbe, anzahl, materialName), rechts = rechts })
                    end
                end
            end
            if #zeilen > 0 then
                table.insert(karten, { art = "material", titel = L("MATERIALS", "Material"), zeilen = zeilen,
                    kopfzeile = { links = OhneDoppelpunkt(L("MATS_PER_ITEM", "Material pro Gegenstand:")),
                                  rechts = string.format(L("STOCK_NEED", "Bestand / Bedarf bis %d"), daten.maxSkill) } })
            end
          end -- herstellen / sammeln

            -- Merkt den aktuellen Schritt für Berufefenster.lua (Auto-Auswahl)
            BSG_Search.AktuellerSchritt = { beruf = berufsName, item = daten.item, typ = daten.typ }
            if BSG_Berufefenster and BSG_Berufefenster.WaehleAktuellesRezept then
                BSG_Berufefenster.WaehleAktuellesRezept()
            end
            break
        end
    end

    -- Lehrer der passenden Stufe (+ Wegpunkt, falls Koordinaten hinterlegt)
    if BerufeLehrerDB and BerufeLehrerDB[berufsName] then
        local eintrag = FindeLehrerEintrag(BerufeLehrerDB[berufsName], spielerSkill)
        if BSG_Wegpunkt and BSG_Wegpunkt.SetzeZielAusLehrer then
            BSG_Wegpunkt.SetzeZielAusLehrer(eintrag, berufsName)
        end
        if eintrag then
            table.insert(karten, { art = "lehrer", titel = OhneDoppelpunkt(string.format(L("NEXT_TEACHER", "Lehrer (%s):"), eintrag.stufe)),
                text = eintrag.standorte, wegpunkt = (BSG_Wegpunkt and BSG_Wegpunkt.Ziel) and true or nil })
        end
    end

    -- Rezept, das man kaufen oder finden muss (+ Wegpunkt)
    if BSG_Search.AktuellerSchritt and BerufeFundorteDB then
        local name = (BSG_Search.AktuellerSchritt.item or ""):gsub("^%s*[Cc][Aa]%.%s*", ""):gsub("^%s*%d+%s*[xX]?%s*", "")
        local fundort = BerufeFundorteDB[name] or BerufeFundorteDB["Enchant " .. name]
        if type(fundort) == "string" then
            local ohneTitel = fundort:gsub("^Formel:[^\n]*\n", ""):gsub("^Formula:[^\n]*\n", "")
            local karte = { art = "rezept", titel = OhneDoppelpunkt(L("RECIPE_SOURCE", "Rezept:")), text = ohneTitel }
            if BSG_Wegpunkt and BSG_Wegpunkt.SetzeZielAusFundort and not BSG_Wegpunkt.Ziel then
                BSG_Wegpunkt.SetzeZielAusFundort(BerufeFundorteDB[name] and name or ("Enchant " .. name))
                if BSG_Wegpunkt.Ziel then
                    karte.wegpunkt = true
                    for _, k in ipairs(karten) do k.wegpunkt = nil end
                end
            end
            table.insert(karten, karte)
        end
    end

    -- Forever-Hinweise (einklappbar, Zustand wird gespeichert)
    if BSG_Spielversion and BSG_Spielversion.HinweisText then
        local hinweis = BSG_Spielversion.HinweisText(berufsName):gsub("\n$", "")
        if hinweis ~= "" then
            table.insert(karten, { art = "forever", id = "forever", einklappbar = true,
                titel = L("FOREVER_NOTES", "WoW Forever"), text = hinweis })
        end
    end

    if BSG_Karten and BSG_Karten.Zeige then
        BSG_Karten.KopfText = string.format("=== %s (%d/%d) ===\n", BSG_Berufe.Gross(BSG_Berufe.Anzeigename(berufsName)), spielerSkill, maxSkill)
        BSG_Karten.ZeigeKopf(kopf)
        BSG_Karten.Zeige(karten)
    end
end

-- FIX/NEU: War zuvor nur ein Stub, der bei nicht-leerer Eingabe gar nichts
-- getan hat. Durchsucht jetzt zuerst die Skill-Guide-Rezepte (BerufeGuideDB)
-- und springt bei einem Treffer zur passenden Skill-Stufe. Findet sich dort
-- nichts, wird zusätzlich in den Fundorte-Infos (BerufeFundorteDB) gesucht,
-- z.B. für seltene Boss-Drop-Rezepte wie "Feurige Waffe", die nicht im
-- normalen Herstell-Guide stehen.
-- NEU (v2.1): Übersetzt einen Suchbegriff in die jeweils andere Sprache.
--   1. Namensliste Daten_Suchnamen.lua (Rezepte, z.B. "Fiery Weapon")
--   2. Item-Datenbank Daten_Items.lua: gleiche Item-ID = gleicher Gegenstand
--      (z.B. "Linen Bandage" -> 1251 -> "Leinenverband")
-- Gibt eine Liste möglicher Übersetzungen zurück (kann leer sein).
local function UebersetzeSuche(suchTextKlein)
    local treffer, gesehen = {}, {}
    local function add(name)
        if name and not gesehen[name] then gesehen[name] = true; table.insert(treffer, name) end
    end
    -- 1. Exakte Namenspaare zuerst, dann Teilstring
    if BSG_Suchnamen then
        for durchgang = 1, 2 do
            for _, paar in ipairs(BSG_Suchnamen) do
                local de, en = paar[1]:lower(), paar[2]:lower()
                local passt = (durchgang == 1) and (de == suchTextKlein or en == suchTextKlein)
                    or (durchgang == 2) and (de:find(suchTextKlein, 1, true) or en:find(suchTextKlein, 1, true))
                if passt then add(paar[1]); add(paar[2]) end
            end
            if #treffer > 0 then
                -- Weiterreichen: alter Name -> englischer Name -> neuer deutscher
                -- Name (z.B. "Fläschchen der obersten Macht" -> "Flask of
                -- Supreme Power" -> "Fläschchen mit oberster Macht").
                local bekannt = {}
                for _, t in ipairs(treffer) do bekannt[t:lower()] = true end
                for _, paar in ipairs(BSG_Suchnamen) do
                    if bekannt[paar[1]:lower()] or bekannt[paar[2]:lower()] then add(paar[1]); add(paar[2]) end
                end
                return treffer
            end
        end
    end
    -- 2. Über die Item-ID
    if BSG_ItemDB then
        local ids = {}
        for name, id in pairs(BSG_ItemDB) do
            if type(id) == "number" and name:lower() == suchTextKlein then ids[id] = true end
        end
        for name, id in pairs(BSG_ItemDB) do
            if ids[id] and name:lower() ~= suchTextKlein then add(name) end
        end
    end
    return treffer
end

function BSG_Search.FuehreRezeptSucheAus(suchText, istUebersetzung)
    if not suchText or suchText == "" then
        BSG_Search.BerechneMaterialBedarf(letzterBeruf, letzterSkill)
        return
    end

    local suchTextKlein = suchText:lower()

    -- 1. Skill-Guide-Rezepte durchsuchen
    if BerufeGuideDB then
        for berufName, eintraege in pairs(BerufeGuideDB) do
            for _, eintrag in ipairs(eintraege) do
                if eintrag.item and eintrag.item:lower():find(suchTextKlein, 1, true) then
                    BSG_Search.BerechneMaterialBedarf(berufName, eintrag.minSkill)
                    return true
                end
            end
        end
    end

    -- 2. Nichts im Guide gefunden -> in den Fundorte-Infos suchen
    if BerufeFundorteDB then
        for rezeptName, info in pairs(BerufeFundorteDB) do
            -- FIX: Manche Einträge (z.B. "..._Zone"/"_X"/"_Y" für TomTom-
            -- Koordinaten) liegen als Zahlen in derselben Tabelle wie die
            -- Beschreibungstexte. Ohne "type(info) == string" konnte die
            -- Substring-Suche (abhängig von der pairs()-Reihenfolge) auf
            -- so einen Koordinaten-Key statt den echten Text-Eintrag
            -- treffen und zeigte dann nur eine nackte Zahl an.
            if type(rezeptName) == "string" and type(info) == "string" and rezeptName:lower():find(suchTextKlein, 1, true) then
                -- Koordinaten des Fundorts für den Wegpunkt-Button
                if BSG_Wegpunkt and BSG_Wegpunkt.LoescheZiel then BSG_Wegpunkt.LoescheZiel() end
                if BSG_Wegpunkt and BSG_Wegpunkt.SetzeZielAusFundort then
                    BSG_Wegpunkt.SetzeZielAusFundort(rezeptName)
                end
                if BSG_Karten and BSG_Karten.Zeige then
                    BSG_Karten.ZeigeKopf(nil, rezeptName)
                    BSG_Karten.KopfText = ""
                    BSG_Karten.Zeige({ { art = "rezept", titel = rezeptName, text = tostring(info),
                        wegpunkt = (BSG_Wegpunkt and BSG_Wegpunkt.Ziel) and true or nil } })
                end
                return true
            end
        end
    end

    -- 3. NEU (v2.1): Nichts gefunden -> in die andere Sprache übersetzen und
    -- erneut suchen (nur einmal, damit keine Endlosschleife entsteht).
    if not istUebersetzung then
        for _, alternative in ipairs(UebersetzeSuche(suchTextKlein)) do
            if alternative:lower() ~= suchTextKlein and BSG_Search.FuehreRezeptSucheAus(alternative, true) then
                return true
            end
        end
    end
    if istUebersetzung then return false end

    -- 4. Wirklich nichts gefunden
    -- FIX: Auch hier alte Icons ausblenden (das fehlte vorher komplett -
    -- Icons vom letzten erfolgreichen Rezept blieben sichtbar stehen).
    if BSG_MatIcons and BSG_MatIcons.InitialisiereIcon then BSG_MatIcons.InitialisiereIcon() end
    if BerufeSkillGuideFrame and BerufeSkillGuideFrame.infoTextDisplay then
        BerufeSkillGuideFrame.infoTextDisplay:SetText("|cffff5500" .. ((BSG_Locale and BSG_Locale.NO_RECIPE_FOUND) or "Kein Rezept gefunden für:") .. "|r " .. suchText)
    end
end

-- ============================================================================
-- NEU: LIVE-UPDATE BEI SKILL-AUFSTIEG (SKILL_LINES_CHANGED)
-- ============================================================================
-- FIX: Der Skill-Stand wurde bisher nur EINMAL beim Login gescannt
-- (InitialisiereMenue -> ScanneCharakterBerufe) bzw. beim Klick auf ein
-- Sidebar-Berufs-Icon neu ausgelesen. Stieg der Skill während des Spielens
-- durch Herstellen von Gegenständen (z.B. 18 -> 19), blieb die Anzeige im
-- Hauptfenster (Guide-Text UND das "Skill:"-Eingabefeld) auf dem alten Stand
-- stehen, bis man manuell erneut auf die Sidebar klickte - das Addon "zählte
-- beim Skillen nicht live mit". SKILL_LINES_CHANGED feuert zuverlässig bei
-- jeder Skillpunkt-Änderung (auch bei Berufen), inklusive Skill-Ups während
-- des Craftens. Wir nutzen das jetzt, um automatisch neu zu berechnen.
local function AktualisiereBeiSkillAenderung()
    local beruf = BerufeSkillGuideFrame and BerufeSkillGuideFrame.aktuellAusgewaehlterBeruf

    if not beruf then
        -- Noch kein Beruf angezeigt (z.B. ganz frischer Login) -> normalen
        -- Auto-Scan probieren, der sich den ersten unterstützten Beruf sucht.
        BSG_Search.ScanneCharakterBerufe()
        return
    end

    -- Holt den ECHTEN, aktuellen Skill für GENAU den gerade angezeigten
    -- Beruf (nicht erneut den ersten gefundenen wie ScanneCharakterBerufe -
    -- das würde einen per Sidebar-Klick/Suche manuell gewählten Beruf
    -- überschreiben, sobald irgendein anderer Beruf skillt).
    local aktuellerSkill = BSG_Compat.HoleBerufsSkill(beruf)

    if aktuellerSkill and aktuellerSkill ~= letzterSkill then
        BSG_Search.BerechneMaterialBedarf(beruf, aktuellerSkill)

        -- Spiegelt den neuen Skill auch im "Skill:"-Eingabefeld, damit es
        -- nicht den alten (jetzt falschen) Stand anzeigt.
        if BSG_Sidebar and BSG_Sidebar.SkillInputBox then
            BSG_Sidebar.SkillInputBox:SetText(aktuellerSkill)
        end
    end
end

local skillEventFrame = CreateFrame("Frame")
-- pcall-gesichert: Event-Listen unterscheiden sich zwischen Classic/Forever
BSG_Compat.RegisterEventSicher(skillEventFrame, "SKILL_LINES_CHANGED")
BSG_Compat.RegisterEventSicher(skillEventFrame, "TRADE_SKILL_LIST_UPDATE")
skillEventFrame:SetScript("OnEvent", AktualisiereBeiSkillAenderung)

-- NEU: Für den Spielversions-Umschalter (Spielversion.lua), damit nach dem
-- Umschalten derselbe Beruf/Skill mit den neuen Daten neu berechnet wird.
function BSG_Search.HoleLetztenStand()
    return letzterBeruf, letzterSkill
end

_G.BSG_Search = BSG_Search
