-- If you aren't a paladin, then disable the addon
if select(2, UnitClass("player")) ~= "PALADIN" then
	return
end

local f = CreateFrame("frame")
local max_holy_power = 5
local xpos = 0
local ypos = 0
local r = 0.9686274509803922
local g = 0.674509803921568
local b = 0.1450980392156863
local scale = 1
local hidenocombat = false
local leftanchor = "CENTER"
local hpframes = {}
local duetohide = false
local hideDefaultFrames = false
local alpha_value = 1.0


f:SetScript("OnEvent", function(self, event, ...)
    self[event](self, ...)
end)

local function updateHP()
	local power = UnitPower("player", 9)
	local i = 1

	while i <= power do
		hpframes[i]:SetBackdropColor(r, g, b, alpha_value)
		i = 1 + i
	end

	while i <= max_holy_power do
		hpframes[i]:SetBackdropColor(r, g, b, 0.1)
		i = 1 + i
	end

	if duetohide and power == 0 then
		for i = 1,max_holy_power do
			hpframes[i]:Hide()
		end
		duetohide = false
	end

end


local function updateFrames()
	for i = 1,max_holy_power do
		hpframes[i]:SetSize(22, 22)

		hpframes[i]:SetBackdropColor(r, g, b, 0.1)
		hpframes[i]:SetBackdropBorderColor(0, 0, 0, 1)
	 
		if i == 1 then
			hpframes[i]:SetPoint(leftanchor, UIParent, leftanchor, xpos, ypos)
			hpframes[i]:SetScale(scale)

			hpframes[i]:SetMovable(true)
			hpframes[i]:EnableMouse(true)
			hpframes[i]:RegisterForDrag("LeftButton")
			hpframes[i]:SetScript("OnDragStart", function(self)
				if IsAltKeyDown() then
					self:StartMoving()
				end
			end)
			hpframes[i]:SetScript("OnDragStop", function(self)
				self:StopMovingOrSizing()
				anch,_, _, x, y = self:GetPoint(1)
				xpos = x
				SimpleHolyPowerDB.xpos = x
				xpos = y
				SimpleHolyPowerDB.ypos = y
				leftanchor = anch
				SimpleHolyPowerDB.leftanchor = anch

			end)
			

		else
			hpframes[i]:SetPoint("RIGHT", 23, 0)

		end

		hpframes[i]:Show()

	end
	updateHP()
end

local function initFrames()
	for i = 1,max_holy_power do
		hpframes[i] = CreateFrame("Frame", "SHPFrame"..i, i == 1 and UIParent or hpframes[i-1])
		hpframes[i]:SetBackdrop({bgFile=[[Interface\ChatFrame\ChatFrameBackground]],edgeFile=[[Interface/Tooltips/UI-Tooltip-Border]],tile=true,tileSize=4,edgeSize=4,insets={left=0.5,right=0.5,top=0.5,bottom=0.5}})

	end
	updateFrames()
end

local function destroyFrames()
	for i = 1,max_holy_power do
		hpframes[i]:Hide()
		hpframes[i] = nil
	end
	hpframes = {}
end

local function updateDisplayState()
	
	local specId = 0
	local tmp_spec = GetSpecialization()
	if tmp_spec ~= nil then
		specId = GetSpecializationInfo(tmp_spec)
	end

	if specId == 70 then -- ret
		if hidenocombat and not InCombatLockdown() and UnitPower("player", 9) == 0 then
			-- frames are meant to be hidden
		else
			for i = 1,max_holy_power do
				hpframes[i]:Show()
			end
			updateHP()
		end
	else 
		for i = 1,max_holy_power do
			hpframes[i]:Hide()
		end
	end


end



function SHP_ColorPickCallback(restore)
	if restore then
		r, g, b = unpack(restore)
	else
		r, g, b = ColorPickerFrame:GetColorRGB();
	end
	
	SimpleHolyPowerDB.r = r
	SimpleHolyPowerDB.g = g
	SimpleHolyPowerDB.b = b

	updateFrames()
end

function f:PLAYER_ENTERING_WORLD()
	if hideDefaultFrames then
		PaladinPowerBarFrame:Hide()
		PaladinPowerBarFrame.Show = function() end 
	end

	updateHP()
end

function f:SPELLS_CHANGED()
	if hideDefaultFrames then
		PaladinPowerBarFrame:Hide()
		PaladinPowerBarFrame.Show = function() end 
	end
end

function f:PLAYER_LOGIN()
	updateDisplayState()
end

function f:PLAYER_SPECIALIZATION_CHANGED()
	updateDisplayState()
end


function f:UNIT_POWER_UPDATE(unit, type)
	if type == "HOLY_POWER" and unit == "player" then
		updateHP()
	end
end


function f:PLAYER_REGEN_DISABLED()
	local specId = 0
	local tmp_spec = GetSpecialization()
	if tmp_spec ~= nil then
		specId = GetSpecializationInfo(tmp_spec)
	end

	if specId == 70 then
		for i = 1,max_holy_power do
			hpframes[i]:Show()
		end
		duetohide = false
	end
end

function f:PLAYER_REGEN_ENABLED()
	if hidenocombat then
		if UnitPower("player", 9) == 0 then
			for i = 1,max_holy_power do
				hpframes[i]:Hide()
			end
		else
			duetohide = true
		end
	end
end


function f:ADDON_LOADED(addon)
	if addon ~= "AnyLua60" then return end
	if select(2, UnitClass("player")) ~= "PALADIN" then
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
		hideDefaultFrames = false,
		alpha_value = 1.0
	}
		
	SimpleHolyPowerDB = SimpleHolyPowerDB or {}
		
	for k,v in pairs(defaults) do
		if SimpleHolyPowerDB[k] == nil then
			SimpleHolyPowerDB[k] = v
		end
	end


	SLASH_SHP1, SLASH_SHP2 = "/shp", "/simpleholypower"
	SlashCmdList.SHP = function(txt)
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
			SimpleHolyPowerDB.xpos = 0
			SimpleHolyPowerDB.ypos = 0
			SimpleHolyPowerDB.r = 0.9686274509803922
			SimpleHolyPowerDB.g = 0.674509803921568
			SimpleHolyPowerDB.b = 0.1450980392156863
			SimpleHolyPowerDB.scale = 1
			SimpleHolyPowerDB.leftanchor = "CENTER"
			SimpleHolyPowerDB.alpha_value = 1.0
			
			destroyFrames()
			initFrames()

			print("Frame reset to the center, you can now move it to the desired position.")

		elseif cmd == "scale" then
			local num = tonumber(msg)
			if num then
				scale = num
				SimpleHolyPowerDB.scale = num

				updateFrames()
			else
				print("Not a valid scale! Scale has to be a number, recommended to be between 0.5 and 3")
			end
		elseif cmd == "alpha" then
			local num = tonumber(msg)
			if num then
				if num <= 1.0 and num >= 0.2 then
					alpha_value = num
					SimpleHolyPowerDB.alpha_value = num

					updateHP()
				else
					print("Not a valid alpha value! Alpha has to be a number, and must be between 0.2 and 1")
				end
			else
				print("Not a valid alpha value! Alpha has to be a number, and must be between 0.2 and 1")
			end
		elseif cmd == "color" or cmd == "colour" then
			ColorPickerFrame.func, ColorPickerFrame.opacityFunc, ColorPickerFrame.cancelFunc = SHP_ColorPickCallback, SHP_ColorPickCallback, SHP_ColorPickCallback
			ColorPickerFrame:SetColorRGB(r,g,b)
			ColorPickerFrame.previousValues = {r,g,b}
			ColorPickerFrame:Hide() -- apparently needed...
			ColorPickerFrame:Show()
		elseif cmd  == "nocombat" then
			if msg == "on" then
				hidenocombat = false
				SimpleHolyPowerDB.hidenocombat = false
				duetohide = false
				f:UnregisterEvent("PLAYER_REGEN_ENABLED")
				f:UnregisterEvent("PLAYER_REGEN_DISABLED")

				updateDisplayState()
			elseif msg == "off" then
				hidenocombat = true
				SimpleHolyPowerDB.hidenocombat = true
				f:RegisterEvent("PLAYER_REGEN_ENABLED")
				f:RegisterEvent("PLAYER_REGEN_DISABLED")

				if not InCombatLockdown() then
					for i = 1,max_holy_power do
						hpframes[i]:Hide()
					end
				end

			else
				print("|cffff0000Invalid command!|r Use |cff3399FF/shp nocombat off|r or |cff3399FF/shp nocombat on|r")
			end
		elseif cmd == "hidedefault" then
			if msg == "on" then
				hideDefaultFrames = true
				SimpleHolyPowerDB.hideDefaultFrames = true

				PaladinPowerBarFrame:Hide()
				PaladinPowerBarFrame.Show = function() end 
				PaladinPowerBarFrame.OnLoad = function() PaladinPowerBarFrame:Hide() end 

				f:RegisterEvent("SPELLS_CHANGED")

			elseif msg == "off" then
				hideDefaultFrames = false
				SimpleHolyPowerDB.hideDefaultFrames = false
			
				print("|cff3399FFSetting updated, you will however need to re-log or reload UI before the changes will take place.|r")
			else
				print("Invalid usage, use |cff3399FF/shp hidedefault|r |cff00cf00on|r | |cffff0000off|r  ")
			end

		else
			print("|cff3399FF/shp|r usage:")
			print("|cff3399FF/shp reset|r Resets the addon back to default settings. Use if you can't see the frame and/or dragged it out of the screen.")
			print("|cff3399FF/shp color|r Open the color picker window.")
			print("|cff3399FF/shp scale|r Change the scale of the addon (default: 1, don't use values larger than 3)")
			print("|cff3399FF/shp alpha|r Change the alpha of the holy power boxes (while you have holy power), default value: 1, value must be between 0.2 and 1")
			print("|cff3399FF/shp nocombat|r |cff00cf00on|r | |cffff0000off|r Whether the boxes should be shown outside combat or not.")
			print("|cff3399FF/shp hidedefault|r |cff00cf00on|r | |cffff0000off|r Whether the Blizzard default holy power frame should be shown or not.")
			print("|cff33FF99To move the boxes:|r Alt+Left mouse button on the leftmost box to drag it.")
		end

	end

	xpos = SimpleHolyPowerDB.xpos
	ypos = SimpleHolyPowerDB.ypos
	r = SimpleHolyPowerDB.r
	g = SimpleHolyPowerDB.g
	b = SimpleHolyPowerDB.b
	scale = SimpleHolyPowerDB.scale
	leftanchor = SimpleHolyPowerDB.leftanchor
	hidenocombat = SimpleHolyPowerDB.hidenocombat
	hideDefaultFrames = SimpleHolyPowerDB.hideDefaultFrames
	alpha_value = SimpleHolyPowerDB.alpha_value


	if hidenocombat and not InCombatLockdown() then
		duetohide = true
	end

	initFrames()
	f:RegisterEvent("UNIT_POWER_UPDATE")
	f:RegisterEvent("PLAYER_ENTERING_WORLD")
	
	f:RegisterEvent("PLAYER_LOGIN")
	f:RegisterEvent("PLAYER_SPECIALIZATION_CHANGED")

	if hidenocombat then
		f:RegisterEvent("PLAYER_REGEN_ENABLED")
		f:RegisterEvent("PLAYER_REGEN_DISABLED")
	end

	if hideDefaultFrames then
		PaladinPowerBarFrame:Hide()
		PaladinPowerBarFrame.Show = function() end 
		PaladinPowerBarFrame.OnLoad = function() PaladinPowerBarFrame:Hide() end 
		f:RegisterEvent("SPELLS_CHANGED")
	end




end

f:RegisterEvent("ADDON_LOADED")

