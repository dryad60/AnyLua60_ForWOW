--------------
--  聊天框  --
--------------



  
----标签字体
----(1)显示标签字体
--[[new fadein func
FCF_FadeInChatFrame = function(self)
  self.hasBeenFaded = true
end

--new fadeout func
FCF_FadeOutChatFrame = function(self)
  self.hasBeenFaded = false
end

FCFTab_UpdateColors = function(self, selected)
  if (selected) then
    self:SetAlpha(1)
    self:GetFontString():SetTextColor(1,0.75,0)
    self.leftSelectedTexture:Show()
    self.middleSelectedTexture:Show()
    self.rightSelectedTexture:Show()
  else
    self:GetFontString():SetTextColor(0.5,0.5,0.5)
    self:SetAlpha(0.3)
    self.leftSelectedTexture:Hide()
    self.middleSelectedTexture:Hide()
    self.rightSelectedTexture:Hide()
  end
end]]
  
  
--[[----(2)隐藏标签字体，但是有BUG
CHAT_TAB_HIDE_DELAY = 1
CHAT_FRAME_TAB_NORMAL_MOUSEOVER_ALPHA = 1
CHAT_FRAME_TAB_NORMAL_NOMOUSE_ALPHA = 0
CHAT_FRAME_TAB_SELECTED_MOUSEOVER_ALPHA = 1
CHAT_FRAME_TAB_SELECTED_NOMOUSE_ALPHA = 0
CHAT_FRAME_TAB_ALERTING_MOUSEOVER_ALPHA = 1
CHAT_FRAME_TAB_ALERTING_NOMOUSE_ALPHA = 1
  
FCFTab_UpdateColors = function(self, selected)
  if (selected) then
    self:GetFontString():SetTextColor(1,0.75,0)
  else
    self:GetFontString():SetTextColor(0.5,0.5,0.5)
  end
end]]




  --add more chat font sizes
for i = 1, 23 do
  CHAT_FONT_HEIGHTS[i] = i+7
end

  
  
  
----按钮的处理
----(1)隐藏所有按钮
--[[hide the menu button
ChatFrameMenuButton:HookScript("OnShow", ChatFrameMenuButton.Hide)
ChatFrameMenuButton:Hide()

--hide the QuickJoinToast button
QuickJoinToastButton:HookScript("OnShow", QuickJoinToastButton.Hide)
QuickJoinToastButton:Hide()

--don't cut the toastframe
BNToastFrame:SetClampedToScreen(true)
BNToastFrame:SetClampRectInsets(-15,15,15,-15)]]


----(2)渐隐表情按钮，黯淡显示好友数字
QuickJoinToastButton:SetAlpha(0)
QuickJoinToastButton:SetScript("OnEnter", function()
	QuickJoinToastButton:FadeIn()
end)
QuickJoinToastButton:SetScript("OnLeave", function()
	QuickJoinToastButton:FadeOut()
end)

ChatFrameMenuButton:SetAlpha(0)
ChatFrameMenuButton:SetScript("OnEnter", function()
	ChatFrameMenuButton:FadeIn()
end)
ChatFrameMenuButton:SetScript("OnLeave", function()
	ChatFrameMenuButton:FadeOut()
end)

ChatFrameChannelButton:SetAlpha(0)
ChatFrameChannelButton:SetScript("OnEnter", function()
	ChatFrameChannelButton:FadeIn()
end)
ChatFrameChannelButton:SetScript("OnLeave", function()
	ChatFrameChannelButton:FadeOut()
end)

ChatFrameToggleVoiceDeafenButton:SetAlpha(0)
ChatFrameToggleVoiceDeafenButton:SetScript("OnEnter", function()
	ChatFrameToggleVoiceDeafenButton:FadeIn()
end)
ChatFrameToggleVoiceDeafenButton:SetScript("OnLeave", function()
	ChatFrameToggleVoiceDeafenButton:FadeOut()
end)

ChatFrameToggleVoiceMuteButton:SetAlpha(0)
ChatFrameToggleVoiceMuteButton:SetScript("OnEnter", function()
	ChatFrameToggleVoiceMuteButton:FadeIn()
end)
ChatFrameToggleVoiceMuteButton:SetScript("OnLeave", function()
	ChatFrameToggleVoiceMuteButton:FadeOut()
end)

ChatFrame1ButtonFrame:Hide()
ChatFrame2ButtonFrame:Hide()
ChatFrame3ButtonFrame:Hide()
ChatFrame4ButtonFrame:Hide()
ChatFrame5ButtonFrame:Hide()

--[[QuickJoinToastButton:ClearAllPoints()
QuickJoinToastButton:SetPoint("BOTTOMRIGHT", ChatFrame1, "TOPLEFT", 0, -15)
QuickJoinToastButton.FriendsButton:SetAlpha(0)
QuickJoinToastButton.FriendCount:SetTextColor( 0.5, 0.5, 0.5, 1)
QuickJoinToastButton.FriendCount:SetAlpha(0.1)]]




-----------------------------
-- FUNCTIONS
-----------------------------

local function skinChat(self)
  if not self or (self and self.skinApplied) then return end

  local name = self:GetName()

  --chat frame resizing
  self:SetClampRectInsets(0, 0, 0, 0)
  --self:SetMaxResize(UIParent:GetWidth(), UIParent:GetHeight())
  --self:SetMinResize(100, 50)

  --set font, outline and shadow for chat text
  self:SetFont(STANDARD_TEXT_FONT, 15, "OUTLINE")
  --self:SetShadowOffset(1,-1)
  --self:SetShadowColor(0,0,0,0.6)

  --fix the buttonframe
  --local frame = _G[name.."ButtonFrame"]
  --frame:Hide()
  --frame:HookScript("OnShow", frame.Hide)

  --editbox skinning
  _G[name.."EditBoxLeft"]:Hide()
  _G[name.."EditBoxMid"]:Hide()
  _G[name.."EditBoxRight"]:Hide()
  --local eb = _G[name.."EditBox"]
  --eb:SetAltArrowKeyMode(false)
  --eb:ClearAllPoints()
  --eb:SetPoint("BOTTOM",self,"TOP",0,22)
  --eb:SetPoint("LEFT",self,-5,0)
  --eb:SetPoint("RIGHT",self,10,0)

  --chat tab skinning
  local tab = _G[name.."Tab"]
  local tabFs = tab:GetFontString()
  tabFs:SetFont(STANDARD_TEXT_FONT, 14, "OUTLINE")
  --tabFs:SetShadowOffset(1,-1)
  --tabFs:SetShadowColor(0,0,0,0.6)
  --tabFs:SetTextColor(1,0.75,0)
   
    _G[name.."TabLeft"]:SetTexture(nil)
    _G[name.."TabMiddle"]:SetTexture(nil)
    _G[name.."TabRight"]:SetTexture(nil)
    _G[name.."TabSelectedLeft"]:SetTexture(nil)
    _G[name.."TabSelectedMiddle"]:SetTexture(nil)
    _G[name.."TabSelectedRight"]:SetTexture(nil)
    _G[name.."TabGlow"]:SetTexture(nil) --do not hide this texture, it will glow when a whisper hits a hidden chat
    _G[name.."TabHighlightLeft"]:SetTexture(nil)
    _G[name.."TabHighlightMiddle"]:SetTexture(nil)
    _G[name.."TabHighlightRight"]:SetTexture(nil)
    
  --tab:SetAlpha(1)

  self.skinApplied = true
  end

-----------------------------
-- CALL
-----------------------------

--chat skinning
for i = 1, NUM_CHAT_WINDOWS do
  skinChat(_G["ChatFrame"..i])
end

--[[skin temporary chats
hooksecurefunc("FCF_OpenTemporaryWindow", function()
  for _, chatFrameName in pairs(CHAT_FRAMES) do
    local frame = _G[chatFrameName]
    if (frame.isTemporary) then
      skinChat(frame)
    end
  end
end)

local a = CreateFrame("Frame")
a:RegisterEvent("PLAYER_LOGIN")
a:SetScript("OnEvent", fixStuffOnLogin)]]
  
  
  
  
  
  
  
  
--[[  隐藏翻页按钮(不在最后一行右下角显示翻页至底按钮)
local updateBottomButton = function(frame)
	local button = frame.buttonFrame.bottomButton
	if frame:AtBottom() then
		button:Hide()
	else
		button:Show()
	end
end  
 local bottomButtonClick = function(button)
	local frame = button:GetParent()
	frame:ScrollToBottom()
	updateBottomButton(frame)
end 
  for i = 1, NUM_CHAT_WINDOWS do
	local frame = _G["ChatFrame" .. i]
	frame:HookScript("OnShow", updateBottomButton)
	frame.buttonFrame:Hide()
	local up = frame.buttonFrame.upButton
    local down = frame.buttonFrame.downButton
    local minimize = frame.buttonFrame.minimizeButton
	local bottom = frame.buttonFrame.bottomButton
	bottom:SetParent(frame)
	bottom:SetPoint("BOTTOMRIGHT", frame, "BOTTOMRIGHT", 5, 5)
	bottom:SetScript("OnClick", bottomButtonClick)
	bottom:SetAlpha(1)----bottom:SetAlpha(0.8)
    bottom:SetScale(0.9)----bottom:SetScale(0.7)
	updateBottomButton(frame)
    up.Show = up.Hide 
    up:Hide()
    down.Show = down.Hide 
    down:Hide()
    minimize:SetScale(.7)   
    minimize:ClearAllPoints()
    minimize:SetPoint('TOPRIGHT', frame, 'TOPRIGHT', 5, 5)
    minimize:SetScript('OnEnter', function(self) self:SetAlpha(1) end)
    minimize:SetScript('OnLeave', function(self) self:SetAlpha(0) end)
end
hooksecurefunc("FloatingChatFrame_OnMouseScroll", updateBottomButton)]]









--  聊天频道精简

local ShortChannel = true

--================================公共频道和自定义频道精简================================--
local gsub = _G.string.gsub
local newAddMsg = {}
local chn, rplc
  if (GetLocale() == "zhCN") then  ---国服
	rplc = {
		"[%1综合]",  
		"[%1交易]",   
		"[%1防务]",   
		"[%1组队]",   
		"[%1世界]",   
		"[%1招募]",
        "[%1世界]", 
        "[%1自定义]",    -- 自定义频道缩写请自行修改
	}
    end
	chn = {
		"%[%d+%. General.-%]",
		"%[%d+%. Trade.-%]",
		"%[%d+%. LocalDefense.-%]",
		"%[%d+%. LookingForGroup%]",
		"%[%d+%. WorldDefense%]",
		"%[%d+%. GuildRecruitment.-%]",
        "%[%d+%. BigFootChannel.-%]",
        "%[%d+%. CustomChannel.-%]",       -- 自定义频道英文名随便填写
	}
---------------------------------------- 国服 ---------------------------------------------
local L = GetLocale()
	if L == "zhCN" then
		chn[1] = "%[%d+%. 综合.-%]"
		chn[2] = "%[%d+%. 交易.-%]"
		chn[3] = "%[%d+%. 本地防务.-%]"
		chn[4] = "%[%d+%. 寻求组队%]"
        chn[5] = "%[%d+%. 世界防务%]"	
		chn[6] = "%[%d+%. 公会招募.-%]"
        chn[7] = "%[%d+%. 大脚世界频道.-%]"
        chn[8] = "%[%d+%. 自定义频道.-%]"   -- 请修改频道名对应你游戏里的频道
	end
	
local function AddMessage(frame, text, ...)
	for i = 1, 8 do	 -- 对应上面几个频道(如果有9个频道就for i = 1, 9 do)
		text = gsub(text, chn[i], rplc[i])
	end

	text = gsub(text, "%[(%d0?)%. .-%]", "%1.") 
	return newAddMsg[frame:GetName()](frame, text, ...)
end
if ShortChannel then
	for i = 1, 5 do
		if i ~= 2 then 
			local f = _G[format("%s%d", "ChatFrame", i)]
			newAddMsg[format("%s%d", "ChatFrame", i)] = f.AddMessage
			f.AddMessage = AddMessage
		end
	end
end







