----------------------------------------------------------------------------------------
--  PORTRAIT
----------------------------------------------------------------------------------------

--  光环美化

local cfg = CreateFrame("Frame")

cfg.background = {
    inset = 3,
	padding = 2,
	color = { r = 0, g = 0, b = 0, a = 0.6},
}
cfg.icon = {
    padding = 1,
}

--backdrop
local backdrop = {
	bgFile = nil,
	edgeFile = "Interface\\AddOns\\AnyLua60\\A4U\\media\\outer_shadow",
	tile = false,
	tileSize = 32,
	edgeSize = cfg.background.inset,
	insets = {
		left = cfg.background.inset,
		right = cfg.background.inset,
		top = cfg.background.inset,
		bottom = cfg.background.inset,
	},
}

 ---------------------------------------
  -- FUNCTIONS
 ---------------------------------------

--apply aura frame texture func
local function applySkin(b)
	if not b or (b and b.styled) then return end
	--button name
	local name = b:GetName()
	if (name:match("Debuff")) then
		b.debuff = true
   	else
   		b.buff = true
	end
	--icon
	local icon = _G[name.."Icon"]
	icon:SetTexCoord(0.1, 0.9, 0.1, 0.9)
	icon:SetDrawLayer("BACKGROUND",-8)
	icon:ClearAllPoints()
	icon:SetPoint("TOPLEFT", b, "TOPLEFT", cfg.icon.padding, -cfg.icon.padding)
	icon:SetPoint("BOTTOMRIGHT", b, "BOTTOMRIGHT", -cfg.icon.padding, cfg.icon.padding)
	b.icon = icon
	--border
	local border = _G[name.."Border"] or b:CreateTexture(name.."Border", "BACKGROUND", nil, -7)
	border:SetTexture("Interface\\AddOns\\AnyLua60\\A4U\\media\\normal")
	border:SetTexCoord(0, 1, 0, 1)
	border:SetDrawLayer("BACKGROUND",- 7)
	if b.buff then
		border:SetVertexColor(0, 0, 0, 1)
	end
	border:ClearAllPoints()
    border:SetAllPoints(b)
	b.border = border
	--count
	local count = _G[name.."Count"]
	count:SetFont(STANDARD_TEXT_FONT, 12, "OUTLINE")
	--count:ClearAllPoints()
    --count:SetPoint("BOTTOMLEFT", b, 0, 0)
    --count:SetPoint("BOTTOMRIGHT", b, 0, 0)
	b.count = count
	--shadow
	local back = CreateFrame("Frame", nil, b)
	back:SetPoint("TOPLEFT", b, "TOPLEFT", -cfg.background.padding, cfg.background.padding)
	back:SetPoint("BOTTOMRIGHT", b, "BOTTOMRIGHT", cfg.background.padding, -cfg.background.padding)
	back:SetFrameLevel(b:GetFrameLevel() - 1)
	back:SetBackdrop(backdrop)
	back:SetBackdropBorderColor(cfg.background.color.r,cfg.background.color.g,cfg.background.color.b,cfg.background.color.a)
	b.bg = back
	--set button styled variable
	b.styled = true
end



 ---------------------------------------
  -- INIT
 ---------------------------------------

hooksecurefunc("TargetFrame_UpdateAuras", function(self)
	for i = 1, MAX_TARGET_BUFFS do
		b = _G["TargetFrameBuff"..i]
		applySkin(b)
	end
	for i = 1, MAX_TARGET_DEBUFFS do
		b = _G["TargetFrameDebuff"..i]
		applySkin(b)
	end
	for i = 1, MAX_TARGET_BUFFS do
		b = _G["FocusFrameBuff"..i]
		applySkin(b)
	end
	for i = 1, MAX_TARGET_DEBUFFS do
		b = _G["FocusFrameDebuff"..i]
		applySkin(b)
	end
end)


	

---------------------------------------------------
-- TARGETBUFFS --
---------------------------------------------------
-- aura positioning constants
local AURA_START_X = 5;
local AURA_START_Y = 30;
local AURA_OFFSET_Y = 3
local LARGE_AURA_SIZE = 30
local SMALL_AURA_SIZE = 22
local AURA_ROW_WIDTH = 132
local NUM_TOT_AURA_ROWS = 3

function UpdateAuraPositions(self, auraName, numAuras, numOppositeAuras, largeAuraList, updateFunc, maxRowWidth, offsetX, mirrorAurasVertically)
    local size
    local offsetY = AURA_OFFSET_Y
    local rowWidth = 0
    local firstBuffOnRow = 1
    for i=1, numAuras do
        if ( largeAuraList[i] ) then
            size = LARGE_AURA_SIZE
            offsetY = AURA_OFFSET_Y + AURA_OFFSET_Y
        else
            size = SMALL_AURA_SIZE
        end
        if ( i == 1 ) then
            rowWidth = size
            self.auraRows = self.auraRows + 1
        else
            rowWidth = rowWidth + size + offsetX
        end
        if ( rowWidth > maxRowWidth ) then
            updateFunc(self, auraName, i, numOppositeAuras, firstBuffOnRow, size, offsetX, offsetY, mirrorAurasVertically)
            rowWidth = size
            self.auraRows = self.auraRows + 1
            firstBuffOnRow = i
            offsetY = AURA_OFFSET_Y
        else
            updateFunc(self, auraName, i, numOppositeAuras, i - 1, size, offsetX, offsetY, mirrorAurasVertically)
        end
    end
end

hooksecurefunc("TargetFrame_UpdateAuraPositions", UpdateAuraPositions)

function UpdateBuffAnchor(self, buffName, index, numDebuffs, anchorIndex, size, offsetX, offsetY, mirrorVertically)
    local point, relativePoint
    local startY, auraOffsetY
    if ( mirrorVertically ) then
        point = "BOTTOM"
        relativePoint = "TOP"
        startY = -8
        offsetY = -offsetY
        auraOffsetY = -AURA_OFFSET_Y
    else
        point = "TOP"
        relativePoint="BOTTOM"
        startY = AURA_START_Y
        auraOffsetY = AURA_OFFSET_Y
    end
     
    local buff = _G[buffName..index]
    if ( index == 1 ) then
        if ( UnitIsFriend("player", self.unit) or numDebuffs == 0 ) then
            -- unit is friendly or there are no debuffs...buffs start on top
            buff:SetPoint(point.."LEFT", self, relativePoint.."LEFT", AURA_START_X, startY)           
        else
            -- unit is not friendly and we have debuffs...buffs start on bottom
            buff:SetPoint(point.."LEFT", self.debuffs, relativePoint.."LEFT", 0, -offsetY)
        end
        self.buffs:SetPoint(point.."LEFT", buff, point.."LEFT", 0, 0)
        self.buffs:SetPoint(relativePoint.."LEFT", buff, relativePoint.."LEFT", 0, -auraOffsetY)
        self.spellbarAnchor = buff
    elseif ( anchorIndex ~= (index-1) ) then
        -- anchor index is not the previous index...must be a new row
        buff:SetPoint(point.."LEFT", _G[buffName..anchorIndex], relativePoint.."LEFT", 0, -offsetY)
        self.buffs:SetPoint(relativePoint.."LEFT", buff, relativePoint.."LEFT", 0, -auraOffsetY)
        self.spellbarAnchor = buff
    else
        -- anchor index is the previous index
        buff:SetPoint(point.."LEFT", _G[buffName..anchorIndex], point.."RIGHT", offsetX, 0)
    end
end

hooksecurefunc("TargetFrame_UpdateBuffAnchor", UpdateBuffAnchor)

function UpdateDebuffAnchor(self, debuffName, index, numBuffs, anchorIndex, size, offsetX, offsetY, mirrorVertically)
    local buff = _G[debuffName..index];
    local isFriend = UnitIsFriend("player", self.unit);
     
    --For mirroring vertically
    local point, relativePoint;
    local startY, auraOffsetY;
    if ( mirrorVertically ) then
        point = "BOTTOM";
        relativePoint = "TOP";
        startY = -8;
        offsetY = - offsetY;
        auraOffsetY = -AURA_OFFSET_Y;
    else
        point = "TOP";
        relativePoint="BOTTOM";
        startY = AURA_START_Y;
        auraOffsetY = AURA_OFFSET_Y;
    end
     
    if ( index == 1 ) then
        if ( isFriend and numBuffs > 0 ) then
            -- unit is friendly and there are buffs...debuffs start on bottom
            buff:SetPoint(point.."LEFT", self.buffs, relativePoint.."LEFT", 0, -offsetY);
        else
            -- unit is not friendly or there are no buffs...debuffs start on top
            buff:SetPoint(point.."LEFT", self, relativePoint.."LEFT", AURA_START_X, startY);
        end
        self.debuffs:SetPoint(point.."LEFT", buff, point.."LEFT", 0, 0);
        self.debuffs:SetPoint(relativePoint.."LEFT", buff, relativePoint.."LEFT", 0, -auraOffsetY);
        if ( ( isFriend ) or ( not isFriend and numBuffs == 0) ) then
            self.spellbarAnchor = buff;
        end
    elseif ( anchorIndex ~= (index-1) ) then
        -- anchor index is not the previous index...must be a new row
        buff:SetPoint(point.."LEFT", _G[debuffName..anchorIndex], relativePoint.."LEFT", 0, -offsetY);
        self.debuffs:SetPoint(relativePoint.."LEFT", buff, relativePoint.."LEFT", 0, -auraOffsetY);
        if ( ( isFriend ) or ( not isFriend and numBuffs == 0) ) then
            self.spellbarAnchor = buff;
        end
    else
        -- anchor index is the previous index
        buff:SetPoint(point.."LEFT", _G[debuffName..(index-1)], point.."RIGHT", offsetX, 0);
    end
end

hooksecurefunc("TargetFrame_UpdateDebuffAnchor", UpdateDebuffAnchor) 


