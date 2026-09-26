-- ============================================================================
-- DATABASE: TRAINERS FOR FIRST AID & GATHERING (v2.1) - ENGLISH
-- ============================================================================
BerufeLehrerDB = BerufeLehrerDB or {}

if GetLocale() ~= "deDE" then
BerufeLehrerDB["Erste Hilfe"] = {
    { stufe = "Apprentice / Journeyman (1-125)",
      standorte = "Alliance: Shaina Fuller (Stormwind), Nissa Firestone (Ironforge), Dannelor (Darnassus)\nHorde: Arnok (Orgrimmar), Mary Edras (Undercity), Pand Stonebinder (Thunder Bluff)" },
    { stufe = "Expert (125-225)",
      standorte = "Buy the book 'Expert First Aid - Under Wraps' from a vendor:\nAlliance: Deneb Walker, Stromgarde Keep, Arathi Highlands (27.2, 58.8)\nHorde: Balai Lok'Wein, Brackenwall Village, Dustwallow Marsh (36.4, 30.4)\nAlso sold there: Manual: Heavy Silk Bandage + Manual: Mageweave Bandage",
      allianzZone = 1417, allianzX = 27.2, allianzY = 58.8,
      hordeZone = 1445, hordeX = 36.4, hordeY = 30.4 },
    { stufe = "Artisan (225-300)",
      standorte = "Quest 'Triage' (level 35+):\nAlliance: Doctor Gustaf VanHowzen, Theramore (Dustwallow Marsh)\nHorde: Doctor Gregory Victor, Hammerfall (Arathi Highlands)\nTalk to the First Aid trainer first (Ironforge / Orgrimmar)." },
}

local GATHER_TRAINER = "Trainers in every capital and many towns.\nLearn the next rank at skill 50 (Journeyman), 125 (Expert) and 200 (Artisan)."
BerufeLehrerDB["Bergbau"]      = { { stufe = "All ranks", standorte = GATHER_TRAINER } }
BerufeLehrerDB["Kräuterkunde"] = { { stufe = "All ranks", standorte = GATHER_TRAINER } }
BerufeLehrerDB["Kürschnerei"]  = { { stufe = "All ranks", standorte = GATHER_TRAINER } }
end
