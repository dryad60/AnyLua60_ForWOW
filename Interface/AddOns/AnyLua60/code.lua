--聊天内容显示时间
for i=1,9 do _G["ChatFrame"..i]:SetTimeVisible(20) end
--渐隐过程持续时间
for i=1,9 do _G["ChatFrame"..i]:SetFadeDuration(3) end
--聊天内容是否渐隐
for i=1,9 do _G["ChatFrame"..i]:SetFading(true) end
