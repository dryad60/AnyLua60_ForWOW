--------------
-- Cast Bar --
--------------

-- Timer
CastingBarFrame.timer = CastingBarFrame:CreateFontString(nil)
CastingBarFrame.timer:SetFont(STANDARD_TEXT_FONT, 12, "OUTLINE")
CastingBarFrame.timer:SetPoint("TOP", CastingBarFrame, "BOTTOM", 0, 0)
CastingBarFrame.update = .1

--显示图标
CastingBarFrame.Icon:Show() 
CastingBarFrame.Icon:SetHeight( 25 ) 
CastingBarFrame.Icon:SetWidth( 25 ) 
CastingBarFrame.Icon:ClearAllPoints() 
CastingBarFrame.Icon:SetPoint( "RIGHT", CastingBarFrame, "LEFT", -8, 2.5 ) 

CastingBarFrame:HookScript("OnUpdate", function(self, elapsed)
    if not self.timer then return end
    if self.update and self.update < elapsed then
        if self.casting then
            self.timer:SetText(format("%2.1f/%1.1f", max(self.maxValue - self.value, 0), self.maxValue))
        elseif self.channeling then
            self.timer:SetText(format("%.1f", max(self.value, 0)))
        else
            self.timer:SetText("")
        end
        self.update = .1
    else
        self.update = self.update - elapsed
    end
end)

--Target 默认头像才有效
--TargetFrameSpellBar:ClearAllPoints() 
--TargetFrameSpellBar:SetPoint("CENTER",UIParent,"CENTER",-35,-95) --坐标
--TargetFrameSpellBar.SetPoint = function() end
--TargetFrameSpellBar:SetScale(1)--大小 
