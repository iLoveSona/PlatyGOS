--Spells, Summoner und Item Usage - PActivator

myHero = GetMyHero()
local summonerNameOne = GetCastName(myHero,SUMMONER_1)
local summonerNameTwo = GetCastName(myHero,SUMMONER_2)
local Heal = (summonerNameOne:lower():find("summonerheal") and SUMMONER_1 or (summonerNameTwo:lower():find("summonerheal") and SUMMONER_2 or nil))
local Barrier = (summonerNameOne:lower():find("summonerbarrier") and SUMMONER_1 or (summonerNameTwo:lower():find("summonerbarrier") and SUMMONER_2 or nil))
local Ghost = (summonerNameOne:lower():find("summonerhaste") and SUMMONER_1 or (summonerNameTwo:lower():find("summonerhaste") and SUMMONER_2 or nil))
local Cleanse = (summonerNameOne:lower():find("summonerboost") and SUMMONER_1 or (summonerNameTwo:lower():find("summonerboost") and SUMMONER_2 or nil))
local Teleport = (summonerNameOne:lower():find("summonerteleport") and SUMMONER_1 or (summonerNameTwo:lower():find("summonerteleport") and SUMMONER_2 or nil)) 
local Clarity = (summonerNameOne:lower():find("summonermana") and SUMMONER_1 or (summonerNameTwo:lower():find("summonermana") and SUMMONER_2 or nil))
local CV = (summonerNameOne:lower():find("summmonerclairvoyance") and SUMMONER_1 or (summonerNameTwo:lower():find("summmonerclairvoyance") and SUMMONER_2 or nil))
local ChillSmite = (summonerNameOne:lower():find("s5_summonersmiteplayerganker") and SUMMONER_1 or (summonerNameTwo:lower():find("s5_summonersmiteplayerganker") and SUMMONER_2 or nil))
local ChallengerSmite = (summonerNameOne:lower():find("s5_summonersmiteduel") and SUMMONER_1 or (summonerNameTwo:lower():find("s5_summonersmiteduel") and SUMMONER_2 or nil))
--local AoESmite = (summonerNameOne:lower():find("itemsmiteaoe") and SUMMONER_1 or (summonerNameTwo:lower():find("itemsmiteaoe") and SUMMONER_2 or nil))
--local UselessSmite = (summonerNameOne:lower():find("s5_summonersmitequick") and SUMMONER_1 or (summonerNameTwo:lower():find("s5_summonersmitequick") and SUMMONER_2 or nil))
local Snowball = (summonerNameOne:lower():find("summonersnowball") and SUMMONER_1 or (summonerNameTwo:lower():find("summonersnowball") and SUMMONER_2 or nil))

function Set(list)
	local set = {}
	for _, l in ipairs(list) do 
		set[l] = true 
	end
	return set
end

class "Activator"
function Activator:__init()
self.Danger = {
		["Annie"] = "InfernalGuardian",
		["Chogath"] = "Feast",
		["Darius"] = "DariusExecute",
		["Garen"] = "GarenR",
		["JarvanIV"] = "JarvanIVCataclysm",
		["LeeSin"] = "BlindMonkR",
		["Lissandra"] = "LissandraR",
		["Skarner"] = "SkarnerImpale",
		["Syndra"] = "SyndraR",
		["Talon"] = "TalonCuttthroat",
		["Veigar"] = "VeigarPrimordialBurst",
		["Vi"] = "ViR",
		["Volibear"] = "VolibearW",
		["Warwick"] = "infiniteduresschannel",
}
self.barrierDanger = {
		["Annie"] = "InfernalGuardian",
		["Brand"] = "BrandWildfireMissile",
		["Chogath"] = "Feast",
		["Darius"] = "DariusExecute",
		["Diana"] = "DianaTeleport",
		["Garen"] = "GarenR",
		["JarvanIV"] = "JarvanIVCataclysm",
		["LeeSin"] = "BlindMonkR",
		["Lissandra"] = "LissandraR",
		["Mordekaiser"] = "MordekaiserChildrenOfTheGrave",
		["Pantheon"] = "PantheonW",
		["Skarner"] = "SkarnerImpale",
		["Syndra"] = "SyndraR",
		["Talon"] = "TalonCuttthroat",
		["Veigar"] = "VeigarPrimordialBurst",
		["Vi"] = "ViR",
		["Volibear"] = "VolibearW",
		["Warwick"] = "infiniteduresschannel",
		["Zed"] = "zedult",
	}
self.exDanger = {
		["Annie"] = "InfernalGuardian",
		["Brand"] = "BrandWildfireMissile",
		["Cassiopeia"] = "CassiopeiaPetrifyingGaze",
		["Chogath"] = "Feast",
		["Darius"] = "DariusExecute",
		["Diana"] = "DianaTeleport",
		["Ekko"] = "EkkoR",
		["Evelynn"] = "EvelynnR", 
		["Fiddlesticks"] = "Crowstorm",
		["Fiora"] = "FioraR",
		["Fizz"] = "FizzMarinerDoom",
		["Garen"] = "GarenR",
		["Gnar"] = "GnarR",
		["Gragas"] = "GragasR",
		["Graves"] = "GravesChargeShot",
		["Hecarim"] = "HecarimUlt",
		["JarvanIV"] = "JarvanIVCataclysm",
		["Jax"] = "JaxRelentlessAssault",
		["Jinx"] = "JinxR",
		["Kalista"] = "KalistaExpungeWrapper",
		["Kassadin"] = "RiftWalk",
		["Leblanc"] = "LeblancSlide",
		["LeeSin"] = "BlindMonkR",
		["Lissandra"] = "LissandraR",
		["Lux"] = "LuxMaliceCannon",
		["Malphite"] = "UFSlash",
		["Malzahar"] = "AlZaharNetherGrasp",
		["MasterYi"] = "Highlander",
		["Mordekaiser"] = "MordekaiserChildrenOfTheGrave",
		["Morgana"] = "SoulShackles",
		["Nunu"] = "AbsoluteZero",
		["Orianna"] = "OrianaDetonateCommand",
		["Pantheon"] = "PantheonW",
		["Quinn"] = "QuinnRFinale",
		["Riven"] = "rivenizunablade",
		["Skarner"] = "SkarnerImpale",
		["Syndra"] = "SyndraR",
		["Talon"] = "TalonCuttthroat",
		["Tristana"] = "TristanaR",
		["Tryndamere"] = "UndyingRage",
		["Twitch"] = "TwitchSprayandPrayAttack",
		["Varus"] = "VarusR",
		["Veigar"] = "VeigarPrimordialBurst",
		["Velkoz"] = "VelkozR",
		["Vi"] = "ViR",
		["Viktor"] = "ViktorChaosStorm",
		["Vladimir"] = "VladimirHemoplague",
		["Volibear"] = "VolibearW",
		["Warwick"] = "infiniteduresschannel",
		["Yasuo"] = "YasuoRKnockUpComboW",
		["Zed"] = "zedult",
		["Ziggs"] = "ZiggsR",
		["Zyra"] = "ZyraBrambleZone"}
self.Interrupt = {
		["Caitlyn"] = {[_R] = true},
	    ["Katarina"] = {[_R] = true},
	    ["MasterYi"] = {[_W] = true},
	    ["FiddleSticks"] = {[_R] = true,  [_W]= true},
	    ["Galio"] = {[_R] = true},
	    ["Lucian"] = {[_R] = true},
	    ["MissFortune"] = {[_R] = true},
	    ["VelKoz"] = {[_R] = true},
	    ["Nunu"] = {[_R] = true},
	    ["Shen"] = {[_R] = true},
	    ["Karthus"] = {[_Q] = true, [_R] = true},
	    ["Malzahar"] = {[_R] = true},
	    ["Pantheon"] = {[_R] = true},
	    ["Warwick"] = {[_R] = true},
	    ["Xerath"] = {[_Q] = true, [_R]= true},
	    ["Varus"] = {[_Q] = true},
	    ["TahmKench"] = {[_R] = true},
	    ["TwistedFate"] = {[_R] = true},
	    ["Janna"] = {[_R] = true}}
self.MS = {
		["Lulu"] = {[_W] = true},
		["Sivir"] = {[_R] = true},
		["Zilean"] = {[_W] = true},
		}
self.CC = {
		["Aatrox"] = {[_Q] = true},
		["Ahri"] = {[_E] = true},
		["Alistar"] = {[_Q] = true, [_W] = true},
		["Amumu"] = {[_Q] = true},
		["Anivia"] = {[_W] = true},
		["Annie"] = {[_Q] = true, [_W] = true, [_R] = true},
		["Ashe"] = {[_R] = true}, 
		["Azir"] = {[_R] = true},
		["Bard"] = {[_Q] = true, [_R] = true},
		["Blitzcrank"] = {[_Q] = true, [_E] = true, [_R] = true},
		["Brand"] = {[_Q] = true},
		["Braum"] = {[_R] = true},
		["Cassiopeia"] = {[_R] = true},
		["Chogath"] = {[_Q] = true, [_W] = true},
		["Darius"] = {[_E] = true},
		["Diana"] = {[_E] = true},
		["Draven"] = {[_E] = true},
		["Ekko"] = {[_W] = true},
		["Elise"] = {[_E] = true},
		["Fiddlesticks"] = {[_Q] = true, [_E] = true},
		["Fizz"] = {[_R] = true},
		["Galio"] = {[_R] = true},
		["Garen"] = {[_Q] = true},
		["Gnar"] = {[_R] = true},
		["Gragas"] = {[_E] = true, [_R] = true},
		["Hecarim"] = {[_E] = true, [_R] = true},
		["Heimerdinger"] = {[_E] = true},
		["Irelia"] = {[_E] = true},
		["JannaQ"] = {[_Q] = true, [_R] = true},
		["JarvanIV"] = {[_Q] = true, [_E] = true},
		["Jax"] = {[_E] = true},
		["Jayce"] = {[_E] = true},
		["Jinx"] = {[_E] = true},
		["Kassadin"] = {[_Q] = true},
		["LeeSin"] = {[_R] = true},
		["Leona"] = {[_Q] = true, [_R] = true},
		["Lissandra"] = {[_R] = true},
		["Lulu"] = {[_W] = true, [_R] = true},
		["Malphite"] = {[_R] = true},
		["Maokai"] = {[_Q] = true},
		["Nami"] = {[_Q] = true, [_R] = true},
		["Nautilus"] = {[_Q] = true, [_R] = true},
		["Orianna"] = {[_R] = true},
		["Pantheon"] = {[_W] = true},
		["Poppy"] = {[_E] = true},
		["Rammus"] = {[_Q] = true, [_E] = true},
		["Reksai"] = {[_W] = true},
		["Renekton"] = {[_W] = true},
		["Riven"] = {[_W] = true},
		["Rumble"] = {[_R] = true},
		["Sejuani"] = {[_Q] = true, [_R] = true},
		["Shen"] = {[_E] = true},
		["Shyvana"] = {[_R] = true},
		["Singed"] = {[_E] = true},
		["Sion"] = {[_Q] = true, [_R] = true},
		["Skarner"] = {[_R] = true},
		["Sona"] = {[_R] = true},
		["Soraka"] = {[_W] = true},
		["Syndra"] = {[_E] = true},
		["TahmKench"] = {[_Q] = true, [_W] = true},
		["Tario"] = {[_E] = true},
		["Thresh"] = {[_Q] = true, [_E] = true},
		["Tristana"] = {[_R] = true},
		["Trundle"] = {[_E] = true},
		["TwistedFate"] = {[_W] = true},
		["Udyr"] = {[_E] = true},
		["Urgot"] = {[_R] = true},
		["Vayne"] = {[_E] = true},
		["Veigar"] = {[_W] = true, [_E] = true},
		["Velkoz"] = {[_E] = true},
		["Vi"] = {[_Q] = true, [_R] = true},
		["Viktor"] = {[_W] = true, [_R] = true},
		["Volibear"] = {[_Q] = true},
		["Warwick"] = {[_R] = true},
		["Wukong"] = {[_R] = true},
		["Xerath"] = {[_E] = true},
		["Xin"] = {[_R] = true},
		["Yasuo"] = {[_Q] = true},
		["Zac"] = {[_E] = true, [_R] = true},
		["Zyra"] = {[_R] = true},}
self.heal = {
		["Alistar"] = {[_E] = true},
		["Bard"] = {[_W] = true},
		["Lulu"] = {[_R] = true},
		["Galio"] = {[_W] = true},
		["Kayle"] = {[_W] = true},
		["Nami"] = {[_W] = true},
		["Sona"] = {[_W] = true},
		["Soraka"] = {[_R] = true},
		["Taric"] = {[_Q] = true}}
self.selfheal = {
		["Gankplank"] = {[_W] = true},
		["MasterYi"] = {[_W] = false},
		["Nunu"] = {[_Q] = true}}
self.allyheal = {
		["Soraka"] = {[_W] = true},
		}
self.shield = {
		["Galio"] = {[_W] = true},
		["Janna"] = {[_E] = true},
		["Karma"] = {[_E] = true},
		["Morgana"] = {[_E] = true},
		["Orianna"] = {[_E] = true},
		["Thresh"] = {[_W] = true},
		["Lux"] = {[_W] = true},
		["Shen"] = {[_R] = true},
		["Sona"] = {[_W] = true}}
self.selfshield = {
		["Diana"] = {[_W] = true},
		["Garen"] = {[_W] = true},
		["JarvanIV"] = {[_W] = true},
		["Riven"] = {[_E] = true},
		["Rumble"] = {[_W] = true},
		["Shen"] = {[_W] = true},
		["Sion"] = {[_W] = true},
		["Udyr"] = {[_W] = true},
		["Viktor"] = {[_Q] = true}}
self.invinc = {
		["Lissandra"] = {[_R] = true},
		["Kayle"] = {[_R] = true}}
self.selfinvinc = {
		["Ekko"] = {[_R] = false},
		["Fiora"] = {[_W] = true},
		["Fizz"] = {[_E] = true},
		["Shaco"] = {[_R] = true},
		["Tryndamere"] = {[_R] = true},
		["Vladimir"] = {[_W] = true}
		}
self.spellshield = {
		["Nocturne"] = {[_W] = true},
		["Riven"] = {[_W] = true},
		["Sivir"] = {[_E] = true}}
self.clean = {
		["Alistar"] = {[_R] = true},
		["Gankplank"] = {[_W] = true},
		["Olaf"] = {[_R] = true}}
self.type = Set{ 5, 24, 10, 7, 5, 6, 11, 18, 21, 22, 23, 25, 31}
self.itemsIDs = {
			[3007] = "DArch",
			[3003] = "Arch",
			[3060] = "BoC",
			[3144] = "Cutl",
			[2041] = "CFlask",
			[3137] = "DervishQSS",
			[2054] = "Snack",
			[2138] = "EIron",
			[2137] = "ERuin",
			[2139] = "ESorc",
			[2140] = "EWrath",
			[3401] = "FotM",
			[3184] = "Entropy",
			[3092] = "FQC",
			[3361] = "GST",
			[3362] = "GVT",
			[3159] = "GSL",
			[2051] = "GuardHorn",
			[2003] = "Hpot",
			[3146] = "HexTechGB",
			[3187] = "HSweeper1",
			[3348] = "HSweeper2",
			[2004] = "Mpot",
			[3139] = "BQSS",
			[3222] = "Mikaels",
			[3042] = "Muramana1",
			[3043] = "Muramana2",
			[3180] = "OdynsVeil",
			[3056] = "Ohmwrecker",
			[2047] = "Oracle",
			[2052] = "PoroSnax",
			[3140] = "QSS",
			[3089] = "Deathcap",
			[3143] = "Randuins",
			[3074] = "Ravenous Hydra",
			[3077] = "Tiamat",
			[3800] = "Glory",
			[3342] = "Scrying",
			[3040] = "Seraph1",
			[3048] = "Seraph2",
			[2049] = "Sightstone",
			[2044] = "Ward",
			[3341] = "Sweeper",
			[3069] = "ToA",
			[3073] = "DTear",
			[3070] = "Tear",
			[3185] = "Lightbringer",
			[3748] = "Titanic Hydra",
			[2009] = "Biscuit1",
			[2010] = "Biscuit2",
			[3023] = "TwinShadows",
			[3290] = "DTwinShadows",
			[2043] = "Pink",
			[3340] = "WardTrinket",
			[3090] = "Wooglets",
			[3154] = "WrigglesLantern",
			[3142] = "Yomumu",
			[3050] = "Zekes",
			[3157] = "Zhonyas",
			[3512] = "ZzRot",}
	OnTick(function() self:Tick() end)
	OnProcessSpell(function(unit, spell) self:ProcessSpell(unit, spell) end)
	if Exhaust ~= nil then OnProcessSpell(function(unit, spell) self:ProcessSpellExhaust(unit, spell) end) end
	if Barrier ~= nil then OnProcessSpell(function(unit, spell) self:ProcessSpellBarrier(unit, spell) end) end

	OnUpdateBuff(function(Object,BuffName,Stacks) self:UpdateBuff(Object, BuffName,Stacks) end)
 
	self.str = {[_Q] = "Q", [_W] = "W", [_E] = "E", [_R] = "R"}
	self.Config = MenuConfig("PlatyActivator", "PActivator")
	self.Config:Menu("Summoners", "Summoners")
		if Ignite ~= nil then
			self.Config.Summoners:Menu("Ignite", "Ignite")
			self.Config.Summoners.Ignite:Boolean("Ignite", "Use Ignite", true)
			self.Config.Summoners.Ignite:Boolean("IgniteSnipe", "Ignite Killsteal", true)
			self.Config.Summoners.Ignite:Boolean("AutoIgnite", "AutoIgnite when low enough", true)
		end
		if Exhaust ~= nil then
			self.Config.Summoners:Menu("Exhaust", "Exhaust")
			self.Config.Summoners.Exhaust:Boolean("Exhaust", "Use Exhaust", true)
				for i, enemy in pairs(GoS:GetEnemyHeroes()) do
					if self.exDanger[GetObjectName(enemy)] then
						self.Config.Summoners.Exhaust:Boolean(self.exDanger[GetObjectName(enemy)], "Use Exhaust on "..self.exDanger[GetObjectName(enemy)], true)
					end
				end
		end
		if Heal ~= nil then
			self.Config.Summoners:Menu("Heal", "Heal")
			self.Config.Summoners.Heal:Boolean("Heal", "Use Heal", true)
			self.Config.Summoners.Heal:Boolean("selfHeal", "Use Heal on selff", true)
			self.Config.Summoners.Heal:Boolean("otherHeal", "Use Heal on Ally", true)
			self.Config.Summoners.Heal:Slider("selfhp", "Max. Hp% to heal self", 20, 0, 100, 1)
			self.Config.Summoners.Heal:Slider("otherhp", "Max. Hp% to heal ally", 10, 0, 100, 1)
			self.Config.Summoners.Heal:Slider("enum", "Number of Enemies in *range*", 2, 1, 5, 1)
			self.Config.Summoners.Heal:Slider("erange", "*range*", 650, 0, 1500, 1)
		end
		if Barrier ~= nil then
			self.Config.Summoners:Menu("Barrier", "Barrier")
			self.Config.Summoners.Barrier:Boolean("Barrier", "Use Barrier", true)
			self.Config.Summoners.Barrier:Boolean("ShieldD", "Shield only Dangerous", true)
				for i, enemy in pairs(GoS:GetEnemyHeroes()) do
					if self.barrierDanger[GetObjectName(enemy)] then
						self.Config.Summoners.Barrier:Boolean(self.barrierDanger[GetObjectName(enemy)], "Use Barrier on "..self.barrierDanger[GetObjectName(enemy)], true)
					end
				end
			self.Config.Summoners.Barrier:Menu("nonD", "Only Applies if Dangerous is Off")
			self.Config.Summoners.Barrier.nonD:Slider("selfhp", "Max. Hp% to shield self", 50, 0, 100, 1)
			self.Config.Summoners.Barrier.nonD:Slider("enum", "Number of Enemies in *range*", 1, 1, 5, 1)
			self.Config.Summoners.Barrier.nonD:Slider("erange", "*range*", 650, 0, 1500, 1)
		end
		self.Config.Summoners:Menu("Cleanse", "Cleanse")
		self.Config.Summoners.Cleanse:Boolean("Cleanse", "Use Cleanse", true)
		self.Config.Summoners.Cleanse:Boolean("5", "Stun", true)
		self.Config.Summoners.Cleanse:Boolean("24", "Supress", true)
		self.Config.Summoners.Cleanse:Boolean("10", "Slow", false)
		self.Config.Summoners.Cleanse:Boolean("7", "Silence", false)
		self.Config.Summoners.Cleanse:Boolean("8", "Taunt", true)
		self.Config.Summoners.Cleanse:Boolean("6", "Polymorph", true)
		self.Config.Summoners.Cleanse:Boolean("11", "Snare", false)
		self.Config.Summoners.Cleanse:Boolean("18", "Sleep", false)
		self.Config.Summoners.Cleanse:Boolean("21", "Fear", false)
		self.Config.Summoners.Cleanse:Boolean("22", "Charm", true)
		self.Config.Summoners.Cleanse:Boolean("23", "Poison", false)
		self.Config.Summoners.Cleanse:Boolean("25", "Blind", false)
		self.Config.Summoners.Cleanse:Boolean("31", "Disarm", false)
		if Teleport ~= nil then
			self.Config.Summoners:Menu("Teleport", "Teleport")
			self.Config.Summoners.Teleport:Boolean("Teleport", "Use Teleport", true)
			self.Config.Summoners.Teleport:Slider("earound", "Dont TP if:Enemy near you", 1500, 0, 2500, 1)
			self.Config.Summoners.Teleport:Slider("erange", "Circle around Destination", 800, 0, 2000, 1)
			self.Config.Summoners.Teleport:Slider("atp", "Allies in Circle", 2, 0, 4, 1)
			self.Config.Summoners.Teleport:Slider("etp", "Enemies in Circle", 3, 1, 5, 1)
			self.Config.Summoners.Teleport:Slider("rangetp", "Max Distance away from ally", 500, 0, 1500, 1)
		end
		if Clarity ~= nil then
			self.Config.Summoners:Menu("Clarity", "Clarity")
			self.Config.Summoners.Clarity:Boolean("Clarity", "Use Clarity", true)
			self.Config.Summoners.Clarity:Boolean("sClarity", "Use Clarity on self", true)
			self.Config.Summoners.Clarity:Boolean("oClarity", "Use Clarity on others", true)
			self.Config.Summoners.Clarity:Slider("rClarity", "Enemy within X to cast", 1000, 0, 2000, 1)
		end
		if CV ~= nil then
			self.Config.Summoners:Menu("CV", "CV")
			self.Config.Summoners.CV:Info("cv", "Did you really pick CV?")
			self.Config.Summoners.CV:Info("cv2", "You need some PlatyBoost")
		end
		if ChillSmite ~= nil then
			self.Config.Summoners:Menu("ChillSmite", "ChillSmite")
			self.Config.Summoners.ChillSmite:Boolean("ChillSmite", "Use ChillSmite", true)
			self.Config.Summoners.ChillSmite:Boolean("ChillSnipe", "Killsteal", true)
			self.Config.Summoners.ChillSmite:Slider("Chillrange", "Range to Chill", GetRange(myHero), 0, 1000, 1)
		end
		
		if Snowball ~= nil then
			self.Config.Summoners:Boolean("Snowball", "Snowball", true)
		end

	self.Config:Menu("Items", "Items")
		self.Config.Items:Info("soon","Next Update")
		
	self.Config:Menu("Spells", "Spells")
		if self.heal[GetObjectName(myHero)] or self.selfheal[GetObjectName(myHero)] or self.allyheal[GetObjectName(myHero)] then
			self.Config.Spells:Menu("Heals", "Heals")
				self.Config.Spells.Heals:Slider("sHeal", "Heal Self below X%", 50, 0, 100, 1)
				self.Config.Spells.Heals:Slider("mHeal", "Min Mana to Heal", 40, 0, 100, 1)
				self.Config.Spells.Heals:Slider("oHeal", "Heal others below X%", 30, 0, 100, 1)
			if self.heal[GetObjectName(myHero)] then
				for k,heal in pairs(self.heal[GetObjectName(myHero)]) do
					self.Config.Spells.Heals:Boolean(self.str[k],"Use ".. self.str[k], heal)
				end
			end
			if self.selfheal[GetObjectName(myHero)] then
				for k,heal in pairs(self.selfheal[GetObjectName(myHero)]) do
					self.Config.Spells.Heals:Boolean(self.str[k],"Use ".. self.str[k], heal)
				end
			end
			if self.allyheal[GetObjectName(myHero)] then
				for k,heal in pairs(self.allyheal[GetObjectName(myHero)]) do
					self.Config.Spells.Heals:Boolean(self.str[k],"Use ".. self.str[k], heal)
				end
			end
		end

		if self.shield[GetObjectName(myHero)] or self.selfshield[GetObjectName(myHero)] then
			self.Config.Spells:Menu("Shield", "Shields")
			if self.shield[GetObjectName(myHero)] then
				for k,shield in pairs(self.shield[GetObjectName(myHero)]) do
					self.Config.Spells.Shield:Boolean(self.str[k],"Use ".. self.str[k], shield)
					OnProcessSpell(function(u,s) self:ProcessSpellShield(u, s, k) end)
				end
			end
			if self.selfshield[GetObjectName(myHero)] then
				for k,shield in pairs(self.selfshield[GetObjectName(myHero)]) do
					self.Config.Spells.Shield:Boolean(self.str[k],"Use ".. self.str[k], shield)
					OnProcessSpell(function(u,s) self:ProcessSpellShield(u, s, k, true) end)
				end
			end
		end

		if self.invinc[GetObjectName(myHero)] then
			self.Config.Spells:Menu("Invinc", "Invinc")
			for k,inv in pairs(self.invinc[GetObjectName(myHero)]) do
				self.Config.Spells.Invinc:Boolean(self.str[k],"Use ".. self.str[k], inv)
				OnProcessSpell(function(u,s) self:ProcessSpellInv(u, s, k) end)
			end
			for k,inv in pairs(self.selfinvinc[GetObjectName(myHero)]) do
				self.Config.Spells.Invinc:Boolean(self.str[k],"Use ".. self.str[k], inv)
				OnProcessSpell(function(u,s) self:ProcessSpellInv(u, s, k, true) end)
			end
		end

		if self.spellshield[GetObjectName(myHero)] then
			self.Config.Spells:Menu("Spellshield", "Spellshield")
			for k,inv in pairs(self.spellshield[GetObjectName(myHero)]) do
				self.Config.Spells.Spellshield:Boolean(self.str[k],"Use ".. self.str[k], inv)
				OnProcessSpell(function(u,s) self:ProcessSpellSpellShield(u, s, k) end)
			end
		end

		if self.clean[GetObjectName(myHero)] then
			self.Config.Spells:Menu("Clean", "Cleanse Effects")
			for k,inv in pairs(self.clean[GetObjectName(myHero)]) do
				self.Config.Spells.Clean:Boolean(self.str[k],"Use ".. self.str[k], inv)
			end
		end

	self.Config:Menu("Interrupt", "Interrupt")
	if self.CC[GetObjectName(myHero)] then
		for k, enemy in pairs(self.CC[GetObjectName(myHero)]) do
			for i, enemy in pairs(GoS:GetEnemyHeroes()) do 
				local ename = GetObjectName(enemy)
				if self.Interrupt[ename] then
					for j, spell in pairs(self.Interrupt[ename]) do
						self.Config.Interrupt:Boolean(""..k..ename..j, "Use "..self.str[k].." to interrupt "..ename.." "..self.str[j], spell and my)
					end
				end
			end
		end
	end
end

function Activator:Tick()
	self:Vars()
	if Clarity and self.Config.Summoners.Clarity.Clarity:Value() then
		self:UseMana()
	end
	if Ignite and self.Config.Summoners.Ignite.Ignite:Value() then
		self:UseIgnite()
	end
	if self.heal[GetObjectName(myHero)] then
		for k,heal in pairs(self.heal[GetObjectName(myHero)]) do
			if self.Config.Spells.Heals[self.str[k]]:Value() then
				self:Healing(k)
			end
		end
	end
	if self.selfheal[GetObjectName(myHero)] then
		for k,heal in pairs(self.selfheal[GetObjectName(myHero)]) do
			if self.Config.Spells.Heals[self.str[k]]:Value() then
				self:Healing(k)
			end
		end
	end
	if self.allyheal[GetObjectName(myHero)] then
		for k,heal in pairs(self.allyheal[GetObjectName(myHero)]) do
			if self.Config.Spells.Heals[self.str[k]]:Value() then
				self:Healing(k)
			end
		end
	end
end

function Activator:Healing(slot)
	local myhppc = 100*GetCurrentHP(myHero)/GetMaxHP(myHero)
	local mymanapc = 100*GetCurrentMana(myHero)/GetMaxMana(myHero)
	if self.Config.Spells.Heals.mHeal:Value() < mymanapc then
		if self.Config.Spells.Heals.sHeal:Value() > myhppc then
			CastTargetSpell(myHero, slot)
			CastSpell(slot)
		end
		for i, ally in pairs(GoS:GetAllyHeroes()) do 
			local allyhppc = 100*GetCurrentHP(ally)/GetMaxHP(myHero)
			if self.Config.Spells.Heals.oHeal:Value() > allyhppc then
				if GoS:IsInDistance(ally, GetCastRange(myHero,slot)) then
					CastTargetSpell(ally, slot)
					CastSpell(slot)
				elseif GetObjectName(myHero) == "Soraka" then
					CastSpell(slot)
				end
			end
		end
	end
end

function Activator:Vars()
	HeroPos = GetOrigin(myHero)
	selfhppc = (GetCurrentHP(myHero)/GetMaxHP(myHero))*100
end

function Activator:UseIgnite()
	local IDmg = function () return 40+20*GetLevel(myHero) end
	for i, enemy in pairs(GoS:GetEnemyHeroes()) do
	local enemyhp = GetCurrentHP(enemy) + GetDmgShield(enemy)
		if enemyhp + (GetHPRegen(enemy)*5) < IDmg() and self.Config.Summoners.Ignite.AutoIgnite:Value() then
			CastTargetSpell(enemy, Ignite)
		end
		if enemyhp + GetHPRegen(enemy) < IDmg()/10 and self.Config.Summoners.Ignite.IgniteSnipe:Value() then
			CastTargetSpell(enemy, Ignite)
		end
	end
end

function Activator:UseMana()
	for i, enemy in pairs(GoS:GetEnemyHeroes()) do
		if GoS:ValidTarget(enemy, self.Config.Summoners.Clarity.rClarity:Value()) then
			for k = 0,3 do
				if CanUseSpell(myHero,k) == NOMANA and self.Config.Summoners.Clarity.sClarity:Value() then
					CastSpell(Clarity)
				end
				if self.Config.Summoners.Clarity.oClarity:Value() then
					for i, ally in pairs(GoS:GetAllyHeroes()) do
						if CanUseSpell(ally,k) == NOMANA and not IsDead(ally) and GoS:IsInDistance(ally, 600) then
							CastSpell(Clarity)
						end
					end
				end
			end
		end
	end
end

function Activator:UseHeal()
	if self.Config.Summoers.Heal.Heal:Value() then
		if GoS:EnemiesAround(HeroPos, self.Config.Summoners.Heal.erange:Value()) > self.Config.Summoners.Heal.enum:Value() then
			if selfhppc < self.Config.Summoners.Heal.selfhp:Value() and self.Config.Summoners.Heal.selfHeal:Value() then
					CastSpell(Heal)
			end
			if self.Config.Summoners.Heal.otherHeal:Value() then
				for i, ally in pairs(GoS:GetAllyHeroes()) do
				local otherhppc = (GetCurrentHP(ally)/GetMaxHP(ally))*100
					if GoS:IsInDistance(ally, 840) and not IsDead(ally) and self.Config.Summoners.Heal.otherhp:Value() > otherhppc then
						CastSpell(Heal)
					end
				end
			end
		end
	end
end

function Activator:UseBarrier()
	if self.Config.Summoners.Barrier.Barrier:Value() then
		if self.Config.Summoners.Barrier.ShieldD:Value() then
			return
		else
			if GoS:EnemiesAround(HeroPos, self.Config.Summoners.Barrier.nonD.erange:Value()) > self.Config.Summoners.Barrier.nonD.enum:Value() then
				if selfhppc < self.Config.Summoners.Barrier.nonD.selfhp:Value() then
					CastSpell(Barrier)
				end
			end
		end
	end
end

function Activator:UseTeleport()
	if self.Config.Summoners.Teleport.Teleport:Value() then
		if GoS:EnemiesAround(HeroPos, self.Config.Summoners.Teleport.earound:Value()) >= 1 then
			for i, ally in pairs(GoS:GetAllyHeroes()) do
				local allyPos = GetOrigin(ally)
				local minion = GoS:ClosestMinion(allyPos, GetTeam(myHero))
				if GoS:EnemiesAround(allyPos, self.Config.Summoners.Teleport.erange:Value()) >= self.Config.Summoners.Teleport.etp:Value() and GoS:AlliesAround(allyPos, self.Config.Summoners.Teleport.erange:Value()) >= self.Config.Summoners.Teleport.atp:Value() then
					if GetDistance(minion, allyPos) < self.Config.Summoners.Teleport.rangetp:Value() then
						CastTargetSpell(minion, Teleport)
					end
				end
			end
		end
	end
end

function Activator:UseCV()
	if 1 == 2 then
		print("Deftsu likes CP ( ͡° ͜ʖ ͡°)")
	end
end

function Activator:UseChillSmite()
	for i, enemy in pairs(GoS:GetEnemyHeroes()) do 
		local enemyhp = GetCurrentHP(enemy) + GetDmgShield(enemy) + GetHPRegen(enemy)
		local smitedmg = 20 + 8*GetLevel(myHero)
		if ValidTarget(enemy, 500 + (GetHitBox(myHero)*0.5) + (GetHitBox(enemy)*0.5)) and enemyhp < smitedmg then
			CastTargetSpell(enemy, ChillSmite)
		end
	end
end

function Activator:UseSnowball(unit)
 	if GoS:ValidTarget(unit,1600) then
    	local SnowPred = GetPredictionForPlayer(myHeroPos,unit,GetMoveSpeed(unit), 1100, 0, 1600, 50, true, true)
    	if SnowPred.HitChance == 1 then
      		CastSkillShot(Snowball,SnowPred.PredPos.x,SnowPred.PredPos.y,SnowPred.PredPos.z)
    	end
  	end
end

function Activator:UseMana()
	for i, enemy in pairs(GoS:GetEnemyHeroes()) do
		if GoS:ValidTarget(enemy, self.Config.Summoners.Clarity.rClarity:Value()) then
			for k = 0,3 do
				if CanUseSpell(myHero,k) == NOMANA and self.Config.Summoners.Clarity.sClarity:Value() then
					CastSpell(Clarity)
				end
				if self.Config.Summoners.Clarity.oClarity:Value() then
					for i, ally in pairs(GoS:GetAllyHeroes()) do
						if CanUseSpell(ally,k) == NOMANA and GoS:IsInDistance(ally, 600) and not IsDead(ally) then
							CastSpell(Clarity)
						end
					end
				end
			end
		end
	end
end

function Activator:UpdateBuff(Object, Buff, Stacks)
	if Object and GetNetworkID(Object) == GetNetworkID(myHero) then
		if (self.type[Buff.Type] or Buff.Name == "zedultexecute" or Buff.Name == "summonerexhaust") and Buff.Count > 0 then
			if self.Config.Summoners.Cleanse.Cleanse:Value() and self.Config.Summoners.Cleanse[""..Buff.Type]:Value() then
				local slot = GetItemSlot(myHero, 3140) > 0 and GetItemSlot(myHero, 3140) or GetItemSlot(myHero, 3139) > 0 and GetItemSlot(myHero, 3139) or 0
				if slot > 0 and CanUseSpell(myHero, slot) == 0 then
					CastSpell(slot)
					return
				end
				if self.clean[GetObjectName] then
					for k,inv in pairs(self.clean[GetObjectName(myHero)]) do
						if self.Config.Spells.Clean[self.str[k]]:Value() and CanUseSpell(myHero,k) == READY then
							CastSpell(k)
							return
						end
					end
				end
				if Cleanse then
					CastSpell(Cleanse)
				end
			end
		end
	end
end

function Activator:ProcessSpellExhaust(unit, spell)
	if unit and GetTeam(unit) ~= GetTeam(myHero) and self.Config.Summoners.Exhaust.Exhaust:Value() then
		if self.exDanger[GetObjectName(unit)] == spell.name and self.Config.Summoners.Exhaust[spell.name]:Value() and GoS:GetDistance(unit) < 625 then
			CastTargetSpell(unit, Exhaust)
		end
	end
end
	
function Activator:ProcessSpellBarrier(unit, spell)
	if unit and GetTeam(unit) ~= GetTeam(myHero) and self.Config.Summoners.Barrier.Barrier:Value() then
		if self.barrierDanger[GetObjectName(unit)] == spell.name and self.Config.Summoners.Barrier[spell.name]:Value() then
			CastSpell(Barrier)
		end
	end
end

function Activator:ProcessSpellSpellShield(unit, spell, k)
	if unit and GetTeam(unit) ~= GetTeam(myHero) and self.Config.Spells.Spellshield[self.str[k]]:Value() then
		if spell.target and spell.target == myHero and self.barrierDanger[GetObjectName(unit)] == spell.name then
			GoS:DelayAction(function()
				CastSpell(k) 
			end, GetLatency())
		end
	end
end

function Activator:ProcessSpellShield(unit, spell, slot, selfcast)
	if unit and GetTeam(unit) ~= GetTeam(myHero) and self.Config.Spells.Shield[self.str[slot]]:Value() then
		if spell.target and GetObjectType(spell.target) == GetObjectType(myHero) and self.barrierDanger[GetObjectName(unit)] == spell.name then
			if selfcast then
				GoS:DelayAction(function()
					local pos = GetMousePos() 
					CastSkillShot(slot, pos.x, pos.y, pos.z) 
				end, GetLatency())
				CastSpell(slot)
			else
				CastTargetSpell(spell.target, slot)
			end
		end
	end
end

function Activator:ProcessSpellInv(unit, spell, slot, selfcast)
	if unit and GetTeam(unit) ~= GetTeam(myHero) and self.Config.Spells.Invinc[self.str[slot]]:Value() then
		if spell.target and GetObjectType(spell.target) == GetObjectType(myHero) and self.barrierDanger[GetObjectName(unit)] == spell.name then
			if selfcast then
				GoS:DelayAction(function()
					local pos = GetMousePos() 
					CastSkillShot(slot, pos.x, pos.y, pos.z) 
				end, GetLatency())
				CastSpell(slot)
			else
				CastTargetSpell(spell.target, slot)
			end
		end
	end
end

function Activator:ProcessSpell(unit, spell)
	if unit and spell and self.Interrupt[GetObjectName(unit)] then
		if self.CC[GetObjectName(myHero)] then
			for k, my in pairs(self.CC[GetObjectName(myHero)]) do
				if CanUseSpell(myHero, k) == 0 and GetCastRange(myHero, k) > GOs:GetDistance(unit) then
					for i = 0, 3 do
						if GetCastName(unit, i) == spell.name then
							if self.Config.Interrupt[""..k..GetObjectName(unit)..i] and self.Config.Interrupt[""..k..GetObjectName(unit)..i] then
								print(self.str[k])
								local pos = GetOrigin(unit)
								CastTargetSpell(unit, k)
								CastSkillShot(k, pos.x, pos.y, pos.z)
								CastSpell(k)
							end
						end
					end	
				end
			end
		end
	end
end



GoS:DelayAction(function() Activator() end, 250)
