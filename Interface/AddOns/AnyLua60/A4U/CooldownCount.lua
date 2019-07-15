----------------
--  冷却数字  --
----------------

local Timer = {}
local timers = {}
local font = GameTooltipTextLeft1:GetFont()
local minFontsize = 7

local ButtonType = {
	{value = "AutoCastable", type = "Pet"    },
	{value = "HotKey",       type = "Action" },
	{value = "Stock",        type = "Item"   },
}

local iCCDB = {
	Action = { config = true, min = 2,  size = 20 },
	Pet    = { config = true, min = 3,  size = 18 },
	Item   = { config = true, min = 3,  size = 20 },
	Buff   = { config = true, max = 86400, scale = 0.5 },
}

local function Timer_OnUpdate(self, elapsed)
	if not self.cd:IsVisible() then
		self:Hide()
	else
		if self.nextUpdate <= 0 then
			Timer.Update(self)
		else
			self.nextUpdate = self.nextUpdate - elapsed
		end
	end
end

local function Timer_Hide(self)
	self.nextUpdate = 0
	self.cd:SetAlpha(1)
end

local function GetButtonType(btn)
	local name = btn:GetName()
	if name then
		for _, index in ipairs(ButtonType) do
			if _G[name..index.value] then
				return index.type
			end
		end
	end
	return "Buff"
end

local function GetFormattedTime(t)
	if t < 9 then
		return ceil(t), 1.2, 1, t-floor(t)>0.5 and 0.12 or 0.82, 0.12, 0.2
	elseif t < 60 then
		return ceil(t), 1, 1, 0.82, 0, t-floor(t)
	elseif t < 600 then
		return ceil(t/60).."m", 0.85, 0.8, 0.6, 0, t-floor(t)
	elseif t < 3600 then
		return ceil(t/60).."m", 0.7, 0.8, 0.6, 0, t%60
	elseif (t < 86400) then
		return ceil(t/3600).."h", 0.6, 0.6, 0.4, 0, t%3600
	else
		return ceil(t).."d", 0.6, 0.4, 0.4, 0.4, t%86400
	end
end

local hideNumbers = {}
local function setHideCooldownNumbers(cooldown, hide)
	if hide then
		hideNumbers[cooldown] = true
	else
		hideNumbers[cooldown] = nil
	end
end

function Timer.Start(cd, start, duration, enable, forceShowDrawEdge, modRate)
	-- hideNumbers 这个进制可以让充能技能不显示CD，代码COPY from TullaCC
	if cd.noCooldownCount or cd:IsForbidden() or hideNumbers[cd]
	then return end
	
	cd.button = cd.button or cd:GetParent()
	if cd.button then
		cd.type = cd.type or GetButtonType(cd.button)
		if cd.type then
			if start > 0 and duration > (iCCDB[cd.type].min or 0) and iCCDB[cd.type].config then
				local timer = timers[cd] or Timer.Create(cd)
				if timer then
					timer.start = start
					timer.duration = duration
					timer.nextUpdate = 0
					timer:Show()
				end
			elseif timers[cd] then
				timers[cd]:Hide()
			end
		end
	end
end

function Timer.Create(cd)
	local timer = CreateFrame("Frame", nil, cd.button)
	timer:SetAllPoints(cd)
	timer.cd = cd
	timer.type = cd.type
	timer.button = cd.button
	timer:Hide()
	timer:SetScript("OnUpdate", Timer_OnUpdate)
	timer:SetScript("OnHide", Timer_Hide)

	local text = timer:CreateFontString(nil, "OVERLAY")
	if cd.type == "Buff" then
		text:SetPoint("CENTER", timer, "CENTER", 0, 0)
	else
		text:SetPoint("CENTER", timer, "CENTER", 0, 1)
	end
	timer.text = text

	timers[cd] = timer
	return timer
end

function Timer.Update(timer)
	local time = timer.start + timer.duration - GetTime()
	local max = iCCDB[timer.type].max
	if max then
		if time > max and max > 0 then
			if timer.text:IsVisible() then
				timer.text:Hide()
			end
			timer.cd:SetAlpha(1)
			return
		else
			if not timer.text:IsVisible() then
				timer.text:Show()
			end
			timer.cd:SetAlpha(1)                      ----显示/隐藏CD圈
		end
	end

	if timer.text:IsVisible() then
		local text, scale, r, g, b, nextUpdate = GetFormattedTime(time)
		local size = iCCDB[timer.type].size or floor((iCCDB[timer.type].scale * timer.button:GetSize()) + 0.5)
		if size < 20 then		                        ----timer.text:SetFont(font, size, "OUTLINE")修改这一段控制失控警报冷却数字大小
		timer.text:SetFont(font, size, "OUTLINE")		----timer.text:SetFont(font, size, "OUTLINE")
		else		                                    ----timer.text:SetFont(font, size, "OUTLINE")
		timer.text:SetFont(font, 20, "OUTLINE")		    ----timer.text:SetFont(font, size, "OUTLINE")
		end		                                        ----timer.text:SetFont(font, size, "OUTLINE")
		timer.text:SetText(size < minFontsize and "" or text)
		timer.text:SetTextColor(r, g, b)
		timer:SetScale(scale)
		timer.nextUpdate = nextUpdate
	end

	if time < 0.2 then
		timer:Hide()
		timer.cd:SetAlpha(1)
	end
end

local iCC = CreateFrame("Frame")
iCC:Hide()
iCC:RegisterEvent("PLAYER_ENTERING_WORLD")
iCC:SetScript("OnEvent", function()
	for cooldown, timer in pairs(timers) do
		Timer.Update(timer)
	end
end)


local cdIns = getmetatable(CreateFrame("Cooldown", nil, nil, "CooldownFrameTemplate")).__index
hooksecurefunc(cdIns, "SetCooldown", Timer.Start)
hooksecurefunc(cdIns, 'SetHideCountdownNumbers', setHideCooldownNumbers)
