--聊天内容显示时间
for i=1,9 do _G["ChatFrame"..i]:SetTimeVisible(20) end
--渐隐过程持续时间
for i=1,9 do _G["ChatFrame"..i]:SetFadeDuration(3) end
--聊天内容是否渐隐
for i=1,9 do _G["ChatFrame"..i]:SetFading(true) end

-- 默认姓名板仇恨颜色
hooksecurefunc("CompactUnitFrame_OnUpdate", function(frame)
    if C_NamePlate.GetNamePlateForUnit(frame.unit) ~= C_NamePlate.GetNamePlateForUnit("player") and not UnitIsPlayer(frame.unit) and not CompactUnitFrame_IsTapDenied(frame) then
    local threat = UnitThreatSituation("player", frame.unit) or 0
    local reaction = UnitReaction(frame.unit, "player")
        if threat == 3 then
    r, g, b = 1, 0, 0 -- 仇恨是你 红色
        elseif threat == 2 then
    r, g, b = 1, 0.3, 0.3   -- 仇恨降低 淡紫
    elseif threat == 1 then
    r, g, b = 1, 0.2, 0     -- 高仇恨 棕色
        elseif reaction == 4 then
          r, g, b = 1, 1, 0     -- 中立怪 黄色
    else
          r, g, b = 1, 0.5, 0   -- 普通怪 橙色
    end
    frame.healthBar:SetStatusBarColor(r, g, b, 1)
      end
    end)

