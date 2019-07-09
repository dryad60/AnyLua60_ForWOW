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

DRF_Version = GetAddOnMetadata("DressingRoomFunctions","Version");

DRF_L = {};
DRF = {};
DRF.config = {}; DRF.change = {}; DRF.text = {}; DRF.alias = {};
DRF_Locale = GetLocale();

DRF.config.s1 = "AutoUndress";
DRF.config.s2 = "Conservative";
DRF.config.s3 = "UndressTarget";
DRF.config.s4 = "OpenToTarget";

DRF_L["Whisper"] = WHISPER;
DRF_L["Cancel"] = CANCEL;

-- Hey, this is a template. Copy me and modify me for your language!
-- *** [[[ ENGLISH ]]] ***
--if ( DRF_Locale == "enUS" or DRF_Locale == "enGB" ) then
	-- *** Words
	DRF_L["Undress"] = "Undress";
	DRF_L["Target"] = "Target";
	DRF_L["Male"] = "Male";
	DRF_L["Female"] = "Female";
	DRF_L["Background"] = "Background";
	DRF_L["Remove"] = "Remove";
	DRF_L["Options"] = "Options";
	DRF_L["None"] = "None";
	DRF_L["Links"] = "Item Links"; -- New for Legion Pre-Patch
	DRF_L["WhisperTarget"] = "Whisper who?";
	DRF_L["InvalidTarget"] = "Invalid target selected";

	-- *** Menu Options - these use special punctuation
	DRF_L["ButtonMore"] = "...";
	DRF_L["M_Gender"] = "- Gender -";
	DRF_L["M_Other"] = "- Other -";
	DRF_L["M_Unequip"] = "- Unequip -";
	DRF_L["M_Configure"] = "- Configure -";
	DRF_L["M_Alliance"] = "- Alliance -";
	DRF_L["M_Horde"] = "- Horde -";
	DRF_L["M_Neutral"] = "- Neutral -";
	DRF_L["M_Dump"] = "- Lists -"; -- New for Legion Pre-Patch

	DRF_L["C_Help"] = "help";

	-- *** Config Options
	DRF.alias.s1 = "AutoUndress";
	DRF.alias.s2 = "Conservative";
	DRF.alias.s3 = "UndressTarget";
	DRF.alias.s4 = "OpenToTarget";
	DRF.change.s1 = "Auto Undress ";
	DRF.change.s2 = "Conservative Mode ";
	DRF.change.s3 = "Undress Target ";
	DRF.change.s4 = "Open To Target ";
	DRF.text.s1 = "Undress self on open";
	DRF.text.s2 = "Use conservative 'undress'";
	DRF.text.s3 = "Undress on Target Change";
	DRF.text.s4 = "Open Room To Target";

	-- *** Race List - Masculine
	DRF_L["HumanM"] = "Human";
	DRF_L["DwarfM"] = "Dwarf";
	DRF_L["NightElfM"] = "Night Elf";
	DRF_L["GnomeM"] = "Gnome";
	DRF_L["DraeneiM"] = "Draenei";
	DRF_L["WorgenM"] = "Worgen";
	DRF_L["LightforgedDraeneiM"] = "Lightforged Draenei";
	DRF_L["VoidElfM"] = "Void Elf";
	DRF_L["DarkIronDwarfM"] = "Dark Iron Dwarf";

	DRF_L["OrcM"] = "Orc";
	DRF_L["UndeadM"] = "Undead";
	DRF_L["TaurenM"] = "Tauren";
	DRF_L["TrollM"] = "Troll";
	DRF_L["GoblinM"] = "Goblin";
	DRF_L["BloodElfM"] = "Blood Elf";
	DRF_L["NightborneM"] = "Nightborne";
	DRF_L["HighmountainTaurenM"] = "Highmountain Tauren";
	DRF_L["ZandalariTrollM"] = "Zandalari Troll";
	DRF_L["MagharOrcM"] = "Mag'har Orc";

	DRF_L["PandarenM"] = "Pandaren";

	-- *** Race List - Feminine
	DRF_L["HumanF"] = "Human";
	DRF_L["DwarfF"] = "Dwarf";
	DRF_L["NightElfF"] = "Night Elf";
	DRF_L["GnomeF"] = "Gnome";
	DRF_L["DraeneiF"] = "Draenei";
	DRF_L["WorgenF"] = "Worgen";
	DRF_L["LightforgedDraeneiF"] = "Lightforged Draenei";
	DRF_L["VoidElfF"] = "Void Elf";
	DRF_L["DarkIronDwarfF"] = "Dark Iron Dwarf";

	DRF_L["OrcF"] = "Orc";
	DRF_L["UndeadF"] = "Undead";
	DRF_L["TaurenF"] = "Tauren";
	DRF_L["TrollF"] = "Troll";
	DRF_L["GoblinF"] = "Goblin";
	DRF_L["BloodElfF"] = "Blood Elf";
	DRF_L["NightborneF"] = "Nightborne";
	DRF_L["HighmountainTaurenF"] = "Highmountain Tauren";
	DRF_L["ZandalariTrollF"] = "Zandalari Troll";
	DRF_L["MagharOrcF"] = "Mag'har Orc";

	DRF_L["PandarenF"] = "Pandaren";

	-- *** Item Slots
	DRF_L["Head"] = "Head";
	DRF_L["Shoulder"] = "Shoulder";
	DRF_L["Back"] = "Back";
	DRF_L["Chest"] = "Chest";
	DRF_L["Shirt"] = "Shirt";
	DRF_L["Tabard"] = "Tabard";
	DRF_L["Wrist"] = "Wrist";
	DRF_L["Hands"] = "Hands";
	DRF_L["Waist"] = "Waist";
	DRF_L["Legs"] = "Legs";
	DRF_L["Feet"] = "Feet";
	DRF_L["MainHand"] = "Main Hand";
	DRF_L["OffHand"] = "Off-Hand";

	-- *** System Messages
	DRF_L["BadUpdate"] = "You have not properly updated your add-ons. Please restart the game - Dressing Room Functions will not work until you do.";
	DRF_L["S_DRF"] = "|cffffff90DRF:|r ";
	DRF_L["S_Enabled"] = "|cff00ff00enabled|r";
	DRF_L["S_Disabled"] = "|cffff0000disabled|r";
	DRF_L["S_Cancel"] = "Canceled Options Change";
	DRF_L["S_Help"] = "/drf help - Shows this help";
	DRF_L["S_Help1"] = "/drf "..DRF.alias.s1.." [on/off] - "..DRF.text.s1;
	DRF_L["S_Help2"] = "/drf "..DRF.alias.s2.." [on/off] - "..DRF.text.s2;
	DRF_L["S_Help3"] = "/drf "..DRF.alias.s3.." [on/off] - "..DRF.text.s3;
	DRF_L["S_Help4"] = "/drf "..DRF.alias.s4.." [on/off] - "..DRF.text.s4;
	DRF_L["S_OptionsFrame"] = "Opening Options Frame.";
	DRF_L["S_BadCommand"] = "Unrecognized command. Type /drf help for a list of options.";

	DRF_L["O_Panel"] = "Dressing Room Functions";
	DRF_L["O_DRF"] = "Dressing Room Functions "..DRF_Version.." by Allikitten (Allicilea of US-MoonGuard)";
--end


-- *** [[[ CHINESE TRADITIONAL ]]] *** (Credit: BlueNightSky from Kerobbs.net)

if ( DRF_Locale == "zhTW" or DRF_Locale == "enTW" ) then

	-- *** Words
	DRF_L["Undress"] = "脫裝";
	DRF_L["Target"] = "目標";
	DRF_L["Male"] = "男性";
	DRF_L["Female"] = "女";
	DRF_L["Background"] = "背景";
	DRF_L["Remove"] = "設置";
	DRF_L["Options"] = "選項";
	DRF_L["None"] = "無";
	DRF_L["Links"] = "物品鏈接"; 

	-- *** Menu Options - these use special punctuation
	DRF_L["ButtonMore"] = "...";
	DRF_L["M_Gender"] = "- 性別 -";
	DRF_L["M_Other"] = "- 其他 -";
	DRF_L["M_Unequip"] = "- 卸裝 -";
	DRF_L["M_Configure"] = "- 設置 -";
	DRF_L["M_Alliance"] = "- 聯盟 -";
	DRF_L["M_Horde"] = "- 部落 -";
	DRF_L["M_Neutral"] = "- 中立 -";
	DRF_L["M_Dump"] = "- 物品列表 -";

	DRF_L["C_Help"] = "help";

	-- *** Config Options
	DRF.alias.s1 = "自動脫衣服";
	DRF.alias.s2 = "保守";
	DRF.alias.s3 = "脫衣服的目標";
	DRF.change.s1 = "自動脫裝 ";
	DRF.change.s2 = "保守模式 ";
	DRF.change.s3 = "目標脫裝 ";
	DRF.text.s1 = "開啟時脫光自己";
	DRF.text.s2 = "使用保守的'脫裝'";
	DRF.text.s3 = "目標轉換時脫裝";

	-- *** Race List - Masculine
	DRF_L["HumanM"] = "人類";
	DRF_L["DwarfM"] = "矮人";
	DRF_L["NightElfM"] = "暗夜精靈";
	DRF_L["GnomeM"] = "地精";
	DRF_L["DraeneiM"] = "德萊尼";
	DRF_L["WorgenM"] = "狼人";

	DRF_L["OrcM"] = "獸人";
	DRF_L["UndeadM"] = "不死族";
	DRF_L["TaurenM"] = "牛頭人";
	DRF_L["TrollM"] = "食人妖";
	DRF_L["GoblinM"] = "哥布林";
	DRF_L["BloodElfM"] = "血精靈";

	DRF_L["PandarenM"] = "熊貓人";

	-- *** Race List - Feminine
	DRF_L["HumanF"] = "人類";
	DRF_L["DwarfF"] = "矮人";
	DRF_L["NightElfF"] = "暗夜精靈";
	DRF_L["GnomeF"] = "地精";
	DRF_L["DraeneiF"] = "德萊尼";
	DRF_L["WorgenF"] = "狼人";

	DRF_L["OrcF"] = "獸人";
	DRF_L["UndeadF"] = "不死族";
	DRF_L["TaurenF"] = "牛頭人";
	DRF_L["TrollF"] = "食人妖";
	DRF_L["GoblinF"] = "哥布林";
	DRF_L["BloodElfF"] = "血精靈";

	DRF_L["PandarenF"] = "熊貓人";

	-- *** Item Slots
	DRF_L["Head"] = "頭部";
	DRF_L["Shoulder"] = "肩部";
	DRF_L["Back"] = "背部";
	DRF_L["Chest"] = "胸部";
	DRF_L["Shirt"] = "襯衣";
	DRF_L["Tabard"] = "外袍";
	DRF_L["Wrist"] = "手腕";
	DRF_L["Hands"] = "手";
	DRF_L["Waist"] = "腰部";
	DRF_L["Legs"] = "腿部";
	DRF_L["Feet"] = "腳";
	DRF_L["MainHand"] = "主手";
	DRF_L["OffHand"] = "副手";

	-- *** System Messages
	DRF_L["BadUpdate"] = "外掛程式不能正確更新。請重新開始遊戲。更衣室功能將無法正常工作直到你重啟。";
	DRF_L["S_DRF"] = "|cffffff90DRF:|r ";
	DRF_L["S_Enabled"] = "|cff00ff00啟用|r";
	DRF_L["S_Disabled"] = "|cffff0000禁用|r";
	DRF_L["S_Cancel"] = "取消選項變更";
	DRF_L["S_Help"] = "/drf help - 顯示命令列表";
	DRF_L["S_Help1"] = "/drf "..DRF.alias.s1.." [on/off] - "..DRF.text.s1;
	DRF_L["S_Help2"] = "/drf "..DRF.alias.s2.." [on/off] - "..DRF.text.s2;
	DRF_L["S_Help3"] = "/drf "..DRF.alias.s3.." [on/off] - "..DRF.text.s3;
	DRF_L["S_Help4"] = "/drf "..DRF.alias.s4.." [on/off] - "..DRF.text.s4;
	DRF_L["S_OptionsFrame"] = "開啟選項面板。";
	DRF_L["S_BadCommand"] = "未組織的命令。 輸入 /drf help 取得命令列表。";

	--DRF_L["O_Panel"] = "試衣間增強";
	DRF_L["O_DRF"] = "試衣間增強"..DRF_Version.."由 AlliKitten （由 BlueNightSky 提供的翻譯） （機由必應和谷歌的翻譯）";
end


-- *** [[[ CHINESE SIMPLIFIED ]]] *** (Using BlueNightSky's Traditional Chinese translations, retranslated to Simplified)
if ( DRF_Locale == "zhCN" or DRF_Locale == "enCN" ) then

	-- *** Words
	DRF_L["Undress"] = "脱装";
	DRF_L["Target"] = "目标";
	DRF_L["Male"] = "男性";
	DRF_L["Female"] = "女";
	DRF_L["Background"] = "背景";
	DRF_L["Remove"] = "设置";
	DRF_L["Options"] = "选项";
	DRF_L["None"] = "无";

	DRF_L["ButtonMore"] = "...";
	DRF_L["M_Gender"] = "- 性别 -";
	DRF_L["M_Other"] = "- 其他 -";
	DRF_L["M_Unequip"] = "- 删除设备 -";
	DRF_L["M_Configure"] = "- 配置 -";
	DRF_L["M_Alliance"] = "- 联盟 -";
	DRF_L["M_Horde"] = "- 部落 -";
	DRF_L["M_Neutral"] = "- 中性 -";

	DRF_L["C_Help"] = "help";

	-- *** Config Options
	DRF.alias.s1 = "自动脱衣服";
	DRF.alias.s2 = "保守";
	DRF.alias.s3 = "脱衣服的目标";
	DRF.change.s1 = "自动脱衣服自拍 ";
	DRF.change.s2 = "保守脱衣服 ";
	DRF.change.s3 = "脱衣服的目标开关 ";
	DRF.text.s1 = "打开时自动脱衣服";
	DRF.text.s2 = "采用保守的衣服脱衣服";
	DRF.text.s3 = "脱衣服的目标，当我切换目标";

	-- *** Race List - Masculine
	DRF_L["HumanM"] = "人类";
	DRF_L["DwarfM"] = "矮人";
	DRF_L["NightElfM"] = "暗夜精灵";
	DRF_L["GnomeM"] = "侏儒";
	DRF_L["DraeneiM"] = "德莱尼";
	DRF_L["WorgenM"] = "狼人";

	DRF_L["OrcM"] = "兽人";
	DRF_L["UndeadM"] = "亡灵";
	DRF_L["TaurenM"] = "牛头人";
	DRF_L["TrollM"] = "巨魔";
	DRF_L["GoblinM"] = "地精";
	DRF_L["BloodElfM"] = "血精灵";

	DRF_L["PandarenM"] = "熊猫人";

	-- *** Race List - Feminine
	DRF_L["HumanF"] = "人类";
	DRF_L["DwarfF"] = "矮人";
	DRF_L["NightElfF"] = "暗夜精灵";
	DRF_L["GnomeF"] = "侏儒";
	DRF_L["DraeneiF"] = "德莱尼";
	DRF_L["WorgenF"] = "狼人";

	DRF_L["OrcF"] = "兽人";
	DRF_L["UndeadF"] = "亡灵";
	DRF_L["TaurenF"] = "牛头人";
	DRF_L["TrollF"] = "巨魔";
	DRF_L["GoblinF"] = "地精";
	DRF_L["BloodElfF"] = "血精灵";

	DRF_L["PandarenF"] = "熊猫人";

	-- *** Item Slots
	DRF_L["Head"] = "头部";
	DRF_L["Shoulder"] = "肩部";
	DRF_L["Back"] = "背部";
	DRF_L["Chest"] = "胸部";
	DRF_L["Shirt"] = "衬衣";
	DRF_L["Tabard"] = "外袍";
	DRF_L["Wrist"] = "手腕";
	DRF_L["Hands"] = "手";
	DRF_L["Waist"] = "腰部";
	DRF_L["Legs"] = "腿部";
	DRF_L["Feet"] = "脚";
	DRF_L["MainHand"] = "主手";
	DRF_L["OffHand"] = "副手";

	-- *** System Messages
	DRF_L["BadUpdate"] = "插件不能正确更新。请重新启动游戏。更衣室功能将无法正常工作，直到你做。";
	DRF_L["S_DRF"] = "|cffffff90DRF:|r ";
	DRF_L["S_Enabled"] = "|cff00ff00启用|r";
	DRF_L["S_Disabled"] = "|cffff0000禁用|r";
	DRF_L["S_Cancel"] = "取消变更";
	DRF_L["S_Help"] = "/drf help - 取消选项变更";
	DRF_L["S_Help1"] = "/drf "..DRF.alias.s1.." [on/off] - "..DRF.text.s1;
	DRF_L["S_Help2"] = "/drf "..DRF.alias.s2.." [on/off] - "..DRF.text.s2;
	DRF_L["S_Help3"] = "/drf "..DRF.alias.s3.." [on/off] - "..DRF.text.s3;
	DRF_L["S_Help4"] = "/drf "..DRF.alias.s4.." [on/off] - "..DRF.text.s4;
	DRF_L["S_OptionsFrame"] = "开启选项面板。";
	DRF_L["S_BadCommand"] = "未组织的命令。 输入 /drf help 取得命令行表。";

	--DRF_L["O_Panel"] = "试衣间增强";
	DRF_L["O_DRF"] = "试衣间增强"..DRF_Version.."由 AlliKitten （由 BlueNightSky 提供的翻译） （机由必应和谷歌的翻译）";
end

-- *** [[[ ITALIAN ]]] ***
if ( DRF_Locale == "itIT" ) then
	-- *** Words
	DRF_L["Undress"] = "Spogliarsi";
	DRF_L["Target"] = "Obiettivo";
	DRF_L["Male"] = "Maschio";
	DRF_L["Female"] = "Femminile";
	DRF_L["Background"] = "Sfondo";
	DRF_L["Remove"] = "Togliere";
	DRF_L["Options"] = "Opzioni";
	DRF_L["None"] = "Nessuno";
	DRF_L["Links"] = "Ligações de itens"; -- New for Legion Pre-Patch

	-- *** Menu Options - these use special punctuation
	DRF_L["ButtonMore"] = "...";
	DRF_L["M_Gender"] = "- Genere -";
	DRF_L["M_Other"] = "- Altro -";
	DRF_L["M_Unequip"] = "- Togliere -";
	DRF_L["M_Configure"] = "- Configurare -";
	DRF_L["M_Alliance"] = "- Alleanza -";
	DRF_L["M_Horde"] = "- Orda -";
	DRF_L["M_Neutral"] = "- Neutrale -";
	DRF_L["M_Dump"] = "- Elenchi -"; -- New for Legion Pre-Patch

	DRF_L["C_Help"] = "help";

	-- *** Config Options
	DRF.alias.s1 = "SpogliarsiMe";
	DRF.alias.s2 = "conservatore";
	DRF.alias.s3 = "DestSpoglarsi";
	DRF.change.s1 = "Svestizione Automatico ";
	DRF.change.s2 = "Modalità conservatore ";
	DRF.change.s3 = "Spogliati di destinazione ";
	DRF.text.s1 = "Spogliarsi me sulla finestra aperta";
	DRF.text.s2 = "Utilizzare il metodo spogliarsi conservativo";
	DRF.text.s3 = "Spogliarsi interruttore di destinazione";

	-- *** Race List - Masculine
	DRF_L["HumanM"] = "Umano";
	DRF_L["DwarfM"] = "Nano";
	DRF_L["NightElfM"] = "Elfo della Notte";
	DRF_L["GnomeM"] = "Gnomo";
	DRF_L["DraeneiM"] = "Draenei";
	DRF_L["WorgenM"] = "Worgen";

	DRF_L["OrcM"] = "Orco";
	DRF_L["UndeadM"] = "Non Morto";
	DRF_L["TaurenM"] = "Tauren";
	DRF_L["TrollM"] = "Troll";
	DRF_L["GoblinM"] = "Goblin";
	DRF_L["BloodElfM"] = "Elfo del Sangue";

	DRF_L["PandarenM"] = "Pandaren";

	-- *** Race List - Feminine
	DRF_L["HumanF"] = "Umana";
	DRF_L["DwarfF"] = "Nana";
	DRF_L["NightElfF"] = "Elfa della Notte";
	DRF_L["GnomeF"] = "Gnoma";
	DRF_L["DraeneiF"] = "Draenei";
	DRF_L["WorgenF"] = "Worgen";

	DRF_L["OrcF"] = "Orchessa";
	DRF_L["UndeadF"] = "Non Morta";
	DRF_L["TaurenF"] = "Tauren";
	DRF_L["TrollF"] = "Troll";
	DRF_L["GoblinF"] = "Goblin";
	DRF_L["BloodElfF"] = "Elfa del Sangue";

	DRF_L["PandarenF"] = "Pandaren";

	-- *** Item Slots
	DRF_L["Head"] = "Testa";
	DRF_L["Shoulder"] = "Spalle";
	DRF_L["Back"] = "Schiena";
	DRF_L["Chest"] = "Torso";
	DRF_L["Shirt"] = "Camicia";
	DRF_L["Tabard"] = "Insegna";
	DRF_L["Wrist"] = "Polsi";
	DRF_L["Hands"] = "Mani";
	DRF_L["Waist"] = "Fianchi";
	DRF_L["Legs"] = "Gambe";
	DRF_L["Feet"] = "Piedi";
	DRF_L["MainHand"] = "Mano Primaria";
	DRF_L["OffHand"] = "Mano Secondaria";

	-- *** System Messages
	DRF_L["BadUpdate"] = "Non hai correttamente aggiornato il tuo addon. Si prega di riavviare il gioco - Spogliatoi Funzioni Camera non funzionerà fino a che fare.";
	DRF_L["S_DRF"] = "|cffffff90DRF:|r ";
	DRF_L["S_Enabled"] = "|cff00ff00abilitato|r";
	DRF_L["S_Disabled"] = "|cffff0000disabile|r";
	DRF_L["S_Cancel"] = "Cambiato nulla";
	DRF_L["S_Help"] = "/drf help - Mostra questo messaggio di aiuto";
	DRF_L["S_Help1"] = "/drf "..DRF.alias.s1.." [on/off] - "..DRF.text.s1;
	DRF_L["S_Help2"] = "/drf "..DRF.alias.s2.." [on/off] - "..DRF.text.s2;
	DRF_L["S_Help3"] = "/drf "..DRF.alias.s3.." [on/off] - "..DRF.text.s3;
	DRF_L["S_Help4"] = "/drf "..DRF.alias.s4.." [on/off] - "..DRF.text.s4;
	DRF_L["S_OptionsFrame"] = "Pannello di configurazione di apertura.";
	DRF_L["S_BadCommand"] = "Comando non riconosciuto. Digitare /drf help per un elenco di opzioni.";

	--DRF_L["O_Panel"] = "Funzioni Spogliatoio";
	DRF_L["O_DRF"] = "Funzioni spogliatoio "..DRF_Version.." da Allikitten (Allicilea di US-MoonGuard) - Tradotto da Google";
end


-- *** [[[ KOREAN ]]] ***
if ( DRF_Locale == "koKR" ) then

	-- *** Words
	DRF_L["Undress"] = "평복";
	DRF_L["Target"] = "목표";
	DRF_L["Male"] = "남성";
	DRF_L["Female"] = "여성";
	DRF_L["Background"] = "배경";
	DRF_L["Remove"] = "장비를 제거";
	DRF_L["Options"] = "옵션";
	DRF_L["None"] = "없음";
	DRF_L["Links"] = "항목 링크";

	-- *** Menu Options - these use special punctuation
	DRF_L["ButtonMore"] = "...";
	DRF_L["M_Gender"] = "- 성 -";
	DRF_L["M_Other"] = "- 다른 -";
	DRF_L["M_Unequip"] = "- 장비를 제거 -";
	DRF_L["M_Configure"] = "- 구성 -";
	DRF_L["M_Alliance"] = "- 동맹 -";
	DRF_L["M_Horde"] = "- 유목민의 떼 -";
	DRF_L["M_Neutral"] = "- 중립국 -";
	DRF_L["M_Dump"] = "- 기울기 -";

	DRF_L["C_Help"] = "help";

	-- *** Config Options
	DRF.alias.s1 = "옷나";
	DRF.alias.s2 = "계속";
	DRF.alias.s3 = "스트립";
	DRF.change.s1 = "자동 알몸 ";
	DRF.change.s2 = "보수적 인 옷을 벗고 ";
	DRF.change.s3 = "알몸 대상 ";
	DRF.text.s1 = "나의 창을 열 때 자동으로 저 옷을 벗고";
	DRF.text.s2 = "대신에 완전한 알몸의 보수적 인 복장";
	DRF.text.s3 = "내가 목표를 전환 할 때 내 목표를 옷을 벗고";

	-- *** Race List - Masculine
	DRF_L["HumanM"] = "인간";
	DRF_L["DwarfM"] = "드워프";
	DRF_L["NightElfM"] = "나이트 엘프";
	DRF_L["GnomeM"] = "노움";
	DRF_L["DraeneiM"] = "드레나이";
	DRF_L["WorgenM"] = "늑대인간";

	DRF_L["OrcM"] = "오크";
	DRF_L["UndeadM"] = "언데드";
	DRF_L["TaurenM"] = "타우렌";
	DRF_L["TrollM"] = "트롤";
	DRF_L["GoblinM"] = "고블린";
	DRF_L["BloodElfM"] = "블러드 엘프";

	DRF_L["PandarenM"] = "판다렌";

	-- *** Race List - Feminine
	DRF_L["HumanF"] = "인간";
	DRF_L["DwarfF"] = "드워프";
	DRF_L["NightElfF"] = "나이트 엘프";
	DRF_L["GnomeF"] = "노움";
	DRF_L["DraeneiF"] = "드레나이";
	DRF_L["WorgenF"] = "늑대인간";

	DRF_L["OrcF"] = "오크";
	DRF_L["UndeadF"] = "언데드";
	DRF_L["TaurenF"] = "타우렌";
	DRF_L["TrollF"] = "트롤";
	DRF_L["GoblinF"] = "고블린";
	DRF_L["BloodElfF"] = "블러드 엘프";

	DRF_L["PandarenF"] = "판다렌";

	-- *** Item Slots
	DRF_L["Head"] = "헬멧";
	DRF_L["Shoulder"] = "어깨";
	DRF_L["Back"] = "케이프";
	DRF_L["Chest"] = "가슴 보호구";
	DRF_L["Shirt"] = "셔츠";
	DRF_L["Tabard"] = "문장이 든 겉옷";
	DRF_L["Wrist"] = "팔 보호구";
	DRF_L["Hands"] = "장갑";
	DRF_L["Waist"] = "벨트";
	DRF_L["Legs"] = "다리 갑옷";
	DRF_L["Feet"] = "부츠";
	DRF_L["MainHand"] = "차 손";
	DRF_L["OffHand"] = "핸드 오프";

	-- *** System Messages
	DRF_L["BadUpdate"] = "제대로 애드온을 업데이트하지 마십시오. 게임을 다시 시작하십시오 - 당신이 할 때까지 작동하지 않습니다 鑴 객실 특징 드레싱.";
	DRF_L["S_DRF"] = "|cffffff90DRF:|r ";
	DRF_L["S_Enabled"] = "|cff00ff00사용|r";
	DRF_L["S_Disabled"] = "|cffff0000장애인|r";
	DRF_L["S_Cancel"] = "취소 변경";
	DRF_L["S_Help"] = "/drf help - 이 도움말 메시지를 표시";
	DRF_L["S_Help1"] = "/drf "..DRF.alias.s1.." [on/off] - "..DRF.text.s1;
	DRF_L["S_Help2"] = "/drf "..DRF.alias.s2.." [on/off] - "..DRF.text.s2;
	DRF_L["S_Help3"] = "/drf "..DRF.alias.s3.." [on/off] - "..DRF.text.s3;
	DRF_L["S_Help4"] = "/drf "..DRF.alias.s4.." [on/off] - "..DRF.text.s4;
	DRF_L["S_OptionsFrame"] = "구성 패널의 오프닝.";
	DRF_L["S_BadCommand"] = "명령을 인식 할 수 없습니다. 옵션 목록 /drf help 입력합니다.";

	--DRF_L["O_Panel"] = "更衣室功能";
	DRF_L["O_DRF"] = "드레싱 룸은 구글 번역 Allikitten로 "..DRF_Version.." 프레임";
end


-- *** [[[ RUSSIAN ]]] *** (Contributed: Nixelf from curseforge.net)
if ( DRF_Locale == "ruRU" ) then
	-- *** Words
	DRF_L["Undress"] = "Раздеть";
	DRF_L["Target"] = "Цель";
	DRF_L["Male"] = "Мужской";
	DRF_L["Female"] = "Женский";
	DRF_L["Background"] = "Фон";
	DRF_L["Remove"] = "Снять вещь";
	DRF_L["Options"] = "Настройки";
	DRF_L["None"] = "Ничего";

	-- *** Menu Options - these use special punctuation
	DRF_L["ButtonMore"] = "...";
	DRF_L["M_Gender"] = "- Пол -";
	DRF_L["M_Other"] = "- Другое -";
	DRF_L["M_Unequip"] = "- Снять -";
	DRF_L["M_Configure"] = "- Настройка -";
	DRF_L["M_Alliance"] = "- Альянс -";
	DRF_L["M_Horde"] = "- Орда -";
	DRF_L["M_Neutral"] = "- Нейтральные -";

	DRF_L["C_Help"] = "Помощь";

	-- *** Config Options
	DRF.alias.s1 = "AutoUndress";
	DRF.alias.s2 = "Conservative";
	DRF.alias.s3 = "UndressTarget";
	DRF.change.s1 = "Автоматическое Раздевание ";
	DRF.change.s2 = "Режим Костюма ";
	DRF.change.s3 = "Раздеть Цель ";
	DRF.text.s1 = "Раздеть персонажа когда открывается гардеробная";
	DRF.text.s2 = "Использовать костюм при раздевании вместо нижнего белья";
	DRF.text.s3 = "Раздеть цель при выборе цели";

	-- *** Race List - Masculine
	DRF_L["HumanM"] = "Человек";
	DRF_L["DwarfM"] = "Дворф";
	DRF_L["NightElfM"] = "Ночной эльф";
	DRF_L["GnomeM"] = "Гном";
	DRF_L["DraeneiM"] = "Дреней";
	DRF_L["WorgenM"] = "Ворген";

	DRF_L["OrcM"] = "Орк";
	DRF_L["UndeadM"] = "Нежить";
	DRF_L["TaurenM"] = "Таурен";
	DRF_L["TrollM"] = "Тролль";
	DRF_L["GoblinM"] = "Гоблин";
	DRF_L["BloodElfM"] = "Эльф крови";

	DRF_L["PandarenM"] = "Пандарен";

	-- *** Race List - Feminine
	DRF_L["HumanF"] = "Человек";
	DRF_L["DwarfF"] = "Дворф";
	DRF_L["NightElfF"] = "Ночная эльфийка";
	DRF_L["GnomeF"] = "Гном";
	DRF_L["DraeneiF"] = "Дреней";
	DRF_L["WorgenF"] = "Ворген";

	DRF_L["OrcF"] = "Орк";
	DRF_L["UndeadF"] = "Нежить";
	DRF_L["TaurenF"] = "Таурен";
	DRF_L["TrollF"] = "Тролль";
	DRF_L["GoblinF"] = "Гоблин";
	DRF_L["BloodElfF"] = "Эльфийка крови";

	DRF_L["PandarenF"] = "Пандарен";

	-- *** Item Slots
	DRF_L["Head"] = "Шлем";
	DRF_L["Shoulder"] = "Плечо";
	DRF_L["Back"] = "Плащ";
	DRF_L["Chest"] = "Грудь";
	DRF_L["Shirt"] = "Рубашка";
	DRF_L["Tabard"] = "Гербовая накидка";
	DRF_L["Wrist"] = "Запястья";
	DRF_L["Hands"] = "Кисти рук";
	DRF_L["Waist"] = "Пояс";
	DRF_L["Legs"] = "Ноги";
	DRF_L["Feet"] = "Ступни";
	DRF_L["MainHand"] = "Правая рука";
	DRF_L["OffHand"] = "Левая рука";

	-- *** System Messages
	DRF_L["BadUpdate"] = "Ваши модификации обновлены неправильно. Пожалуйста, перезапустите игру - Dressing Room Functions не будет работать пока вы этого не сделаете";
	DRF_L["S_DRF"] = "|cffffff90DRF:|r ";
	DRF_L["S_Enabled"] = "|cff00ff00включено|r";
	DRF_L["S_Disabled"] = "|cffff0000выключено|r";
	DRF_L["S_Cancel"] = "Изменения настроек отменены";
	DRF_L["S_Help"] = "/drf help - Показывает эту справку";
	DRF_L["S_Help1"] = "/drf "..DRF.alias.s1.." [on/off] - "..DRF.text.s1
	DRF_L["S_Help2"] = "/drf "..DRF.alias.s2.." [on/off] - "..DRF.text.s2
	DRF_L["S_Help3"] = "/drf "..DRF.alias.s3.." [on/off] - "..DRF.text.s3
	DRF_L["S_Help4"] = "/drf "..DRF.alias.s4.." [on/off] - "..DRF.text.s4;
	DRF_L["S_OptionsFrame"] = "Открытие панели настроек";
	DRF_L["S_BadCommand"] = "Неизвестная команда. Введите /drf help для получения списка настроек.";

	--DRF_L["O_Panel"] = "Dressing Room Functions";
	DRF_L["O_DRF"] = "Dressing Room Functions "..DRF_Version.." по Allikitten - перевод Армун@Азурегос";
end


-- *** [[[ SPANISH ]]] ***
if ( DRF_Locale == "esES" or DRF_Locale == "esMX" ) then
	-- *** Words
	DRF_L["Undress"] = "Desvestirse";
	DRF_L["Target"] = "Objetivo";
	DRF_L["Male"] = "Masculino";
	DRF_L["Female"] = "Femenino";
	DRF_L["Background"] = "Fondo";
	DRF_L["Remove"] = "Retire";
	DRF_L["Options"] = "Opciones";
	DRF_L["None"] = "Ninguno";
	DRF_L["Links"] = "Enlaces artículo";

	-- *** Menu Options - these use special punctuation
	DRF_L["ButtonMore"] = "...";
	DRF_L["M_Gender"] = "- Género -";
	DRF_L["M_Other"] = "- Otro -";
	DRF_L["M_Unequip"] = "- Desequipamiento -";
	DRF_L["M_Configure"] = "- Configure -";
	DRF_L["M_Alliance"] = "- Alianza -";
	DRF_L["M_Horde"] = "- Horda -";
	DRF_L["M_Neutral"] = "- Neutral -";
	DRF_L["M_Dump"] = "- Liza -";

	DRF_L["C_Help"] = "help";

	-- *** Config Options
	DRF.alias.s1 = "AutoDesv";
	DRF.alias.s2 = "Conservador";
	DRF.alias.s3 = "DesvObjetivo";
	DRF.change.s1 = "Automáticamente Desvestirse ";
	DRF.change.s2 = "Desvestirse Conservador ";
	DRF.change.s3 = "Desvestirse Objetivo ";
	DRF.text.s1 = "Desnudar a mí mismo al abrir mi camerino";
	DRF.text.s2 = "Utilice traje conservador para desnudarse en lugar de traje de baño";
	DRF.text.s3 = "Desvestirse Objetivo cuando pongo metas vestidor";

	-- *** Race List - Masculine
	DRF_L["HumanM"] = "Humano";
	DRF_L["DwarfM"] = "Enano";
	DRF_L["NightElfM"] = "Elfo de la noche";
	DRF_L["GnomeM"] = "Gnomo";
	DRF_L["DraeneiM"] = "Draenei";
	DRF_L["WorgenM"] = "Huargen";

	DRF_L["OrcM"] = "Orco";
	DRF_L["UndeadM"] = "No-muerto";
	DRF_L["TaurenM"] = "Tauren";
	DRF_L["TrollM"] = "Trol";
	DRF_L["GoblinM"] = "Goblin";
	DRF_L["BloodElfM"] = "Elfo de sangre";

	DRF_L["PandarenM"] = "Pandaren";

	-- *** Race List - Feminine
	DRF_L["HumanF"] = "Humana";
	DRF_L["DwarfF"] = "Enana";
	DRF_L["NightElfF"] = "Elfa de la noche";
	DRF_L["GnomeF"] = "Gnoma";
	DRF_L["DraeneiF"] = "Draenei";
	DRF_L["WorgenF"] = "Huargen";

	DRF_L["OrcF"] = "Orco";
	DRF_L["UndeadF"] = "No-muerta";
	DRF_L["TaurenF"] = "Tauren";
	DRF_L["TrollF"] = "Trol";
	DRF_L["GoblinF"] = "Goblin";
	DRF_L["BloodElfF"] = "Elfa de sangre";

	DRF_L["PandarenF"] = "Pandaren";

	-- *** Item Slots
	DRF_L["Head"] = "Cabeza";
	DRF_L["Shoulder"] = "Hombros";
	DRF_L["Back"] = "Espalda";
	DRF_L["Chest"] = "Pecho";
	DRF_L["Shirt"] = "Camisa";
	DRF_L["Tabard"] = "Tabardo";
	DRF_L["Wrist"] = "Muñecas";
	DRF_L["Hands"] = "Manos";
	DRF_L["Waist"] = "Cintura";
	DRF_L["Legs"] = "Piernas";
	DRF_L["Feet"] = "Pies";
	DRF_L["MainHand"] = "Mano derecha";
	DRF_L["OffHand"] = "Mano izquierda";

	-- *** System Messages
	DRF_L["BadUpdate"] = "Usted no ha actualizado correctamente sus addons. Por favor, reinicie el juego - Vestir Funciones de habitación no funcionarán hasta que lo haga.";
	DRF_L["S_DRF"] = "|cffffff90DRF:|r ";
	DRF_L["S_Enabled"] = "|cff00ff00habilitado|r";
	DRF_L["S_Disabled"] = "|cffff0000discapacitado|r";
	DRF_L["S_Cancel"] = "Cancelado modificación Opciones";
	DRF_L["S_Help"] = "/drf help - Muestra esta ayuda";
	DRF_L["S_Help1"] = "/drf "..DRF.alias.s1.." [on/off] - "..DRF.text.s1;
	DRF_L["S_Help2"] = "/drf "..DRF.alias.s2.." [on/off] - "..DRF.text.s2;
	DRF_L["S_Help3"] = "/drf "..DRF.alias.s3.." [on/off] - "..DRF.text.s3;
	DRF_L["S_Help4"] = "/drf "..DRF.alias.s4.." [on/off] - "..DRF.text.s4;
	DRF_L["S_OptionsFrame"] = "Panel de configuración de apertura.";
	DRF_L["S_BadCommand"] = "Comando no reconocido. Escriba /drf help para una lista de opciones.";

	--DRF_L["O_Panel"] = "Funciones Vestidor";
	DRF_L["O_DRF"] = "Funciones Vestidor "..DRF_Version.." por Allikitten - Traducción de Google";
end


-- *** [[[ GERMAN ]]] *** (Credit: Imithat from wowinterface.com)
if ( DRF_Locale == "deDE" ) then
	-- *** Words
	DRF_L["Undress"] = "Entkleiden";
	DRF_L["Target"] = "Ziel";
	DRF_L["Male"] = "Männlich";
	DRF_L["Female"] = "Weiblich";
	DRF_L["Background"] = "Hintergrund";
	DRF_L["Remove"] = "Rüstung entfernen";
	DRF_L["Options"] = "Optionen";
	DRF_L["None"] = "Nichts";

	-- *** Menu Options - these use special punctuation
	DRF_L["ButtonMore"] = "...";
	DRF_L["M_Gender"] = "- Geschlecht -";
	DRF_L["M_Other"] = "- Andere -";
	DRF_L["M_Unequip"] = "- Ausschalten -";
	DRF_L["M_Configure"] = "- Konfigurieren -";
	DRF_L["M_Alliance"] = "- Allianz -";
	DRF_L["M_Horde"] = "- Horde -";
	DRF_L["M_Neutral"] = "- Neutral -";

	DRF_L["C_Help"] = "help";

	-- *** Config Options
	DRF.alias.s1 = "Entkleiden";
	DRF.alias.s2 = "Konservativ";
	DRF.alias.s3 = "Entkleide Ziel";
	DRF.change.s1 = "Automatisch Entkleiden ";
	DRF.change.s2 = "Konservatives Entkleiden ";
	DRF.change.s3 = "Entkleide Ziel ";
	DRF.text.s1 = "Entkleide mich, wenn meine Anprobe geöffnet wird";
	DRF.text.s2 = "Verwende ein Konservatives Outfit wenn du dich entkleidest";
	DRF.text.s3 = "Entkleide das Ziel, nachdem zweiten drücken des Ziels";

	-- *** Race List - Masculine
	DRF_L["HumanM"] = "Mensch";
	DRF_L["DwarfM"] = "Zwerg";
	DRF_L["NightElfM"] = "Nachtelf";
	DRF_L["GnomeM"] = "Gnom";
	DRF_L["DraeneiM"] = "Draenei";
	DRF_L["WorgenM"] = "Worgen";

	DRF_L["OrcM"] = "Orc";
	DRF_L["UndeadM"] = "Untoter";
	DRF_L["TaurenM"] = "Tauren";
	DRF_L["TrollM"] = "Troll";
	DRF_L["GoblinM"] = "Goblin";
	DRF_L["BloodElfM"] = "Blutelf";

	DRF_L["PandarenM"] = "Pandaren";

	-- *** Race List - Feminine
	DRF_L["HumanF"] = "Mensch";
	DRF_L["DwarfF"] = "Zwerg";
	DRF_L["NightElfF"] = "Nachtelfe";
	DRF_L["GnomeF"] = "Gnom";
	DRF_L["DraeneiF"] = "Draenei";
	DRF_L["WorgenF"] = "Worgen";

	DRF_L["OrcF"] = "Orc";
	DRF_L["UndeadF"] = "Untote";
	DRF_L["TaurenF"] = "Tauren";
	DRF_L["TrollF"] = "Troll";
	DRF_L["GoblinF"] = "Goblin";
	DRF_L["BloodElfF"] = "Blutelfe";

	DRF_L["PandarenF"] = "Pandaren";

	-- *** Item Slots
	DRF_L["Head"] = "Kopf";
	DRF_L["Shoulder"] = "Schulter";
	DRF_L["Back"] = "Rücken";
	DRF_L["Chest"] = "Brust";
	DRF_L["Shirt"] = "Hemd";
	DRF_L["Tabard"] = "Wappenrock";
	DRF_L["Wrist"] = "Handgelenk";
	DRF_L["Hands"] = "Hände";
	DRF_L["Waist"] = "Taille";
	DRF_L["Legs"] = "Beine";
	DRF_L["Feet"] = "Füße";
	DRF_L["MainHand"] = "Waffenhand";
	DRF_L["OffHand"] = "Schildhand";

	-- *** System Messages
	DRF_L["BadUpdate"] = "Sie haben das Addon nicht korrekt Aktualisiert. Bitte starten sie das Spiel neu - DressingRoomFuntions wird nicht richtig funktionieren bevor sie das tun";
	DRF_L["S_DRF"] = "|cffffff90DRF:|r ";
	DRF_L["S_Enabled"] = "|cff00ff00Aktiviert|r";
	DRF_L["S_Disabled"] = "|cffff0000Ausgeschalten|r";
	DRF_L["S_Cancel"] = "Abgebrochene Optionen ändern";
	DRF_L["S_Help"] = "/drf help - Zeigt die Hilfe";
	DRF_L["S_Help1"] = "/drf "..DRF.alias.s1.." [on/off] - "..DRF.text.s1;
	DRF_L["S_Help2"] = "/drf "..DRF.alias.s2.." [on/off] - "..DRF.text.s2;
	DRF_L["S_Help3"] = "/drf "..DRF.alias.s3.." [on/off] - "..DRF.text.s3;
	DRF_L["S_Help4"] = "/drf "..DRF.alias.s4.." [on/off] - "..DRF.text.s4;
	DRF_L["S_OptionsFrame"] = "Öffne Optionen Menu ";
	DRF_L["S_BadCommand"] = "Unbekannter Befehl. Gebe /drf help ein für eine Liste von Optionen.";

	--DRF_L["O_Panel"] = "DressingRoomFuntions";
	DRF_L["O_DRF"] = "DressingRoomFuntions "..DRF_Version.." von Allikitten";
end


-- *** [[[ FRENCH ]]] ***
if ( DRF_Locale == "frFR" ) then
	-- *** Words
	DRF_L["Undress"] = "Se Déshabiller";
	DRF_L["Target"] = "Cible";
	DRF_L["Male"] = "Homme";
	DRF_L["Female"] = "Femme";
	DRF_L["Background"] = "Toile de Fond";
	DRF_L["Remove"] = "Retirer L'Équipement";
	DRF_L["Options"] = "Options de";
	DRF_L["None"] = "Aucun";
	DRF_L["Links"] = "Point Liens"; -- New for Legion Pre-Patch

	-- *** Menu Options - these use special punctuation
	DRF_L["ButtonMore"] = "...";
	DRF_L["M_Gender"] = "- Sexe -";
	DRF_L["M_Other"] = "- Autre -";
	DRF_L["M_Unequip"] = "- Déséquipement -";
	DRF_L["M_Configure"] = "- Configurez -";
	DRF_L["M_Alliance"] = "- Alliance -";
	DRF_L["M_Horde"] = "- Horde -";
	DRF_L["M_Neutral"] = "- Neutre -";
	DRF_L["M_Dump"] = "- Listes -";

	DRF_L["C_Help"] = "help";

	-- *** Config Options
	DRF.alias.s1 = "AutoDeshab";
	DRF.alias.s2 = "Conservateur";
	DRF.alias.s3 = "DeshabCible";
	DRF.change.s1 = "Automatiquement Déshabillez ";
	DRF.change.s2 = "Déshabillez conservateur ";
	DRF.change.s3 = "Déshabillez cible ";
	DRF.text.s1 = "Me déshabiller quand mon dressing est ouvert";
	DRF.text.s2 = "Utilisez tenue conservatrice pour se déshabiller au lieu de maillot de bain";
	DRF.text.s3 = "Cible se déshabiller quand je passe objectifs de dressing";

	-- *** Race List - Masculine
	DRF_L["HumanM"] = "Humain";
	DRF_L["DwarfM"] = "Nain";
	DRF_L["NightElfM"] = "Elfe de la nuit";
	DRF_L["GnomeM"] = "Gnome";
	DRF_L["DraeneiM"] = "Draeneï";
	DRF_L["WorgenM"] = "Worgen";

	DRF_L["OrcM"] = "Orc";
	DRF_L["UndeadM"] = "Mort-vivant";
	DRF_L["TaurenM"] = "Tauren";
	DRF_L["TrollM"] = "Troll";
	DRF_L["GoblinM"] = "Gobelin";
	DRF_L["BloodElfM"] = "Elfe de sang";

	DRF_L["PandarenM"] = "Pandaren";

	-- *** Race List - Feminine
	DRF_L["HumanF"] = "Humaine";
	DRF_L["DwarfF"] = "Naine";
	DRF_L["NightElfF"] = "Elfe de la nuit";
	DRF_L["GnomeF"] = "Gnome";
	DRF_L["DraeneiF"] = "Draeneï";
	DRF_L["WorgenF"] = "Worgen";

	DRF_L["OrcF"] = "Orque";
	DRF_L["UndeadF"] = "Morte-vivante";
	DRF_L["TaurenF"] = "Taurène";
	DRF_L["TrollF"] = "Trollesse";
	DRF_L["GoblinF"] = "Gobeline";
	DRF_L["BloodElfF"] = "Elfe de sang";

	DRF_L["PandarenF"] = "Pandarène";

	-- *** Item Slots
	DRF_L["Head"] = "Tête";
	DRF_L["Shoulder"] = "Épaules";
	DRF_L["Back"] = "Dos";
	DRF_L["Chest"] = "Torse";
	DRF_L["Shirt"] = "Chemise";
	DRF_L["Tabard"] = "Tabard";
	DRF_L["Wrist"] = "Poignets";
	DRF_L["Hands"] = "Mains";
	DRF_L["Waist"] = "Taille";
	DRF_L["Legs"] = "Jambes";
	DRF_L["Feet"] = "Pieds";
	DRF_L["MainHand"] = "Main droite";
	DRF_L["OffHand"] = "Main gauche";

	-- *** System Messages
	DRF_L["BadUpdate"] = "Vous n'avez pas mis à jour correctement vos addons. S'il vous plaît redémarrer le jeu - Dressing Fonctions de la chambre ne fonctionnera pas jusqu'à ce que vous faites. ";
	DRF_L["S_DRF"] = "|cffffff90DRF:|r ";
	DRF_L["S_Enabled"] = "|cff00ff00permis|r";
	DRF_L["S_Disabled"] = "|cffff0000handicapés|r";
	DRF_L["S_Cancel"] = "Des options annulées changement";
	DRF_L["S_Help"] = "/drf help - Affiche cette aide";
	DRF_L["S_Help1"] = "/drf "..DRF.alias.s1.." [on/off] - "..DRF.text.s1;
	DRF_L["S_Help2"] = "/drf "..DRF.alias.s2.." [on/off] - "..DRF.text.s2;
	DRF_L["S_Help3"] = "/drf "..DRF.alias.s3.." [on/off] - "..DRF.text.s3;
	DRF_L["S_Help4"] = "/drf "..DRF.alias.s4.." [on/off] - "..DRF.text.s4;
	DRF_L["S_OptionsFrame"] = "Ouvrant le Panneau de configuration.";
	DRF_L["S_BadCommand"] = "Commande non reconnue. Tapez /drf help pour une liste d'options.";

	--DRF_L["O_Panel"] = "Fonctions Dressing Room";
	DRF_L["O_DRF"] = "Fonctions Dressing Room "..DRF_Version.." par Allikitten - Traduit par Google";
end


-- *** [[[ PORTUGESE ]]] ***
if ( DRF_Locale == "ptPT" or DRF_Locale == "ptBR" ) then
	-- *** Words
	DRF_L["Undress"] = "Despir";
	DRF_L["Target"] = "Alvo";
	DRF_L["Male"] = "Masculino";
	DRF_L["Female"] = "Femenino";
	DRF_L["Background"] = "Contexto";
	DRF_L["Remove"] = "Remover";
	DRF_L["Options"] = "Opções";
	DRF_L["None"] = "Nenhum";
	DRF_L["Links"] = "Ligações de itens"; -- New for Legion Pre-Patch

	-- *** Menu Options - these use special punctuation
	DRF_L["ButtonMore"] = "...";
	DRF_L["M_Gender"] = "- Sexo -";
	DRF_L["M_Other"] = "- Outro -";
	DRF_L["M_Unequip"] = "- Desquipar -";
	DRF_L["M_Configure"] = "- Configurar -";
	DRF_L["M_Alliance"] = "- Aliança -";
	DRF_L["M_Horde"] = "- Horda -";
	DRF_L["M_Neutral"] = "- Neutro -";
	DRF_L["M_Dump"] = "- Listas -";

	DRF_L["C_Help"] = "help";

	-- *** Config Options
	DRF.alias.s1 = "AutoDespir";
	DRF.alias.s2 = "Conservador";
	DRF.alias.s3 = "DespirAlvo";
	DRF.change.s1 = "Automaticamente Despir ";
	DRF.change.s2 = "Despir Conservador ";
	DRF.change.s3 = "Despir-Alvo ";
	DRF.text.s1 = "Desnudar a mí mismo al abrir mi camerino";
	DRF.text.s2 = "Utilice traje conservador para desnudarse en lugar de traje de baño";
	DRF.text.s3 = "Desvestirse Objetivo cuando pongo metas vestidor";

	-- *** Race List - Masculine
	DRF_L["HumanM"] = "Humano";
	DRF_L["DwarfM"] = "Anão";
	DRF_L["NightElfM"] = "Elfo Noturno";
	DRF_L["GnomeM"] = "Gnomo";
	DRF_L["DraeneiM"] = "Draenei";
	DRF_L["WorgenM"] = "Worgen";

	DRF_L["OrcM"] = "Orc";
	DRF_L["UndeadM"] = "Morto-vivo";
	DRF_L["TaurenM"] = "Tauren";
	DRF_L["TrollM"] = "Troll";
	DRF_L["GoblinM"] = "Goblin";
	DRF_L["BloodElfM"] = "Elfo Sangrento";

	DRF_L["PandarenM"] = "Pandaren";

	-- *** Race List - Feminine
	DRF_L["HumanF"] = "Humana";
	DRF_L["DwarfF"] = "Anã";
	DRF_L["NightElfF"] = "Elfa Noturna";
	DRF_L["GnomeF"] = "Gnomida";
	DRF_L["DraeneiF"] = "Draeneia";
	DRF_L["WorgenF"] = "Worgenin";

	DRF_L["OrcF"] = "Orquisa";
	DRF_L["UndeadF"] = "Morta-viva";
	DRF_L["TaurenF"] = "Taurena";
	DRF_L["TrollF"] = "Trolesa";
	DRF_L["GoblinF"] = "Goblina";
	DRF_L["BloodElfF"] = "Elfa Sangrenta";

	DRF_L["PandarenF"] = "Pandarena";

	-- *** Item Slots
	DRF_L["Head"] = "Cabeça";
	DRF_L["Shoulder"] = "Ombros";
	DRF_L["Back"] = "Costas";
	DRF_L["Chest"] = "Torso";
	DRF_L["Shirt"] = "Camisa";
	DRF_L["Tabard"] = "Tabardo";
	DRF_L["Wrist"] = "Pulsos";
	DRF_L["Hands"] = "Mãos";
	DRF_L["Waist"] = "Cintura";
	DRF_L["Legs"] = "Pernas";
	DRF_L["Feet"] = "Pés";
	DRF_L["MainHand"] = "Mão principal";
	DRF_L["OffHand"] = "Mão secundária";

	-- *** System Messages
	DRF_L["BadUpdate"] = "Você não atualizado corretamente seus addons. Por favor, reinicie o jogo - Vestir Funções do quarto não funcionará até que você faz.";
	DRF_L["S_DRF"] = "|cffffff90DRF:|r ";
	DRF_L["S_Enabled"] = "|cff00ff00ativado|r";
	DRF_L["S_Disabled"] = "|cffff0000inválido|r";
	DRF_L["S_Cancel"] = "Cancelado mudança opções";
	DRF_L["S_Help"] = "/drf help - Mostra esta ajuda";
	DRF_L["S_Help1"] = "/drf "..DRF.alias.s1.." [on/off] - "..DRF.text.s1;
	DRF_L["S_Help2"] = "/drf "..DRF.alias.s2.." [on/off] - "..DRF.text.s2;
	DRF_L["S_Help3"] = "/drf "..DRF.alias.s3.." [on/off] - "..DRF.text.s3;
	DRF_L["S_Help4"] = "/drf "..DRF.alias.s4.." [on/off] - "..DRF.text.s4;
	DRF_L["S_OptionsFrame"] = "Abertura Painel de Configuração.";
	DRF_L["S_BadCommand"] = "Comando não reconhecido. Digite /drf help para uma lista de opções.";

	--DRF_L["O_Panel"] = "Funções Sala de Vestir";
	DRF_L["O_DRF"] = "Funções Sala de Vestir "..DRF_Version.." por Allikitten - Traduzido pelo Google";	
end


BINDING_NAME_DRF = DRF_L["O_Panel"];
BINDING_NAME_OPENDRESSINGROOM = DRESSUP_FRAME;
BINDING_NAME_OPENDRFOPTIONS = INTERFACE_OPTIONS;

-- Why undead are labeled internally as scourge? - just a hack to correct this for some parts of the addon
DRF_L["ScourgeM"] = DRF_L["UndeadM"]
DRF_L["ScourgeF"] = DRF_L["UndeadF"]
