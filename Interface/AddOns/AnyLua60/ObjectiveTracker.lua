--任务字体
QuestFont:SetFont("Fonts\\ARKai_T.ttf", 18)

--进入FB收起任务栏
local autocollapse = CreateFrame("Frame") 
autocollapse:RegisterEvent("ZONE_CHANGED_NEW_AREA") 
autocollapse:RegisterEvent("PLAYER_ENTERING_WORLD") 
autocollapse:SetScript("OnEvent", 
	function(self) 
		if IsInInstance() then 
			ObjectiveTrackerFrame.userCollapsed = true 
			ObjectiveTracker_Collapse() 
		else 
			ObjectiveTrackerFrame.userCollapsed = nil 
			ObjectiveTracker_Expand() 
		end 
	end
)
