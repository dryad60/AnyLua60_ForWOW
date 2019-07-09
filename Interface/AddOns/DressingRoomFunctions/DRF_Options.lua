--
--    Dressing Room Functions - Allows undress and target model for dressing room
--    Copyright (C) 2018  Rachael Alexanderson
--
-- Redistribution and use in source and binary forms, with or without modification, are permitted provided
-- that the following conditions are met:
-- 
-- 1. Redistributions of source code must retain the above copyright notice, this list of conditions and the following
-- disclaimer.
-- 
-- 2. Redistributions in binary form must reproduce the above copyright notice, this list of conditions and the following
-- disclaimer in the documentation and/or other materials provided with the distribution.
-- 
-- 3. Neither the name of the copyright holder nor the names of its contributors may be used to endorse or promote products
-- derived from this software without specific prior written permission.
-- 
-- THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING,
-- BUT NOT LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO
-- EVENT SHALL THE COPYRIGHT HOLDER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR
-- CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR
-- PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR
-- TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE
-- POSSIBILITY OF SUCH DAMAGE.
--

local function SysMessage(text)
	DEFAULT_CHAT_FRAME:AddMessage(DRF_L["S_DRF"]..text);
end
local function englishOnOff(conditional)
	if (conditional) then return DRF_L["S_Enabled"]; else return DRF_L["S_Disabled"]; end
end

if not ( DRF_Version == DRF_CoreVersion ) then
	return;
end

if DRF_Global == nil then DRF_Global = {} end;

-- Code based on LUA-only options panel code found on wowpedia.org
-- Credit goes to CurtWulf and Mortilus
-- [SP] The section that used to be here has been moved to Localization.lua

if DRF_Global[DRF.config.s1] == nil then DRF_Global[DRF.config.s1] = false; end
if DRF_Global[DRF.config.s2] == nil then DRF_Global[DRF.config.s2] = false; end
if DRF_Global[DRF.config.s3] == nil then DRF_Global[DRF.config.s3] = false; end
if DRF_Global[DRF.config.s4] == nil then DRF_Global[DRF.config.s4] = false; end

DRF.panel = CreateFrame( "Frame", "DRFPanel", UIParent );

-- Register in the Interface Addon Options GUI
-- Set the name for the Category for the Options Panel
DRF.panel.name = DRF_L["O_Panel"];
-- Add the panel to the Interface Options
InterfaceOptions_AddCategory(DRF.panel);

DRF.panel.text1 = DRF.panel:CreateFontString(nil, "ARTWORK", "GameFontNormalSmall");
DRF.panel.text1:SetPoint("TOP",0,-100);
DRF.panel.text1:SetText(DRF_L["O_DRF"]);

DRF.panel.option1 = CreateFrame("CheckButton", "DRFOption1", DRF.panel, "UICheckButtonTemplate");
DRF.panel.option1:SetPoint("CENTER",-190,45);
DRF.panel.option1.text = _G["DRFOption1Text"];
DRF.panel.option1.text:SetText(DRF.text.s1);
DRF.panel.option1:SetScript("OnClick",function(self,event,arg1)
	DRF_Global[DRF.config.s1] = self:GetChecked()
	SysMessage(DRF.change.s1..englishOnOff(DRF_Global[DRF.config.s1])..".");
end);

DRF.panel.option2 = CreateFrame("CheckButton", "DRFOption2", DRF.panel, "UICheckButtonTemplate");
DRF.panel.option2:SetPoint("CENTER",-190,15);
DRF.panel.option2.text = _G["DRFOption2Text"];
DRF.panel.option2.text:SetText(DRF.text.s2);
DRF.panel.option2:SetScript("OnClick",function(self,event,arg1)
	DRF_Global[DRF.config.s2] = self:GetChecked()
	SysMessage(DRF.change.s2..englishOnOff(DRF_Global[DRF.config.s2])..".");
end);

DRF.panel.option3 = CreateFrame("CheckButton", "DRFOption3", DRF.panel, "UICheckButtonTemplate");
DRF.panel.option3:SetPoint("CENTER",-190,-15);
DRF.panel.option3.text = _G["DRFOption3Text"];
DRF.panel.option3.text:SetText(DRF.text.s3);
DRF.panel.option3:SetScript("OnClick",function(self,event,arg1)
	DRF_Global[DRF.config.s3] = self:GetChecked()
	SysMessage(DRF.change.s3..englishOnOff(DRF_Global[DRF.config.s3])..".");
end);

DRF.panel.option4 = CreateFrame("CheckButton", "DRFOption4", DRF.panel, "UICheckButtonTemplate");
DRF.panel.option4:SetPoint("CENTER",-190,-45);
DRF.panel.option4.text = _G["DRFOption4Text"];
DRF.panel.option4.text:SetText(DRF.text.s4);
DRF.panel.option4:SetScript("OnClick",function(self,event,arg1)
	DRF_Global[DRF.config.s4] = self:GetChecked()
	SysMessage(DRF.change.s4..englishOnOff(DRF_Global[DRF.config.s4])..".");
end);

local function SetOptionsPanel()
	if ( DRF_Global[DRF.config.s1] ) then
		DRF.panel.option1:SetChecked(true); else
		DRF.panel.option1:SetChecked(false); end
	DRF_Option1 = DRF_Global[DRF.config.s1];
	if ( DRF_Global[DRF.config.s2] ) then
		DRF.panel.option2:SetChecked(true); else
		DRF.panel.option2:SetChecked(false); end
	DRF_Option2 = DRF_Global[DRF.config.s2];
	if ( DRF_Global[DRF.config.s3] ) then
		DRF.panel.option3:SetChecked(true); else
		DRF.panel.option3:SetChecked(false); end
	DRF_Option3 = DRF_Global[DRF.config.s3];
	if ( DRF_Global[DRF.config.s4] ) then
		DRF.panel.option4:SetChecked(true); else
		DRF.panel.option4:SetChecked(false); end
	DRF_Option4 = DRF_Global[DRF.config.s4];
end

local function DRF_Cancel()
	local didchange = false;
	if ( DRF_Global[DRF.config.s1] ~= DRF_Option1 ) then didchange = true; end
	if ( DRF_Global[DRF.config.s2] ~= DRF_Option2 ) then didchange = true; end
	if ( DRF_Global[DRF.config.s3] ~= DRF_Option3 ) then didchange = true; end
	if ( DRF_Global[DRF.config.s4] ~= DRF_Option4 ) then didchange = true; end
	DRF_Global[DRF.config.s1] = DRF_Option1;
	DRF_Global[DRF.config.s2] = DRF_Option2;
	DRF_Global[DRF.config.s3] = DRF_Option3;
	DRF_Global[DRF.config.s4] = DRF_Option4;
	if didchange then
		SysMessage(DRF_L["S_Cancel"]);
	end
end

DRF.panel.cancel = function (self) DRF_Cancel();  end;
DRF.panel.refresh = function (self) SetOptionsPanel();  end;

local function parseSwitch(textconditional,originalstate)
	if textconditional == "on" then return true;
	elseif textconditional == "true" then return true;
	elseif textconditional == "1" then return true;
	elseif textconditional == "off" then return false;
	elseif textconditional == "false" then return false;
	elseif textconditional == "0" then return false;
	elseif originalstate == false then return true;
	else return false;
	end
end

SLASH_DRF1, SLASH_DRF2 = '/drf', '/dressingroomfunctions';
function SlashCmdList.DRF(msg, editbox)
	local command, rest = msg:match("^(%S*)%s*(.-)$");

	command = string.lower(command);

	if command == DRF_L["C_Help"] then
		SysMessage(DRF_L["S_Help"]);
		SysMessage(DRF_L["S_Help1"]);
		SysMessage(DRF_L["S_Help2"]);
		SysMessage(DRF_L["S_Help3"]);
		SysMessage(DRF_L["S_Help4"]);
	elseif command == string.lower(DRF.config.s1) or command == string.lower(DRF.alias.s1) then
		DRF_Global[DRF.config.s1] = parseSwitch(rest,DRF_Global[DRF.config.s1]);
		SysMessage(DRF.change.s1..englishOnOff(DRF_Global[DRF.config.s1])..".");
		SetOptionsPanel();
	elseif command == string.lower(DRF.config.s2) or command == string.lower(DRF.alias.s2) then
		DRF_Global[DRF.config.s2] = parseSwitch(rest,DRF_Global[DRF.config.s2]);
		SysMessage(DRF.change.s2..englishOnOff(DRF_Global[DRF.config.s2])..".");
		SetOptionsPanel();
	elseif command == string.lower(DRF.config.s3) or command == string.lower(DRF.alias.s3) then
		DRF_Global[DRF.config.s3] = parseSwitch(rest,DRF_Global[DRF.config.s3]);
		SysMessage(DRF.change.s3..englishOnOff(DRF_Global[DRF.config.s3])..".");
		SetOptionsPanel();
	elseif command == string.lower(DRF.config.s4) or command == string.lower(DRF.alias.s4) then
		DRF_Global[DRF.config.s4] = parseSwitch(rest,DRF_Global[DRF.config.s4]);
		SysMessage(DRF.change.s4..englishOnOff(DRF_Global[DRF.config.s4])..".");
		SetOptionsPanel();
	elseif command == "" then
		InterfaceOptionsFrame_OpenToCategory(DRF.panel);
		SysMessage(DRF_L["S_OptionsFrame"]);
	else
		SysMessage(DRF_L["S_BadCommand"]);
	end
end
