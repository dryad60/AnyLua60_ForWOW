vexpower.options.markers.openTab = {
	["information"] = false,
	["Create"] = false,
	["Edit"] = false,
	["delete"] = false,
	["appearance"] = false,
	}
vexpower.options.markers.openSubTab = {
	["specs"] = false,
	["classes"] = false,
	["powertypes"] = false,
	["talents"] = false,
	["spells"] = false,
	}
	
function vexpower.options.markers.toggleTab(tab)
	if vexpower.options.markers.openTab[tab] ~= nil then
		vexpower.options.markers.closeAllTabs()
		vexpower.options.markers.openTab[tab] = true
	end
end
	
function vexpower.options.markers.closeAllTabs()
	for key in pairs(vexpower.options.markers.openTab) do
		vexpower.options.markers.openTab[key] = false
	end
end

function vexpower.options.markers.toggleSubTab(tab)
	if vexpower.options.markers.openSubTab[tab] ~= nil then
		vexpower.options.markers.closeAllSubTabs()
		vexpower.options.markers.openSubTab[tab] = true
	end
end
	
function vexpower.options.markers.closeAllSubTabs()
	for key in pairs(vexpower.options.markers.openSubTab) do
		vexpower.options.markers.openSubTab[key] = false
	end
end

vexpower.options.markers.LocationCreate = ""
vexpower.options.markers.NameCreate = ""
vexpower.options.markers.idEdit = 0
vexpower.options.markers.specsCreate = {
	[1] = true,
	[2] = true,
	[3] = true,
	[4] = true,
	}
vexpower.options.markers.powertypesCreate = {
	["FOCUS"] = true,
	["MANA"] = true,
	["RUNIC_POWER"] = true,
	["ENERGY"] = true,
	["RAGE"] = true,
	["PAIN"] = true,
	["FURY"] = true,
	["INSANITY"] = true,
	["MAELSTROM"] = true,
	["LUNAR_POWER"] = true,
	}
vexpower.options.markers.classesCreate = {
	["DEATHKNIGHT"] = true,
	["DEMONHUNTER"] = true,
	["DRUID"] = true,
	["HUNTER"] = true,
	["MAGE"] = true,
	["MONK"] = true,
	["PALADIN"] = true,
	["PRIEST"] = true,
	["ROGUE"] = true,
	["SHAMAN"] = true,
	["WARLOCK"] = true,
	["WARRIOR"] = true,
	}
vexpower.options.markers.talentsCreate = {
	[1] = {true, true, true},
	[2] = {true, true, true},
	[3] = {true, true, true},
	[4] = {true, true, true},
	[5] = {true, true, true},
	[6] = {true, true, true},
	[7] = {true, true, true},
	}
vexpower.options.markers.spellCreate = {
	["active"] = false,
	["spelltype"] = "buff",
	["identifier"] = {
		["name"] = "",
		["id"] = "",
		},
	["stackControl"] = {
		["active"] = false,
		["stacks"] = 0,
		["arithmetic"] = ">=",
		},
	}
vexpower.options.markers.spellCreateDefault = {
	["active"] = false,
	["spelltype"] = "buff",
	["identifier"] = {
		["name"] = "",
		["id"] = "",
		},
	["stackControl"] = {
		["active"] = false,
		["stacks"] = 0,
		["arithmetic"] = ">=",
		},
	}
vexpower.options.markers.spellCreateIdentify = "name"
vexpower.options.markers.spellArithmeticDecode = {
	["1"] = ">",
	["2"] = ">=",
	["3"] = "=",
	["4"] = "<=",
	["5"] = "<",
	}
vexpower.options.markers.spellArithmeticCode = {
	[">"] = "1",
	[">="] = "2",
	["="] = "3",
	["<="] = "4",
	["<"] = "5",
	}
vexpower.options.markers.classesShorts = {
	["DEATHKNIGHT"] = "DK",
	["DEMONHUNTER"] = "DH",
	["DRUID"] = "D",
	["HUNTER"] = "H",
	["MAGE"] = "Ma",
	["MONK"] = "Mo",
	["PALADIN"] = "P",
	["PRIEST"] = "P",
	["ROGUE"] = "R",
	["SHAMAN"] = "S",
	["WARLOCK"] = "W",
	["WARRIOR"] = "WL",
	}
vexpower.options.markers.ressourcesShorts = {
	["FOCUS"] = "F",
	["MANA"] = "M",
	["RUNIC_POWER"] = "RP",
	["ENERGY"] = "E",
	["RAGE"] = "R",
	["PAIN"] = "P",
	["FURY"] = "Fu",
	["INSANITY"] = "I",
	["MAELSTROM"] = "M",
	["LUNAR_POWER"] = "LP",
	}
	
	
vexpower.options.markers.statusMsgCreated = " "
vexpower.options.markers.statusMsgDeleted = " "

function vexpower.options.markers.getList(val)	
	local returnvalue = {}
	
	if #vexpower_SV_markers[vexpower_SV_data["profile"]]>0 then
		for k,v in ipairs(vexpower_SV_markers[vexpower_SV_data["profile"]]) do
			local i = v["position"].." "..k
			
			if vexpower.markers.checkActivation(v["ressource"], v["spec"], v["class"], v["talent"]) then
				returnvalue[i] = "|CFF00ff00"	--color green
			else
				returnvalue[i] = "|CFFff0000"	--color red
			end
			returnvalue[i] = returnvalue[i]..v["position"].."|r '"..v["name"].."'"
			
			
			--Check for activated specs
			local specs = ""
			local timer  = 0
			for key, val in ipairs(v["spec"]) do
				if val then
					if timer == 0 then
						specs = key
					else
						specs = specs..", "..key
					end
					timer = timer + 1
				end
			end
			if timer == 4 then
				returnvalue[i] = returnvalue[i].." [|CFF00FF00all specs|r]"
			elseif timer == 0 then
				returnvalue[i] = returnvalue[i].." [|CFFC41F3Bno specs|r]"
			else
				returnvalue[i] = returnvalue[i].." [spec "..specs.."]"
			end
			
			--Check for activated classes
			timer  = 0
			local class = ""
			for key, val in pairs(v["class"]) do
				if val then
					if timer == 0 then
						class = "|CFF"..vexpower.data.lib.getColor.classHex(key)..vexpower.options.markers.classesShorts[key].."|r"
					else
						class = class..", |CFF"..vexpower.data.lib.getColor.classHex(key)..vexpower.options.markers.classesShorts[key].."|r"
					end
					timer = timer + 1
				end
			end
			if timer == 12 then
				returnvalue[i] = returnvalue[i].." [|CFF00FF00all classes|r]"
			elseif timer == 0 then
				returnvalue[i] = returnvalue[i].." [|CFFC41F3Bno classes|r]"
			else
				returnvalue[i] = returnvalue[i].." ["..class.."]"
			end
			
			--Check for activated ressources
			timer  = 0
			local ressources = ""
			for key, val in pairs(v["ressource"]) do
				if val then
					if timer == 0 then
						ressources = "|CFF"..vexpower.data.lib.getColor.powertypeHex(key)..vexpower.options.markers.ressourcesShorts[key].."|r"
					else
						ressources = ressources..", |CFF"..vexpower.data.lib.getColor.powertypeHex(key)..vexpower.options.markers.ressourcesShorts[key].."|r"
					end
					timer = timer + 1
				end
			end
			if timer == 10 then
				returnvalue[i] = returnvalue[i].." [|CFF00FF00all ressources|r]"
			elseif timer == 0 then
				returnvalue[i] = returnvalue[i].." [|CFFC41F3Bno ressources|r]"
			else
				returnvalue[i] = returnvalue[i].." ["..ressources.."]"
			end
			
			
			--Check for activated talents
			timer  = 0
			local talents = ""
			for row, rowval in ipairs(v["talent"]) do
				for talent, talentval in ipairs(rowval) do
					if talentval then
						timer = timer + 1
					end
				end
			end			
			if timer == 21 then
				returnvalue[i] = returnvalue[i].." [|CFF00FF00all talents|r]"
			elseif timer == 0 then
				returnvalue[i] = returnvalue[i].." [|CFFC41F3Bno talents|r]"
			else
				returnvalue[i] = returnvalue[i].." [some talents]"
			end
			
			
			--Check for activated talents
			if v["spell"]["active"] then
				returnvalue[i] = returnvalue[i].." [|CFF00FF00spell|r]"
			-- else
				-- returnvalue[i] = returnvalue[i].." [|CFFC41F3Bno spell|r]"
			end
		end
	else
		returnvalue[0] = "No markers created"
	end
	
	return returnvalue
end

function vexpower.options.markers.getKeyFromCryptList(val)
	return tonumber(string.match(val, "[%d%%]+ ([%d]+)"))
end

function vexpower.options.markers.createCryptListKey(val)
	local returnvalue = nil
	if vexpower_SV_markers ~= nil then
		if vexpower_SV_markers[vexpower_SV_data["profile"]] ~= nil then
			if vexpower_SV_markers[vexpower_SV_data["profile"]][val] ~= nil then
				returnvalue = vexpower_SV_markers[vexpower_SV_data["profile"]][val]["position"].." "..val
			end
		end	
	end
	return returnvalue
end

function vexpower.options.markers.add(update)
	local pos = vexpower.options.markers.LocationCreate
	
	if vexpower.options.markers.check(pos) then
		local marker  = {
			["position"] = vexpower.options.markers.LocationCreate,
			["name"] = vexpower.options.markers.NameCreate,
			["ressource"] = {},
			["spec"] = {},
			["class"] = {},
			["talent"] = {},
			}
		marker["ressource"] = vexpower.data.lib.copyTable(vexpower.options.markers.powertypesCreate)
		marker["spec"] = vexpower.data.lib.copyTable(vexpower.options.markers.specsCreate)
		marker["class"] = vexpower.data.lib.copyTable(vexpower.options.markers.classesCreate)
		marker["talent"] = vexpower.data.lib.copyTable(vexpower.options.markers.talentsCreate)
		marker["spell"] = vexpower.data.lib.copyTable(vexpower.options.markers.spellCreate)
		if update then
			if vexpower_SV_markers[vexpower_SV_data["profile"]][vexpower.options.markers.idEdit] ~= nil then
				vexpower_SV_markers[vexpower_SV_data["profile"]][vexpower.options.markers.idEdit] = nil
				vexpower_SV_markers[vexpower_SV_data["profile"]][vexpower.options.markers.idEdit] = vexpower.data.lib.copyTable(marker)
			end
		else
			table.insert(vexpower_SV_markers[vexpower_SV_data["profile"]], marker)
			vexpower.options.markers.statusMsgCreated = "|CFF00FF00marker ("..vexpower.options.markers.NameCreate..") successfully created|r"	
			vexpower.options.markers.statusMsgDeleted = " "
		end
	else
		vexpower.options.markers.statusMsgCreated = "|CFFC41F3B'"..pos.."' is not a valid marker|r"
		vexpower.options.markers.statusMsgDeleted = " "
	end
end

function vexpower.options.markers.getTalentName(row,talent)
	local returnvalue = ""
	if select(2,GetTalentInfo(row, talent, GetActiveSpecGroup())) ~= nil then
	returnvalue = "|CFF"..vexpower.data.lib.getColor.classHex(vexpower.data.classString)..select(2,GetTalentInfo(row, talent, GetActiveSpecGroup())).."|r"
		
	end
	return returnvalue
end

function vexpower.options.markers.getTalentRowLevel(row)
	local returnvalue = ""
	if select(2,GetTalentInfo(row, talent, GetActiveSpecGroup())) ~= nil then
	returnvalue = "|CFF"..vexpower.data.lib.getColor.classHex(vexpower.data.classString)..select(2,GetTalentInfo(row, talent, GetActiveSpecGroup())).."|r"
		
	end
	return returnvalue
end

function vexpower.options.markers.load()
	if vexpower_SV_markers[vexpower_SV_data["profile"]][vexpower.options.markers.idEdit] ~= nil then
		vexpower.options.markers.LocationCreate = vexpower_SV_markers[vexpower_SV_data["profile"]][vexpower.options.markers.idEdit]["position"]
		vexpower.options.markers.NameCreate = vexpower_SV_markers[vexpower_SV_data["profile"]][vexpower.options.markers.idEdit]["name"]
		vexpower.options.markers.specsCreate = vexpower.data.lib.copyTable(vexpower_SV_markers[vexpower_SV_data["profile"]][vexpower.options.markers.idEdit]["spec"])
		vexpower.options.markers.powertypesCreate = vexpower.data.lib.copyTable(vexpower_SV_markers[vexpower_SV_data["profile"]][vexpower.options.markers.idEdit]["ressource"])
		vexpower.options.markers.classesCreate = vexpower.data.lib.copyTable(vexpower_SV_markers[vexpower_SV_data["profile"]][vexpower.options.markers.idEdit]["class"])
		vexpower.options.markers.talentsCreate = vexpower.data.lib.copyTable(vexpower_SV_markers[vexpower_SV_data["profile"]][vexpower.options.markers.idEdit]["talent"])
		vexpower.options.markers.spellCreate = vexpower.data.lib.copyTable(vexpower_SV_markers[vexpower_SV_data["profile"]][vexpower.options.markers.idEdit]["spell"])
	else
		vexpower.options.markers.LocationCreate = ""
		vexpower.options.markers.NameCreate = ""
		for key in pairs(vexpower.options.markers.specsCreate) do
			vexpower.options.markers.specsCreate[key] = true
		end
		for key in pairs(vexpower.options.markers.powertypesCreate) do
			vexpower.options.markers.powertypesCreate[key] = true
		end
		for key in pairs(vexpower.options.markers.classesCreate) do
			vexpower.options.markers.classesCreate[key] = true
		end
		for key in pairs(vexpower.options.markers.spellCreate) do
			vexpower.options.markers.spellCreate[key] = vexpower.options.markers.spellCreateDefault[key]
		end
		for r,v in ipairs(vexpower.options.markers.talentsCreate) do
			for t,v in ipairs(v) do
				vexpower.options.markers.talentsCreate[r][t] = true
			end
		end
	end
end

function vexpower.options.markers.check(val)
	local returnvalue = false
	
	if string.gsub(val, "^%d+%%?", "") == "" then
		returnvalue = true
	end
	
	if val == "" then
		returnvalue = false
	end
	
	return returnvalue
end

function vexpower.options.markers.delete()	
	if vexpower_SV_markers[vexpower_SV_data["profile"]][vexpower.options.markers.idEdit] ~= nil then
		table.remove(vexpower_SV_markers[vexpower_SV_data["profile"]], vexpower.options.markers.idEdit)
		vexpower.options.markers.statusMsgDeleted = "|CFF00FF00marker ("..vexpower.options.markers.NameCreate..") successfully deleted|r"
		vexpower.options.markers.statusMsgCreated = " "
		vexpower.options.markers.idEdit = 0
		vexpower.options.markers.load()
	else
		vexpower.options.markers.statusMsgDeleted = "|CFFC41F3BCouldn't delete marker ("..vexpower.options.markers.NameCreate..").|r Marker doesn't exist"
		vexpower.options.markers.statusMsgCreated = " "
	end
end
