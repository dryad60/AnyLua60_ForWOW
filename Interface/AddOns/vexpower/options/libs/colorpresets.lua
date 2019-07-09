vexpower.options.colorpresets.colorset = {
	["1"] = {["r"]=1, ["g"]=0.929, ["b"]=0.0156, ["a"]=1},
	["2"] = {["r"]=0.7725, ["g"]=1, ["b"]=0.043, ["a"]=1},
	["3"] = {["r"]=0.314, ["g"]=1, ["b"]=0.6666, ["a"]=1},
	["4"] = {["r"]=0, ["g"]=1, ["b"]=0.753, ["a"]=1},
	["5"] = {["r"]=0.0078, ["g"]=0.757, ["b"]=1, ["a"]=1},
	["6"] = {["r"]=0.0078, ["g"]=0.757, ["b"]=1, ["a"]=1},
	["7"] = {["r"]=0.0078, ["g"]=0.757, ["b"]=1, ["a"]=1},
	["8"] = {["r"]=0.314, ["g"]=1, ["b"]=0.6666, ["a"]=1},
	["9"] = {["r"]=0, ["g"]=1, ["b"]=0.753, ["a"]=1},
	["10"] = {["r"]=0.0078, ["g"]=0.757, ["b"]=1, ["a"]=1},
	["change"] = {["r"]=1, ["g"]=0, ["b"]=0, ["a"]=1},
	["used"] = {["r"]=1, ["g"]=0.6, ["b"]=0, ["a"]=1},
	}
	
vexpower.options.colorpresets.openTab = {
	["Load"] = false,
	["Create"] = false,
	["Edit"] = false,
	["Delete"] = false,
	["Defaults"] = false,
	}
	
function vexpower.options.colorpresets.toggleTab(tab)
	if vexpower.options.colorpresets.openTab[tab] ~= nil then
		vexpower.options.colorpresets.closeAllTabs()
		vexpower.options.colorpresets.openTab[tab] = true
	end
end

function vexpower.options.colorpresets.closeAllTabs()
	for key in pairs(vexpower.options.colorpresets.openTab) do
		vexpower.options.colorpresets.openTab[key] = false
	end
	vexpower.options.colorpresets.statusMsg = ""
end

vexpower.options.colorpresets.editName = ""
vexpower.options.colorpresets.statusMsg = " "

function vexpower.options.colorpresets.checkForExist(name)
	if name == nil then
		name = vexpower.options.colorpresets.saveName
	end
	
	if vexpower_SV_colorsets[name] ~= nil then
		return true
	else
		return false
	end
end

function vexpower.options.colorpresets.create()
	if vexpower_SV_colorsets[vexpower.options.colorpresets.editName] ~= nil then
		vexpower_SV_colorsets[vexpower.options.colorpresets.editName] = vexpower.data.lib.copyTable(vexpower.options.colorpresets.colorset)
	end
end

function vexpower.options.colorpresets.delete()
	if vexpower_SV_colorsets[vexpower.options.colorpresets.editName] ~= nil then
		vexpower_SV_colorsets[vexpower.options.colorpresets.editName] = nil
		vexpower.options.colorpresets.statusMsg = "|CFF00FF00Successfully deleted ColorSet '"..vexpower.options.colorpresets.editName.."'|r"
		vexpower.options.colorpresets.editName = ""
	end
end

function vexpower.options.colorpresets.loadDefaults()
	local counter = 0
	for key, val in pairs(vexpower.defaults.colorPresets) do
		vexpower_SV_colorsets[key] =vexpower.data.lib.copyTable(val)
		counter = counter +1
	end
	if counter~= 0 then
		vexpower.options.colorpresets.statusMsg = "|CFF00FF00Successfully loaded "..counter.." predefined colorsets|r"
	end
end

function vexpower.options.colorpresets.loadData()
	if vexpower_SV_colorsets[vexpower.options.colorpresets.editName] ~= nil then
		vexpower.options.colorpresets.colorset = vexpower.data.lib.copyTable(vexpower_SV_colorsets[vexpower.options.colorpresets.editName])
	end
end

function vexpower.options.colorpresets.activate(name)
	if name ~= nil then
		if vexpower_SV_colorsets[name] ~= nil then
			vexpower_SV_profiles[vexpower_SV_data["profile"]]["CPBar"]["design"]["colors"]["colors"] = vexpower.data.lib.copyTable(vexpower_SV_colorsets[name])
		end
	else
		if vexpower_SV_colorsets[vexpower.options.colorpresets.editName] ~= nil then
			vexpower_SV_profiles[vexpower_SV_data["profile"]]["CPBar"]["design"]["colors"]["colors"] = vexpower.data.lib.copyTable(vexpower_SV_colorsets[vexpower.options.colorpresets.editName])
		end
	end
end

function vexpower.options.colorpresets.save(create)
	if vexpower_SV_colorsets ~= nil then
		vexpower_SV_colorsets[vexpower.options.colorpresets.editName] = vexpower.data.lib.copyTable(vexpower.options.colorpresets.colorset)
		if create then
			vexpower.options.colorpresets.statusMsg = "|CFF00FF00Successfully created ColorSet '"..vexpower.options.colorpresets.editName.."'|r"
		end
	end
end

function vexpower.options.colorpresets.getList(usedInfo)
	local returnvalue = {}
	local timer = 0
	for key in pairs(vexpower_SV_colorsets) do
		if usedInfo then
			local isSet = false
			local presetFor = ""
			local count = 0
			for class,classdata in pairs(vexpower_SV_profiles[vexpower_SV_data["profile"]]["CPBar"]["design"]["colors"]["classPresets"]["classPresets"]) do
				if key == classdata and vexpower_SV_profiles[vexpower_SV_data["profile"]]["CPBar"]["design"]["colors"]["classPresets"]["activate"] then
					if count ~= 0 then
						presetFor = presetFor..", "
					end
					presetFor= presetFor.."|CFF"..vexpower.data.lib.getColor.classHex(class)..class.."|r"
					count=count+1
				end
			end
			
			if count==0 then
				returnvalue[key]=key
			else
				returnvalue[key]=key.." ("..presetFor..")"
			end
		else
			returnvalue[key]=key
		end
		timer = timer + 1
	end
	
	if not(usedInfo) and timer == 0 then
		returnvalue[""] = "No color sets created"
	end
	
	return returnvalue
end
