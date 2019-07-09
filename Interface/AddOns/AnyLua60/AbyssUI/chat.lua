--------------------------------------------------------------------------
-- Chat Hide Button
-- Thanks to Syncrow for this script (maybe include some modifications) --
--------------------------------------------------------------------------

local ChatHideFrame = CreateFrame("Button", nil, UIParent)
ChatHideFrame:SetSize(30, 30)
ChatHideFrame.t = ChatHideFrame:CreateTexture(nil, "BORDER")
ChatHideFrame.t:SetTexture("Interface\\CHATFRAME\\UI-ChatIcon-Minimize-Up.blp")
ChatHideFrame.t:SetAllPoints(ChatHideFrame)
ChatHideFrame:SetPoint("BOTTOM","ChatFrame1ButtonFrame","BOTTOM",0,-35)
ChatHideFrame:Show()

local ChatHide = false

ChatHideFrame:SetScript("OnMouseDown", function(self, Button)
	if ChatHide == false then
		if Button == "LeftButton" then
			ChatHideFrame.t:SetTexture("Interface\\CHATFRAME\\UI-ChatIcon-Minimize-Down.blp")
		end
	elseif ChatHide == true then
		if Button == "LeftButton" then
			ChatHideFrame.t:SetTexture("Interface\\CHATFRAME\\UI-ChatIcon-Maximize-Down.blp")
		end
	end
end)

ChatHideFrame:SetScript("OnMouseUp", function(self, Button)
	if ChatHide == false then
		if Button == "LeftButton" then
			ChatHideFrame.t:SetTexture("Interface\\CHATFRAME\\UI-ChatIcon-Minimize-Up.blp")
		end
	elseif ChatHide == true then
		if Button == "LeftButton" then
			ChatHideFrame.t:SetTexture("Interface\\CHATFRAME\\UI-ChatIcon-Maximize-Up.blp")
		end
	end
end)

ChatHideFrame:SetScript("OnClick", function(self, Button)
	if ChatHide == false then
		ChatHideFrame.t:SetTexture("Interface\\CHATFRAME\\UI-ChatIcon-Maximize-Up.blp")
		QuickJoinToastButton:Hide()
		GeneralDockManager:Hide()
		ChatFrameMenuButton:Hide()
		ChatFrameChannelButton:Hide()
		--ChatFrameToggleVoiceDeafenButton.Icon:Hide()
		--ChatFrameToggleVoiceMuteButton.Icon:Hide()
		ChatFrame1EditBox:Hide()

		for i = 1, NUM_CHAT_WINDOWS do
			_G["ChatFrame"..i..""]:SetAlpha(0)
			_G["ChatFrame"..i.."ButtonFrame"]:Hide()
			_G["ChatFrame"..i.."EditBox"]:SetAlpha(0)
		end
		ChatHide = true
	elseif ChatHide == true then
		ChatHideFrame.t:SetTexture("Interface\\CHATFRAME\\UI-ChatIcon-Minimize-Up.blp")
		QuickJoinToastButton:Show()
		GeneralDockManager:Show()
		ChatFrameMenuButton:Show()
		ChatFrameChannelButton:Show()
		--ChatFrameToggleVoiceDeafenButton.Icon:Show()
		--ChatFrameToggleVoiceMuteButton.Icon:Show()
		ChatFrame1EditBox:Show()

		for i = 1 , NUM_CHAT_WINDOWS do
			_G["ChatFrame"..i..""]:SetAlpha(1)
			_G["ChatFrame"..i.."ButtonFrame"]:Show()
			_G["ChatFrame"..i.."EditBox"]:SetAlpha(1)
		end
		ChatHide = false
	end
end)
----------------------------------------------------
