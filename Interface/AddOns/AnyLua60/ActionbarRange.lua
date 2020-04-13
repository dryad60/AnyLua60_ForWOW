-- 动作条按键范围着色
hooksecurefunc("ActionButton_OnUpdate", function(self, elapsed)
	if self.rangeTimer == TOOLTIP_UPDATE_TIME and self.action then
		local range = false
		if IsActionInRange(self.action) == false then
			_G[self:GetName().."Icon"]:SetVertexColor(1, 0, 1)
			range = true
		end;
		if self.range ~= range and range == false then
			ActionButton_UpdateUsable(self)
		end;
		self.range = range
	end

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
