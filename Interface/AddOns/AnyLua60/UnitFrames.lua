--框体大小
TargetFrame:SetScale(1.2)
TargetFrameToT:SetScale(1.1)

--[目标buff debuff大小] 
local function UpdateTargetAuraPositions(self, auraName, numAuras, numOppositeAuras, largeAuraList, updateFunc, maxRowWidth, offsetX) 
    local AURA_OFFSET_Y = 3; 
    local DEBUFF_AURA_SIZE = 16; 
    local BUFF_AURA_SIZE = 32; 
    local size; 
    local offsetY = AURA_OFFSET_Y; 
    local rowWidth = 0; 
    local firstBuffOnRow = 1; 
    for i=1, numAuras do 
        if ( largeAuraList[i] ) then 
            size = DEBUFF_AURA_SIZE; 
            offsetY = AURA_OFFSET_Y + AURA_OFFSET_Y; 
        else 
            size = BUFF_AURA_SIZE; 
        end 
        if ( i == 1 ) then 
            rowWidth = size; 
            self.auraRows = self.auraRows + 1; 
        else 
            rowWidth = rowWidth + size + offsetX; 
        end 
        if ( rowWidth > maxRowWidth ) then 
            updateFunc(self, auraName, i, numOppositeAuras, firstBuffOnRow, size, offsetX, offsetY); 
            rowWidth = size; 
            self.auraRows = self.auraRows + 1; 
            firstBuffOnRow = i; 
            offsetY = AURA_OFFSET_Y; 
        else 
            updateFunc(self, auraName, i, numOppositeAuras, i - 1, size, offsetX, offsetY); 
        end 
    end; 
end; 
hooksecurefunc("TargetFrame_UpdateAuraPositions", UpdateTargetAuraPositions)