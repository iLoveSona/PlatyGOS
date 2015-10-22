--PA:Metempsychosis

myHero = GetMyHero()
local summonerNameOne = GetCastName(myHero,SUMMONER_1)
local summonerNameTwo = GetCastName(myHero,SUMMONER_2)
local Flash = (summonerNameOne:lower():find("summonerflash") and SUMMONER_1 or (summonerNameTwo:lower():find("summonerflash") and SUMMONER_2 or nil))

class "Annie"
function Annie:__init()
	OnLoop(function(myHero) self:Loop(myHero) end)
 
	self.spellData = 
	{
	[_Q] = {dmg = function () return 45 + 35*GetCastLevel(myHero,_Q) + 0.8*GetBonusAP(myHero) end, range = 625, mana = function () return 55 + 5*GetCastLevel(myHero,_Q) end},
	[_W] = {dmg = function () return 25 + 45*GetCastLevel(myHero,_W) + 0.85*GetBonusAP(myHero) end , range = 625, mana = function () return 60 + 10*GetCastLevel(myHero,_W) end},
	[_E] = {dmg = function () return 10 + 10*GetCastLevel(myHero,_E) + 0.2*GetBonusAP(myHero) end , mana = 20 },
	[_R] = {dmg = function () return 50 + 125*GetCastLevel(myHero,_R) + 0.8*GetBonusAP(myHero) end, range = 600, radius = 250, mana = 100 },
	}

	self.Config = MenuConfig("PA:Metempsychosis Annie", "PAMannie")
		self.Config:Menu("Combo", "Combo")
			self.Config.Combo:Boolean("Q", "Use Q", true)
			self.Config.Combo:Boolean("W", "Use W", true)
			self.Config.Combo:Boolean("E", "Use E", true)
			self.Config.Combo:Boolean("R", "Use R", true)
			self.Config.Combo:DropDown("Rmode", "R Modus", 4, {"Instant", "Last in Combo", "Stun only", "Smart", "Killable only", "Never", "im trolling"})
			self.Config.Combo:Slider("Qmana", "Mana% for Q", 0, 0, 100, 1)
			self.Config.Combo:Slider("Wmana", "Mana% for W", 0, 0, 100, 1)
			self.Config.Combo:Slider("Emana", "Mana% for E", 0, 0, 100, 1)
			self.Config.Combo:Slider("Rmana", "Mana% for R", 0, 0, 100, 1)
		self.Config:Menu("Harass", "Harass")
			self.Config.Harass:Boolean("Q", "Use Q", true)
			self.Config.Harass:Boolean("W", "Use W", true)
			self.Config.Harass:Boolean("E", "Use E", true)
			self.Config.Harass:Slider("Qmana", "Mana% for Q", 50, 0, 100, 1)
			self.Config.Harass:Slider("Wmana", "Mana% for W", 50, 0, 100, 1)
			self.Config.Harass:Slider("Emana", "Mana% for E", 50, 0, 100, 1)
		self.Config:Menu("LastHit", "LastHit")
			self.Config.LastHit:Boolean("stun", "Farm with Stun", false)
			self.Config.LastHit:Boolean("Q", "Use Q", true)
			self.Config.LastHit:Boolean("W", "Use W", false)
			self.Config.LastHit:Slider("Qmana", "Mana% for Q", 10, 0, 100, 1)
			self.Config.LastHit:Slider("Wmana", "Mana% for W", 50, 0, 100, 1)
		self.Config:Menu("LaneClear", "LaneClear")
			self.Config.LaneClear:Boolean("stun", "Farm with Stun", false)
			self.Config.LaneClear:Boolean("Q", "Use Q", true)
			self.Config.LaneClear:Boolean("W", "Use W", true)
			self.Config.LaneClear:Slider("Whit", "Min. Hits for W", 1, 1, 13, 1)
			self.Config.LaneClear:Slider("Qmana", "Mana% for Q", 10, 0, 100, 1)
			self.Config.LaneClear:Slider("Wmana", "Mana% for W", 20, 0, 100, 1)
		self.Config:Menu("Misc", "Misc")
			self.Config.Misc:Boolean("autoQ","AutoLastHit with Q", false)
			self.Config.Misc:Boolean("as", "AutoE to Stack", false)
			self.Config.Misc:DropDown("autoult", "AutoUlt", 2, {"Always", "Stun Only"})
			self.Config.Misc:DropDown("numult", "Number of Targets", 3, {"1", "2", "3", "4", "5"})
			self.Config.Misc:SubMenu("ft", "FlashTibbers")
				self.Config.Misc.ft:Boolean("stun", "Only Flash with Stun", true)
				self.Config.Misc.ft:Slider("r", "Range to flash Tibbers", 1000, 600, 1100, 1)
				self.Config.Misc.ft:Slider("n", "Number of Enemies", 3, 1, 5, 1)
		self.Config:Menu("Killsteal", "Killsteal")
			self.Config.Killsteal:Boolean("Q", "Use Q", true)
			self.Config.Killsteal:Boolean("W", "Use W", true)
			self.Config.Killsteal:Boolean("R", "Use R", true)
			self.Config.Killsteal:Slider("Qmana", "Mana% for Q", 0, 0, 100, 1)
			self.Config.Killsteal:Slider("Wmana", "Mana% for W", 0, 0, 100, 1)
			self.Config.Killsteal:Slider("Rmana", "Mana% for R", 0, 0, 100, 1)
		self.Config:Menu("Draw", "Draws")
			self.Config.Draw:Boolean("Q", "Use Q", true)
				self.Config.Draw:Menu("qset","Q Settings")
					self.Config.Draw.qset:Slider("r", "Range Def:625", 625, 0, 800, 1)
					self.Config.Draw.qset:Slider("T", "Thickness", 0, 0, 30, 1)
					self.Config.Draw.qset:Slider("Q", "Quality", 0, 0, 128, 1)
					self.Config.Draw.qset:Slider("A", "Opacity", 180, 0, 255, 1)
					self.Config.Draw.qset:Slider("R", "Red", 255, 0, 255, 1)
					self.Config.Draw.qset:Slider("G", "Green", 255, 0, 255, 1)
					self.Config.Draw.qset:Slider("B", "Blue", 255, 0, 255, 1)
			self.Config.Draw:Boolean("W", "Use W", true)	
				self.Config.Draw:Menu("wset","W Settings")
					self.Config.Draw.wset:Slider("r", "Range Def:625", 625, 0, 800, 1)
					self.Config.Draw.wset:Slider("T", "Thickness", 0, 0, 30, 1)
					self.Config.Draw.wset:Slider("Q", "Quality", 0, 0, 128, 1)
					self.Config.Draw.wset:Slider("A", "Opacity", 180, 0, 255, 1)
					self.Config.Draw.wset:Slider("R", "Red", 255, 0, 255, 1)
					self.Config.Draw.wset:Slider("G", "Green", 255, 0, 255, 1)
					self.Config.Draw.wset:Slider("B", "Blue", 255, 0, 255, 1)
			self.Config.Draw:Boolean("E", "Use E", true)
				self.Config.Draw:Menu("eset","E Settings")
					self.Config.Draw.eset:Slider("r", "Range Def:150", 150, 0, 800, 1)
					self.Config.Draw.eset:Slider("T", "Thickness", 0, 0, 30, 1)
					self.Config.Draw.eset:Slider("Q", "Quality", 0, 0, 128, 1)
					self.Config.Draw.eset:Slider("A", "Opacity", 180, 0, 255, 1)
					self.Config.Draw.eset:Slider("R", "Red", 255, 0, 255, 1)
					self.Config.Draw.eset:Slider("G", "Green", 255, 0, 255, 1)
					self.Config.Draw.eset:Slider("B", "Blue", 255, 0, 255, 1)
			self.Config.Draw:Boolean("R", "Use R", true)
				self.Config.Draw:Menu("rset","R Settings")
					self.Config.Draw.rset:Slider("r", "Range Def:600", 600, 0, 800, 1)
					self.Config.Draw.rset:Slider("T", "Thickness", 0, 0, 30, 1)
					self.Config.Draw.rset:Slider("Q", "Quality", 0, 0, 128, 1)
					self.Config.Draw.rset:Slider("A", "Opacity", 180, 0, 255, 1)
					self.Config.Draw.rset:Slider("R", "Red", 255, 0, 255, 1)
					self.Config.Draw.rset:Slider("G", "Green", 255, 0, 255, 1)
					self.Config.Draw.rset:Slider("B", "Blue", 255, 0, 255, 1)
		self.Config:Menu("Keys", "Keys")
			self.Config.Keys:Key("Combo", "Combo", 32)
			self.Config.Keys:Key("Harass", "Harass", string.byte("C"))
			self.Config.Keys:Key("LaneClear", "LaneClear", string.byte("V"))
			self.Config.Keys:Key("LastHit", "LastHit", string.byte("X"))
			self.Config.Keys:Key("ft", "FlashTibbers", string.byte("T"))
end

function Annie:Draw()
	for i,s in pairs({"q","w","e","r"}) do
		DrawCircle(myHeroPos, self.Config.Draw[s.."set"].r:Value(), self.Config.Draw[s.."set"].T:Value(), self.Config.Draw[s.."set"].Q:Value(), ARGB(self.Config.Draw[s.."set"].A:Value(), self.Config.Draw[s.."set"].R:Value(), self.Config.Draw[s.."set"].G:Value(), self.Config.Draw[s.."set"].B:Value()))
	end

	local Qm = self.spellData[_Q].mana()
	local Wm = self.spellData[_W].mana()
	local Rm = self.spellData[_R].mana
	local Cm = GetCurrentMana(myHero)
	for i,enemy in pairs(GoS:GetEnemyHeroes()) do
		local Qdmg = GoS:CalcDamage(myHero, enemy, 0, (self.QREADY and Cm > Qm) and self.spellData[_Q].dmg() or 0)
		local Wdmg = GoS:CalcDamage(myHero, enemy, 0, (self.WREADY and Cm > Wm) and self.spellData[_W].dmg() or 0)
		local Rdmg = GoS:CalcDamage(myHero, enemy, 0, (self.RREADY and Cm > Rm and GetCastName(myHero,_R) == "InfernalGuardian") and self.spellData[_R].dmg() or 0)
		local dmg = Qdmg + Wdmg + Rdmg
		if GoS:ValidTarget(enemy, 2000) then
			DrawDmgOverHpBar(enemy, GetCurrentHP(enemy), 0, dmg, 0xffffffff)
		end
	end
end

function Annie:Loop(myHero)
		self:Checks()
		self:Draw()
		if self.Config.Keys.Combo:Value() then
			self:ComboPick()
		end
		if self.Config.Keys.Harass:Value() then
			self:HarassPick()
		end
		if self.Config.Keys.LastHit:Value() then
			self:LastHit()
		end
		if self.Config.Keys.LaneClear:Value() then
			self:LaneClear()
		end
		if self.Config.Keys.ft:Value() then
			self:AutoFlashUlt()
		end
		self:AutoUlt()
		self:AutoE()
		self:Killsteal()
		if self.Config.Misc.autoQ:Value() then
			self:LastHit()
		end
end

function Annie:Checks()
	self.QREADY = CanUseSpell(myHero,_Q) == READY
	self.WREADY = CanUseSpell(myHero,_W) == READY
	self.EREADY = CanUseSpell(myHero,_E) == READY
	self.RREADY = CanUseSpell(myHero,_R) == READY and GetCastName(myHero,_R) == "InfernalGuardian"
	if Ignite ~= nil then
	self.IREADY = CanUseSpell(myHero,Ignite) == READY
	end
	self.target = GoS:GetTarget(650, DAMAGE_MAGIC)
	self.targetPos = GetOrigin(self.target)
	myHeroPos = GetOrigin(myHero)
	self.manapc = GetCurrentMana(myHero)/GetMaxMana(myHero)*100
	self.StunUP = GotBuff(myHero,"pyromania_particle") == 1
end

 
function Annie:CastQ(unit)
	if self.QREADY and GoS:ValidTarget(unit, 625) then
		CastTargetSpell(unit,_Q)
	end
end

function Annie:CastW(unit)
	local upos = GetOrigin(unit)
	if self.WREADY and GoS:ValidTarget(unit, 615) then
		CastSkillShot(_W, upos.x, upos.y, upos.z)
	end
end

function Annie:CastE()
	if self.EREADY then
		CastSpell(_E)
	end
end

function Annie:CastR(unit)
	local upos = GetOrigin(unit)
	if self.RREADY then
		CastSkillShot(_R, upos.x, upos.y, upos.z)
	end
end

function Annie:RHandler(unit)
	if self.RREADY and GoS:ValidTarget(self.target,650) then
		if self.Config.Combo.Rmode:Value() == 1 then
			self:CastR(unit)
		elseif self.Config.Combo.Rmode:Value() == 2 then
			if not self.QREADY and not self.WREADY then
				self:CastR(unit)
			end
		elseif self.Config.Combo.Rmode:Value() == 3 or self.Config.Combo.Rmode:Value() == 4 then
			if self.StunUP then
				self:CastR(unit)
			end
		elseif self.Config.Combo.Rmode:Value() == 7 then
			if GoS:ValidTarget(unit, 650) then
				Rpred = GetPredictionForPlayer(myHero, unit, GetMoveSpeed(unit), math.huge, 5000, 600, 250, false, true)
				if Rpred.HitChance == 1 then
				CastSkillShot(_R, Rpred.PredPos.x, Rpred.PredPos.y, Rpred.PredPos.z)
				end
			end
			if GoS:ValidTarget(unit, 625) and self.WREADY then
				Wpred = GetPredictionForPlayer(myHero, self.target,GetMoveSpeed(unit) , math.huge, 5000, 625, 100, false, true)
				if Wpred.HitChance == 1 then
				CastSkillShot(_W, Wpred.PredPos.x, Wpred.PredPos.y, Wpred.PredPos.z)
				end
			end
		end
	end
end

function Annie:ComboPick()
	local stacks = GotBuff(myHero, "pyromania")
	if stacks == 0 or stacks == 1 then
		if self.RREADY and self.Config.Combo.Rmode:Value() == 1 and self.manapc > self.Config.Combo.Rmana:Value() and self.Config.Combo.R:Value() then
			self:RHandler(self.target)
		end
		if self.WREADY and self.manapc > self.Config.Combo.Wmana:Value() and self.Config.Combo.W:Value() then
			self:CastW(self.target)
		end
		if self.QREADY and self.manapc > self.Config.Combo.Qmana:Value() and self.Config.Combo.Q:Value() then
			self:CastQ(self.target)
		end
		if self.EREADY and self.manapc > self.Config.Combo.Emana:Value() and self.Config.Combo.E:Value() then
			self:CastE()
		end
		if self.RREADY and self.Config.Combo.Rmode:Value() == 2 and self.manapc > self.Config.Combo.Rmana:Value() and self.Config.Combo.R:Value() then
			self:RHandler(self.target)
		end
	elseif stacks == 2 then
		if self.RREADY and self.Config.Combo.Rmode:Value() == 1 and self.manapc > self.Config.Combo.Rmana:Value() and self.Config.Combo.R:Value() then
			self:RHandler(self.target)
		end
		if self.QREADY and self.manapc > self.Config.Combo.Qmana:Value() and self.Config.Combo.Q:Value() then
			self:CastQ(self.target)
		end
		if self.EREADY and self.manapc > self.Config.Combo.Emana:Value() and self.Config.Combo.E:Value() then
			self:CastE()
		end
		if self.WREADY and self.manapc > self.Config.Combo.Wmana:Value() and self.Config.Combo.W:Value() then
			self:CastW(self.target)
		end
		if self.RREADY and self.Config.Combo.Rmode:Value() == 2 and self.manapc > self.Config.Combo.Rmana:Value() and self.Config.Combo.R:Value() then
			self:RHandler(self.target)
		end
	elseif stacks == 3 then
		if self.RREADY and self.Config.Combo.Rmode:Value() == 1 and self.manapc > self.Config.Combo.Rmana:Value() and self.Config.Combo.R:Value() then
			self:RHandler(self.target)
		end
		if self.EREADY and self.manapc > self.Config.Combo.Emana:Value() and self.Config.Combo.E:Value() then
			self:CastE()
		end
		if self.QREADY and self.manapc > self.Config.Combo.Qmana:Value() and self.Config.Combo.Q:Value() then
			self:CastQ(self.target)
		end
		if self.WREADY and self.manapc > self.Config.Combo.Wmana:Value() and self.Config.Combo.W:Value() then
			self:CastW(self.target)
		end
		if self.RREADY and self.Config.Combo.Rmode:Value() == 2 and self.manapc > self.Config.Combo.Rmana:Value() and self.Config.Combo.R:Value() then
			self:RHandler(self.target)
		end
	elseif self.StunUP then
		if self.RREADY and self.Config.Combo.Rmode:Value() == 1 or self.Config.Combo.Rmode:Value() == 3 or self.Config.Combo.Rmode:Value() == 4 and self.manapc > self.Config.Combo.Rmana:Value() and self.Config.Combo.R:Value() then
			self:RHandler(self.target)
		end
		if self.WREADY and self.manapc > self.Config.Combo.Wmana:Value() and self.Config.Combo.W:Value() then
			self:CastW(self.target)
		end
		if self.QREADY and self.manapc > self.Config.Combo.Qmana:Value() and self.Config.Combo.Q:Value() then
			self:CastQ(self.target)
		end
		if self.RREADY and self.Config.Combo.Rmode:Value() == 2 and self.manapc > self.Config.Combo.Rmana:Value() and self.Config.Combo.R:Value() then
			self:RHandler(self.target)
		end
	end
end

function Annie:HarassPick()
	local stacks = GotBuff(myHero, "pyromania")
	if not self.StunUP and stacks ~= 3 then
		if self.WREADY and self.manapc > self.Config.Harass.Wmana:Value() and self.Config.Harass.W:Value() then
			self:CastW(self.target)
		end
		if self.QREADY and self.manapc > self.Config.Harass.Qmana:Value() and self.Config.Harass.Q:Value() then
			self:CastQ(self.target)
		end
	elseif stacks == 3 then
		if self.EREADY and self.manapc > self.Config.Harass.Emana:Value() and self.Config.Harass.E:Value() then
			self:CastE()
		end
		if self.QREADY and self.manapc > self.Config.Harass.Qmana:Value() and self.Config.Harass.Q:Value() then
			self:CastQ(self.target)
		end
		if self.WREADY and self.manapc > self.Config.Harass.Wmana:Value() and self.Config.Harass.W:Value() then
			self:CastW(self.target)
		end
	elseif self.StunUP then
		if self.WREADY and self.manapc > self.Config.Harass.Wmana:Value() and self.Config.Harass.W:Value() then
			self:CastW(self.target)
		end
		if self.QREADY and self.manapc > self.Config.Harass.Qmana:Value() and self.Config.Harass.Q:Value() then
			self:CastQ(self.target)
		end
	end
end

function Annie:AutoE()
	if self.Config.Misc.as:Value() and self.EREADY and not self.StunUP then
		self:CastE()
	end
end

function Annie:AutoUlt()
	for _, k in pairs(GoS:GetEnemyHeroes()) do
		if GoS:ValidTarget(k,625) then
			local e = CountObjectsNearPos(GetOrigin(k), self.spellData[_R].range, self.spellData[_R].radius - GetHitBox(k), GoS:GetEnemyHeroes())
			if e >= self.Config.Misc.numult:Value() then
				self:CastR(k)
				return;
			end
		end
	end
end

function Annie:AutoFlashUlt()
	MoveToXYZ(GetMousePos())
	if Flash and self.RREADY and (not self.Config.Misc.ft.stun:Value() or self.StunUP) then
		for _, k in pairs(GoS:GetEnemyHeroes()) do
			if GoS:ValidTarget(k,self.Config.Misc.ft.r:Value()) then
				local e = CountObjectsNearPos(GetOrigin(k), self.Config.Misc.ft.r:Value(), self.spellData[_R].radius - GetHitBox(k), GoS:GetEnemyHeroes())
				if e >= self.Config.Misc.ft.n:Value() then
					local pos = GetOrigin(k)
					CastSkillShot(Flash, pos.x, pos.y, pos.z)
					GoS:DelayAction(function() self:CastR(k) end, 0.25)
				end
			end
		end
	end
end

function Annie:LastHit()
	local Qm = self.spellData[_Q].mana()
	local Wm = self.spellData[_W].mana()
	local Rm = self.spellData[_R].mana
	local Cm = GetCurrentMana(myHero)
	for i,minion in pairs(GoS:GetAllMinions(MINION_ENEMY)) do
		local mhp = GetCurrentHP(minion)
		local Qdmg = GoS:CalcDamage(myHero, minion, 0, (self.QREADY and Cm > Qm and self.manapc > self.Config.LastHit.Qmana:Value() and self.Config.LastHit.Q:Value()) and self.spellData[_Q].dmg() or 0)
		local Wdmg = GoS:CalcDamage(myHero, minion, 0, (self.WREADY and Cm > Wm and self.manapc > self.Config.LastHit.Wmana:Value() and self.Config.LastHit.W:Value()) and self.spellData[_W].dmg() or 0)
		if self.Config.LastHit.stun:Value() or not self.StunUP then
			if GoS:ValidTarget(minion, 625) then
				if self.QREADY and mhp < Qdmg then
					self:CastQ(minion)
				elseif self.WREADY and mhp < Wdmg then
					self:CastW(minion)
				end
			end
		end
	end
end

function Annie:LaneClear()
	local Qm = self.spellData[_Q].mana()
	local Wm = self.spellData[_W].mana()
	local Rm = self.spellData[_R].mana
	local Cm = GetCurrentMana(myHero)
	for i,minion in pairs(GoS:GetAllMinions(MINION_ENEMY)) do
		local mhp = GetCurrentHP(minion)
		local Qdmg = GoS:CalcDamage(myHero, minion, 0, (self.QREADY and Cm > Qm and self.manapc > self.Config.LaneClear.Qmana:Value() and self.Config.LaneClear.Q:Value()) and self.spellData[_Q].dmg() or 0)
		if self.Config.LaneClear.stun:Value() or not self.StunUP then
			if GoS:ValidTarget(minion, 625) then
				if mhp < Qdmg then
					self:CastQ(minion)
					return;
				end
			end
		end
	end
	if self.manapc > self.Config.LaneClear.Wmana:Value() and self.Config.LaneClear.W:Value() then
		local pos, hit = GetFarmPosition(self.spellData[_R].range, self.spellData[_R].radius)
		if pos and hit and hit >= self.Config.LaneClear.Whit:Value() then
			CastSkillShot(_W, pos.x, pos.y, pos.z)
		end
	end
end

function GetFarmPosition(range, width)
  local BestPos 
  local BestHit = 0
  local objects = minionManager.objects
  for i, object in pairs(objects) do
  	if GetOrigin(object) ~= nil and IsObjectAlive(object) and GetTeam(object) ~= GetTeam(myHero) then
	  	local hit = CountObjectsNearPos(Vector(object), range, width, objects)
		if hit > BestHit and GoS:GetDistanceSqr(Vector(object)) < range * range then
		  BestHit = hit
		  BestPos = Vector(object)
		  if BestHit == #objects then
			break
		  end
		end
	end
  end
  return BestPos, BestHit
end

function CountObjectsNearPos(pos, range, radius, objects)
  local n = 0
  for i, object in pairs(objects) do
	if IsObjectAlive(object) and GoS:GetDistanceSqr(pos, Vector(object)) <= radius^2 then
	  n = n + 1
	end
  end
  return n
end

function Annie:Killsteal()
	local Qm = self.spellData[_Q].mana()
	local Wm = self.spellData[_W].mana()
	local Rm = self.spellData[_R].mana
	local Cm = GetCurrentMana(myHero)
	for i,enemy in pairs(GoS:GetEnemyHeroes()) do
		local Qdmg = GoS:CalcDamage(myHero, enemy, 0, (self.QREADY and Cm > Qm and self.manapc > self.Config.Killsteal.Qmana:Value() and self.Config.Killsteal.Q:Value()) and self.spellData[_Q].dmg() or 0)
		local Wdmg = GoS:CalcDamage(myHero, enemy, 0, (self.WREADY and Cm > Wm and self.manapc > self.Config.Killsteal.Wmana:Value() and self.Config.Killsteal.W:Value()) and self.spellData[_W].dmg() or 0)
		local Rdmg = GoS:CalcDamage(myHero, enemy, 0, (self.RREADY and Cm > Rm and self.manapc > self.Config.Killsteal.Rmana:Value() and self.Config.Killsteal.R:Value() and GetCastName(myHero,_R) == "InfernalGuardian") and self.spellData[_R].dmg() or 0)
		local dmg = Qdmg + Wdmg + Rdmg
		local enemyhp = GetCurrentHP(enemy) + GetDmgShield(enemy) + GetMagicShield(enemy)
		local Qok = self.Config.Killsteal.Q:Value()
		local Wok = self.Config.Killsteal.W:Value()
		local Rok = self.Config.Killsteal.R:Value()
		if GoS:ValidTarget(enemy, 625) and enemyhp < Wdmg and Wok then
			self:CastW(enemy)
		elseif GoS:ValidTarget(enemy, 625) and enemyhp < Qdmg and Qok then
			self:CastQ(enemy)
		elseif GoS:ValidTarget(enemy, 700) and enemyhp < Rdmg and Rok then
			self:CastR(enemy)
		elseif GoS:ValidTarget(enemy, 625) and enemyhp < Qdmg + Wdmg and self.QREADY and self.WREADY and Qok and Wok and Cm > Qm + Wm then 
			self:CastQ(enemy) GoS:DelayAction(function() self:CastW(enemy) end, 250) 
		elseif GoS:ValidTarget(enemy, 625) and enemyhp < Qdmg + Rdmg and self.QREADY and self.RREADY and Qok and Rok and Cm > Qm + Rm then 
			self:CastQ(enemy) GoS:DelayAction(function() self:CastR(enemy) end, 250)
		elseif GoS:ValidTarget(enemy, 625) and enemyhp < Rdmg + Wdmg and self.RREADY and self.WREADY and Rok and Wok and Cm > Rm + Wm then 
			self:CastW(enemy) GoS:DelayAction(function() self:CastR(enemy) end, 250)
		elseif GoS:ValidTarget(enemy, 625) and enemyhp < Qdmg + Wdmg + Rdmg and self.QREADY and self.WREADY and self.RREADY and Qok and Wok and Rok and Cm > Qm + Wm + Rm then
			self:CastQ(enemy) GoS:DelayAction(function() self:CastW(enemy) GoS:DelayAction(function() self:CastR(enemy) end, 250) end, 250) 
		end 
	end
end





------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
---------------------------------------------------------------------------------------------------------------Kalista-----------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------





class "Kalista"
function Kalista:__init()
	OnLoop(function(myHero) self:Loop(myHero) end)
 	
	bond = nil
	self.spellData = 
	{
	[_Q] = {dmg = function () return 30 + 30*GetCastLevel(myHero,_Q) + 0.2*(GetBonusDmg(myHero) + GetBaseDamage(myHero)) end, range = 1150, speed = 2000, mana = function () return 45 + 5*GetCastLevel(myHero,_Q) end},
	[_W] = {mana = 25},
	[_E] = {range = 1000, mana = 40 },
	[_R] = {range = 1400, mana = 100},
	}

	self.Config = MenuConfig("PA:Metempsychosis Kalista", "PAMkalista")
		self.Config:Menu("Combo", "Combo")
			self.Config.Combo:Boolean("Q", "Use Q", true)
			self.Config.Combo:Boolean("E", "Use E", true)
			self.Config.Combo:Slider("Qmana", "Mana% for Q", 0, 0, 100, 1)
			self.Config.Combo:Slider("Emana", "Mana% for E", 0, 0, 100, 1)
		self.Config:Menu("Harass", "Harass")
			self.Config.Harass:Boolean("Q", "Use Q", true)
			self.Config.Harass:Boolean("E", "Use E", true)
			self.Config.Harass:Slider("Qmana", "Mana% for Q", 50, 0, 100, 1)
			self.Config.Harass:Slider("Emana", "Mana% for E", 50, 0, 100, 1)
		self.Config:Menu("LastHit", "LastHit")
			self.Config.LastHit:Boolean("Q", "Use Q", true)
			self.Config.LastHit:Boolean("E", "Use E", true)
			self.Config.LastHit:Slider("Qmana", "Mana% for Q", 30, 0, 100, 1)
			self.Config.LastHit:Slider("Emana", "Mana% for E", 10, 0, 100, 1)
		self.Config:Menu("LaneClear", "LaneClear")
			self.Config.LaneClear:Boolean("Q", "Use Q", true)
			self.Config.LaneClear:Boolean("E", "Use E", true)
			self.Config.LaneClear:Slider("Qmana", "Mana% for Q", 10, 0, 100, 1)
			self.Config.LaneClear:Slider("Emana", "Mana% for E", 20, 0, 100, 1)
		self.Config:Menu("JungleClear", "JungleClear")
			self.Config.JungleClear:Boolean("c","JungleClear", true)
			self.Config.JungleClear:Boolean("SRU_Dragon", "Dragon", true)
			self.Config.JungleClear:Boolean("SRU_Baron", "Baron", true)
			self.Config.JungleClear:Boolean("SRU_Red","Red", true)
			self.Config.JungleClear:Boolean("SRU_Blue","Blue", true)
			self.Config.JungleClear:Boolean("Sru_Crab","ScuttleCrab", true)
			self.Config.JungleClear:Boolean("SRU_Krug","Krug", true)
			self.Config.JungleClear:Boolean("SRU_Razorbeak","Chickens", true)
			self.Config.JungleClear:Boolean("SRU_Murkwolf","Wolfs", true)
			self.Config.JungleClear:Boolean("SRU_Gromp","Fat Frog", true)
		self.Config:Menu("Misc", "Misc")
			self.Config.Misc:Boolean("asave", "AutoUlt to save", true)
			self.Config.Misc:Boolean("balli", "Blitzcrank + Kalista", true)
			self.Config.Misc:Boolean("talli", "Tahm + Kalista", true)
			self.Config.Misc:Boolean("skalli", "Skarner + Kalista", true)
			self.Config.Misc:Boolean("exMinions", "E Reset on Minions", true)
			self.Config.Misc:Slider("exnum", "Min. Number of Minions to E", 1, 0, 4, 1)
		self.Config:Menu("Killsteal", "Killsteal")
			self.Config.Killsteal:Boolean("Q", "Use Q", true)
			self.Config.Killsteal:Boolean("E", "Use E", true)
			self.Config.Killsteal:Slider("Qmana", "Mana% for Q", 0, 0, 100, 1)
			self.Config.Killsteal:Slider("Emana", "Mana% for E", 0, 0, 100, 1)
		self.Config:Menu("Draw", "Draws")
			self.Config.Draw:Boolean("q", "Draw Q", true)
				self.Config.Draw:Menu("qset","Q Settings")
					self.Config.Draw.qset:Slider("r", "Range Def:1150", 1150, 0, 1000, 1)
					self.Config.Draw.qset:Slider("T", "Thickness", 0, 0, 30, 1)
					self.Config.Draw.qset:Slider("Q", "Quality", 0, 0, 128, 1)
					self.Config.Draw.qset:Slider("A", "Opacity", 180, 0, 255, 1)
					self.Config.Draw.qset:Slider("R", "Red", 255, 0, 255, 1)
					self.Config.Draw.qset:Slider("G", "Green", 255, 0, 255, 1)
					self.Config.Draw.qset:Slider("B", "Blue", 255, 0, 255, 1)
			self.Config.Draw:Boolean("e", "Draw E", true)
				self.Config.Draw:Menu("eset","E Settings")
					self.Config.Draw.eset:Slider("r", "Range Def:1050", 1050, 0, 800, 1)
					self.Config.Draw.eset:Slider("T", "Thickness", 0, 0, 30, 1)
					self.Config.Draw.eset:Slider("Q", "Quality", 0, 0, 128, 1)
					self.Config.Draw.eset:Slider("A", "Opacity", 180, 0, 255, 1)
					self.Config.Draw.eset:Slider("R", "Red", 255, 0, 255, 1)
					self.Config.Draw.eset:Slider("G", "Green", 255, 0, 255, 1)
					self.Config.Draw.eset:Slider("B", "Blue", 255, 0, 255, 1)
			self.Config.Draw:Boolean("r", "Draw R", true)
				self.Config.Draw:Menu("rset","R Settings")
					self.Config.Draw.rset:Slider("r", "Range Def:1400", 1400, 0, 800, 1)
					self.Config.Draw.rset:Slider("T", "Thickness", 0, 0, 30, 1)
					self.Config.Draw.rset:Slider("Q", "Quality", 0, 0, 128, 1)
					self.Config.Draw.rset:Slider("A", "Opacity", 180, 0, 255, 1)
					self.Config.Draw.rset:Slider("R", "Red", 255, 0, 255, 1)
					self.Config.Draw.rset:Slider("G", "Green", 255, 0, 255, 1)
					self.Config.Draw.rset:Slider("B", "Blue", 255, 0, 255, 1)
		self.Config:Menu("Keys", "Keys")
			self.Config.Keys:Key("Combo", "Combo", 32)
			self.Config.Keys:Key("Harass", "Harass", string.byte("C"))
			self.Config.Keys:Key("LaneClear", "LaneClear", string.byte("V"))
			self.Config.Keys:Key("LastHit", "LastHit", string.byte("X"))
end

function Kalista:Draw()
	for i,s in pairs({"q","e","r"}) do
		if self.Config.Draw[s]:Value() then
			DrawCircle(myHeroPos, self.Config.Draw[s.."set"].r:Value(), self.Config.Draw[s.."set"].T:Value(), self.Config.Draw[s.."set"].Q:Value(), ARGB(self.Config.Draw[s.."set"].A:Value(), self.Config.Draw[s.."set"].R:Value(), self.Config.Draw[s.."set"].G:Value(), self.Config.Draw[s.."set"].B:Value()))
		end
	end

	local AD = GetBonusDmg(myHero)+GetBaseDamage(myHero)
	local Qm = self.spellData[_Q].mana()
	local Em = self.spellData[_E].mana
	local Cm = GetCurrentMana(myHero)
	for i,enemy in pairs(GoS:GetEnemyHeroes()) do
		local hp = GetCurrentHP(enemy)
		local Qdmg = GoS:CalcDamage(myHero, enemy, (self.QREADY and Cm > Qm) and self.spellData[_Q].dmg() or 0, 0)
		local Edmg = ((self.EREADY and Cm > Em) and self:GetEDamage(enemy, 0)) or 0
		local dmg = Qdmg + Edmg
		local enemyPos = GetOrigin(enemy)
		local drawPos = WorldToScreen(1, enemyPos.x, enemyPos.y, enemyPos.z)
		if GoS:ValidTarget(enemy, 2000) then
			DrawDmgOverHpBar(enemy, GetCurrentHP(enemy), dmg, 0, 0xffffffff)
		end
	  	if Edmg > 0 then 
	   		DrawText(math.floor(Edmg/hp*100).."%",20,drawPos.x,drawPos.y,0xffffffff)
		end
	end
end

function Kalista:GetEDamage(unit, extraStack)
	local unithp = GetCurrentHP(unit)
	local stack = GetBuffData(unit,"kalistaexpungemarker")
	local dmgstack = (stack.Count-1)+extraStack
	local AD = GetBonusDmg(myHero)+GetBaseDamage(myHero)
	local initEdmg = (stack.Count >= 1 and 10+10*GetCastLevel(myHero, _E) + 0.6*AD) or 0
	local addEdmg = (stack.Count >= 2 and Kalista:ReturnAddE()*dmgstack) or 0
	local dmg = GoS:CalcDamage(myHero, unit, initEdmg + addEdmg, 0)
		return dmg
end

function Kalista:ReturnAddE()
	local level = GetCastLevel(myHero, _E)
	local AD = GetBonusDmg(myHero)+GetBaseDamage(myHero)
	if level == 0 then
		dmg = 0
	elseif level == 1 then
		dmg = 10 + 0.2*AD
	elseif level == 2 then
		dmg = 14 + 0.225*AD
	elseif level == 3 then
		dmg = 19 + 0.25*AD
	elseif level == 4 then
		dmg = 25 + 0.275*AD
	elseif level == 5 then
		dmg = 32 + 0.30*AD
	end
	return dmg
end

function Kalista:Loop(myHero)
		self:Checks()
		self:Draw()
		if self.Config.Keys.Combo:Value() then
			self:Combo()
		end
		if self.Config.Keys.Harass:Value() then
			self:Harass()
		end
		if self.Config.Keys.LastHit:Value() then
			self:LastHit()
		end
		if self.Config.Keys.LaneClear:Value() then
			self:LaneClear()
		end
		self:Killsteal()
		self:UltCombos()
		self:JungleClear()
		self:GetEMinions()
end

function Kalista:Checks()
	self.QREADY = CanUseSpell(myHero,_Q) == READY
	self.WREADY = CanUseSpell(myHero,_W) == READY
	self.EREADY = CanUseSpell(myHero,_E) == READY
	self.RREADY = CanUseSpell(myHero,_R) == READY
	self.target = GoS:GetTarget(600, DAMAGE_PHYSICAL)
	self.qtarget = GoS:GetTarget(1200, DAMAGE_PHYSICAL)
	self.targetPos = GetOrigin(self.target)
	self.qtargetPos = GetOrigin(self.qtarget)
	myHeroPos = GetOrigin(myHero)
	self.manapc = GetCurrentMana(myHero)/GetMaxMana(myHero)*100
end

function Kalista:UltCombos()
	if self.RREADY then
		local mate = nil
		for i, ally in pairs(GoS:GetAllyHeroes()) do
			if GotBuff(ally, "kalistacoopstrikeally") >= 1 then
				mate = ally
				if (GetMaxHP(ally)/GetCurrentHP(ally)*100) < 15 and GoS:EnemiesAround(GetOrigin(ally), 2000) and self.Config.Misc.asave:Value() then
					CastSpell(_R)
				end
			end
		end
		if mate then
			local ally = mate
			for i, enemy in pairs(GoS:GetEnemyHeroes()) do 
				if GetObjectName(ally) == "Blitzcrank" then
					if GotBuff(enemy, "rocketgrab2") >= 1 and GoS:GetDistance(enemy) < 2500 and GoS:GetDistance(ally, enemy) > 300 and GoS:GetDistance(ally, myHero) > 500 then
						local blitzAP = GetBonusAP(ally)
						local Qdmg = 25 + 55*GetCastLevel(ally, _Q) + blitzAP
						local Edmg = (GetBonusDmg(ally) + GetBaseDamage(ally))*2
						local Rdmg = 125 + 125*GetCastLevel(ally, _R) + blitzAP
						local blitzDMG = GoS:CalcDamage(ally, enemy, Edmg, Rdmg+Qdmg)
						local enemyhp = GetCurrentHP(enemy)
						if blitzDMG < enemyhp then
								CastSpell(_R)
						end
		   	 		end
				elseif GetObjectName(ally) == "Skarner" then
					if GotBuff(enemy,"SkarnerImpale") >= 1 and GoS:GetDistance(enemy) < 2000 and GoS:GetDistance(ally, myHero) > 300 then
						CastSpell(_R)
					end
				elseif GetObjectName(ally) == "TahmKench" then
					if GotBuff(enemy, "tahmkenchwdevoured") >= 1 and GoS:GetDistance(enemy) < 2000 and GoS:GetDistance(ally, myHero) > 500 then
						local Wdmg = GoS:CalcDamage(ally, enemy, 0, GetMaxHP(enemy)*(0.17+(0.03*GetCastLevel(ally, _W)) + 0.02*GetBonusAP(ally)))
						local enemyhp = GetCurrentHP(enemy)
						if Wdmg < enemyhp+100 then
							CastSpell(_R)
						end
					end	
				end
			end
 		end
	end
end

function Kalista:CastQ(unit)
	if GoS:ValidTarget(unit, 1200) then
		local Qpred = GetPredictionForPlayer(myHeroPos, unit, GetMoveSpeed(unit), 2000, 250, 1125 + GetHitBox(unit), 70, true, true)
		if Qpred.HitChance == 1 then
			CastSkillShot(_Q, Qpred.PredPos.x, Qpred.PredPos.y, Qpred.PredPos.z)
		end
	end
end

function Kalista:Combo()
	if self.target == nil then
		if self.QREADY and GoS:ValidTarget(self.qtarget, 1200) and self.Config.Combo.Q:Value() and self.manapc > self.Config.Combo.Qmana:Value() then
			self:CastQ(self.qtarget)
		end
	else
		if self.QREADY and GoS:ValidTarget(self.target, 600) and self.Config.Combo.Q:Value() and self.manapc > self.Config.Combo.Qmana:Value() then
			self.CastQ(self.target)
		end
	end
	if (self.target ~= nil) or (self.qtarget ~= nil) then
		if self:GetEMinions() >= 1 and self.manapc > self.Config.Combo.Emana:Value() and (GotBuff(self.target, "kalistaexpungemarker") or GotBuff(self.qtarget, "kalistaexpungemarker")) then
			CastSpell(_E)
		end
	end
end

function Kalista:Harass()
	if self.target == nil then
		if self.QREADY and GoS:ValidTarget(self.qtarget, 1200) and self.Config.Harass.Q:Value() and self.manapc > self.Config.Harass.Qmana:Value() then
			self:CastQ(self.qtarget)
		end
	else
		if self.QREADY and GoS:ValidTarget(self.target, 600) and self.Config.Harass.Q:Value() and self.manapc > self.Config.Harass.Qmana:Value() then
			self.CastQ(self.target)
		end
	end
	if self:GetEMinions() >= 1 and self.manapc > self.Config.Harass.Emana:Value() and (GotBuff(self.target, "kalistaexpungemarker") or GotBuff(self.qtarget, "kalistaexpungemarker")) then
		CastSpell(_E)
	end
end

function Kalista:LastHit()
	local Qm = self.spellData[_Q].mana()
	local Em = self.spellData[_E].mana
	local Cm = GetCurrentMana(myHero)
	for i,minion in pairs(GoS:GetAllMinions(MINION_ENEMY)) do
		local mhp = GetCurrentHP(minion)
		local Qdmg = GoS:CalcDamage(myHero, minion, (self.QREADY and Cm > Qm and self.manapc > self.Config.LastHit.Qmana:Value() and self.Config.LastHit.Q:Value()) and self.spellData[_Q].dmg() or 0, 0)
		local Edmg = (self.EREADY and Cm > Em and self.manapc > self.Config.LastHit.Emana:Value() and self:GetEDamage(minion, 0) or 0)
		if GoS:ValidTarget(minion, 1050) then
			if self.EREADY and mhp < Edmg and self.Config.LastHit.E:Value() then
				CastSpell(_E)
			elseif self.QREADY and mhp < Qdmg and not IOW:TimeToAttack() then
				self:CastQ(minion)
			end
		end
	end
end

function Kalista:LaneClear()
	local Qm = self.spellData[_Q].mana()
	local Em = self.spellData[_E].mana
	local Cm = GetCurrentMana(myHero)
	for i,minion in pairs(GoS:GetAllMinions(MINION_ENEMY)) do
		local mhp = GetCurrentHP(minion)
		local Qdmg = GoS:CalcDamage(myHero, minion, (self.QREADY and Cm > Qm and self.manapc > self.Config.LastHit.Qmana:Value() and self.Config.LastHit.Q:Value()) and self.spellData[_Q].dmg() or 0, 0)
		local Edmg = (self.EREADY and Cm > Em and self.manapc > self.Config.LastHit.Emana:Value() and self:GetEDamage(minion, 0) or 0)
		if GoS:ValidTarget(minion, 1050) then
			if self.EREADY and mhp < Edmg and self.Config.LaneClear.E:Value() and self:GetEMinions() >= self.Config.Misc.exnum:Value() and IOW:TimeToMove() then
				CastSpell(_E)
			elseif self.QREADY and mhp < Qdmg and IOW:TimeToMove() then
				self:CastQ(minion)
			end
		end
	end
end

function GetFarmPosition(range, width)
  	local BestPos 
  	local BestHit = 0
  	local objects = minionManager.objects
  	for i, object in pairs(objects) do
  		if GetOrigin(object) ~= nil and IsObjectAlive(object) and GetTeam(object) ~= GetTeam(myHero) then
	  	local hit = CountObjectsNearPos(Vector(object), range, width, objects)
	   		if hit > BestHit and GoS:GetDistanceSqr(Vector(object)) < range * range then
		  	BestHit = hit
		  	BestPos = Vector(object)
		  	if BestHit == #objects then
				break
		  	end
		end
		end
  	end
  	return BestPos, BestHit
end

function Kalista:GetEMinions()
local killCount = 0
	if self.EREADY and self.Config.Misc.exMinions:Value() then
	 	for i,minion in pairs(GoS:GetAllMinions(MINION_ENEMY)) do
		 	if minion and GoS:ValidTarget(minion, 1050) then
		 	local mhp = GetCurrentHP(minion)
				if Kalista:GetEDamage(minion, 0) - 5 > mhp then
					killCount = killCount + 1
				end
			end
		end
	end
	return killCount
end

function Kalista:JungleClear()
	for i, unit in pairs(GoS:GetAllMinions(MINION_JUNGLE)) do
	local Edmg = GoS:CalcDamage(myHero, unit, self:GetEDamage(unit, 0), 0)
	local junglehp = GetCurrentHP(unit)
		if GoS:ValidTarget(unit, 1000 + GetHitBox(unit)) and self.EREADY then
			for i=1,9 do
				local s = ({"SRU_Dragon", "SRU_Baron", "SRU_Red", "SRU_Blue", "Sru_Crab", "SRU_Krug", "SRU_Razorbeak", "SRU_Murkwolf", "SRU_Gromp"})[i]
				if self.Config.JungleClear[s]:Value() then
					local unitPos = GetOrigin(unit)
					local draw = WorldToScreen(1, unitPos.x, unitPos.y, unitPos.z)
					if Edmg > 0 then
						DrawText(math.floor(Edmg/junglehp*100).."%",20,draw.x,draw.y,0xffffffff)
					end
					if GetObjectName(unit) == s and junglehp < Edmg then
					CastSpell(_E)
					end
				end
			end
		end
	end
end

function Kalista:Killsteal()
	local Qm = self.spellData[_Q].mana()
	local Em = self.spellData[_E].mana
	local Cm = GetCurrentMana(myHero)
	for i,enemy in pairs(GoS:GetEnemyHeroes()) do
		local Qdmg = GoS:CalcDamage(myHero, enemy, 0, (self.QREADY and Cm > Qm and self.manapc > self.Config.Killsteal.Qmana:Value() and self.Config.Killsteal.Q:Value()) and self.spellData[_Q].dmg() or 0)
		local Edmg = self:GetEDamage(enemy, 0)
		local EQdmg = self:GetEDamage(enemy, 1)
		local Qrange = 1125 + GetHitBox(enemy)
		local Erange = 1000 + GetHitBox(enemy)
		local traveltime = (GoS:GetDistance(enemy)/2000)*1000
		local enemyhp = GetCurrentHP(enemy) + GetDmgShield(enemy)
		local Qok = self.Config.Killsteal.Q:Value()
		local Eok = self.Config.Killsteal.E:Value()
		if GoS:ValidTarget(enemy, Qrange) and enemyhp < Qdmg and Qok then
			self:CastQ(enemy)
		elseif GoS:ValidTarget(enemy, Erange) and enemyhp < Edmg - (Edmg*0.02) and Eok then
			CastSpell(_E)
		elseif GoS:ValidTarget(enemy, 700) and enemyhp < Qdmg + EQdmg - (Edmg*0.02) and self.QREADY and self.EREADY and Qok and Eok and Cm > Qm + Em then 
			self:CastQ(enemy) GoS:DelayAction(function() CastSpell(_E) end, traveltime+250) 
		end
	end
end










------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
---------------------------------------------------------------------------------------------------------------Riven-----------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------




class "Riven"

function Riven:__init()
	self.Target = nil
	self.tables = {
		combo = {
			{
				function() 
					if not GoS:ValidTarget(self.Target) or GetCastName(myHero, _R) == "RivenFengShuiEngine" then return false end
					self.rPred = GetPredictionForPlayer(GetOrigin(myHero), self.Target, GetMoveSpeed(self.Target), 2000, 250, 1125 + GetHitBox(self.Target), 70, true, true)
					local rDmg = GoS:CalcDamage(myHero, self.Target, self.spellData[_R].dmg(1, self.Target),0)
					return self.doR and self.rPred.hitChance == 1 and GetCurrentHP(self.Target) < rDmg
				end, 
				function() 
					CastSkillShot(_R, self.rPred.predPos.x, self.rPred.predPos.y, self.rPred.predPos.z) 
				end
			},
			{
				function() 
					return self.EREADY and GoS:ValidTarget(self.Target, 550) and not GoS:IsInDistance(self.Target, GetRange(myHero)+GetHitBox(self.Target))
				end, 
				function() 
					local pos = GetOrigin(self.Target)
					CastSkillShot(_E, pos.x, pos.y, pos.z) 
				end
			}
		},
		harass = {
			{
				function() 
					if not GoS:ValidTarget(self.Target) or GetCastName(myHero, _R) == "RivenFengShuiEngine" then return false end
					self.rPred = GetPredictionForPlayer(GetOrigin(myHero), self.Target, GetMoveSpeed(self.Target), 2000, 250, 1125 + GetHitBox(self.Target), 70, true, true)
					local rDmg = GoS:CalcDamage(myHero, self.Target, self.spellData[_R].dmg(1, self.Target),0)
					return self.doR and self.rPred.hitChance == 1 and GetCurrentHP(self.Target) < rDmg
				end, 
				function() 
					CastSkillShot(_R, self.rPred.predPos.x, self.rPred.predPos.y, self.rPred.predPos.z) 
				end
			},
			{
				function() 
					return self.EREADY and GoS:ValidTarget(self.Target, 550) and not GoS:IsInDistance(self.Target, GetRange(myHero)+GetHitBox(self.Target))
				end, 
				function() 
					local pos = GetOrigin(self.Target)
					CastSkillShot(_E, pos.x, pos.y, pos.z) 
				end
			}
		},
		auto = {
			{
				function()
					return self.Config.Misc.autoWok:Value() and IOW:TimeToMove() and GoS:EnemiesAround(GetOrigin(myHero), 265) >= self.Config.Misc.autoW:Value()
				end,
				function()
					CastSpell(_W)
				end
			},
			{
				function()
					return self.Config.Keys.Flee:Value()
				end,
				function()
					self:Flee()
				end
			},
			{
				function()
					return true
				end,
				function()
					self.Target = self:GetTarget()
				end
			}
		}
	}
	self.lastTick = {}
	self.maxTicks = {}
	for k, v in pairs(self.tables) do
		self.lastTick[k] = 0
		self.maxTicks[k] = #v
	end
	self.tick = OnTick(function() self:Tick() end)
	self.draw = OnDraw(function() self:Draw() end)
	OnCreateObj(function(o) self:CreateObj(o) end)
	OnProcessSpell(function(u,s) self:ProcessSpell(u,s) end)
	OnProcessSpellComplete(function(u,s) self:ProcessSpellComplete(u,s) end)
	
	self.spellData = {
		[_Q] = {dmg = function (rMulti) return 20 * GetCastLevel(myHero,_Q) + (0.35+0.05*GetCastLevel(myHero,_Q))*(GetBonusDmg(myHero) + GetBaseDamage(myHero))*rMulti - 10 end},
		[_W] = {dmg = function (rMulti) return 20 + 30 * GetCastLevel(myHero,_W) + GetBonusDmg(myHero)*rMulti end},
		[_R] = {dmg = function (rMulti, target) return (40 + 40 * GetCastLevel(myHero,_R) + 0.6*GetBonusDmg(myHero)*rMulti)*(math.min(3,math.max(1,4*(GetMaxHP(target)-GetCurrentHP(target))/GetMaxHP(target)))) end},
	}

	self.Config = MenuConfig("PA:Metempsychosis Riven", "PAMriven")
		self.Config:Menu("Combo", "Combo")
			self.Config.Combo:Boolean("Q", "Use Q", true)
			self.Config.Combo:Boolean("W", "Use W", true)
			self.Config.Combo:Boolean("E", "Use E", true)
		self.Config:Menu("Harass", "Harass")
			self.Config.Harass:Boolean("Q", "Use Q", true)
			self.Config.Harass:Boolean("W", "Use W", false)
		self.Config:Menu("Misc", "Misc")
			self.Config.Misc:Boolean("autoWok", "Auto W", true)
			self.Config.Misc:Slider("autoW", "AutoW X Enemies", 3, 1, 5, 1)
		self.Config:Menu("Killsteal", "Killsteal")
			self.Config.Killsteal:Boolean("Q", "Use Q", false)
			self.Config.Killsteal:Boolean("W", "Use W", false)
			self.Config.Killsteal:Boolean("E", "Use E", false)
			self.Config.Killsteal:Boolean("R", "Use R2", false)
		self.Config:Menu("Draw", "Draws")
			self.Config.Draw:Menu("hpDraw", "HPbar Draw")
				self.Config.Draw.hpDraw:Boolean("rect", "Draw Rect", true)
				self.Config.Draw.hpDraw:Boolean("drawR", "Draw R text", true)
				self.Config.Draw.hpDraw:Boolean("drawT", "Draw Target", true)
			self.Config.Draw:Boolean("q", "Draw Q", true)
				self.Config.Draw:Menu("qset","Q Settings")
					self.Config.Draw.qset:Slider("r", "Range Def:260", 260, 0, 1000, 1)
					self.Config.Draw.qset:Slider("T", "Thickness", 0, 0, 30, 1)
					self.Config.Draw.qset:Slider("Q", "Quality", 0, 0, 128, 1)
					self.Config.Draw.qset:Slider("A", "Opacity", 180, 0, 255, 1)
					self.Config.Draw.qset:Slider("R", "Red", 255, 0, 255, 1)
					self.Config.Draw.qset:Slider("G", "Green", 255, 0, 255, 1)
					self.Config.Draw.qset:Slider("B", "Blue", 255, 0, 255, 1)
			self.Config.Draw:Boolean("w", "Draw W", true)
				self.Config.Draw:Menu("wset","W Settings")
					self.Config.Draw.wset:Slider("r", "Range Def:265", 265, 0, 800, 1)
					self.Config.Draw.wset:Slider("T", "Thickness", 0, 0, 30, 1)
					self.Config.Draw.wset:Slider("Q", "Quality", 0, 0, 128, 1)
					self.Config.Draw.wset:Slider("A", "Opacity", 180, 0, 255, 1)
					self.Config.Draw.wset:Slider("R", "Red", 255, 0, 255, 1)
					self.Config.Draw.wset:Slider("G", "Green", 255, 0, 255, 1)
					self.Config.Draw.wset:Slider("B", "Blue", 255, 0, 255, 1)
			self.Config.Draw:Boolean("e", "Draw E", true)
				self.Config.Draw:Menu("eset","E Settings")
					self.Config.Draw.eset:Slider("r", "Range Def:390", 390, 0, 800, 1)
					self.Config.Draw.eset:Slider("T", "Thickness", 0, 0, 30, 1)
					self.Config.Draw.eset:Slider("Q", "Quality", 0, 0, 128, 1)
					self.Config.Draw.eset:Slider("A", "Opacity", 180, 0, 255, 1)
					self.Config.Draw.eset:Slider("R", "Red", 255, 0, 255, 1)
					self.Config.Draw.eset:Slider("G", "Green", 255, 0, 255, 1)
					self.Config.Draw.eset:Slider("B", "Blue", 255, 0, 255, 1)
			self.Config.Draw:Boolean("r", "Draw R", true)
				self.Config.Draw:Menu("rset","R Settings")
					self.Config.Draw.rset:Slider("r", "Range Def:930", 930, 0, 800, 1)
					self.Config.Draw.rset:Slider("T", "Thickness", 0, 0, 30, 1)
					self.Config.Draw.rset:Slider("Q", "Quality", 0, 0, 128, 1)
					self.Config.Draw.rset:Slider("A", "Opacity", 180, 0, 255, 1)
					self.Config.Draw.rset:Slider("R", "Red", 255, 0, 255, 1)
					self.Config.Draw.rset:Slider("G", "Green", 255, 0, 255, 1)
					self.Config.Draw.rset:Slider("B", "Blue", 255, 0, 255, 1)
		self.Config:Menu("Keys", "Keys")
			self.Config.Keys:KeyBinding("Combo", "Combo", 32)
			self.Config.Keys:KeyBinding("Harass", "Harass", string.byte("C"))
			self.Config.Keys:KeyBinding("Flee", "Flee", string.byte("G"))
			self.Config.Keys:KeyBinding("ForceR", "Force Ult", string.byte("T"), true)
			self.Config.Keys.ForceR:Value(false)
		self.Config:TargetSelector("ts", "TargetSelector", TARGET_LESS_CAST, 550, DAMAGE_PHYSICAL, true, false)
	self.QCast = 0
	self.doQ = false
	self.doW = false
	self.startT = GetTickCount()
	self.lastE = 0
end

function Riven:Tick()
	if self.startT + 2500 < GetTickCount() then
		IOW.Config.items.__val = false
		IOW.Config.sticky.__val = true
	end
	self.doQ = (self.Config.Keys.Combo:Value() and self.Config.Combo.Q:Value()) or (self.Config.Keys.Harass:Value() and self.Config.Harass.Q:Value()) or (self.Config.Keys.LaneClear:Value() and self.Config.LaneClear.Q:Value())
	self.doW = (self.Config.Keys.Combo:Value() and self.Config.Combo.W:Value()) or (self.Config.Keys.Harass:Value() and self.Config.Harass.W:Value()) or (self.Config.Keys.LaneClear:Value() and self.Config.LaneClear.W:Value())
	self.doR = self.Config.Keys.ForceR:Value()
	self.QREADY = CanUseSpell(myHero,_Q) == READY
	self.WREADY = CanUseSpell(myHero,_W) == READY
	self.EREADY = CanUseSpell(myHero,_E) == READY
	self.RREADY = CanUseSpell(myHero,_R) == READY
	for _, v in pairs({"Combo", "Harass", "LaneClear"}) do
		if self.Config.Keys[v]:Value() then
			self:Advance(v);break;
		end
	end
	self:Advance("Auto")
end

function Riven:Advance(___)
	local __ = ___:lower()
	local function Execute(__)
		if __[1](_) then __[2](___) end
	end
	self.lastTick[__] = self.lastTick[__] + 1
	if self.lastTick[__] > self.maxTicks[__] then self.lastTick[__] = 1 end
	Execute(self.tables[__][self.lastTick[__]])
end

function Riven:GetTarget()
	if self.Config.Keys.Combo:Value() then
		return self.Config.ts:GetTarget()
	end
	return self.Config.ts:GetTarget()
end

function Riven:Draw()
	local hpbar = GetHPBarPos(myHero)
	if self.Config.Draw.hpDraw.rect:Value() then
		FillRect(hpbar.x, hpbar.y+10, 107, 12,ARGB(255,74,73,74))
	end
	if self.Config.Draw.hpDraw.drawT:Value() and self.Target ~= nil then
		DrawText(GetObjectName(self.Target),14,hpbar.x+110-GetTextArea(GetObjectName(self.Target),14)/2, hpbar.y+9,ARGB(255,52,210,35))
	end
	if self.Config.Draw.hpDraw.drawR:Value() then
		if self.doR then
			DrawText("Force R",14,hpbar.x, hpbar.y+9,ARGB(255,52,210,35))
		else
			DrawText("Force R",14,hpbar.x, hpbar.y+9,ARGB(255,210,40,35))
		end
	end

	for i,s in pairs({"q","w","e","r"}) do
		if self.Config.Draw[s]:Value() then
			DrawCircle(GetOrigin(myHero), self.Config.Draw[s.."set"].r:Value(), self.Config.Draw[s.."set"].T:Value(), self.Config.Draw[s.."set"].Q:Value(), ARGB(self.Config.Draw[s.."set"].A:Value(), self.Config.Draw[s.."set"].R:Value(), self.Config.Draw[s.."set"].G:Value(), self.Config.Draw[s.."set"].B:Value()))
		end
	end
	local rMulti = 1
	if self.RREADY and GetCastName(myHero,_R) == "RivenFengShuiEngine" and self.doR then
		rMulti = 1.20
	end
	for i,enemy in pairs(GoS:GetEnemyHeroes()) do
		local Pdmg = self:DmgP((GetBaseDamage(myHero)+GetBonusDmg(myHero))*rMulti) + GetBaseDamage(myHero)+GetBonusDmg(myHero)
		local hydra = GetItemSlot(myHero,3074) > 0 and GetItemSlot(myHero,3074) or GetItemSlot(myHero,3077) > 0 and GetItemSlot(myHero,3077) or nil
		local Tdmg = 0
		if hydra and CanUseSpell(myHero, hydra) == 0 then 
			Tdmg = (GetBaseDamage(myHero)+GetBonusDmg(myHero)) * (GetItemSlot(myHero,3074) > 0 and 1 or GetItemSlot(myHero,3077) > 0 and 0.6) 
		end
		local Qdmg = (self.QREADY or (self.QCast < 3 and self.QCast > 0) or (self.QCast == 0 and self.QREADY)) and self.spellData[_Q].dmg(rMulti)+(3-self.QCast)*Pdmg or 0
		local Wdmg = self.WREADY and self.spellData[_W].dmg(rMulti)+Pdmg or 0
		local Rdmg = self.RREADY and GetCastName(myHero,_R) ~= "RivenFengShuiEngine" and self.spellData[_R].dmg(rMulti, enemy) or 0
		local dmg = GoS:CalcDamage(myHero, enemy,Tdmg + Qdmg + Wdmg + Rdmg, 0)
		if GoS:ValidTarget(enemy, 2000) then
			DrawDmgOverHpBar(enemy, GetCurrentHP(enemy), 0, dmg, 0xffffffff)
		end
	end
end

function Riven:Flee()
	local mousepos = GetMousePos()
	if self.EREADY then
		CastSkillShot(_E, mousepos)
	elseif self.QREADY and self.lastE < GetTickCount() then
		CastSkillShot(_Q, mousepos)
	else
		MoveToXYZ(mousepos)
	end
end

function Riven:CreateObj(object)
	if object and GetObjectBaseName(object) and GetOrigin(object) and GoS:GetDistance(object) < 1000 then
		if GetObjectBaseName(object):find("Riven_Base_Q_") and GetObjectBaseName(object):find("_detonate") and self.doQ and GoS:GetDistance(object) < 150 then
			CastEmote(EMOTE_DANCE)
			for I=0, 250 do
				GoS:DelayAction(function() IOW.lastAttack = 0 end, I)
			end
		end
	end
end

function Riven:DmgP(ad)
	return 5+math.max(5*math.floor((GetLevel(myHero)+2)/3)+10,10*math.floor((GetLevel(myHero)+2)/3)-15)*ad/100
end

function Riven:ProcessSpellComplete(unit, spell)
	if unit and spell and spell.name and GetNetworkID(unit) == GetNetworkID(myHero) then
		if spell.name:lower():find("attack") then
			if GoS:ValidTarget(self.Target) then
				local hydra = GetItemSlot(myHero,3074) > 0 and GetItemSlot(myHero,3074) or GetItemSlot(myHero,3077) > 0 and GetItemSlot(myHero,3077) or nil
				if self.doW and self.WREADY then
					CastSpell(_W)
					return
				elseif hydra and CanUseSpell(myHero, hydra) == READY then
					CastSpell(hydra)
					return;
				elseif self.doQ then
					local pos = GetOrigin(self.Target)
					CastSkillShot(_Q, pos.x, pos.y, pos.z) 
				end
			end
		elseif spell.name:lower():find("rivenmartyr") then
			if GoS:ValidTarget(self.Target) and self.doQ then
				local pos = GetOrigin(self.Target)
				CastSkillShot(_Q, pos.x, pos.y, pos.z)
			end
		elseif spell.name:lower():find("itemtiamatcleave") then
			if GoS:ValidTarget(self.Target) and self.doQ then
				local pos = GetOrigin(self.Target)
				CastSkillShot(_Q, pos.x, pos.y, pos.z)
			end
		end
	end
end

function Riven:ProcessSpell(unit, spell)
	if unit and spell and spell.name and GetNetworkID(unit) == GetNetworkID(myHero) then
		if spell.name == "RivenTriCleave" then
			self.QCast = self.QCast + 1
			GoS:DelayAction(function() if not self.QREADY then self.QCast = 0 end end, 4000)
		elseif spell.name == "RivenFeint" then
			if GoS:ValidTarget(self.Target) and self.doR then
				CastSpell(_R)
				return
			end 
			if GoS:ValidTarget(self.Target) and self.doW then
				CastSpell(_W)
			end
			self.lastE = GetTickCount() + 450
		end
	end
end

if _G[GetObjectName(myHero)] then
	_G[GetObjectName(myHero)]()
end
--PJSalt Deftsu