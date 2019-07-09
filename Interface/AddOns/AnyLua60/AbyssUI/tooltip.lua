------------------------------------------------------------------------
-- Tooltip Class Color Name
-- Thanks to Phanx for this script (maybe include some modifications) --
------------------------------------------------------------------------

GameTooltip:HookScript("OnTooltipSetUnit", function(GameTooltip)
	--print("OnTooltipSetUnit")
	local _, unit = GameTooltip:GetUnit()
	--print(unit)
	if UnitIsPlayer(unit) then
		--print("UnitIsPlayer")
		local _, class = UnitClass(unit)
		--print(class)
		local color = class and (CUSTOM_CLASS_COLORS or RAID_CLASS_COLORS)[class]
		if color then
			local text = GameTooltipTextLeft1:GetText()
			--print(text)
			GameTooltipTextLeft1:SetFormattedText("|cff%02x%02x%02x%s|r", color.r * 255, color.g * 255, color.b * 255, text:match("|cff\x\x\x\x\x\x(.+)|r") or text)
		end
	end
end)
----------------------------------------------------

----------------------------------
-- Tooltip Faction Color Change --
----------------------------------

GameTooltip:HookScript("OnTooltipSetUnit", function(GameTooltip)
	local _, factionGroup
	-- Horde
		if UnitFactionGroup("player") == "Horde" then
			if GameTooltipTextLeft3:GetText() == "Horde" then
				GameTooltipTextLeft3:SetTextColor(255, 0.1, 0)
			elseif GameTooltipTextLeft4 ~= nil and GameTooltipTextLeft4:GetText() == "Horde"then
				GameTooltipTextLeft4:SetTextColor(255, 0.1, 0)
			elseif GameTooltipTextLeft4 ~= nil and GameTooltipTextLeft3:GetText() == "Alliance"then
				GameTooltipTextLeft3:SetTextColor(0, 0.5, 255)
			elseif GameTooltipTextLeft4 ~= nil and GameTooltipTextLeft4:GetText() == "Alliance"then
				GameTooltipTextLeft4:SetTextColor(0, 0.5, 255)
			else
				GameTooltipTextLeft3:SetTextColor(255, 255, 255)
				if GameTooltipTextLeft4 ~= nil then				
					GameTooltipTextLeft4:SetTextColor(255, 255, 255)
				end
			end
		end
  -- Alliance
	if UnitFactionGroup("player") == "Alliance" then
		if GameTooltipTextLeft3:GetText() == "Alliance" then
			GameTooltipTextLeft3:SetTextColor(0, 0.5, 255)
		elseif GameTooltipTextLeft4 ~= nil and GameTooltipTextLeft4:GetText() == "Alliance"then
			GameTooltipTextLeft4:SetTextColor(0, 0.5, 255)
		elseif GameTooltipTextLeft4 ~= nil and GameTooltipTextLeft3:GetText() == "Horde"then
			GameTooltipTextLeft3:SetTextColor(255, 0.1, 0)
		elseif GameTooltipTextLeft4 ~= nil and GameTooltipTextLeft4:GetText() == "Horde"then
			GameTooltipTextLeft4:SetTextColor(255, 0.1, 0)
		else
			GameTooltipTextLeft3:SetTextColor(255, 255, 255)
				if GameTooltipTextLeft4 ~= nil then				
					GameTooltipTextLeft4:SetTextColor(255, 255, 255)
				end
		end
	end
end)
----------------------------------------------------

-----------------------------
-- Tooltip Dark background --
-----------------------------

local TooltipBackground = GameTooltip:CreateTexture(nil, "BACKGROUND", nil, 1)
TooltipBackground:SetPoint("TOPLEFT", 3, -3)
TooltipBackground:SetPoint("BOTTOMRIGHT", -3, 3)
TooltipBackground:SetColorTexture(0.02, 0.02, 0.02)
TooltipBackground:SetAlpha(.05, .05, .05)
----------------------------------------------------

--------------------------------
-- Tooltip Class Color Health --
--------------------------------

GameTooltip:HookScript("OnUpdate", function(self, elapsed)
	local _, unit = GameTooltip:GetUnit()
	if UnitIsPlayer(unit) then
		local _, class = UnitClass(unit)
		local color = class and (CUSTOM_CLASS_COLORS or RAID_CLASS_COLORS)[class]
		if color then
			GameTooltipStatusBar:SetStatusBarColor(color.r, color.g, color.b)
		end
	end
end)
----------------------------------------------------


----------------------------------
-- Tooltip 设置为跟随鼠标 --
--------------------------------
local function AnchorFrameToMouse(frame)
	local x, y = GetCursorPosition()
	local effScale = frame:GetEffectiveScale()
	frame:ClearAllPoints()
	frame:SetPoint("BOTTOM", UIParent, "BOTTOMLEFT", (x / effScale), (y / effScale))
end

hooksecurefunc("GameTooltip_SetDefaultAnchor", function(tooltip, parent)
	tooltip:SetOwner(parent, "ANCHOR_CURSOR")
	AnchorFrameToMouse(tooltip)
	tooltip.default = 1
end)
----------------------------------------------------


--[[
--------------------------------------------------------------------------
-- Tooltip Instant Fade
-- Thanks to sacrife for this script (maybe include some modifications) --
--------------------------------------------------------------------------
GameTooltip.FadeOut = function(self)
	GameTooltip:Hide()
end

local hasUnit
local updateFrame = CreateFrame("Frame")
updateFrame:SetScript("OnUpdate", function(self)
	local _, unit = GameTooltip:GetUnit()
	if hasUnit and not unit then
		GameTooltip:Hide()
		hasUnit = nil
	elseif unit then
		hasUnit = true
	end
end)
]]
