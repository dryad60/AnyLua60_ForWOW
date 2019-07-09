----------------
--  迷你地图  --
----------------

--  迷你地图  --------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

	
------------
-- Shadow --
------------
local shadows = {
	edgeFile = "Interface\\AddOns\\AnyLua60\\A4U\\media\\outer_shadow",
	edgeSize = 6,
	insets = 6,
	color = { r = 0, g = 0, b = 0, a = 1},
}
function CreateShadow(f)
	if f.shadow then return end
	local shadow = CreateFrame("Frame", nil, f)
	shadow:SetFrameLevel(1)
	shadow:SetFrameStrata(f:GetFrameStrata())
	shadow:SetPoint("TOPLEFT", -3, 3)
	shadow:SetPoint("BOTTOMRIGHT", 3, -3)
	shadow:SetBackdrop(shadows)
	shadow:SetBackdropColor(0, 0, 0, 0)
	shadow:SetBackdropBorderColor(0, 0, 0, 1)
	f.shadow = shadow
	return shadow
end

CreateShadow(Minimap)

----------------
-- Shadow End -- 
----------------


-- Minimap
Minimap:SetSize(150, 150)
Minimap:SetMaskTexture("Interface\\Buttons\\WHITE8x8")
Minimap:SetScale(1)
Minimap:SetFrameStrata("LOW")
Minimap:ClearAllPoints()
Minimap:SetPoint("TOPRIGHT"	, UIParent, -6, -22)
--Minimap:SetPoint("BOTTOMLEFT", MainMenuBarArtFrame.LeftEndCap, -100, 150)


-- Zone text
MinimapZoneTextButton:SetParent(Minimap)
MinimapZoneTextButton:SetPoint("CENTER", Minimap, "TOP", 0, 11)
MinimapZoneTextButton:SetFrameStrata("LOW")
MinimapZoneText:SetPoint("CENTER","MinimapZoneTextButton","CENTER", 0, 0)
MinimapZoneText:SetFont(STANDARD_TEXT_FONT, 15, "OUTLINE")
MinimapZoneText:SetJustifyH("CENTER")


-- Border
Minimap:SetBackdrop{edgeFile = 'Interface\\Buttons\\WHITE8x8', edgeSize = 2, insets = {left = -1, right = -1, top = -1, bottom = -1}}
Minimap:SetBackdropColor(1, 1, 1, 1)
Minimap:SetBackdropBorderColor(0, 0, 0, 1)


-- Hide Stuff
MinimapBorder:Hide()
MinimapBorderTop:Hide()
MinimapZoomIn:Hide()
MinimapZoomOut:Hide()
--MiniMapVoiceChatFrame:Hide()
--GameTimeFrame:Hide()
MiniMapTracking:Hide()
MiniMapMailBorder:Hide()
--MinimapNorthTag:SetAlpha(0)
Minimap:SetQuestBlobRingScalar(0)----任务扫描圈

--WorldMapFrame:HookScript("OnHide",SetMapToCurrentZone);
MiniMapWorldMapButton:Hide()


-- QueueStatus: Raid, Battelfield, 
QueueStatusMinimapButton:ClearAllPoints()
QueueStatusMinimapButton:SetPoint("BOTTOMLEFT", Minimap, -16, 30)
QueueStatusMinimapButtonIcon:SetScale(1)


-- Difficulty 
local iconScale = 0.9

GuildInstanceDifficulty:SetParent(Minimap)
GuildInstanceDifficulty:ClearAllPoints() 
GuildInstanceDifficulty:SetPoint("TOPLEFT", Minimap, "TOPLEFT", 1, -1)
GuildInstanceDifficulty:SetScale(iconScale)

MiniMapInstanceDifficulty:SetParent(Minimap)
MiniMapInstanceDifficulty:ClearAllPoints()
MiniMapInstanceDifficulty:SetPoint("TOPLEFT", Minimap, "TOPLEFT", 1, -1)
MiniMapInstanceDifficulty:SetScale(iconScale)

MiniMapChallengeMode:SetParent(Minimap)
MiniMapChallengeMode:ClearAllPoints()
MiniMapChallengeMode:SetPoint("TOPLEFT", Minimap, "TOPLEFT", -1, -1)
MiniMapChallengeMode:SetScale(iconScale)


-- Default LFG icon
LFG_EYE_TEXTURES.raid = LFG_EYE_TEXTURES.default
LFG_EYE_TEXTURES.unknown = LFG_EYE_TEXTURES.default


-- Time
LoadAddOn("Blizzard_TimeManager")
select(1, TimeManagerClockButton:GetRegions()):Hide()
TimeManagerClockTicker:SetFont(STANDARD_TEXT_FONT, 12, "OUTLINE")--TimeManagerClockTicker:SetFont("Interface\\AddOns\\AnyLua60\\A4U\\media\\Pixel.ttf", 14, "OUTLINE")
TimeManagerClockTicker:SetJustifyH("RIGHT")
TimeManagerClockTicker:SetTextColor(1, 0.82, 0.1)
TimeManagerClockTicker:SetPoint("TOPRIGHT", Minimap, "BOTTOMRIGHT", 0, -2)
TimeManagerClockButton:ClearAllPoints()
TimeManagerClockButton:SetPoint("TOPRIGHT", Minimap, "BOTTOMRIGHT", 0, -2)


-- Mail
local mailicon = "Interface\\AddOns\\AnyLua60\\A4U\\media\\mail"
MiniMapMailFrame:ClearAllPoints()
MiniMapMailFrame:SetPoint("BOTTOM", Minimap, "BOTTOM", 0, 5)
MiniMapMailFrame:SetSize(16,10)
MiniMapMailFrame:SetScale(0.9)
MiniMapMailIcon:SetTexture(mailicon)
MiniMapMailIcon:SetPoint("TOPLEFT", MiniMapMailFrame, "TOPLEFT", -1, 3)


-- Mouse
Minimap:EnableMouseWheel(true)
Minimap:SetScript('OnMouseWheel', function(self, delta)
    if delta > 0 then
        Minimap_ZoomIn()
    else
        Minimap_ZoomOut() 
    end
end)

Minimap:SetScript('OnMouseUp', function(self, button)
    if (button == "RightButton") then
        ToggleDropDownMenu(1, nil, MiniMapTrackingDropDown, self, - (Minimap:GetWidth() * 0.7), -3)
    elseif (button == "MiddleButton") then
        ToggleCalendar()
    else
        Minimap_OnClick(self)
    end
end)

function GetMinimapShape() return 'SQUARE' end

--  搜索眼睛边框染色
for i,v in pairs({
	QueueStatusMinimapButtonBorder,
	}) do
    v:SetVertexColor(.3, .3, .3)
end







--  小地图隐藏日历、要塞图标  -------------------------------------------------------------------------------------------------------------------------------------------------------------
GarrisonLandingPageMinimapButton:ClearAllPoints()
--GarrisonLandingPageMinimapButton:SetWidth(40)
--GarrisonLandingPageMinimapButton:SetHeight(40)
GarrisonLandingPageMinimapButton:SetPoint("CENTER", Minimap, "BOTTOMLEFT", 0, 0)----GarrisonLandingPageMinimapButton:SetPoint("BOTTOMLEFT", Minimap, -20, -20)
GarrisonLandingPageMinimapButton:SetAlpha(0)
GarrisonLandingPageMinimapButton:SetScript("OnEnter", function()
	GarrisonLandingPageMinimapButton:FadeIn()
end)
GarrisonLandingPageMinimapButton:SetScript("OnLeave", function()
	GarrisonLandingPageMinimapButton:FadeOut()
end)


GameTimeFrame:ClearAllPoints()
GameTimeFrame:SetPoint("TOPRIGHT", Minimap, "TOPRIGHT", 0, 0)----GameTimeFrame:SetPoint("TOPRIGHT", Minimap, 14, 14)
GameTimeFrame:SetAlpha(0)
GameTimeFrame:SetScript("OnEnter", function()
	GameTimeFrame:FadeIn()
end)
GameTimeFrame:SetScript("OnLeave", function()
	GameTimeFrame:FadeOut()
end)


local function FadeIn(f)
	UIFrameFadeIn(f, 0.4, f:GetAlpha(), 1)
end

local function FadeOut(f)
	UIFrameFadeOut(f, 0.8, f:GetAlpha(), 0)
end

local function addapi(object)
	local mt = getmetatable(object).__index
	if not object.FadeIn then mt.FadeIn = FadeIn end
	if not object.FadeOut then mt.FadeOut = FadeOut end
end

local handled = {["Frame"] = true}
local object = CreateFrame("Frame")
addapi(object)

object = EnumerateFrames()
while object do
	if not handled[object:GetObjectType()] then
		addapi(object)
		handled[object:GetObjectType()] = true
	end
	object = EnumerateFrames(object)
end







--[[  小地图坐标  ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
Minimap:CreateFontString("MapCoordsMinimapText","OVERLAY","NumberFontNormal");
MapCoordsMinimapText:SetPoint("TOPLEFT", Minimap, "BOTTOMLEFT", 1, -2);
MapCoordsMinimapText:SetTextColor(1, 0.82, 0.1, 1);
MapCoordsMinimapText:SetText("Hook Failed!");
MapCoordsMinimapText:SetFont(STANDARD_TEXT_FONT, 12, "OUTLINE")--MapCoordsMinimapText:SetFont("Interface\\AddOns\\AnyLua60\\A4U\\media\\Pixel.ttf", 14, 'OUTLINE')
MapCoordsMinimapText:SetJustifyH("LEFT");

local EventFrame=CreateFrame("Frame",nil,Minimap);
EventFrame:RegisterEvent("PLAYER_LOGIN");
EventFrame:RegisterEvent("ZONE_CHANGED_INDOORS");
EventFrame:RegisterEvent("ZONE_CHANGED_NEW_AREA");

EventFrame:SetScript("OnUpdate",function()
    local position = C_Map.GetPlayerMapPosition(MapUtil.GetDisplayableMapForPlayer(), "player")
	MapCoordsMinimapText:SetText(format("%.1f,%.1f", position.x*100, position.y*100));
end);]]


--  小地图坐标  ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
Minimap.coords = Minimap:CreateFontString(nil, 'ARTWORK') 
Minimap.coords:SetPoint("TOPLEFT", Minimap, "BOTTOMLEFT", 1, -2);
Minimap.coords:SetTextColor(1, 0.82, 0.1, 1);
Minimap.coords:SetFont(STANDARD_TEXT_FONT, 12, "OUTLINE")
Minimap.coords:SetJustifyH("LEFT");
Minimap:HookScript("OnUpdate", function(self, elapsed) 
    self.elapsed = (self.elapsed or 0) + elapsed
    if (self.elapsed < 0.2) then return end
    self.elapsed = 0
    local position = C_Map.GetPlayerMapPosition(MapUtil.GetDisplayableMapForPlayer(), "player")
    if (position) then
        self.coords:SetText(format("%.1f,%.1f", position.x*100, position.y*100))
    else
        self.coords:SetText("")
    end
end)



--  大地图坐标  ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
WorldMapFrame.playerPos = WorldMapFrame.BorderFrame:CreateFontString(nil, 'ARTWORK') 
WorldMapFrame.playerPos:SetFont(STANDARD_TEXT_FONT, 14, "OUTLINE") 
WorldMapFrame.playerPos:SetJustifyH("LEFT") 
WorldMapFrame.playerPos:SetPoint('LEFT', WorldMapFrameCloseButton, 'LEFT', -180, 0) ----WorldMapFrame.playerPos:SetPoint("BOTTOMRIGHT", WorldMapFrame.BorderFrame, "BOTTOM", -100, 22)
WorldMapFrame.playerPos:SetTextColor(1, 0.82, 0.1) 
WorldMapFrame.mousePos = WorldMapFrame.BorderFrame:CreateFontString(nil, "ARTWORK") 
WorldMapFrame.mousePos:SetFont(STANDARD_TEXT_FONT, 14, "OUTLINE") 
WorldMapFrame.mousePos:SetJustifyH("LEFT") 
WorldMapFrame.mousePos:SetPoint('LEFT', WorldMapFrame.playerPos, 'LEFT', -160, 0) ----WorldMapFrame.mousePos:SetPoint("BOTTOMLEFT", WorldMapFrame.BorderFrame, "BOTTOM", -60, 22)
WorldMapFrame.mousePos:SetTextColor(1, 0.82, 0.1) 
WorldMapFrame:HookScript("OnUpdate", function(self, elapsed) 
    self.elapsed = (self.elapsed or 0) + elapsed
    if (self.elapsed < 0.2) then return end
    self.elapsed = 0
    --玩家坐标
    local position = C_Map.GetPlayerMapPosition(MapUtil.GetDisplayableMapForPlayer(), "player")
    if (position) then
        self.playerPos:SetText(format("玩家  X:%.1f  Y:%.1f", position.x*100, position.y*100))
    else
        self.playerPos:SetText("")
    end
    --鼠标坐标
    local mapInfo = C_Map.GetMapInfo(self:GetMapID())
    if (mapInfo and mapInfo.mapType == 3) then
        local x, y = self.ScrollContainer:GetNormalizedCursorPosition()
        if (x and y and x > 0 and x < 1 and y > 0 and y < 1) then
            self.mousePos:SetText(format("鼠标  X:%.1f  Y:%.1f", x*100, y*100))
        else
            self.mousePos:SetText("")
        end
    else
        self.mousePos:SetText("")
    end
end)







--  隐藏战场地图关闭按钮  --
--LoadAddOn("Blizzard_BattlefieldMinimap")
--BattlefieldMinimapCorner:Hide()
--BattlefieldMinimapCloseButton:Hide()








