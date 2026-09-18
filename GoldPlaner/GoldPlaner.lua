-- ============================================================================
-- GOLD-PLANER MODUL V5.6 (BLIZZARD-AH-LIVESCAN + AUCTIONATOR + TSM-FALLBACK)
-- ============================================================================
-- NEU in V5.6: Auctionator wird jetzt als zusätzliche Preisquelle genutzt.
-- API: Auctionator.API.v1.GetAuctionPriceByItemLink(callerID, itemLink)
--   - Erwartet zwei Strings: einen Aufrufer-Namen und einen echten Item-Link
--     (NICHT nur den Item-Namen!). Wir holen den Link uns selbst über
--     GetItemInfo(matsName) - Rückgabewert 2 ist der itemLink (Rückgabewert
--     1 wäre der Name), analog zum bereits in MatIcons.lua verwendeten
--     Muster GetItemInfo(materialName).
--   - Liefert den Preis (in Kupfer) aus Auctionators EIGENER, dauerhaft
--     gespeicherter Preisdatenbank (SavedVariable AUCTIONATOR_PRICE_DATABASE)
--     zurück oder nil, wenn keine Daten vorhanden sind. Das Auktionshaus muss
--     dafür NICHT geöffnet sein - Auctionator synchronisiert seine Datenbank
--     bei jedem AH-Besuch im Hintergrund.
--   - Quelle: Auctionators eigene interne Fehlermeldung bei falscher Nutzung
--     ("Usage Auctionator.API.v1.GetAuctionPriceByItemLink(string, string)",
--     GitHub-Issue TheMouseNest/Auctionator #1209) sowie der Aufruf-Stil der
--     bereits bestätigten Schwester-Funktion GetVendorPriceByItemLink im
--     selben API-Namespace. Der genaue Rückgabewert (Zahl in Kupfer bei
--     Erfolg, nil sonst) folgt der Namenskonvention & dem Verhalten von
--     GetVendorPriceByItemLink und ist WoW-Addon-Konvention, aber nicht aus
--     dem Quellcode selbst einsehbar gewesen - bitte in der Praxis
--     gegenprüfen, falls sich das Verhalten anders zeigt.
--
-- Da Auctionator (anders als der reine Blizzard-Live-Scan) keine geöffnete
-- Auktionshaus-Ansicht braucht, wurde das bisherige harte "Auktionshaus
-- nicht geöffnet"-Abbruchschloss gelockert: Es blockiert jetzt nur noch
-- SCHRITT 1 (Blizzard-Live-Scan), nicht mehr die komplette Funktion.
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

function BSG_GoldPlaner.OeffnePlaner(matsName, anzahl)
    if not matsName or not anzahl then return end
    local korrigierterName = matsName:gsub("^%l", string.upper)

    -- SICHERHEITS-SCHLOSS (gelockert seit V5.6): Der reine Blizzard-Live-Scan
    -- (SCHRITT 1) braucht weiterhin ein offenes AH-Fenster, aber Auctionator
    -- und TSM lesen aus ihrer eigenen, dauerhaft gespeicherten Preisdatenbank
    -- und funktionieren AUCH ohne offenes Auktionshaus. Daher bricht die
    -- Funktion nicht mehr komplett ab, sondern überspringt nur SCHRITT 1.
    local auktionshausOffen = AuctionFrame and AuctionFrame:IsVisible()
    if not auktionshausOffen then
        print("|cffff5500[BSG-GoldPlaner]:|r |cff888888Auktionshaus nicht geöffnet - überspringe Live-Scan, nutze Auctionator/TSM-Preisdatenbank.|r")
    end

    local finalerPreis = 0
    local scanMethode = ""

    -- SCHRITT 1: Wir scannen das Blizzard-Standardfenster direkt auf deinem Bildschirm ab!
    if auktionshausOffen then
        local suchNameKlein = matsName:lower()
        local anzahlAuktionen = GetNumAuctionItems("browse")

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
    end

    -- SCHRITT 2: Auctionator-Preisdatenbank (funktioniert ohne offenes AH!).
    -- Wir brauchen dafür einen echten Item-Link statt nur den Namen - den
    -- holen wir uns über GetItemInfo (Rückgabewert 2 = itemLink), analog zum
    -- bereits in MatIcons.lua verwendeten GetItemInfo(materialName)-Muster.
    if finalerPreis == 0 and Auctionator and Auctionator.API and Auctionator.API.v1
       and Auctionator.API.v1.GetAuctionPriceByItemLink then
        local _, itemLink = GetItemInfo(matsName)
        if itemLink then
            -- pcall als Sicherheitsnetz: Auctionator wirft bei falscher
            -- Nutzung eigene Lua-Fehler statt nil zurückzugeben.
            local erfolg, auctionatorPreis = pcall(Auctionator.API.v1.GetAuctionPriceByItemLink, "BerufeSkillGuide", itemLink)
            if erfolg and auctionatorPreis and auctionatorPreis > 0 then
                finalerPreis = auctionatorPreis
                scanMethode = "|cff3fe1e8Auctionator-Preisdatenbank|r"
            end
        end
    end

    -- SCHRITT 3: Falls weiterhin nichts gefunden wurde, nutzen wir TSM als stabiles Sicherheitsnetz
    if finalerPreis == 0 then
        local itemID = nil
        if korrigierterName == "Maguskönigskraut" then itemID = 3821
        elseif korrigierterName == "Würgetang" then itemID = 3820
        elseif korrigierterName == "Leere Phiole" then itemID = 3371
        end

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
    
    local gesamtKupfer = finalerPreis * anzahl
    local formatiertEinzel = FormatierungsKupfer(finalerPreis)
    local formatiertGesamt = FormatierungsKupfer(gesamtKupfer)
    
    print(string.format("|cff00ff00[BSG-GoldPlaner]:|r Scan abgeschlossen für |cffffff00%s|r (Methode: %s):", korrigierterName, scanMethode))
    print(string.format("   • AH-Preis pro Stück: %s", formatiertEinzel))
    print(string.format("   • Gesamtkosten für %dx: %s 💰", anzahl, formatiertGesamt))
end
