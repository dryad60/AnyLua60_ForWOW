function vexpower.markers.handler()
	if not(vexpower.show.CheckHidePowerType("powerbar")) then
		vexpower.markers.ClearMarkers()
		vexpower.markers.SetNewMarkers()
	end
end

function vexpower.markers.ClearMarkers()
	for i=1,#vexpower.markers.created do
		if vexpower.markers.created[i] ~= nil then
			if vexpower.markers.created[i]:IsShown() then vexpower.markers.created[i]:Hide() end
			
			--Dumping Unused Frames into array for later use
			table.insert(vexpower.markers.old,#vexpower.markers.old+1, vexpower.markers.created[i])
		end
		vexpower.markers.created[i]=nil
	end
	vexpower.markers.created = {}
end

function vexpower.markers.SetNewMarkers()
	local markers = vexpower_SV_markers[vexpower_SV_data["profile"]]
	for i,v in ipairs(markers) do
		if vexpower.markers.checkActivation(v["ressource"], v["spec"], v["class"], v["talent"], v["spell"]) then
			vexpower.markers.create(vexpower.powerBar.getWidth(v["position"])-0.5*vexpower_SV_profiles[vexpower_SV_data["profile"]]["powerbar"]["markers"]["width"], v["spell"])
		end
	end
end

function vexpower.markers.checkTalents(talents)
	local returnvalue = true
	for row=1, 7 do
		for talent=1,3 do
			if select(4,GetTalentInfo(row, talent, GetActiveSpecGroup())) and not(talents[row][talent]) then
				returnvalue = false
			end
		end
	end
	return returnvalue
end

function vexpower.markers.checkActivation(ressource, spec, class, talent, spellData)
	return ressource[vexpower.powerBar.powerType] and spec[vexpower.data.specTabID] and class[vexpower.data.classString] and vexpower.markers.checkTalents(talent) and vexpower.markers.checkSpell(spellData)
end

function vexpower.markers.checkSpell(spellData)
	local returnvalue = true
	if spellData~= nil then
		if spellData["active"] then
			returnvalue = vexpower.markers.CheckSpellData(spellData)
		end
	end
	return returnvalue
end

function vexpower.markers.popOldMarker()
	local temp = vexpower.markers.old[#vexpower.markers.old]
	table.remove(vexpower.markers.old,#vexpower.markers.old)
	return temp
end

function vexpower.markers.getFrameToCreate()
	if #vexpower.markers.old > 0 then
		return vexpower.markers.popOldMarker()
	else
		return CreateFrame("Frame", nil, vexpower.powerBar.frames.markers)
	end
end

function vexpower.markers.create(pos, spellData)
	if pos < vexpower.powerBar.maxWidth and vexpower.powerBar.maxPower ~= 0 then
		local temp = vexpower.markers.getFrameToCreate()
		
		temp:SetBackdrop({
			bgFile="Interface\\Buttons\\WHITE8X8", tile=false,
			edgeFile="Interface\\Buttons\\WHITE8X8",
			edgeSize=vexpower_SV_profiles[vexpower_SV_data["profile"]]["powerbar"]["markers"]["border"]["size"]})
							
		if vexpower_SV_profiles[vexpower_SV_data["profile"]]["powerbar"]["markers"]["colorLikeBG"] then
		
			local colors = vexpower.powerBar.getBarColors()
			temp:SetBackdropColor(colors[1],colors[2],colors[3],vexpower_SV_profiles[vexpower_SV_data["profile"]]["powerbar"]["markers"]["color"]["a"])
		else
			temp:SetBackdropColor(
				vexpower_SV_profiles[vexpower_SV_data["profile"]]["powerbar"]["markers"]["color"]["r"],
				vexpower_SV_profiles[vexpower_SV_data["profile"]]["powerbar"]["markers"]["color"]["g"],
				vexpower_SV_profiles[vexpower_SV_data["profile"]]["powerbar"]["markers"]["color"]["b"],
				vexpower_SV_profiles[vexpower_SV_data["profile"]]["powerbar"]["markers"]["color"]["a"])
		end
		
		
		if vexpower_SV_profiles[vexpower_SV_data["profile"]]["powerbar"]["markers"]["border"]["colorLikeBG"] then
			local colors = vexpower.powerBar.getBarColors()
			temp:SetBackdropBorderColor(colors[1],colors[2],colors[3],vexpower_SV_profiles[vexpower_SV_data["profile"]]["powerbar"]["design"]["BarColor"]["a"])
		else
			temp:SetBackdropBorderColor(vexpower_SV_profiles[vexpower_SV_data["profile"]]["powerbar"]["markers"]["border"]["color"]["r"],
											vexpower_SV_profiles[vexpower_SV_data["profile"]]["powerbar"]["markers"]["border"]["color"]["g"],
											vexpower_SV_profiles[vexpower_SV_data["profile"]]["powerbar"]["markers"]["border"]["color"]["b"],
											vexpower_SV_profiles[vexpower_SV_data["profile"]]["powerbar"]["markers"]["border"]["color"]["a"])
		end
		
		temp:SetFrameStrata(vexpower.options.strata.convertValues(vexpower_SV_profiles[vexpower_SV_data["profile"]]["data"]["strata"]["markers"]))
		temp:SetWidth(vexpower_SV_profiles[vexpower_SV_data["profile"]]["powerbar"]["markers"]["width"])
		temp:SetHeight(vexpower_SV_profiles[vexpower_SV_data["profile"]]["powerbar"]["design"]["size"]["height"]-(vexpower_SV_profiles[vexpower_SV_data["profile"]]["powerbar"]["design"]["border"]["size"]*2)-4)
		
		temp:SetPoint("TOPLEFT", vexpower.powerBar.frames.barBG, "TOPLEFT", pos, -vexpower_SV_profiles[vexpower_SV_data["profile"]]["powerbar"]["design"]["border"]["size"]-2)
		
		temp:Show()
		table.insert(vexpower.markers.created,#vexpower.markers.created+1, temp)
	end
end

function vexpower.markers.CheckSpellData(spellData)
	local returnvalue = false
	local stacks = vexpower.markers.getSpellStack(spellData["identifier"]["id"], spellData["identifier"]["name"], spellData["spelltype"])
	local threshold = tonumber(spellData["stackControl"]["stacks"])
	if spellData["stackControl"]["active"] then
		if spellData["stackControl"]["arithmetic"] == ">" then
			if stacks > threshold then
				returnvalue = true
			end
		elseif spellData["stackControl"]["arithmetic"] == ">=" then
			if stacks >= threshold then
				returnvalue = true
			end
		elseif spellData["stackControl"]["arithmetic"] == "=" then
			if stacks == threshold then
				returnvalue = true
			end
		elseif spellData["stackControl"]["arithmetic"] == "<=" then
			if stacks <= threshold then
				returnvalue = true
			end
		else
			if stacks < threshold then
				returnvalue = true
			end
		end
	else
		if stacks > 0 then
			returnvalue = true
		end
	end
	
	return returnvalue
end

function vexpower.markers.getSpellStack(auraid, auraname, spelltype)
	local count = 0
	local continue = true
	local i = 1
	local identifyByID = true
	--local identifyByID = false
	--if auraid ~= "" then identifyByID = true	end
	if spelltype == "buff" then
		while continue do
			if UnitBuff("player", i, nil, "PLAYER") == nil then
				continue = false
			else
				if identifyByID then
					if select(10, UnitBuff("player", i)) == auraid then
						count = select(4, UnitBuff("player", i))
						if count == 0 then count = 1 end
						continue = false
					end
				else
					if select(1, UnitBuff("player", i)) == auraname then
						count = select(4, UnitBuff("player", i))
						if count == 0 then count = 1 end
						continue = false
					end
				end
			end
			i = i + 1
		end
	else
		while continue do
			if UnitDebuff("player", i, nil, "PLAYER") == nil then
				continue = false
			else
				if identifyByID then
					if select(10, UnitDebuff("player", i)) == auraid then
						count = select(4, UnitDebuff("player", i))
						if count == 0 then count = 1 end
						continue = false
					end
				else
					if select(1, UnitDebuff("player", i)) == auraname then
						count = select(4, UnitDebuff("player", i))
						if count == 0 then count = 1 end
						continue = false
					end
				end
			end
			i = i + 1
		end
	end
	return count
end
