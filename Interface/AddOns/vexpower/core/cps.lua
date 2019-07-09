function vexpower.CPBar.handler(change)	-- XXXXXXXXXXXXXXXXXXXXXXXXX
	vexpower.CPBar.setCurrent(change)
	if vexpower.CPBar.currentCP[1] > vexpower.CPBar.currentCP[2] then
		--CPs built
		for i=1, vexpower.CPBar.currentCP[1] do
			if vexpower.CPBar.aniGrps[i]~=nil then
				if vexpower.CPBar.aniGrps[i]:IsPlaying() then
					vexpower.CPBar.aniGrps[i]:Stop()
				end
			end
			if not(vexpower.CPBar.frames[i]:IsShown()) then vexpower.CPBar.frames[i]:Show() end
			vexpower.CPBar.setBGColors(i, true)
		end
	else
		--CPs used
		for i=1, vexpower.CPBar.maxCPs do
			vexpower.CPBar.setBGColors(i, true)
		end
		
		local cpsLost = vexpower.CPBar.currentCP[2]-vexpower.CPBar.currentCP[1]
		
		for i=1, cpsLost do
			local bar = vexpower.CPBar.currentCP[2]+1-i
			vexpower.CPBar.setBGColors(bar, false)
			if vexpower_SV_profiles[vexpower_SV_data["profile"]]["CPBar"]["design"]["usedEffect"]["activate"] then
				vexpower.CPBar.aniGrps[bar]:Play()
			else
				if vexpower.CPBar.frames[bar]:IsShown() then vexpower.CPBar.frames[bar]:Hide() end
			end
		end
	end
	vexpower.CPBar.playSound()
end

function vexpower.CPBar.getCPToAdjust(CP)
	return CP
end

function vexpower.CPBar.get(current)	
	local returnvalue = 0
	if vexpower.vehicle.CP and vexpower_SV_profiles[vexpower_SV_data["profile"]]["CPBar"]["show"]["vehicleCPs"] then
		if current then
			returnvalue = GetComboPoints("vehicle")
		else
			returnvalue = 5
		end
	elseif vexpower.data.classString == "DRUID" then
		if current then
			if vexpower_SV_profiles[vexpower_SV_data["profile"]]["data"]["classSpec"]["druid"]["keepCPShown"]  then
				returnvalue = UnitPower("player", 4)
			else
				returnvalue = GetComboPoints("player")
			end
		else
			if vexpower_SV_profiles[vexpower_SV_data["profile"]]["data"]["classSpec"]["druid"]["cps"] then
				returnvalue = 5
			else
				returnvalue = 0
			end
		end
	elseif vexpower.data.classString == "ROGUE" then
		-- if vexpower_SV_profiles[vexpower_SV_data["profile"]]["data"]["classSpec"]["rogue"]["anticipation"] and select(2, GetTalentTierInfo(3))==19250  then
			-- if current then
				-- if vexpower_SV_profiles[vexpower_SV_data["profile"]]["data"]["classSpec"]["rogue"]["keepCPShown"]  then
					-- returnvalue = UnitPower("player", 4)
				-- else
					-- returnvalue = GetComboPoints("player")
				-- end
				
				-- if returnvalue ~= 0 then
					-- returnvalue = returnvalue+vexpower.CPBar.getCurrentBuff()
				-- end
			-- else
				-- returnvalue = 10
			-- end
		-- else
		if current then
			if vexpower_SV_profiles[vexpower_SV_data["profile"]]["data"]["classSpec"]["rogue"]["keepCPShown"]  then
				returnvalue = UnitPower("player", 4)
			else
				returnvalue = GetComboPoints("player")
			end
		else
			if vexpower_SV_profiles[vexpower_SV_data["profile"]]["data"]["classSpec"]["rogue"]["cps"] then
				-- returnvalue = UnitPowerMax("player", SPELL_POWER_COMBO_POINTS)
				if select(4, GetTalentInfo(3,2, GetActiveSpecGroup())) then
					returnvalue = 6
				else
					returnvalue = 5
				end
			else
				returnvalue = 0
			end
		end
		-- end
	elseif vexpower.data.classString == "PALADIN" then
		if current then
			if vexpower_SV_profiles[vexpower_SV_data["profile"]]["data"]["classSpec"]["paladin"]["cps"] then
				returnvalue = UnitPower("player", 9)
			else
				returnvalue = 0
			end
		else
			returnvalue = UnitPowerMax("player", 9)
		end
	elseif vexpower.data.classString == "DEMONHUNTER" then
		if vexpower.data.specID == 581 then		-- Vengeance
			if current then
				if vexpower_SV_profiles[vexpower_SV_data["profile"]]["data"]["classSpec"]["dh"]["fragments"] then
					returnvalue = vexpower.CPBar.getCurrentBuff()
				else
					returnvalue = 0
				end
			else
				returnvalue = 5
			end
			--vexdebugs.print("returnvalue",returnvalue)
		end
	elseif vexpower.data.classString == "MONK" then
		if vexpower.data.specID == 270 then --Mistweaver
			returnvalue = 0
		elseif vexpower.data.specID == 268 then --Brewmaster
			if current then
				if vexpower_SV_profiles[vexpower_SV_data["profile"]]["data"]["classSpec"]["monk"]["GotO"] then
					returnvalue = vexpower.CPBar.getSpellCount()
				else
					returnvalue = 0
				end
			else
				returnvalue = 5
			end
		else
			if current then
				if vexpower_SV_profiles[vexpower_SV_data["profile"]]["data"]["classSpec"]["monk"]["cps"] then
					returnvalue = UnitPower("player", 12) 
				else
					returnvalue = 0
				end
			else
				returnvalue = UnitPowerMax("player", 12)
			end
		end
	elseif vexpower.data.classString == "PRIEST" then
		if vexpower.data.specID == 258 then		-- Shadow
			if current then
				returnvalue = 0
			else
				if vexpower_SV_profiles[vexpower_SV_data["profile"]]["data"]["classSpec"]["priest"]["mana"] then
					returnvalue = 1
				else
					returnvalue = 0
				end
			end
		end
	elseif vexpower.data.classString == "SHAMAN" then
		if vexpower.data.specID == 263 then		-- Enhancer (263)
			if current then
				if vexpower_SV_profiles[vexpower_SV_data["profile"]]["data"]["classSpec"]["shaman"]["enhancerMana"] then
					returnvalue = 0
				elseif vexpower_SV_profiles[vexpower_SV_data["profile"]]["data"]["classSpec"]["shaman"]["enhancerStormstrikes"] then
					returnvalue = 0
					local start, duration = GetSpellCooldown(17364)
					if start > 0 and duration > 1.5 then
						returnvalue = 0
					else
						returnvalue = 1 + vexpower.CPBar.getCurrentBuff()
					end
				else
					returnvalue = 0
				end
			else
				if vexpower_SV_profiles[vexpower_SV_data["profile"]]["data"]["classSpec"]["shaman"]["enhancerMana"] then
					returnvalue = 1
				elseif vexpower_SV_profiles[vexpower_SV_data["profile"]]["data"]["classSpec"]["shaman"]["enhancerStormstrikes"] then
					if select(4, GetTalentInfo(5,1, GetActiveSpecGroup())) then
						returnvalue = 3
					else
						returnvalue = 2
					end
				else
					returnvalue = 0
				end
			end
		elseif vexpower.data.specID == 262 then		-- Ele (262)
			if current then
				returnvalue = 0
			else
				if vexpower_SV_profiles[vexpower_SV_data["profile"]]["data"]["classSpec"]["shaman"]["eleMana"] then
					returnvalue = 1
				else
					returnvalue = 0
				end
			end
		end
	elseif vexpower.data.classString == "WARLOCK" then
		if current then
			if vexpower_SV_profiles[vexpower_SV_data["profile"]]["data"]["classSpec"]["warlock"]["cps"] then
				returnvalue = UnitPower("player", 7)
			else
				returnvalue = 0
			end
		else
			returnvalue = UnitPowerMax("player", 7)
		end
	elseif vexpower.data.classString == "MAGE" then
		if vexpower.data.specID == 62 then 		-- Arcane
			if current then
				if vexpower_SV_profiles[vexpower_SV_data["profile"]]["data"]["classSpec"]["mage"]["cps"] then
					returnvalue = UnitPower("player", 16)
				else
					returnvalue = 0
				end
			else
				returnvalue = UnitPowerMax("player", 16)
			end
		end
	elseif vexpower.data.classString == "WARRIOR" then
		if vexpower.data.specID == 73 then 		-- Protection
			if current then
				if vexpower_SV_profiles[vexpower_SV_data["profile"]]["data"]["classSpec"]["warrior"]["focuesdrage"] then
					returnvalue = vexpower.CPBar.getCurrentBuff()
				else
					returnvalue = 0
				end
			else
				returnvalue = 3
			end
		
		elseif vexpower.data.specID == 71 then 		-- Arms
			if current then
				if vexpower_SV_profiles[vexpower_SV_data["profile"]]["data"]["classSpec"]["warrior"]["focuesdrageArms"] then
					returnvalue = vexpower.CPBar.getCurrentBuff()
				else
					returnvalue = 0
				end
			else
				returnvalue = 3
			end
		end
	end
	if current then
		if returnvalue > vexpower.CPBar.maxCPs then
			returnvalue = vexpower.CPBar.maxCPs
		end
	end
	return returnvalue
end

function vexpower.CPBar.getSpellCount()
	local returnvalue = 0
	if vexpower.data.specID == 268 then		-- Brewmaster
		returnvalue = GetSpellCount(115072) --Expel Harm
	end
	return returnvalue
end

function vexpower.CPBar.getCurrent(change)
	local new = 0

	if change ~= nil then
		new = vexpower.CPBar.currentCP[1]+change
	else
		new = vexpower.CPBar.get(true)
	end

	return new
end

function vexpower.CPBar.setCurrent(change)
	local new = vexpower.CPBar.getCurrent(change)
	
	if change ~= nil then new = vexpower.CPBar.currentCP[1]+change end
	
	if new ~= vexpower.CPBar.currentCP[1] then
		vexpower.CPBar.currentCP[2] = vexpower.CPBar.currentCP[1]
		vexpower.CPBar.currentCP[1] = new
	end
end

function vexpower.CPBar.getSpecAuraID()
	local returnvalue = 0
	
	if vexpower.data.specID == 581 then		-- Vengeance DH
		returnvalue = 203981
	elseif vexpower.data.specID == 263 then		-- Enhancer
		returnvalue = 201846
	elseif vexpower.data.specID == 73 then		-- Protection
		returnvalue = 204488
	elseif vexpower.data.specID == 71 then		-- Arms Warri
		returnvalue = 207982
	-- if vexpower.data.specID == 254 then		-- Marksman
		-- returnvalue = 
	-- elseif vexpower.data.specID == 253 then		-- Beast Master
		-- returnvalue = 19615
	-- elseif vexpower.data.specID == 72 then		-- Fury
		-- returnvalue = 131116
	-- elseif vexpower.data.classString == "ROGUE" then									-- Anticipation for all rogues
		-- returnvalue = 115189
	end
	
	return returnvalue
end

function vexpower.CPBar.getCurrentDebuff()
	local count = 0
	local continue = true
	local i = 1
	local auraid = vexpower.CPBar.getSpecAuraID()
	
	if auraid ~= 0 then
		while continue do
			if UnitDebuff("player", i) == nil then
				continue = false
			elseif select(10, UnitDebuff("player", i)) == auraid then
				count = select(3, UnitDebuff("player", i))
				continue = false
			end
			i = i + 1
		end
	end	
	return count
end

function vexpower.CPBar.getCurrentBuff()
	local count = 0
	local continue = true
	local i = 1
	local auraid = vexpower.CPBar.getSpecAuraID()
	
	if auraid ~= 0 then
		while continue do
			if UnitBuff("player", i) == nil then
				continue = false
			elseif select(10, UnitBuff("player", i)) == auraid then
				count = select(3, UnitBuff("player", i))
				continue = false
			end
			i = i + 1
		end
	end
	
	-- Marksman Override for "Fire!"
	-- if vexpower.data.specID == 254 then -- Marksman
		-- i = 1
		-- continue = true
		-- while continue do
			-- if UnitBuff("player", i, nil, "PLAYER") == nil then
				-- continue = false
			-- elseif select(10, UnitBuff("player", i)) == 82926 then
				-- count = vexpower.CPBar.maxCPs
				-- continue = false
			-- end
			-- i = i + 1
		-- end
	-- end
	
	return count
end

function vexpower.CPBar.getMax()
	return vexpower.CPBar.get(false)
end

function vexpower.CPBar.setMax()
	vexpower.CPBar.maxCPs = vexpower.CPBar.getMax()
end

function vexpower.CPBar.calcDownCP(cp)
	while cp>10 do
		cp = cp -10
	end
	return cp
end

function vexpower.CPBar.setBGColors(cp, standard)	-- XXXXXXXXXXXXXXXXXXXXXXXXX
	cp = vexpower.CPBar.getCPToAdjust(cp)
	if vexpower.CPBar.frames[cp] ~=nil then
		local color = tostring(vexpower.CPBar.calcDownCP(cp))
		-- local color = tostring(cp)
		if vexpower_SV_profiles[vexpower_SV_data["profile"]]["CPBar"]["design"]["colors"]["activateRecoloring"] then
			if not(vexpower_SV_profiles[vexpower_SV_data["profile"]]["CPBar"]["design"]["colors"]["changeOnMax"]) and vexpower.CPBar.currentCP[1] >= tonumber(vexpower_SV_profiles[vexpower_SV_data["profile"]]["CPBar"]["design"]["colors"]["threshold"]) then
				if (vexpower_SV_profiles[vexpower_SV_data["profile"]]["CPBar"]["design"]["colors"]["changeThresholdOnly"] and cp <= tonumber(vexpower_SV_profiles[vexpower_SV_data["profile"]]["CPBar"]["design"]["colors"]["threshold"])) then
					color = "change"
				elseif not(vexpower_SV_profiles[vexpower_SV_data["profile"]]["CPBar"]["design"]["colors"]["changeThresholdOnly"]) then
					color = "change"
				end
			elseif vexpower_SV_profiles[vexpower_SV_data["profile"]]["CPBar"]["design"]["colors"]["changeOnMax"] and vexpower.CPBar.currentCP[1]==vexpower.CPBar.maxCPs then
				color = "change"
			end
		end
		if not(standard) then
			color = "used"
		end
		vexpower.CPBar.frames[cp]:SetBackdropColor(
			vexpower_SV_profiles[vexpower_SV_data["profile"]]["CPBar"]["design"]["colors"]["colors"][color]["r"],
			vexpower_SV_profiles[vexpower_SV_data["profile"]]["CPBar"]["design"]["colors"]["colors"][color]["g"],
			vexpower_SV_profiles[vexpower_SV_data["profile"]]["CPBar"]["design"]["colors"]["colors"][color]["b"],
			vexpower_SV_profiles[vexpower_SV_data["profile"]]["CPBar"]["design"]["colors"]["colors"][color]["a"])
	end
end

function vexpower.CPBar.setBars()
	if not(vexpower.testmode.activated) then
		if vexpower.CPBar.frames ~= nil then
			for i=1, #vexpower.CPBar.frames do
				if vexpower.CPBar.frames[i] ~= nil then vexpower.CPBar.frames[i]:Hide() end
			end
		end
	end
	
	--Setup CPs
	for i=1, vexpower.CPBar.maxCPs do
		if not(vexpower.testmode.activated) then
			vexpower.CPBar.frames[i] = CreateFrame("Frame", nil, vexpower.CPBar.mainframe)
		end
		if vexpower_SV_profiles[vexpower_SV_data["profile"]]["CPBar"]["design"]["texture"]["usePack"] == 1 then
			vexpower.CPBar.frames[i]:SetBackdrop({
				bgFile=vexpower.LSM:Fetch("background", vexpower_SV_profiles[vexpower_SV_data["profile"]]["CPBar"]["design"]["texture"]["pack1"]),
				edgeFile=vexpower.LSM:Fetch("border", vexpower_SV_profiles[vexpower_SV_data["profile"]]["CPBar"]["design"]["border"]["texture"]), tile=false,
				edgeSize=vexpower_SV_profiles[vexpower_SV_data["profile"]]["CPBar"]["design"]["border"]["size"],
				insets = {
					left = vexpower_SV_profiles[vexpower_SV_data["profile"]]["CPBar"]["design"]["insets"]["left"],
					right = vexpower_SV_profiles[vexpower_SV_data["profile"]]["CPBar"]["design"]["insets"]["right"],
					top = vexpower_SV_profiles[vexpower_SV_data["profile"]]["CPBar"]["design"]["insets"]["top"],
					bottom = vexpower_SV_profiles[vexpower_SV_data["profile"]]["CPBar"]["design"]["insets"]["bottom"]
					}
				})
		else
			vexpower.CPBar.frames[i]:SetBackdrop({
				bgFile=vexpower.LSM:Fetch("statusbar", vexpower_SV_profiles[vexpower_SV_data["profile"]]["CPBar"]["design"]["texture"]["pack2"]),
				edgeFile=vexpower.LSM:Fetch("border", vexpower_SV_profiles[vexpower_SV_data["profile"]]["CPBar"]["design"]["border"]["texture"]), tile=false,
				edgeSize=vexpower_SV_profiles[vexpower_SV_data["profile"]]["CPBar"]["design"]["border"]["size"],
				insets = {
					left = vexpower_SV_profiles[vexpower_SV_data["profile"]]["CPBar"]["design"]["insets"]["left"],
					right = vexpower_SV_profiles[vexpower_SV_data["profile"]]["CPBar"]["design"]["insets"]["right"],
					top = vexpower_SV_profiles[vexpower_SV_data["profile"]]["CPBar"]["design"]["insets"]["top"],
					bottom = vexpower_SV_profiles[vexpower_SV_data["profile"]]["CPBar"]["design"]["insets"]["bottom"]
					}
				})
		end
		vexpower.CPBar.setBGColors(i, true)
		vexpower.CPBar.frames[i]:SetBackdropBorderColor(
			vexpower_SV_profiles[vexpower_SV_data["profile"]]["CPBar"]["design"]["border"]["color"]["r"],
			vexpower_SV_profiles[vexpower_SV_data["profile"]]["CPBar"]["design"]["border"]["color"]["g"],
			vexpower_SV_profiles[vexpower_SV_data["profile"]]["CPBar"]["design"]["border"]["color"]["b"],
			vexpower_SV_profiles[vexpower_SV_data["profile"]]["CPBar"]["design"]["border"]["color"]["a"])
		
		if not(vexpower.testmode.activated) then
			if vexpower.CPBar.currentCP[1] > 0 then
				if not(vexpower.CPBar.frames[i]:IsShown()) then vexpower.CPBar.frames[i]:Show() end
			else
				if vexpower.CPBar.frames[i]:IsShown() then vexpower.CPBar.frames[i]:Hide() end
			end
		end
		
		if vexpower_SV_profiles[vexpower_SV_data["profile"]]["CPBar"]["design"]["intMode"]["activate"] then
			vexpower.CPBar.frames[i]:ClearAllPoints()
			vexpower.CPBar.frames[i]:SetFrameStrata(vexpower.options.strata.convertValues(vexpower_SV_profiles[vexpower_SV_data["profile"]]["data"]["strata"]["cps"]))
			-- if vexpower.data.classString == "ROGUE" and vexpower_SV_profiles[vexpower_SV_data["profile"]]["data"]["classSpec"]["rogue"]["anticipation"] and vexpower_SV_profiles[vexpower_SV_data["profile"]]["data"]["classSpec"]["rogue"]["anti2ndRow"] then
				-- local width = 0
				-- if vexpower.CPBar.maxCPs ~= 0 then
					-- width = (vexpower_SV_profiles[vexpower_SV_data["profile"]]["powerbar"]["design"]["size"]["width"] - (vexpower.CPBar.maxCPs-6)*vexpower_SV_profiles[vexpower_SV_data["profile"]]["CPBar"]["design"]["intMode"]["gap"] - vexpower_SV_profiles[vexpower_SV_data["profile"]]["CPBar"]["design"]["intMode"]["offset"]*2)/(vexpower.CPBar.maxCPs-5)
				-- else
					 -- vexpower.CPBar.frames[i]:Hide()
				-- end
				-- vexpower.CPBar.frames[i]:SetWidth(width)
				-- if i>5 then
					-- local start = vexpower_SV_profiles[vexpower_SV_data["profile"]]["CPBar"]["design"]["intMode"]["offset"]+(width*(i-6))+(vexpower_SV_profiles[vexpower_SV_data["profile"]]["CPBar"]["design"]["intMode"]["gap"]*(i-6))
					-- vexpower.CPBar.frames[i]:SetHeight(vexpower_SV_profiles[vexpower_SV_data["profile"]]["data"]["classSpec"]["rogue"]["antiRowHeight"])
					-- vexpower.CPBar.frames[i]:SetPoint("TOPLEFT", vexpower.CPBar.mainframe, "TOPLEFT", start, vexpower_SV_profiles[vexpower_SV_data["profile"]]["data"]["classSpec"]["rogue"]["antiRowHeight"]+vexpower_SV_profiles[vexpower_SV_data["profile"]]["data"]["classSpec"]["rogue"]["antiRowYDistance"])
				-- else
					-- vexpower.CPBar.frames[i]:SetHeight(vexpower_SV_profiles[vexpower_SV_data["profile"]]["CPBar"]["design"]["intMode"]["height"])
					-- local start = vexpower_SV_profiles[vexpower_SV_data["profile"]]["CPBar"]["design"]["intMode"]["offset"]+(width*(i-1))+(vexpower_SV_profiles[vexpower_SV_data["profile"]]["CPBar"]["design"]["intMode"]["gap"]*(i-1))
					-- vexpower.CPBar.frames[i]:SetPoint("TOPLEFT", vexpower.CPBar.mainframe, "TOPLEFT", start, 0)
				-- end
			-- else
				vexpower.CPBar.frames[i]:SetHeight(vexpower_SV_profiles[vexpower_SV_data["profile"]]["CPBar"]["design"]["intMode"]["height"])
				local width = 0
				if vexpower.CPBar.maxCPs ~= 0 then
					width = (vexpower_SV_profiles[vexpower_SV_data["profile"]]["powerbar"]["design"]["size"]["width"] - (vexpower.CPBar.maxCPs-1)*vexpower_SV_profiles[vexpower_SV_data["profile"]]["CPBar"]["design"]["intMode"]["gap"] - vexpower_SV_profiles[vexpower_SV_data["profile"]]["CPBar"]["design"]["intMode"]["offset"]*2)/vexpower.CPBar.maxCPs
				else
					if vexpower.CPBar.frames[i]:IsShown()		then 	vexpower.CPBar.frames[i]:Hide()	end
				end
				vexpower.CPBar.frames[i]:SetWidth(width)
				local start = vexpower_SV_profiles[vexpower_SV_data["profile"]]["CPBar"]["design"]["intMode"]["offset"]+(width*(i-1))+(vexpower_SV_profiles[vexpower_SV_data["profile"]]["CPBar"]["design"]["intMode"]["gap"]*(i-1))
				vexpower.CPBar.frames[i]:SetPoint("TOPLEFT", vexpower.CPBar.mainframe, "TOPLEFT", start, 0)
			-- end
		else
			local usage = vexpower.CPBar.getAltPos()
			if vexpower_SV_profiles[vexpower_SV_data["profile"]]["CPBar"]["design"]["altPositioning"][usage] ~= nil then
				vexpower.CPBar.frames[i]:SetHeight(vexpower_SV_profiles[vexpower_SV_data["profile"]]["CPBar"]["design"]["altPositioning"][usage]["height"])
				vexpower.CPBar.frames[i]:SetWidth(vexpower_SV_profiles[vexpower_SV_data["profile"]]["CPBar"]["design"]["altPositioning"][usage]["width"])
				vexpower.CPBar.frames[i]:SetFrameStrata(vexpower.options.strata.convertValues(vexpower_SV_profiles[vexpower_SV_data["profile"]]["data"]["strata"]["cps"]))
				vexpower.CPBar.frames[i]:ClearAllPoints()
				vexpower.CPBar.frames[i]:SetPoint(
					vexpower_SV_profiles[vexpower_SV_data["profile"]]["CPBar"]["design"]["altPositioning"][usage][tostring(i)]["anchor"],
					vexpower.CPBar.mainframe,
					vexpower_SV_profiles[vexpower_SV_data["profile"]]["CPBar"]["design"]["altPositioning"][usage][tostring(i)]["anchorFrame"],
					vexpower_SV_profiles[vexpower_SV_data["profile"]]["CPBar"]["design"]["altPositioning"][usage][tostring(i)]["x"],
					vexpower_SV_profiles[vexpower_SV_data["profile"]]["CPBar"]["design"]["altPositioning"][usage][tostring(i)]["y"])
			else
				if vexpower.CPBar.frames[i]:IsShown()		then 	vexpower.CPBar.frames[i]:Hide()	end
			end
		end
		
		vexpower.CPBar.aniGrps[i] = vexpower.CPBar.frames[i]:CreateAnimationGroup("vexpower.CPBar.aniGrps["..i.."]")
		vexpower.CPBar.aniGrps[i]:SetLooping("NONE")
		vexpower.CPBar.aniGrps[i]:SetScript("OnPlay", function () if not(vexpower.CPBar.frames[i]:IsShown()) then vexpower.CPBar.frames[i]:Show() end end)
		vexpower.CPBar.aniGrps[i]:SetScript("OnFinished", function () if vexpower.CPBar.frames[i]:IsShown() then vexpower.CPBar.frames[i]:Hide() end end)
		vexpower.CPBar.anis[i] = vexpower.CPBar.aniGrps[i]:CreateAnimation("Alpha")
		vexpower.CPBar.anis[i]:SetDuration(0.3)
		vexpower.CPBar.anis[i]:SetOrder(1)
		vexpower.CPBar.anis[i]:SetFromAlpha(vexpower_SV_profiles[vexpower_SV_data["profile"]]["CPBar"]["design"]["colors"]["colors"]["used"]["a"])
		vexpower.CPBar.anis[i]:SetToAlpha(0)
		
	end
end

function vexpower.CPBar.getAltPos()
	if vexpower.CPBar.maxCPs == 10 then
		return "10"
	else
		if vexpower_SV_profiles[vexpower_SV_data["profile"]]["CPBar"]["design"]["altPositioning"][tostring(vexpower.CPBar.maxCPs)] ~= nil then
			if vexpower_SV_profiles[vexpower_SV_data["profile"]]["CPBar"]["design"]["altPositioning"][tostring(vexpower.CPBar.maxCPs)]["change"] then
				return tostring(vexpower.CPBar.maxCPs)
			else
				return "10"
			end
		end
	end
end

function vexpower.CPBar.setMovable(movable)
	if movable ~= nil then
		if vexpower_SV_profiles[vexpower_SV_data["profile"]]["CPBar"]["design"]["position"]["clipToPower"] then
			vexpower_MainFrame:SetMovable(movable)
		else
			vexpower.CPBar.mainframe:SetMovable(movable)
		end
		vexpower.CPBar.mainframe:EnableMouse(movable)
	end
end

function vexpower.CPBar.savePosition()	
	vexpower_SV_profiles[vexpower_SV_data["profile"]]["CPBar"]["design"]["position"]["anchor"] = select(1, vexpower.CPBar.mainframe:GetPoint())
	vexpower_SV_profiles[vexpower_SV_data["profile"]]["CPBar"]["design"]["position"]["anchorFrame"] = select(3, vexpower.CPBar.mainframe:GetPoint())
	vexpower_SV_profiles[vexpower_SV_data["profile"]]["CPBar"]["design"]["position"]["x"] = select(4, vexpower.CPBar.mainframe:GetPoint())
	vexpower_SV_profiles[vexpower_SV_data["profile"]]["CPBar"]["design"]["position"]["y"] = select(5, vexpower.CPBar.mainframe:GetPoint())
end

function vexpower.CPBar.toggleBGColor()
	if vexpower.testmode.activated then
		vexpower.CPBar.mainframe:SetBackdropColor(1,1,1,0.3)
	else
		vexpower.CPBar.mainframe:SetBackdropColor(0,0,0,0)
	end
end

function vexpower.CPBar.setMainframe()
	vexpower.CPBar.mainframe:ClearAllPoints()
	vexpower.CPBar.mainframe:SetWidth(vexpower_SV_profiles[vexpower_SV_data["profile"]]["powerbar"]["design"]["size"]["width"])
	vexpower.CPBar.mainframe:SetHeight(vexpower_SV_profiles[vexpower_SV_data["profile"]]["powerbar"]["design"]["size"]["height"])
	vexpower.CPBar.mainframe:SetBackdrop({
		bgFile="Interface\\Buttons\\WHITE8X8", edgeFile=vexpower.LSM:Fetch("border", vexpower_SV_profiles[vexpower_SV_data["profile"]]["powerbar"]["design"]["border"]["texture"]), tile=false,
		edgeSize=vexpower_SV_profiles[vexpower_SV_data["profile"]]["powerbar"]["design"]["border"]["size"]})
		
	if not(vexpower.testmode.activated) then
		vexpower.CPBar.mainframe:SetBackdropColor(0,0,0,0)
	else
		vexpower.CPBar.mainframe:SetBackdropColor(1,1,1,0.3)
	end
	
	vexpower.CPBar.mainframe:SetBackdropBorderColor(0,0,0,0)
	
	if vexpower_SV_profiles[vexpower_SV_data["profile"]]["CPBar"]["design"]["position"]["clipToPower"] then
		vexpower.CPBar.mainframe:SetPoint(
			vexpower_SV_profiles[vexpower_SV_data["profile"]]["CPBar"]["design"]["position"]["anchor"],
			vexpower_MainFrame,
			vexpower_SV_profiles[vexpower_SV_data["profile"]]["CPBar"]["design"]["position"]["anchorFrame"],
			vexpower_SV_profiles[vexpower_SV_data["profile"]]["CPBar"]["design"]["position"]["x"],
			vexpower_SV_profiles[vexpower_SV_data["profile"]]["CPBar"]["design"]["position"]["y"])
	else
		vexpower.CPBar.mainframe:SetPoint(
			vexpower_SV_profiles[vexpower_SV_data["profile"]]["CPBar"]["design"]["position"]["anchor"],
			UIparent,
			vexpower_SV_profiles[vexpower_SV_data["profile"]]["CPBar"]["design"]["position"]["anchorFrame"],
			vexpower_SV_profiles[vexpower_SV_data["profile"]]["CPBar"]["design"]["position"]["x"],
			vexpower_SV_profiles[vexpower_SV_data["profile"]]["CPBar"]["design"]["position"]["y"])
	end
	
	vexpower.CPBar.mainframe:RegisterForDrag("LeftButton")
	vexpower.CPBar.mainframe:SetScript("OnDragStart", function ()
		if vexpower_SV_profiles[vexpower_SV_data["profile"]]["CPBar"]["design"]["position"]["clipToPower"] then
			vexpower_MainFrame:StartMoving()
		else
			vexpower.CPBar.mainframe:StartMoving()
		end end)
	vexpower.CPBar.mainframe:SetScript("OnDragStop", function ()
		if vexpower_SV_profiles[vexpower_SV_data["profile"]]["CPBar"]["design"]["position"]["clipToPower"] then
			vexpower_MainFrame:StopMovingOrSizing()
			vexpower.mainframe.savePositon()
		else
			vexpower.CPBar.mainframe:StopMovingOrSizing()
			vexpower.CPBar.savePosition()
		end end)
	vexpower.CPBar.mainframe:SetMovable(vexpower.testmode.activated)
	vexpower.CPBar.mainframe:EnableMouse(vexpower.testmode.activated)
end

function vexpower.CPBar.showHandler()	-- XXXXXXXXXXXXXXXXXXXXXXXXX
	for i=1, #vexpower.CPBar.frames do
		if vexpower.CPBar.frames[i] ~=nil then
			if i <= vexpower.CPBar.currentCP[1] then
				if not(vexpower.CPBar.frames[i]:IsShown())	then 	vexpower.CPBar.frames[i]:Show()	end
			else
				if vexpower.CPBar.frames[i]:IsShown()		then 	vexpower.CPBar.frames[i]:Hide()	end
			end
		end
	end
end

function vexpower.CPBar.playSound()
	local x = vexpower_SV_profiles[vexpower_SV_data["profile"]]["CPBar"]["sound"]["threshold"]
	if vexpower.CPBar.currentCP[2] < x and vexpower.CPBar.currentCP[1] >= x and vexpower_SV_profiles[vexpower_SV_data["profile"]]["CPBar"]["sound"]["activate"] then
		PlaySoundFile(vexpower.LSM:Fetch("sound", vexpower_SV_profiles[vexpower_SV_data["profile"]]["CPBar"]["sound"]["file"]), vexpower_SV_profiles[vexpower_SV_data["profile"]]["CPBar"]["sound"]["channel"])
	end
end
