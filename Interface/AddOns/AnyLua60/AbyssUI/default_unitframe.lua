------------------------------------------------------------------------
-- Action Bar Icon Border Remove
-- Thanks to Spyr枚 for this script (maybe include some modifications) --
------------------------------------------------------------------------

hooksecurefunc("ActionButton_ShowGrid", function(Button)
	_G[Button:GetName().."NormalTexture"]:SetVertexColor(.4, .4, .4)
end)

for _, Bar in pairs({ "Action",
	"MultiBarBottomLeft",
	"MultiBarBottomRight",
	"MultiBarLeft",
	"MultiBarRight",
	"Stance",
	"PetAction", }) do
for i = 1, 12 do
	local Button = Bar.."Button"..i
		if _G[Button] then _G[Button.."Icon"]:SetTexCoord(0.06, 0.94, 0.06, 0.94)
		end
	end
end
----------------------------------------------------

--------------------------------------------------------
-- Class Icons (Need Flat Icons or some Texture Pack) --
--------------------------------------------------------

hooksecurefunc("UnitFramePortrait_Update", function(self)
	if self.portrait then
		if UnitIsPlayer(self.unit) then
			local t = CLASS_ICON_TCOORDS[select(2, UnitClass(self.unit))]
			if t then
				self.portrait:SetTexture("Interface\\TargetingFrame\\UI-Classes-Circles")
				self.portrait:SetTexCoord(unpack(t))
			end
		else
			self.portrait:SetTexCoord(0,1,0,1)
		end
	end
end)
----------------------------------------------------

----------------------
-- Class HP Colours --
----------------------

local function colour(statusbar, unit)
	local _, class, c
	if UnitIsPlayer(unit) and UnitIsConnected(unit) and unit == statusbar.unit and UnitClass(unit) then
		_, class = UnitClass(unit)
		c = CUSTOM_CLASS_COLORS and CUSTOM_CLASS_COLORS[class] or RAID_CLASS_COLORS[class]
		statusbar:SetStatusBarColor(c.r, c.g, c.b)
		--PlayerFrameHealthBar:SetStatusBarColor(0,1,0)
	end
end

hooksecurefunc("UnitFrameHealthBar_Update", colour)
hooksecurefunc("HealthBar_OnValueChanged", function(self)
	colour(self, self.unit)
end)
----------------------------------------------------

------------------------------------
-- Class colours on players names --
------------------------------------

local frame = CreateFrame("FRAME")
frame:RegisterEvent("GROUP_ROSTER_UPDATE")
frame:RegisterEvent("PLAYER_TARGET_CHANGED")
frame:RegisterEvent("PLAYER_FOCUS_CHANGED")
frame:RegisterEvent("UNIT_FACTION")

local function eventHandler(self, event, ...)
	if UnitIsPlayer("target") then
		c = RAID_CLASS_COLORS[select(2, UnitClass("target"))]
		TargetFrameNameBackground:SetVertexColor(c.r, c.g, c.b)
	end
	if UnitIsPlayer("focus") then
		c = RAID_CLASS_COLORS[select(2, UnitClass("focus"))]
		FocusFrameNameBackground:SetVertexColor(c.r, c.g, c.b)
	end
end

frame:SetScript("OnEvent", eventHandler)

for _, BarTextures in pairs({TargetFrameNameBackground, FocusFrameNameBackground}) do
	BarTextures:SetTexture("Interface\\TargetingFrame\\UI-StatusBar")
end
----------------------------------------------------

-----------------------
-- Text round values --
-----------------------

hooksecurefunc("TextStatusBar_UpdateTextStringWithValues", function()
	PlayerFrameHealthBar.TextString:SetText(AbbreviateLargeNumbers(UnitHealth("player")))
	--PlayerFrameManaBar.TextString:SetText(AbbreviateLargeNumbers(UnitMana("player")))

	TargetFrameHealthBar.TextString:SetText(AbbreviateLargeNumbers(UnitHealth("target")))
	--TargetFrameManaBar.TextString:SetText(AbbreviateLargeNumbers(UnitMana("target")))

	FocusFrameHealthBar.TextString:SetText(AbbreviateLargeNumbers(UnitHealth("focus")))
	--FocusFrameManaBar.TextString:SetText(AbbreviateLargeNumbers(UnitMana("focus")))
end)
----------------------------------------------------
--
----------------------------------------
-- Target Mob(Enemy) Health Bar Color --
----------------------------------------

local frame = CreateFrame("FRAME")
frame:RegisterEvent("PLAYER_TARGET_CHANGED")
frame:RegisterEvent("PLAYER_FOCUS_CHANGED")

local function eventHandler(self, event, ...)
	if UnitIsEnemy("player", "target") and not UnitIsFriend("player", "target") and not UnitIsPlayer("target") then
		TargetFrameHealthBar:SetStatusBarColor(208/255, 23/255, 42/255)
	elseif not UnitIsEnemy("player", "target") and not UnitIsFriend("player", "target") and not UnitIsPlayer("target") and UnitReaction("player", "target") == 4 then
		TargetFrameHealthBar:SetStatusBarColor(244/255, 243/255, 119/255)
	end
	if UnitIsEnemy("player", "focus") and not UnitIsFriend("player", "focus") and not UnitIsPlayer("focus") then
		FocusFrameHealthBar:SetStatusBarColor(208/255, 23/255, 42/255)
	elseif not UnitIsEnemy("player", "target") and not UnitIsFriend("player", "target") and not UnitIsPlayer("target") and UnitReaction("player", "target") == 4 then
		FocusFrameHealthBar:SetStatusBarColor(244/255, 243/255, 119/255)
	end
end

frame:SetScript("OnEvent", eventHandler)

for _, BarTextures in pairs({TargetFrameNameBackground, FocusFrameNameBackground}) do
	BarTextures:SetTexture("Interface\\TargetingFrame\\UI-StatusBar")
end

-- Keep the color when health changes
hooksecurefunc("HealthBar_OnValueChanged", function()
	if UnitIsEnemy("player", "target") and not UnitIsFriend("player", "target") and not UnitIsPlayer("target") then
		TargetFrameHealthBar:SetStatusBarColor(208/255, 23/255, 42/255)
	elseif not UnitIsEnemy("player", "target") and not UnitIsFriend("player", "target") and not UnitIsPlayer("target") and UnitReaction("player", "target") == 4 then
		TargetFrameHealthBar:SetStatusBarColor(244/255, 243/255, 119/255)
	else
		return nil
	end
	if UnitIsEnemy("player", "focus") and not UnitIsFriend("player", "focus") and not UnitIsPlayer("focus") then
		FocusFrameHealthBar:SetStatusBarColor(208/255, 23/255, 42/255)
	elseif not UnitIsEnemy("player", "target") and not UnitIsFriend("player", "target") and not UnitIsPlayer("target") and UnitReaction("player", "target") == 4 then
		FocusFrameHealthBar:SetStatusBarColor(244/255, 243/255, 119/255)
	else
		return nil
	end
end)
----------------------------------------------------

------------------------------
-- Percent at target health --
------------------------------

FrameList = {"Target", "Focus"}
function UpdateHealthValues(...)
for i = 1, select("#", unpack(FrameList)) do
	local FrameName = (select(i, unpack(FrameList)))
	local Health = AbbreviateLargeNumbers(UnitHealth(FrameName))
	local HealthPercent = (UnitHealth(FrameName)/UnitHealthMax(FrameName))*100
		if HealthPercent > 0 then
			_G[FrameName.."FrameHealthBar"].TextString:SetText(Health.." / " .. " ("..format("%.0f", HealthPercent).."%)")
		else
			_G[FrameName.."FrameHealthBar"].TextString:SetText("")
		end
	end
end

hooksecurefunc("TextStatusBar_UpdateTextStringWithValues", UpdateHealthValues)
----------------------------------------------------
