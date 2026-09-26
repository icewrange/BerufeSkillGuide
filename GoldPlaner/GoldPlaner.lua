-- ============================================================================
-- GOLD-PLANER MODUL V5.5 (REINES REALTIME BLIZZARD-AH SCANSYSTEM)
-- ============================================================================
BSG_GoldPlaner = {}

BSG_GoldPlaner.AuktionshausOffen = false

local ahWatcher = CreateFrame("Frame")
ahWatcher:RegisterEvent("AUCTION_HOUSE_SHOW")
ahWatcher:RegisterEvent("AUCTION_HOUSE_CLOSED")
ahWatcher:SetScript("OnEvent", function(self, event)
    if event == "AUCTION_HOUSE_SHOW" then
        BSG_GoldPlaner.AuktionshausOffen = true
    elseif event == "AUCTION_HOUSE_CLOSED" then
        BSG_GoldPlaner.AuktionshausOffen = false
    end
end)

local function FormatierungsKupfer(gesamtKupfer)
    if not gesamtKupfer or gesamtKupfer <= 0 then return "|cff888888Keine Preisdaten|r" end
    local gold = math.floor(gesamtKupfer / 10000)
    local silber = math.floor((gesamtKupfer % 10000) / 100)
    local kupfer = gesamtKupfer % 100
    local ergebnis = ""
    if gold > 0 then ergebnis = ergebnis .. string.format("|cffffd100%dg|r ", gold) end
    if silber > 0 or gold > 0 then ergebnis = ergebnis .. string.format("|cffe6e6e6%ds|r ", silber) end
    ergebnis = ergebnis .. string.format("|cffc71305%dk|r", kupfer)
    return ergebnis
end

-- Sucht den günstigsten Stückpreis für ein Material: zuerst live im
-- geöffneten Blizzard-AH-Suchfenster, dann als Sicherheitsnetz über TSM
-- (falls installiert), zuletzt ein grober Notfall-Schätzwert. Gibt
-- (stueckPreisInKupfer, scanMethodeAlsText) zurück, oder (nil, nil) wenn
-- das Auktionshaus nicht geöffnet ist.
-- FIX/NEU: War zuvor direkt in OeffnePlaner eingebettet und konnte daher
-- nur für EIN Material auf einmal genutzt werden. Jetzt eigenständig, damit
-- auch BerechneGesamtkosten() (Scan mehrerer Materialien am Stück) dieselbe
-- Logik wiederverwenden kann.
local function ErmittleGuenstigstenPreis(matsName)
    -- Forever-kompatibel: altes (AuctionFrame) ODER neues AH (AuctionHouseFrame)
    if not BSG_Compat.IstAuktionshausOffen() then
        return nil, nil
    end

    local korrigierterName = matsName:gsub("^%l", string.upper)
    local finalerPreis = 0
    local scanMethode = ""

    -- SCHRITT 1: Wir scannen das Blizzard-Standardfenster direkt auf deinem Bildschirm ab!
    local suchNameKlein = matsName:lower()
    -- Nur das alte Classic-AH erlaubt das direkte Auslesen der Suchliste.
    -- In Forever (neues AH) wird direkt mit TSM/Fallback weitergemacht.
    local anzahlAuktionen = BSG_Compat.HatKlassischesAHBrowse() and GetNumAuctionItems("browse") or 0

    -- KUGELSICHERER NUMMERN-CHECK: Verhindert den alten "compare number with function" Fehler komplett!
    if type(anzahlAuktionen) == "number" and anzahlAuktionen > 0 then
        for i = 1, anzahlAuktionen do
            local name, _, count, _, _, _, _, _, _, buyoutPrice = GetAuctionItemInfo("browse", i)

            if name and name:lower():find(suchNameKlein) and buyoutPrice and buyoutPrice > 0 and count and count > 0 then
                local stueckPreis = math.floor(buyoutPrice / count)

                -- Da das AH nach Preis sortiert ist, ist der allererste Treffer mit Sofortkauf der billigste!
                if stueckPreis > 0 then
                    finalerPreis = stueckPreis
                    scanMethode = "|cff00ff00Echtzeit Blizzard-Live-Blick|r"
                    break -- Schleife sofort beenden, wir haben den Tiefstpreis!
                end
            end
        end
    end

    -- SCHRITT 2: Falls das Suchfenster komplett leer war, nutzen wir TSM als stabiles Sicherheitsnetz
    if finalerPreis == 0 then
        local itemID = (_G.BSG_ItemDB and _G.BSG_ItemDB[korrigierterName]) or nil

        if itemID and TSM_API then
            local tsmPreis = TSM_API.GetCustomPriceValue("DBMarket", "i:"..itemID)
            if tsmPreis and tsmPreis > 0 then
                finalerPreis = tsmPreis
                scanMethode = "|cff00ffffVollautomatischer TSM-Scan|r"
            end
        end
    end

    -- Letzter Rettungsanker
    if finalerPreis == 0 then
        finalerPreis = 19
        scanMethode = "|cff888888Addon-Notfall-Fallback|r"
    end

    return finalerPreis, scanMethode
end

function BSG_GoldPlaner.OeffnePlaner(matsName, anzahl)
    if not matsName or not anzahl then return end
    local korrigierterName = matsName:gsub("^%l", string.upper)

    local finalerPreis, scanMethode = ErmittleGuenstigstenPreis(matsName)

    -- SICHERHEITS-SCHLOSS: Rechnet nur live am offenen AH-Fenster
    if not finalerPreis then
        print("|cffff5500[BSG-GoldPlaner]:|r |cffff0000Auktionshaus nicht geöffnet!|r")
        print("|cff888888(Bitte sprich erst mit einem Auktionator, um die Live-Preise zu laden!)|r")
        return
    end

    local gesamtKupfer = finalerPreis * anzahl
    local formatiertEinzel = FormatierungsKupfer(finalerPreis)
    local formatiertGesamt = FormatierungsKupfer(gesamtKupfer)

    print(string.format("|cff00ff00[BSG-GoldPlaner]:|r Scan abgeschlossen für |cffffff00%s|r (Methode: %s):", korrigierterName, scanMethode))
    print(string.format("   • AH-Preis pro Stück: %s", formatiertEinzel))
    print(string.format("   • Gesamtkosten für %dx: %s 💰", anzahl, formatiertGesamt))
end

-- NEU: Berechnet die Gesamtkosten für ALLE Materialien, die der aktuell im
-- Guide-Fenster angezeigte Skill-Schritt noch benötigt (BSG_Search.
-- LetzteGesamtBedarf), statt wie OeffnePlaner nur für ein einzelnes
-- Material. Aufrufbar per Material-Icon-Klick (ein einzelnes Material)
-- oder komplett per "/bsg gold" (alle Materialien des aktuellen Schritts).
function BSG_GoldPlaner.BerechneGesamtkosten(materialienBedarf)
    if not materialienBedarf or not next(materialienBedarf) then
        print("|cffff5500[BSG-GoldPlaner]:|r Kein aktiver Guide-Schritt mit offenem Material-Bedarf gefunden.")
        return
    end

    if not BSG_Compat.IstAuktionshausOffen() then
        print("|cffff5500[BSG-GoldPlaner]:|r |cffff0000Auktionshaus nicht geöffnet!|r")
        print("|cff888888(Bitte sprich erst mit einem Auktionator, um die Live-Preise zu laden!)|r")
        return
    end

    print("|cff00ff00[BSG-GoldPlaner]:|r Gesamtkosten für den aktuellen Guide-Schritt:")

    local gesamtKupferAlle = 0
    local nichtGefunden = {}

    -- Sortiert nach Namen, damit die Ausgabe bei jedem Aufruf gleich bleibt.
    local namenSortiert = {}
    for name in pairs(materialienBedarf) do table.insert(namenSortiert, name) end
    table.sort(namenSortiert)

    for _, name in ipairs(namenSortiert) do
        local anzahl = materialienBedarf[name]
        local stueckPreis, scanMethode = ErmittleGuenstigstenPreis(name)

        if stueckPreis and stueckPreis > 0 and anzahl and anzahl > 0 then
            local gesamtKupfer = stueckPreis * anzahl
            gesamtKupferAlle = gesamtKupferAlle + gesamtKupfer
            print(string.format("   • %dx %s: %s (%s)", anzahl, name, FormatierungsKupfer(gesamtKupfer), scanMethode))
        else
            table.insert(nichtGefunden, name)
        end
    end

    if #nichtGefunden > 0 then
        print("|cff888888   Keine Preisdaten gefunden für: " .. table.concat(nichtGefunden, ", ") .. "|r")
    end

    print(string.format("|cffffd100Gesamt (alle Materialien):|r %s 💰", FormatierungsKupfer(gesamtKupferAlle)))
end
