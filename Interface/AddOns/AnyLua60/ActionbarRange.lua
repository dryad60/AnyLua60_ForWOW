hooksecurefunc("ActionButton_UpdateRangeIndicator", function(self, checksRange, inRange)
	if self.action == nil then return end
	local isUsable, notEnoughMana = IsUsableAction(self.action)
	if (checksRange and not inRange) then
		_G[self:GetName().."Icon"]:SetVertexColor(0.5, 0.1, 0.1)
	elseif isUsable ~= true or notEnoughMana == true then
		_G[self:GetName().."Icon"]:SetVertexColor(0.4, 0.4, 0.4)
	else
		_G[self:GetName().."Icon"]:SetVertexColor(1, 1, 1)
	end
end)

--[[
hooksecurefunc("ActionButton_UpdateCount", function(self)
	local charges, maxCharges = GetActionCharges(self.action)
	if maxCharges > 1 then
		btn_ChargeCount:SetFont(STANDARD_TEXT_FONT, 16, "THICKOUTLINE")
		btn_ChargeCount:ClearAllPoints()
		btn_ChargeCount:SetPoint("BOTTOMRIGHT", 0, 0)
		if charges == 0 then
			btn_ChargeCount:SetTextColor(1, 0, 0.5, 1)
		else
			btn_ChargeCount:SetTextColor(0, 1, 0.5, 1)
		end
	end
end)
--]]
--[[
hooksecurefunc("ActionButton_UpdateCount", function(self, elapsed)
	--按钮充能数字的显示调整
	local btn_ChargeCount = _G[self:GetName()..'Count'];
	if btn_ChargeCount:GetText() ~= nil then
		btn_ChargeCount:SetFont(STANDARD_TEXT_FONT, 16, "THICKOUTLINE")
		btn_ChargeCount:ClearAllPoints()
		btn_ChargeCount:SetPoint("BOTTOMRIGHT", 0, 0)
		if btn_ChargeCount:GetText() == "0" then
			btn_ChargeCount:SetTextColor(1, 0, 0.5, 1)
		else
			btn_ChargeCount:SetTextColor(0, 1, 0.5, 1)
		end
	end
end)
--]]
