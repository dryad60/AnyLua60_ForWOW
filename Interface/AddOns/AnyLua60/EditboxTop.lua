-- function to reposition editbox
local function RepositionEditBox(self)

if not self then return end

local name = self:GetName()
local box = _G[name.."EditBox"]
box:ClearAllPoints()
box:SetPoint("BOTTOM", self, "TOP", 0, 16)
box:SetPoint("LEFT", self, -5, 0)
box:SetPoint("RIGHT", self, 10, 0)

end
-- code to initiate the repositioning
for i = 1, NUM_CHAT_WINDOWS do
RepositionEditBox(_G["ChatFrame"..i])
end
