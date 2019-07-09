-- If you aren't a rogue/druid, then disable the addon
if select(2, UnitClass("player")) ~= "ROGUE" and select(2, UnitClass("player")) ~= "DRUID" then
	return
end

local f = CreateFrame("frame")
local max_combo_points = 5
local xpos = 0
local ypos = 0
local r = 0.9686274509803922
local g = 0.674509803921568
local b = 0.1450980392156863
local scale = 1
local hidenocombat = false
local leftanchor = "CENTER"
local cpframes = {}
local apframes = {}
local locked_by_druid_form = false
local currently_shown = true
local alpha_value = 1.0
local has_initialized = false

local anticipation_enabled = true
local anticipation_r = 0.9
local anticipation_g = 0.05
local anticipation_b = 0.15
local anticipation_scale = 1
local anticipation_position = "above"
local apframes_shown = false

local max_anticipation = 5

local anticipation_overlap = false
local anticipation_replace = false

local anticipation_name = "Anticipation"

local catFormID = 2

f:SetScript("OnEvent", function(self, event, ...)
    self[event](self, ...)
end)


local function updateCatFormID()
	local level = UnitLevel("player")
	if level < 8 then
		catFormID = 1
	else
		catFormID = 2
	end
end

local function refreshDisplayState()
	if locked_by_druid_form then
		return
	end

	if not InCombatLockdown() and UnitPower("player", 4) == 0 and hidenocombat then
		for i = 1,max_combo_points do
			cpframes[i]:Hide()
		end
		currently_shown = false
	else
		if not currently_shown then
			for i = 1,max_combo_points do
				cpframes[i]:Show()
			end
			currently_shown = true
		end
	end
end

local function updateCP()
	--local power = GetComboPoints("player")
	local power = UnitPower("player", 4)
	local i = 1
	local a_count = 0

	if power > max_combo_points then
		a_count = power - max_combo_points
		power = max_combo_points
	end


	if anticipation_overlap or anticipation_replace then
		--local _, _, _, a_count =  UnitAura("player", anticipation_name)

		if a_count == nil then
			a_count = 0
		end

		if a_count > max_combo_points then
			a_count = max_combo_points
		end


		if power >= max_combo_points then
		
			power = power + a_count
			power = power - max_combo_points

			while i <= power do
				cpframes[i]:SetBackdropColor(anticipation_r, anticipation_g, anticipation_b, alpha_value)
				i = 1 + i
			end

			while i <= max_combo_points do
				if anticipation_replace then
					cpframes[i]:SetBackdropColor(anticipation_r, anticipation_g, anticipation_b, 0.1)
				else
					cpframes[i]:SetBackdropColor(r, g, b, alpha_value)
				end
				i = 1 + i
			end

			if hidenocombat then
				refreshDisplayState()
			end

			return
		end

	end

	while i <= power do
		cpframes[i]:SetBackdropColor(r, g, b, alpha_value)
		i = 1 + i
	end

	while i <= max_combo_points do
		cpframes[i]:SetBackdropColor(r, g, b, 0.1)
		i = 1 + i
	end

	if hidenocombat then
		refreshDisplayState()
	end

	if currently_shown and anticipation_enabled then
		--local _, _, _, a_count =  UnitAura("player", anticipation_name)

		if a_count == nil then
			a_count = 0
		end

		if a_count == 0 and apframes_shown == true then
			for i = 1,max_anticipation do
				apframes[i]:Hide()
			end
			apframes_shown = false
		end

		if a_count > max_anticipation then
			a_count = max_anticipation
		end

		if a_count > 0 and apframes_shown == false then
			for i = 1,max_anticipation do
				apframes[i]:Show()
			end
			apframes_shown = true
		end

		if apframes_shown then
			local ai = 1

			while ai <= a_count do
				apframes[ai]:SetBackdropColor(anticipation_r, anticipation_g, anticipation_b, alpha_value)
				ai = 1 + ai
			end	

			while ai <= max_anticipation do
				apframes[ai]:SetBackdropColor(anticipation_r, anticipation_g, anticipation_b, 0.1)
				ai = 1 + ai
			end
			
		end

	end
end


local function updateFrames()
	for i = 1,max_combo_points do
		cpframes[i]:SetSize(22, 22)

		cpframes[i]:SetBackdropColor(r, g, b, 0.1)
		cpframes[i]:SetBackdropBorderColor(0, 0, 0, 1)
	 
		if i == 1 then
			cpframes[i]:SetPoint(leftanchor, UIParent, leftanchor, xpos, ypos)
			cpframes[i]:SetScale(scale)

			cpframes[i]:SetMovable(true)
			cpframes[i]:EnableMouse(true)
			cpframes[i]:RegisterForDrag("LeftButton")
			cpframes[i]:SetScript("OnDragStart", function(self)
				if IsAltKeyDown() then
					self:StartMoving()
				end
			end)
			cpframes[i]:SetScript("OnDragStop", function(self)
				self:StopMovingOrSizing()
				anch,_, _, x, y = self:GetPoint(1)
				xpos = x
				SimpleComboPointsDB.xpos = x
				xpos = y
				SimpleComboPointsDB.ypos = y
				leftanchor = anch
				SimpleComboPointsDB.leftanchor = anch

			end)
			

		else
			cpframes[i]:SetPoint("RIGHT", 23, 0)

		end

		cpframes[i]:Show()

	end

	if anticipation_position ~= "off" and anticipation_enabled then

		local r_offset = 0
		for i = 1,max_anticipation do
			apframes[i]:SetSize(22*anticipation_scale, 22*anticipation_scale)

			apframes[i]:SetBackdropColor(anticipation_r, anticipation_g, anticipation_b, 0.1)
			apframes[i]:SetBackdropBorderColor(0, 0, 0, 1)
		 
			if i == 1 then


				if anticipation_position == "above" then
					r_offset = 0
				else
					r_offset = 46
				end


				apframes[i]:SetPoint("TOP", cpframes[1], "TOP", 0, 23-r_offset)
				

			else
				apframes[i]:SetPoint("RIGHT", 23, 0)

			end
			apframes[i]:Hide()

		end
		apframes_shown = false
	end

	has_initialized = true

	updateCP()
end

local function initFrames()
	for i = 1,max_combo_points do
		cpframes[i] = CreateFrame("Frame", "SCPFrame"..i, i == 1 and UIParent or cpframes[i-1])
		cpframes[i]:SetBackdrop({bgFile=[[Interface\ChatFrame\ChatFrameBackground]],edgeFile=[[Interface/Tooltips/UI-Tooltip-Border]],tile=true,tileSize=4,edgeSize=4,insets={left=0.5,right=0.5,top=0.5,bottom=0.5}})

	end

	for i = 1,max_anticipation do
		apframes[i] = CreateFrame("Frame", "ASCPFrame"..i, i == 1 and cpframes[1] or apframes[i-1])
		apframes[i]:SetBackdrop({bgFile=[[Interface\ChatFrame\ChatFrameBackground]],edgeFile=[[Interface/Tooltips/UI-Tooltip-Border]],tile=true,tileSize=4,edgeSize=4,insets={left=0.5,right=0.5,top=0.5,bottom=0.5}})

	end

	updateFrames()
end

local function destroyFrames()
	for i = 1,max_combo_points do
		cpframes[i]:Hide()
		cpframes[i] = nil
	end
	cpframes = {}
end

local function updateMaxpower()
	local maxpower = UnitPowerMax("player", 4)
	local old_maxpower = max_combo_points
	if maxpower == 6 then
		max_combo_points = 6
	else
		max_combo_points = 5
		maxpower = 5
	end

	if old_maxpower == maxpower then
		return
	end

	if not has_initialized then
		return
	end


	if old_maxpower == 6 and maxpower == 5 then
		if cpframes[6] ~= nil then
			cpframes[6]:Hide()
		end
	elseif old_maxpower == 5 and maxpower == 6 then
		if cpframes[6] ~= nil then
			cpframes[6]:Show()
		else
			cpframes[6] = CreateFrame("Frame", "SCPFrame6", cpframes[5])
			cpframes[6]:SetBackdrop({bgFile=[[Interface\ChatFrame\ChatFrameBackground]],edgeFile=[[Interface/Tooltips/UI-Tooltip-Border]],tile=true,tileSize=4,edgeSize=4,insets={left=0.5,right=0.5,top=0.5,bottom=0.5}})
			cpframes[6]:SetSize(22, 22)
			cpframes[6]:SetBackdropColor(r, g, b, 0.1)
			cpframes[6]:SetBackdropBorderColor(0, 0, 0, 1)
			cpframes[6]:SetPoint("RIGHT", 23, 0)

			if UnitPower("player", 4) == 0 and hidenocombat and not InCombatLockdown() then
				cpframes[6]:Hide()
			else
				cpframes[6]:Show()
			end


			updateCP()
		end
	elseif old_maxpower ~= maxpower then
		destroyFrames()
		initFrames()
	end
end



function CPColorPickCallback(restore)
	if restore then
		r, g, b = unpack(restore)
	else
		r, g, b = ColorPickerFrame:GetColorRGB();
	end
	
	SimpleComboPointsDB.r = r
	SimpleComboPointsDB.g = g
	SimpleComboPointsDB.b = b

	updateFrames()
end

function A_CPColorPickCallback(restore)
	if restore then
		anticipation_r, anticipation_g, anticipation_b = unpack(restore)
	else
		anticipation_r, anticipation_g, anticipation_b = ColorPickerFrame:GetColorRGB();
	end
	
	SimpleComboPointsDB.anticipationr = anticipation_r
	SimpleComboPointsDB.anticipationg = anticipation_g
	SimpleComboPointsDB.anticipationb = anticipation_b

	updateFrames()
end

function f:PLAYER_ENTERING_WORLD()
	updateCP()
end

function f:UNIT_COMBO_POINTS()
	updateCP()
end

function f:UNIT_POWER_UPDATE(unit, type)
	if unit == "player" then
		updateCP()
	end
end


function f:UPDATE_SHAPESHIFT_FORM()
	if GetShapeshiftForm() == catFormID then
		for i = 1,max_combo_points do
			cpframes[i]:Show()
		end
		locked_by_druid_form = false
	else
		for i = 1,max_combo_points do
			cpframes[i]:Hide()
		end
		locked_by_druid_form = true
	end
	updateCP()
end

function f:PLAYER_REGEN_ENABLED()
	refreshDisplayState()
end

function f:PLAYER_LEVEL_UP(level)
	updateCatFormID()
end

function f:PLAYER_LOGIN()
	updateMaxpower()
end

function f:UNIT_MAXPOWER()
	updateMaxpower()
end


function f:ADDON_LOADED(addon)
	if addon ~= "AnyLua60" then return end
	if select(2, UnitClass("player")) ~= "ROGUE" and select(2, UnitClass("player")) ~= "DRUID" then
		return
	end

	local defaults = {
		xpos = 0,
		ypos = 0,
		r = 0.9686274509803922,
		g = 0.6745098039215687,
		b = 0.1450980392156863,
		scale = 1,
		leftanchor = "CENTER",
		hidenocombat = false, 
		anticipationenabled = true,
		anticipationr = 0.9,
		anticipationg = 0.05,
		anticipationb = 0.15,
		anticipationscale = 1,
		anticipationposition = "above",
		anticipationoverlap = false,
		anticipationreplace = false,
		alpha_value = 1.0

	}
		
	SimpleComboPointsDB = SimpleComboPointsDB or {}
		
	for k,v in pairs(defaults) do
		if SimpleComboPointsDB[k] == nil then
			SimpleComboPointsDB[k] = v
		end
	end


	SLASH_SCP1, SLASH_SCP2 = "/scp", "/simplecombopoints"
	SlashCmdList.SCP = function(txt)
		local cmd, msg = txt:match("^(%S*)%s*(.-)$");
		cmd = string.lower(cmd)
		msg = string.lower(msg)

		if cmd == "reset" then
			xpos = 0
			ypos = 0
			r = 0.9686274509803922
			g = 0.674509803921568
			b = 0.1450980392156863
			scale = 1
			leftanchor = "CENTER"
			alpha_value = 1.0
			SimpleComboPointsDB.xpos = 0
			SimpleComboPointsDB.ypos = 0
			SimpleComboPointsDB.r = 0.9686274509803922
			SimpleComboPointsDB.g = 0.674509803921568
			SimpleComboPointsDB.b = 0.1450980392156863
			SimpleComboPointsDB.scale = 1
			SimpleComboPointsDB.leftanchor = "CENTER"
			SimpleComboPointsDB.alpha_value = 1.0
			
			anticipation_r = 0.9
			anticipation_g = 0.05
			anticipation_b = 0.15
			anticipation_scale = 1
			anticipation_position = "above"
			anticipation_overlap = false
			anticipation_replace = false

			SimpleComboPointsDB.anticipationr = 0.9
			SimpleComboPointsDB.anticipationg = 0.05
			SimpleComboPointsDB.anticipationb = 0.15
			SimpleComboPointsDB.anticipationscale = 1
			SimpleComboPointsDB.anticipationposition = "above"
			SimpleComboPointsDB.anticipationoverlap = false
			SimpleComboPointsDB.anticipationreplace = false

				
			destroyFrames()
			initFrames()

			print("Frame reset to the center, you can now move it to the desired position.")

		elseif cmd == "scale" then
			local num = tonumber(msg)
			if num then
				scale = num
				SimpleComboPointsDB.scale = num

				updateFrames()
			else
				print("Not a valid scale! Scale has to be a number, recommended to be between 0.5 and 3")
			end
		elseif cmd == "alpha" then
			local num = tonumber(msg)
			if num then
				if num <= 1.0 and num >= 0.2 then
					alpha_value = num
					SimpleComboPointsDB.alpha_value = num

					updateCP()
				else
					print("Not a valid alpha value! Alpha has to be a number, and must be between 0.2 and 1")
				end
			else
				print("Not a valid alpha value! Alpha has to be a number, and must be between 0.2 and 1")
			end
		elseif cmd == "anticipation_scale" then
			local num = tonumber(msg)
			if num then
				anticipation_scale = num
				SimpleComboPointsDB.anticipationscale = num

				updateFrames()
			else
				print("Not a valid scale! Scale has to be a number, recommended to be between 0.5 and 3")
			end
		elseif cmd == "anticipation_position" then
			if msg == "above" then
				anticipation_overlap = false
				anticipation_replace = false
				anticipation_position = "above"
				SimpleComboPointsDB.anticipationposition = "above"
				SimpleComboPointsDB.anticipationoverlap = false
				SimpleComboPointsDB.anticipationreplace = false
				anticipation_enabled = true

				print("Setting updated. Anticipation charges will be shown above the main frame.")

			elseif msg == "below" then
				anticipation_overlap = false
				anticipation_replace = false
				anticipation_position = "below"
				SimpleComboPointsDB.anticipationposition = "below"
				SimpleComboPointsDB.anticipationoverlap = false
				SimpleComboPointsDB.anticipationreplace = false
				anticipation_enabled = true

				print("Setting updated. Anticipation charges will be shown below the main frame.")

			elseif msg == "off" then
				anticipation_overlap = false
				anticipation_replace = false
				anticipation_position = "off"
				SimpleComboPointsDB.anticipationposition = "off"
				SimpleComboPointsDB.anticipationoverlap = false
				SimpleComboPointsDB.anticipationreplace = false
				anticipation_enabled = false
				for i = 1,max_anticipation do
					apframes[i]:Hide()
				end

				print("Setting updated. Anticipation charges will not be tracked.")

			elseif msg == "overlap" then
				anticipation_overlap = true
				anticipation_replace = false
				anticipation_position = "off"
				SimpleComboPointsDB.anticipationposition = "off"
				SimpleComboPointsDB.anticipationoverlap = true
				SimpleComboPointsDB.anticipationreplace = false
				anticipation_enabled = false
				for i = 1,max_anticipation do
					apframes[i]:Hide()
				end

				print("Setting updated. Anticipation will now overlap the combo points when you have anticipation charges.")

			elseif msg == "replace" then
				anticipation_overlap = false
				anticipation_replace = true
				anticipation_position = "off"
				SimpleComboPointsDB.anticipationposition = "off"
				SimpleComboPointsDB.anticipationoverlap = false
				SimpleComboPointsDB.anticipationreplace = true
				anticipation_enabled = false
				for i = 1,max_anticipation do
					apframes[i]:Hide()
				end

				print("Setting updated. Anticipation will now replace the combo points when you have anticipation charges.")

			else
				print("Invalid position. The position has to be above, below, overlap, replace or off.")	
			end

			updateFrames()	
		elseif cmd == "color" or cmd == "colour" then
			ColorPickerFrame.func, ColorPickerFrame.opacityFunc, ColorPickerFrame.cancelFunc = CPColorPickCallback, CPColorPickCallback, CPColorPickCallback
			ColorPickerFrame:SetColorRGB(r,g,b)
			ColorPickerFrame.previousValues = {r,g,b}
			ColorPickerFrame:Hide() -- apparently needed...
			ColorPickerFrame:Show()
			updateFrames()
		elseif cmd == "anticipation_color" or cmd == "anticipation_colour" then
			ColorPickerFrame.func, ColorPickerFrame.opacityFunc, ColorPickerFrame.cancelFunc = A_CPColorPickCallback, A_CPColorPickCallback, A_CPColorPickCallback
			ColorPickerFrame:SetColorRGB(anticipation_r,anticipation_g,anticipation_b)
			ColorPickerFrame.previousValues = {anticipation_r,anticipation_g,anticipation_b}
			ColorPickerFrame:Hide() -- apparently needed...
			ColorPickerFrame:Show()
			updateFrames()
		elseif cmd  == "nocombat" then
			if msg == "on" then
				hidenocombat = false
				SimpleComboPointsDB.hidenocombat = false
				refreshDisplayState()
			elseif msg == "off" then
				hidenocombat = true
				SimpleComboPointsDB.hidenocombat = true
				refreshDisplayState()
			else
				print("|cffff0000Invalid command!|r Use |cff3399FF/scp nocombat off|r or |cff3399FF/scp nocombat on|r")
			end
		else
			print("|cff3399FF/scp|r usage:")
			print("|cff3399FF/scp reset|r Resets the addon back to default settings. Use if you can't see the frame and/or dragged it out of the screen.")
			print("|cff3399FF/scp color|r Open the color picker window.")
			print("|cff3399FF/scp scale|r Change the scale of the addon (default: 1, don't use values larger than 3)")
			print("|cff3399FF/scp alpha|r Change the alpha of the combo point boxes (while you have combo points), default value: 1, value must be between 0.2 and 1")
			print("|cff3399FF/scp nocombat|r |cff00cf00on|r | |cffff0000off|r Whether the boxes should be shown outside combat or not.")
			print("|cff3399FF/scp anticipation_color|r Open the anticipation color picker window.")
			print("|cff3399FF/scp anticipation_scale|r Change the scale of the anticipation boxes.")
			print("|cff3399FF/scp anticipation_position above|below|overlap||replace|off |r Change the postition of the anticipation boxes relative the combo point boxes.")
			print("|cff33FF99To move the boxes:|r Alt+Left mouse button on the leftmost box to drag it.")
		end

	end

	xpos = SimpleComboPointsDB.xpos
	ypos = SimpleComboPointsDB.ypos
	r = SimpleComboPointsDB.r
	g = SimpleComboPointsDB.g
	b = SimpleComboPointsDB.b
	scale = SimpleComboPointsDB.scale
	leftanchor = SimpleComboPointsDB.leftanchor
	hidenocombat = SimpleComboPointsDB.hidenocombat
	alpha_value = SimpleComboPointsDB.alpha_value

	anticipation_r = SimpleComboPointsDB.anticipationr
	anticipation_g = SimpleComboPointsDB.anticipationg
	anticipation_b = SimpleComboPointsDB.anticipationb
	anticipation_scale = SimpleComboPointsDB.anticipationscale
	anticipation_position = SimpleComboPointsDB.anticipationposition
	anticipation_overlap = SimpleComboPointsDB.anticipationoverlap
	anticipation_replace = SimpleComboPointsDB.anticipationreplace

	local locale = GetLocale()
	if locale == "ruRU" then
		anticipation_name = "Предчувствие"
	elseif locale == "deDE" then
		anticipation_name = "Erwartung"
	elseif locale == "esES" or locale == "esMX" then
		anticipation_name = "Anticipación"
	elseif locale == "ptBR" then
		anticipation_name = "Antecipação"
	elseif locale == "enUS" then
		anticipation_name = "Anticipation"
	else
		anticipation_name = GetSpellInfo(114015)
	end

	updateCatFormID()
	updateMaxpower()

	initFrames()
	-- f:RegisterEvent("UNIT_COMBO_POINTS")
	f:RegisterEvent("UNIT_POWER_UPDATE")
	f:RegisterEvent("UNIT_MAXPOWER")
	f:RegisterEvent("PLAYER_LOGIN")
	f:RegisterEvent("PLAYER_ENTERING_WORLD")
	f:RegisterEvent("PLAYER_REGEN_ENABLED")

	if select(2, UnitClass("player")) == "DRUID" then
		f:RegisterEvent("UPDATE_SHAPESHIFT_FORM")
		f:RegisterEvent("PLAYER_LEVEL_UP")
		f:UPDATE_SHAPESHIFT_FORM()
		anticipation_enabled = false
	end


end

f:RegisterEvent("ADDON_LOADED")

