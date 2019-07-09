------------
--  头像  --
------------




--  隐藏自身头像受到伤害、治疗数值
local p=PlayerHitIndicator;p.Show=p.Hide;p:Hide() 
local p=PetHitIndicator;p.Show=p.Hide;p:Hide()




--  隐藏宠物、队友、战场旗手、竞技场框体状态文字
hooksecurefunc("TextStatusBar_UpdateTextString", function(textStatusBar)
	local name = textStatusBar:GetName()
    if (name == "PartyMemberFrame1HealthBar"
        or name == "PartyMemberFrame2HealthBar"
        or name == "PartyMemberFrame3HealthBar"
        or name == "PartyMemberFrame4HealthBar"
        or name == "PartyMemberFrame1ManaBar"
        or name == "PartyMemberFrame2ManaBar"
        or name == "PartyMemberFrame3ManaBar"
        or name == "PartyMemberFrame4ManaBar"
        or name == "ArenaEnemyFrame1HealthBar"
        or name == "ArenaEnemyFrame2HealthBar"
        or name == "ArenaEnemyFrame3HealthBar"
        or name == "ArenaEnemyFrame4HealthBar"
        or name == "ArenaEnemyFrame1ManaBar"
        or name == "ArenaEnemyFrame2ManaBar"
        or name == "ArenaEnemyFrame3ManaBar"
        or name == "ArenaEnemyFrame4ManaBar"
        or name == "PetFrameHealthBar"
        or name == "PetFrameManaBar") then
        if (textStatusBar.lockShow == 0) then
            textStatusBar.TextString:Hide()
            if (textStatusBar.LeftText) then textStatusBar.LeftText:Hide() end
            if (textStatusBar.RightText) then textStatusBar.RightText:Hide() end
        end
    end
end)




--[[  头像、目标、焦点名字字体自定义
PlayerName:SetFont(STANDARD_TEXT_FONT, 14, "THINOUTLINE")
TargetFrameTextureFrameName:SetFont(STANDARD_TEXT_FONT, 14, "THINOUTLINE")
FocusFrameTextureFrameName:SetFont(STANDARD_TEXT_FONT, 14, "THINOUTLINE")]]




--  修正
TargetFrameToTBackground:SetSize(48,16)
FocusFrameToTBackground:SetSize(48,16)




--  死亡骑士隐藏宠物名称
local playerClass = select(2, UnitClass('player'))
if (playerClass == "DEATHKNIGHT") then
    PetName:Hide()
end




--[[  移动玩家、目标头像，坐标自己改
local frame= CreateFrame("Frame")
frame:SetScript("OnEvent", function(f, e, ...)
if InCombatLockdown() then return end
		PlayerFrame:ClearAllPoints()
		PlayerFrame:SetPoint("CENTER",UIParent,"CENTER",-300,0)
		TargetFrame:ClearAllPoints()
		TargetFrame:SetPoint("CENTER",UIParent,"CENTER",300,0)
end)
frame:RegisterEvent("PLAYER_ENTERING_WORLD")
frame:RegisterEvent('ZONE_CHANGED_NEW_AREA');]]




--[[  生命值数字万
	local f=function(v)
		if (v >= 1e8) then
		return ("%.2f亿"):format(v / 1e8)
		--elseif(v >= 1e7) then 
		--return ('%.2f千万'):format(v / 1e7)
		--elseif(v >= 1e6) then 
		--return ('%.2f百万'):format(v / 1e6)
		elseif(v >= 1e4) then 
		return ('%.1f万'):format(v / 1e4)
		else 
		return ("%d"):format(v)
		end 
	end 

	hooksecurefunc("TextStatusBar_UpdateTextString",function(s) 
		if not GetCVarBool("statusTextPercentage") then 
			if 	s.TextString and s.currValue then 
				s.TextString:SetText(f(s.currValue)) 
			end
			if 	s.RightText and s.currValue then
				s.RightText:SetText(f(s.currValue))
			end 
		end 
	end)]]




