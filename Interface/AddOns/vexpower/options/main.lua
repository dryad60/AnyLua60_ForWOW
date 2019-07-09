function vexpower.options.main.panel()
	return {
		type = "group",
		args = {
			title={name="|CFFFF7D0AVersion: |r"..GetAddOnMetadata("vexpower", "Version").."\n", type="description", order=1, fontSize="large"},
			author={name="|CFFFF7D0AAuthor: |rVexar Aegwynn-EU\n", type="description", order=2, fontSize="large"},
			slashcmds={name="\nSlash Cmds:\n/vexpower\n/vexp\n", type="description", order=3, fontSize="large"},
			-- space={name="\n\n", type="description", order=4, fontSize="large"},
			
			activate = {
				name = "Enable Addon",
				order=5, type = "toggle", width="double",
				set = function(self,key) vexpower_SV_profiles[vexpower_SV_data["profile"]]["data"]["show"]["enableAddon"]=key vexpower.initialize.core(true) end,
				get = function() return vexpower_SV_profiles[vexpower_SV_data["profile"]]["data"]["show"]["enableAddon"] end,
				},
			defaults = {
				name = "Reset to defaults",
				order=6, type = "execute",
				func = function(info,val) vexpower.initialize.loadSV(true) end,
				},
			
			support_space ={name="\n", type="description", order=100},
			support_info =	{type="description", order=101, fontSize="medium", name="The ComboPoints currently support the following classes and specs:"},
			supportdk =		{type="description", order=110, fontSize="medium", name="  |CFF"..vexpower.data.lib.getColor.classHex("DEATHKNIGHT").."Death Knight|r: outsourced to '|CFFFF7D0AVex Runes|r'"},
			supportdh =		{type="description", order=120, fontSize="medium", name="  |CFF"..vexpower.data.lib.getColor.classHex("DEMONHUNTER").."Demon Hunter (Vengeance)|r: Soul Fragments"},
			supportdruid =	{type="description", order=130, fontSize="medium", name="  |CFF"..vexpower.data.lib.getColor.classHex("DRUID").."Druid (Cat-Form)|r: ComboPoints"},
			-- supporthunter ={type="description", order=140, fontSize="medium", name="  |CFF"..vexpower.data.lib.getColor.classHex("HUNTER").."Hunter|r (Beast Master): 'Frenzy'-Stacks"},
			supportmage =	{type="description", order=150, fontSize="medium", name="  |CFF"..vexpower.data.lib.getColor.classHex("MAGE").."Mage (Arcane)|r: Arcane Charges"},
			supportmonk2 =	{type="description", order=160, fontSize="medium", name="  |CFF"..vexpower.data.lib.getColor.classHex("MONK").."Monk (Brewmaster)|r: Healing Spheres"},
			supportmonk =	{type="description", order=161, fontSize="medium", name="  |CFF"..vexpower.data.lib.getColor.classHex("MONK").."Monk (Windwalker)|r: Chi"},
			supportpala =	{type="description", order=170, fontSize="medium", name="  |CFF"..vexpower.data.lib.getColor.classHex("PALADIN").."Paladin (Retribution)|r: Holy Power"},
			-- supportpriest =	{type="description", order=180, fontSize="medium", name="  |CFF"..vexpower.data.lib.getColor.classHex("PRIEST").."Priest|r (Shadow): Shows mana"},
			supportrogue =	{type="description", order=190, fontSize="medium", name="  |CFF"..vexpower.data.lib.getColor.classHex("ROGUE").."Rogue|r: ComboPoints"},
			-- supportshaman ={type="description", order=200, fontSize="medium", name="  |CFF"..vexpower.data.lib.getColor.classHex("SHAMAN").."Shaman|r (Enhancer): Mana"},
			supportshaman ={type="description", order=200, fontSize="medium", name="  |CFF"..vexpower.data.lib.getColor.classHex("SHAMAN").."Shaman|r (Enhancer): 'Stormstrike'-Charges"},
			-- supportshaman ={type="description", order=200, fontSize="medium", name="  |CFF"..vexpower.data.lib.getColor.classHex("SHAMAN").."Shaman|r (Elemental): Mana"},
			supportwl =		{type="description", order=210, fontSize="medium", name="  |CFF"..vexpower.data.lib.getColor.classHex("WARLOCK").."Warlock|r: Soul Shards"},
			supportwarrior ={type="description", order=220, fontSize="medium", name="  |CFF"..vexpower.data.lib.getColor.classHex("WARRIOR").."Warrior|r (Protection): 'Focused Rage'-Stacks"},
			supportwarrior2 ={type="description", order=221, fontSize="medium", name="  |CFF"..vexpower.data.lib.getColor.classHex("WARRIOR").."Warrior|r (Arms): 'Focused Rage'-Stacks"},
			
			support_APB_info =		{type="description", order=300, fontSize="medium", name="\nThe 2nd powerbar ('alternative powerbar') supports the following classes and specs:"},
			support_APB_shaman1 =	{type="description", order=301, fontSize="medium", name="  |CFF"..vexpower.data.lib.getColor.classHex("SHAMAN").."Shaman (Enhancer)|r: mana"},
			support_APB_shaman2 =	{type="description", order=302, fontSize="medium", name="  |CFF"..vexpower.data.lib.getColor.classHex("SHAMAN").."Shaman (Elemental)|r: mana"},
			support_APB_priest =	{type="description", order=303, fontSize="medium", name="  |CFF"..vexpower.data.lib.getColor.classHex("PRIEST").."Priest (Shadow)|r: mana"},
			
			support_request =	{type="description", order=1000, fontSize="medium", name="\nIf you want anything to be tracked similar to a ComboPoint for a spec that has nothing tracked yet, feel free to contact me at curse or wowinterface"},
			}
		}
end
