local NAME, S = ...
local L = S.L
local f = CreateFrame("Frame")

function f:OnEvent(event, ...)
	if event == "ADDON_LOADED" then
		local addon = ...
		if addon == "Blizzard_TalkingHeadUI" then
			local THF = TalkingHeadFrame
			THF:SetMovable(true)
			THF:SetClampedToScreen(true)
			THF.ignoreFramePositionManager = true -- important
			
			THF:ClearAllPoints()
			THF:SetPoint("TOP", nil, "TOP", 0, -5)
			THF:SetScale(0.85)
			--THF:EnableMouse(false)
			self:UnregisterEvent(event)
		end
	end
end

f:RegisterEvent("ADDON_LOADED")
f:SetScript("OnEvent", f.OnEvent)
