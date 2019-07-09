--右左动作条放到主动作条旁边, 4个*3行显示  
for i = 1,12 do                                                                  
	_G["MultiBarLeftButton"..i]:ClearAllPoints()
--	_G["MultiBarLeftButton"..i]:SetScale(1.2)
	if (i == 1 or i == 5 or i == 9) then                                                                                  
		_G["MultiBarLeftButton"..i]:SetPoint("LEFT", MultiBarBottomLeftButton12, "RIGHT", 160, -40 * (i -1) / 4)
	else
		_G["MultiBarLeftButton"..i]:SetPoint("LEFT", _G["MultiBarLeftButton"..i-1], "RIGHT", 3, 0)
	end
end

--右侧右放到屏幕右下
MultiBarRight:ClearAllPoints()---------右侧技能条 
MultiBarRight:SetPoint("BOTTOMRIGHT",UIParent,"BOTTOMRIGHT", 0, 0) 
MultiBarRight.SetPoint = function() end 


--[[
MultiBarRight:ClearAllPoints()---------右侧技能条 
MultiBarRight:SetPoint("RIGHT",UIParent,"RIGHT",-0,-130) 
MultiBarRight.SetPoint = function() end 

MultiBarLeft:ClearAllPoints()----------右侧技能条 
MultiBarLeft:SetPoint("RIGHT",UIParent,"RIGHT",-40,-130) 
MultiBarLeft.SetPoint = function() end 
]]

--[[
--右右动作条1-12实现鼠标划过显示 
local function showhidebar1(alpha) 
    if MultiBarRight:IsShown() then 
	for i=1, 12 do 
    local hb1 = _G["MultiBarRightButton"..i] 
        hb1:SetAlpha(alpha) 
    end 
end 
end 
--实现鼠标划过显示 
for i=1, 12 do 
	local hb1 = _G["MultiBarRightButton"..i] 
	hb1:SetAlpha(0.3) 
	hb1:HookScript("OnEnter", function(self) showhidebar1(1) end) 
	hb1:HookScript("OnLeave", function(self) showhidebar1(0.3) end) 
end 

--右左动作条1-12,实现鼠标划过显示 
local function showhidebar2(alpha) 
	if MultiBarLeft:IsShown() then 
		for i=1, 12 do 
			local hb2 = _G["MultiBarLeftButton"..i] 
			hb2:SetAlpha(alpha) 
		end 
	end 
end 
--实现鼠标划过显示 
for i=1, 12 do 
	local hb2 = _G["MultiBarLeftButton"..i] 
	hb2:SetAlpha(0.3) 
	hb2:HookScript("OnEnter", function(self) showhidebar2(1) end) 
	hb2:HookScript("OnLeave", function(self) showhidebar2(0.3) end) 
end
]]
