function vexpower.options.markers.panel()		
	return {
		type = "group",
		order= 5,
		args = {
			grptestmode = {
				name = "Option Settings",
				order=1, type ="group", dialogInline = true,
				args = {
					testmode = {
						name = "activate Testmode",
						order=1, type = "toggle", width="double",
						set = function(info,val) vexpower.testmode.activated=val vexpower.testmode.handler() end,
						get = function() return vexpower.testmode.activated end,
						},
					advOptions = {
						name = "show advanced Options",
						order=2, type = "toggle", width="normal",
						set = function(info,val) vexpower_SV_profiles[vexpower_SV_data["profile"]]["data"]["advancedOptions"]=val vexpower.initialize.core(true) end,
						get = function() return vexpower_SV_profiles[vexpower_SV_data["profile"]]["data"]["advancedOptions"] end,
						},
					info = {name ="- ComboPoint gain and loss are simulated\n- Textfields get a colored background and are moveable\n- Powerbar and ComboPointBar become movable\n'/vexp testmode' can be used to toggle the testmode", type = "description", order=3, width="double"},
					edit = {name ='\nAny changes will be saved in profile: "|CFF008000'..vexpower_SV_data["profile"]..'|r"', type = "description", order=5, width="normal"},
					},
				},
			spacetestmode = {name ="\n", type = "description", order=3},
			
			grpoptiontabs = {
				name = "Toggle Option Tabs",
				order=5, type ="group", dialogInline = true,
				args = {
					Add = {
						name = "Create",
						order=1, type = "execute", width="half",
						func = function(info,val) vexpower.options.markers.toggleTab("Create") vexpower.initialize.core(true) end,
						},
					Update = {
						name = "Update",
						order=2, type = "execute", width="half",
						func = function(info,val) vexpower.options.markers.toggleTab("Edit") vexpower.initialize.core(true) end,
						},
					Delete = {
						name = "Delete",
						order=3, type = "execute", width="half",
						func = function(info,val) vexpower.options.markers.toggleTab("delete") vexpower.initialize.core(true) end,
						},
					Appearance = {
						name = "Color & Size",
						order=4, type = "execute",
						func = function(info,val) vexpower.options.markers.toggleTab("appearance") vexpower.initialize.core(true) end,
						},
					Information = {
						name = "HELP",
						order=5, type = "execute", width="half",
						func = function(info,val) vexpower.options.markers.toggleTab("information") vexpower.initialize.core(true) end,
						},
					--space = {name =" ", type = "description", order=3, width="half"},
					},
				},
			spaceoptiontabs = {name =" ", type = "description", order=6},
			
			grpex = {
				name = "Information",
				order=10, type = "group", dialogInline = true, hidden = not(vexpower.options.markers.openTab["information"]),
				args = {
					infopic={name = "", type="description", order=1, image="Interface\\AddOns\\vexpower\\images\\options_markers.tga",
						imageWidth=512, imageHeight=64},	
					info1={name = "Examples for markers are in the red circles\n", type="description", order=2,},	
					info2={name = "Markers are marks at absolute or at relative positions on your energybar.", type="description", order=3},	
					info3={name = "'50' will be placed on the energybar that represents exact 50 points of your power (absolute)", type="description", order=4},	
					info4={name = "'50%' will be placed on the energybar that represents 50% of your power (relative)", type="description", order=5},	
					info5={name = "You can create markers that are only shown with specific powertypes and specific specs.", type="description", order=6},
					info6={name = "By adjusting the powertype settings of a marker druids can use markers for specific forms. By setting a marker that is only shown with energy, the marker will only be shown when they are in their cat-form.", type="description", order=7},
					info7={name = "By adjusting the spec settings of a marker a rogue can place a marker for each of their primary attack spells", type="description", order=8},
					},
				},
			
			grpedit = {
				name = function () if vexpower.options.markers.openTab["Edit"] then return "Edit marker" else return "Create marker" end end,
				order=30, type ="group", dialogInline = true, hidden = not(vexpower.options.markers.openTab["Edit"]) and not(vexpower.options.markers.openTab["Create"]),
				args = {
					marker = {
						name = "Select marker",
						order=1, type = "select", style = "dropdown",
						values = vexpower.options.markers.getList(), width="full", hidden = not(vexpower.options.markers.openTab["Edit"]),
						set = function(self,key) vexpower.options.markers.idEdit=vexpower.options.markers.getKeyFromCryptList(key) vexpower.options.markers.load() vexpower.initialize.core(true) end,
						get = function() return vexpower.options.markers.createCryptListKey(vexpower.options.markers.idEdit) end,
						},
					marker_loc = {
						name = "Location",
						desc = "Enter a location where to put the new marker",
						order=2, type = "input", multiline = false, disabled = vexpower.options.markers.openTab["Edit"] and vexpower.options.markers.idEdit==0,
						validate = function (info, val)
							if vexpower.options.markers.check(val) then return true
							else print("ERROR - "..val.." is not a valid position") return false end
							end,
						set = function(info,val) vexpower.options.markers.LocationCreate=val if vexpower.options.markers.openTab["Edit"] then vexpower.options.markers.add(true) end	vexpower.initialize.core(true)	end,
						get = function() return vexpower.options.markers.LocationCreate end,
						},
					marker_name = {
						name = "Name",
						desc = "You can name this marker",
						order=3, type = "input", multiline = false, disabled = vexpower.options.markers.openTab["Edit"] and vexpower.options.markers.idEdit==0, width="double",
						set = function(info,val) vexpower.options.markers.NameCreate=val if vexpower.options.markers.openTab["Edit"] then vexpower.options.markers.add(true) end vexpower.initialize.core(true) end, 
						get = function() return vexpower.options.markers.NameCreate end,
						},
						
					grpsubtabs = {
						name = "Toggle Sub Tabs",
						order=5, type ="group", dialogInline = true,
						args = {
							Specs = {
								name = "Specs",
								order=1, type = "execute", width="half",
								func = function(info,val) vexpower.options.markers.toggleSubTab("specs") vexpower.initialize.core(true) end,
								},
							Classes = {
								name = "Classes",
								order=2, type = "execute", width="half",
								func = function(info,val) vexpower.options.markers.toggleSubTab("classes") vexpower.initialize.core(true) end,
								},
							powertypes = {
								name = "Powertypes",
								order=3, type = "execute",
								func = function(info,val) vexpower.options.markers.toggleSubTab("powertypes") vexpower.initialize.core(true) end,
								},
							talents = {
								name = "Talents",
								order=4, type = "execute", width="half",
								func = function(info,val) vexpower.options.markers.toggleSubTab("talents") vexpower.initialize.core(true) end,
								},
							spell = {
								name = "Spell",
								order=5, type = "execute", width="half",
								func = function(info,val) vexpower.options.markers.toggleSubTab("spells") vexpower.initialize.core(true) end,
								},
							},
						},
					spacesubtabs = {name =" ", type = "description", order=6},
						
						
						
					specs = {
						name = "Visible with the following specs", hidden = not(vexpower.options.markers.openSubTab["specs"]),
						order=10, type ="group", dialogInline = true, disabled = vexpower.options.markers.openTab["Edit"] and vexpower.options.markers.idEdit==0,
						args = {
							spec1 = {
								name = "Spec 1: |CFF"..vexpower.data.lib.getColor.classHex(vexpower.data.classString)..vexpower.options.specProfiles.getSpecName(1).."|r",
								order=1, type = "toggle",
								set = function(self,key) vexpower.options.markers.specsCreate[1] = key if vexpower.options.markers.openTab["Edit"] then vexpower.options.markers.add(true) end vexpower.initialize.core(true) end,
								get = function() return vexpower.options.markers.specsCreate[1] end,
								},
							spec2 = {
								name = "Spec 2: |CFF"..vexpower.data.lib.getColor.classHex(vexpower.data.classString)..vexpower.options.specProfiles.getSpecName(2).."|r",
								order=2, type = "toggle", width="double",
								set = function(self,key) vexpower.options.markers.specsCreate[2] = key if vexpower.options.markers.openTab["Edit"] then vexpower.options.markers.add(true) end vexpower.initialize.core(true) end,
								get = function() return vexpower.options.markers.specsCreate[2] end,
								},
							spec3 = {
								name = "Spec 3: |CFF"..vexpower.data.lib.getColor.classHex(vexpower.data.classString)..vexpower.options.specProfiles.getSpecName(3).."|r",
								order=3, type = "toggle",
								set = function(self,key) vexpower.options.markers.specsCreate[3] = key if vexpower.options.markers.openTab["Edit"] then vexpower.options.markers.add(true) end vexpower.initialize.core(true) end,
								get = function() return vexpower.options.markers.specsCreate[3] end,
								},
							spec4 = {
								name = "Spec 4: |CFF"..vexpower.data.lib.getColor.classHex(vexpower.data.classString)..vexpower.options.specProfiles.getSpecName(4).."|r",
								order=4, type = "toggle", width="double",
								set = function(self,key) vexpower.options.markers.specsCreate[4] = key if vexpower.options.markers.openTab["Edit"] then vexpower.options.markers.add(true) end vexpower.initialize.core(true) end,
								get = function() return vexpower.options.markers.specsCreate[4] end,
								},
							},
						},
					classes = {
						name = "Visible with the following classes", hidden = not(vexpower.options.markers.openSubTab["classes"]),
						order=11, type ="group", dialogInline = true, disabled = vexpower.options.markers.openTab["Edit"] and vexpower.options.markers.idEdit==0,
						args = {
							DEATHKNIGHT = {
								name = "|CFF"..vexpower.data.lib.getColor.classHex("DEATHKNIGHT").."Death Knight|r",
								order=1, type = "toggle",
								set = function(self,key) vexpower.options.markers.classesCreate["DEATHKNIGHT"] = key if vexpower.options.markers.openTab["Edit"] then vexpower.options.markers.add(true) end vexpower.initialize.core(true) end,
								get = function() return vexpower.options.markers.classesCreate["DEATHKNIGHT"] end,
								},
							DEMONHUNTER = {
								name = "|CFF"..vexpower.data.lib.getColor.classHex("DEMONHUNTER").."Demon Hunter|r",
								order=2, type = "toggle",
								set = function(self,key) vexpower.options.markers.classesCreate["DEMONHUNTER"] = key if vexpower.options.markers.openTab["Edit"] then vexpower.options.markers.add(true) end vexpower.initialize.core(true) end,
								get = function() return vexpower.options.markers.classesCreate["DEMONHUNTER"] end,
								},
							DRUID = {
								name = "|CFF"..vexpower.data.lib.getColor.classHex("DRUID").."Druid|r",
								order=3, type = "toggle",
								set = function(self,key) vexpower.options.markers.classesCreate["DRUID"] = key if vexpower.options.markers.openTab["Edit"] then vexpower.options.markers.add(true) end vexpower.initialize.core(true) end,
								get = function() return vexpower.options.markers.classesCreate["DRUID"] end,
								},
							HUNTER = {
								name = "|CFF"..vexpower.data.lib.getColor.classHex("HUNTER").."Hunter|r",
								order=4, type = "toggle",
								set = function(self,key) vexpower.options.markers.classesCreate["HUNTER"] = key if vexpower.options.markers.openTab["Edit"] then vexpower.options.markers.add(true) end vexpower.initialize.core(true) end,
								get = function() return vexpower.options.markers.classesCreate["HUNTER"] end,
								},
							MAGE = {
								name = "|CFF"..vexpower.data.lib.getColor.classHex("MAGE").."Mage|r",
								order=5, type = "toggle",
								set = function(self,key) vexpower.options.markers.classesCreate["MAGE"] = key if vexpower.options.markers.openTab["Edit"] then vexpower.options.markers.add(true) end vexpower.initialize.core(true) end,
								get = function() return vexpower.options.markers.classesCreate["MAGE"] end,
								},
							MONK = {
								name = "|CFF"..vexpower.data.lib.getColor.classHex("MONK").."Monk|r",
								order=6, type = "toggle",
								set = function(self,key) vexpower.options.markers.classesCreate["MONK"] = key if vexpower.options.markers.openTab["Edit"] then vexpower.options.markers.add(true) end vexpower.initialize.core(true) end,
								get = function() return vexpower.options.markers.classesCreate["MONK"] end,
								},
							PALADIN = {
								name = "|CFF"..vexpower.data.lib.getColor.classHex("PALADIN").."Paladin|r",
								order=7, type = "toggle",
								set = function(self,key) vexpower.options.markers.classesCreate["PALADIN"] = key if vexpower.options.markers.openTab["Edit"] then vexpower.options.markers.add(true) end vexpower.initialize.core(true) end,
								get = function() return vexpower.options.markers.classesCreate["PALADIN"] end,
								},
							PRIEST = {
								name = "|CFF"..vexpower.data.lib.getColor.classHex("PRIEST").."Priest|r",
								order=8, type = "toggle",
								set = function(self,key) vexpower.options.markers.classesCreate["PRIEST"] = key if vexpower.options.markers.openTab["Edit"] then vexpower.options.markers.add(true) end vexpower.initialize.core(true) end,
								get = function() return vexpower.options.markers.classesCreate["PRIEST"] end,
								},
							ROGUE = {
								name = "|CFF"..vexpower.data.lib.getColor.classHex("ROGUE").."Rogue|r",
								order=9, type = "toggle",
								set = function(self,key) vexpower.options.markers.classesCreate["ROGUE"] = key if vexpower.options.markers.openTab["Edit"] then vexpower.options.markers.add(true) end vexpower.initialize.core(true) end,
								get = function() return vexpower.options.markers.classesCreate["ROGUE"] end,
								},
							SHAMAN = {
								name = "|CFF"..vexpower.data.lib.getColor.classHex("SHAMAN").."Shaman|r",
								order=10, type = "toggle",
								set = function(self,key) vexpower.options.markers.classesCreate["SHAMAN"] = key if vexpower.options.markers.openTab["Edit"] then vexpower.options.markers.add(true) end vexpower.initialize.core(true) end,
								get = function() return vexpower.options.markers.classesCreate["SHAMAN"] end,
								},
							WARLOCK = {
								name = "|CFF"..vexpower.data.lib.getColor.classHex("WARLOCK").."Warlock|r",
								order=11, type = "toggle",
								set = function(self,key) vexpower.options.markers.classesCreate["WARLOCK"] = key if vexpower.options.markers.openTab["Edit"] then vexpower.options.markers.add(true) end vexpower.initialize.core(true) end,
								get = function() return vexpower.options.markers.classesCreate["WARLOCK"] end,
								},
							WARRIOR = {
								name = "|CFF"..vexpower.data.lib.getColor.classHex("WARRIOR").."Warrior|r",
								order=12, type = "toggle",
								set = function(self,key) vexpower.options.markers.classesCreate["WARRIOR"] = key if vexpower.options.markers.openTab["Edit"] then vexpower.options.markers.add(true) end vexpower.initialize.core(true) end,
								get = function() return vexpower.options.markers.classesCreate["WARRIOR"] end,
								},
							},
						},
					powertypes = {
						name = "Visible with the following powertypes", hidden = not(vexpower.options.markers.openSubTab["powertypes"]),
						order=12, type ="group", dialogInline = true, disabled = vexpower.options.markers.openTab["Edit"] and vexpower.options.markers.idEdit==0,
						args = {
							marker_new_powertype_rage = {
								name = "|CFF"..vexpower.data.lib.getColor.powertypeHex("RAGE").."(R)age|r",
								order=1, type = "toggle",
								set = function(self,key) vexpower.options.markers.powertypesCreate["RAGE"] = key if vexpower.options.markers.openTab["Edit"] then vexpower.options.markers.add(true) end vexpower.initialize.core(true) end,
								get = function() return vexpower.options.markers.powertypesCreate["RAGE"] end,
								},
							marker_new_powertype_mana = {
								name = "|CFF"..vexpower.data.lib.getColor.powertypeHex("MANA").."(M)ana|r",
								order=2, type = "toggle",
								set = function(self,key) vexpower.options.markers.powertypesCreate["MANA"] = key if vexpower.options.markers.openTab["Edit"] then vexpower.options.markers.add(true) end vexpower.initialize.core(true) end,
								get = function() return vexpower.options.markers.powertypesCreate["MANA"] end,
								},
							marker_new_powertype_focus = {
								name = "|CFF"..vexpower.data.lib.getColor.powertypeHex("FOCUS").."(F)ocus|r",
								order=3, type = "toggle",
								set = function(self,key) vexpower.options.markers.powertypesCreate["FOCUS"] = key if vexpower.options.markers.openTab["Edit"] then vexpower.options.markers.add(true) end vexpower.initialize.core(true) end,
								get = function() return vexpower.options.markers.powertypesCreate["FOCUS"] end,
								},
							marker_new_powertype_energy = {
								name = "|CFF"..vexpower.data.lib.getColor.powertypeHex("ENERGY").."(E)nergy|r",
								order=11, type = "toggle",
								set = function(self,key) vexpower.options.markers.powertypesCreate["ENERGY"] = key if vexpower.options.markers.openTab["Edit"] then vexpower.options.markers.add(true) end vexpower.initialize.core(true) end,
								get = function() return vexpower.options.markers.powertypesCreate["ENERGY"] end,
								},
							marker_new_powertype_rp = {
								name = "|CFF"..vexpower.data.lib.getColor.powertypeHex("RUNIC_POWER").."(R)unic (P)ower|r",
								order=12, type = "toggle",
								set = function(self,key) vexpower.options.markers.powertypesCreate["RUNIC_POWER"] = key if vexpower.options.markers.openTab["Edit"] then vexpower.options.markers.add(true) end vexpower.initialize.core(true) end,
								get = function() return vexpower.options.markers.powertypesCreate["RUNIC_POWER"] end,
								},
							marker_new_powertype_p = {
								name = "|CFF"..vexpower.data.lib.getColor.powertypeHex("PAIN").."(Pa)in",
								order=13, type = "toggle",
								set = function(self,key) vexpower.options.markers.powertypesCreate["PAIN"] = key if vexpower.options.markers.openTab["Edit"] then vexpower.options.markers.add(true) end vexpower.initialize.core(true) end,
								get = function() return vexpower.options.markers.powertypesCreate["PAIN"] end,
								},
							marker_new_powertype_fu = {
								name = "|CFF"..vexpower.data.lib.getColor.powertypeHex("FURY").."(Fu)ry",
								order=14, type = "toggle",
								set = function(self,key) vexpower.options.markers.powertypesCreate["FURY"] = key if vexpower.options.markers.openTab["Edit"] then vexpower.options.markers.add(true) end vexpower.initialize.core(true) end,
								get = function() return vexpower.options.markers.powertypesCreate["FURY"] end,
								},
							marker_new_powertype_i = {
								name = "|CFF"..vexpower.data.lib.getColor.powertypeHex("INSANITY").."(I)nsanity",
								order=15, type = "toggle",
								set = function(self,key) vexpower.options.markers.powertypesCreate["INSANITY"] = key if vexpower.options.markers.openTab["Edit"] then vexpower.options.markers.add(true) end vexpower.initialize.core(true) end,
								get = function() return vexpower.options.markers.powertypesCreate["INSANITY"] end,
								},
							marker_new_powertype_m = {
								name = "|CFF"..vexpower.data.lib.getColor.powertypeHex("MAELSTROM").."(M)aelstrom",
								order=16, type = "toggle",
								set = function(self,key) vexpower.options.markers.powertypesCreate["MAELSTROM"] = key if vexpower.options.markers.openTab["Edit"] then vexpower.options.markers.add(true) end vexpower.initialize.core(true) end,
								get = function() return vexpower.options.markers.powertypesCreate["MAELSTROM"] end,
								},
							marker_new_powertype_lp = {
								name = "|CFF"..vexpower.data.lib.getColor.powertypeHex("LUNAR_POWER").."(L)unar (P)ower",
								order=17, type = "toggle",
								set = function(self,key) vexpower.options.markers.powertypesCreate["LUNAR_POWER"] = key if vexpower.options.markers.openTab["Edit"] then vexpower.options.markers.add(true) end vexpower.initialize.core(true) end,
								get = function() return vexpower.options.markers.powertypesCreate["LUNAR_POWER"] end,
								},
							},
						},
					talents = {
						name = "Visible with the following talents", hidden = not(vexpower.options.markers.openSubTab["talents"]),
						order=13, type ="group", dialogInline = true, disabled = vexpower.options.markers.openTab["Edit"] and vexpower.options.markers.idEdit==0,
						args = {
							talent_11 = {
								name = "1/1 ("..vexpower.options.markers.getTalentName(1,1)..")",
								order=11, type = "toggle",
								set = function(self,key) vexpower.options.markers.talentsCreate[1][1] = key if vexpower.options.markers.openTab["Edit"] then vexpower.options.markers.add(true) end vexpower.initialize.core(true) end,
								get = function() return vexpower.options.markers.talentsCreate[1][1] end,
								},
							talent_12 = {
								name = "1/2 ("..vexpower.options.markers.getTalentName(1,2)..")",
								order=12, type = "toggle",
								set = function(self,key) vexpower.options.markers.talentsCreate[1][2] = key if vexpower.options.markers.openTab["Edit"] then vexpower.options.markers.add(true) end vexpower.initialize.core(true) end,
								get = function() return vexpower.options.markers.talentsCreate[1][2] end,
								},
							talent_13 = {
								name = "1/3 ("..vexpower.options.markers.getTalentName(1,3)..")",
								order=13, type = "toggle",
								set = function(self,key) vexpower.options.markers.talentsCreate[1][3] = key if vexpower.options.markers.openTab["Edit"] then vexpower.options.markers.add(true) end vexpower.initialize.core(true) end,
								get = function() return vexpower.options.markers.talentsCreate[1][3] end,
								},
							talent_21 = {
								name = "2/1 ("..vexpower.options.markers.getTalentName(2,1)..")",
								order=21, type = "toggle",
								set = function(self,key) vexpower.options.markers.talentsCreate[2][1] = key if vexpower.options.markers.openTab["Edit"] then vexpower.options.markers.add(true) end vexpower.initialize.core(true) end,
								get = function() return vexpower.options.markers.talentsCreate[2][1] end,
								},
							talent_22 = {
								name = "2/2 ("..vexpower.options.markers.getTalentName(2,2)..")",
								order=22, type = "toggle",
								set = function(self,key) vexpower.options.markers.talentsCreate[2][2] = key if vexpower.options.markers.openTab["Edit"] then vexpower.options.markers.add(true) end vexpower.initialize.core(true) end,
								get = function() return vexpower.options.markers.talentsCreate[2][2] end,
								},
							talent_23 = {
								name = "2/3 ("..vexpower.options.markers.getTalentName(2,3)..")",
								order=23, type = "toggle",
								set = function(self,key) vexpower.options.markers.talentsCreate[2][3] = key if vexpower.options.markers.openTab["Edit"] then vexpower.options.markers.add(true) end vexpower.initialize.core(true) end,
								get = function() return vexpower.options.markers.talentsCreate[2][3] end,
								},
							talent_31 = {
								name = "3/1 ("..vexpower.options.markers.getTalentName(3,1)..")",
								order=31, type = "toggle",
								set = function(self,key) vexpower.options.markers.talentsCreate[3][1] = key if vexpower.options.markers.openTab["Edit"] then vexpower.options.markers.add(true) end vexpower.initialize.core(true) end,
								get = function() return vexpower.options.markers.talentsCreate[3][1] end,
								},
							talent_32 = {
								name = "3/2 ("..vexpower.options.markers.getTalentName(3,2)..")",
								order=32, type = "toggle",
								set = function(self,key) vexpower.options.markers.talentsCreate[3][2] = key if vexpower.options.markers.openTab["Edit"] then vexpower.options.markers.add(true) end vexpower.initialize.core(true) end,
								get = function() return vexpower.options.markers.talentsCreate[3][2] end,
								},
							talent_33 = {
								name = "3/3 ("..vexpower.options.markers.getTalentName(3,3)..")",
								order=33, type = "toggle",
								set = function(self,key) vexpower.options.markers.talentsCreate[3][3] = key if vexpower.options.markers.openTab["Edit"] then vexpower.options.markers.add(true) end vexpower.initialize.core(true) end,
								get = function() return vexpower.options.markers.talentsCreate[3][3] end,
								},
							talent_41 = {
								name = "4/1 ("..vexpower.options.markers.getTalentName(4,1)..")",
								order=41, type = "toggle",
								set = function(self,key) vexpower.options.markers.talentsCreate[4][1] = key if vexpower.options.markers.openTab["Edit"] then vexpower.options.markers.add(true) end vexpower.initialize.core(true) end,
								get = function() return vexpower.options.markers.talentsCreate[4][1] end,
								},
							talent_42 = {
								name = "4/2 ("..vexpower.options.markers.getTalentName(4,2)..")",
								order=42, type = "toggle",
								set = function(self,key) vexpower.options.markers.talentsCreate[4][2] = key if vexpower.options.markers.openTab["Edit"] then vexpower.options.markers.add(true) end vexpower.initialize.core(true) end,
								get = function() return vexpower.options.markers.talentsCreate[4][2] end,
								},
							talent_43 = {
								name = "4/3 ("..vexpower.options.markers.getTalentName(4,3)..")",
								order=43, type = "toggle",
								set = function(self,key) vexpower.options.markers.talentsCreate[4][3] = key if vexpower.options.markers.openTab["Edit"] then vexpower.options.markers.add(true) end vexpower.initialize.core(true) end,
								get = function() return vexpower.options.markers.talentsCreate[4][3] end,
								},
							talent_51 = {
								name = "5/1 ("..vexpower.options.markers.getTalentName(5,1)..")",
								order=51, type = "toggle",
								set = function(self,key) vexpower.options.markers.talentsCreate[5][1] = key if vexpower.options.markers.openTab["Edit"] then vexpower.options.markers.add(true) end vexpower.initialize.core(true) end,
								get = function() return vexpower.options.markers.talentsCreate[5][1] end,
								},
							talent_52 = {
								name = "5/2 ("..vexpower.options.markers.getTalentName(5,2)..")",
								order=52, type = "toggle",
								set = function(self,key) vexpower.options.markers.talentsCreate[5][2] = key if vexpower.options.markers.openTab["Edit"] then vexpower.options.markers.add(true) end vexpower.initialize.core(true) end,
								get = function() return vexpower.options.markers.talentsCreate[5][2] end,
								},
							talent_53 = {
								name = "5/3 ("..vexpower.options.markers.getTalentName(5,3)..")",
								order=53, type = "toggle",
								set = function(self,key) vexpower.options.markers.talentsCreate[5][3] = key if vexpower.options.markers.openTab["Edit"] then vexpower.options.markers.add(true) end vexpower.initialize.core(true) end,
								get = function() return vexpower.options.markers.talentsCreate[5][3] end,
								},
							talent_61 = {
								name = "6/1 ("..vexpower.options.markers.getTalentName(6,1)..")",
								order=61, type = "toggle",
								set = function(self,key) vexpower.options.markers.talentsCreate[6][1] = key if vexpower.options.markers.openTab["Edit"] then vexpower.options.markers.add(true) end vexpower.initialize.core(true) end,
								get = function() return vexpower.options.markers.talentsCreate[6][1] end,
								},
							talent_62 = {
								name = "6/2 ("..vexpower.options.markers.getTalentName(6,2)..")",
								order=62, type = "toggle",
								set = function(self,key) vexpower.options.markers.talentsCreate[6][2] = key if vexpower.options.markers.openTab["Edit"] then vexpower.options.markers.add(true) end vexpower.initialize.core(true) end,
								get = function() return vexpower.options.markers.talentsCreate[6][2] end,
								},
							talent_63 = {
								name = "6/3 ("..vexpower.options.markers.getTalentName(6,3)..")",
								order=63, type = "toggle",
								set = function(self,key) vexpower.options.markers.talentsCreate[6][3] = key if vexpower.options.markers.openTab["Edit"] then vexpower.options.markers.add(true) end vexpower.initialize.core(true) end,
								get = function() return vexpower.options.markers.talentsCreate[6][3] end,
								},
							talent_71 = {
								name = "7/1 ("..vexpower.options.markers.getTalentName(7,1)..")",
								order=71, type = "toggle",
								set = function(self,key) vexpower.options.markers.talentsCreate[7][1] = key if vexpower.options.markers.openTab["Edit"] then vexpower.options.markers.add(true) end vexpower.initialize.core(true) end,
								get = function() return vexpower.options.markers.talentsCreate[7][1] end,
								},
							talent_72 = {
								name = "7/2 ("..vexpower.options.markers.getTalentName(7,2)..")",
								order=72, type = "toggle",
								set = function(self,key) vexpower.options.markers.talentsCreate[7][2] = key if vexpower.options.markers.openTab["Edit"] then vexpower.options.markers.add(true) end vexpower.initialize.core(true) end,
								get = function() return vexpower.options.markers.talentsCreate[7][2] end,
								},
							talent_73 = {
								name = "7/3 ("..vexpower.options.markers.getTalentName(7,3)..")",
								order=73, type = "toggle",
								set = function(self,key) vexpower.options.markers.talentsCreate[7][3] = key if vexpower.options.markers.openTab["Edit"] then vexpower.options.markers.add(true) end vexpower.initialize.core(true) end,
								get = function() return vexpower.options.markers.talentsCreate[7][3] end,
								},	
							},
						},
					spells = {
						name = "Visible with the following spells active", hidden = not(vexpower.options.markers.openSubTab["spells"]),
						order=13, type ="group", dialogInline = true, disabled = vexpower.options.markers.openTab["Edit"] and vexpower.options.markers.idEdit==0,
						args = {
							active = {
								name = "A specific spell has to be active to show the marker",
								order=1, type = "toggle", width="full",
								set = function(self,key) vexpower.options.markers.spellCreate["active"] = key if vexpower.options.markers.openTab["Edit"] then vexpower.options.markers.add(true) end vexpower.initialize.core(true) end,
								get = function() return vexpower.options.markers.spellCreate["active"] end,
								},
							Spelltype = {
								name = "Spelltype",
								order=2, type = "select", style = "dropdown", disabled = not(vexpower.options.markers.spellCreate["active"]),
								values = {["buff"] = "Buff", ["debuff"] = "Debuff",},
								set = function(self,key) vexpower.options.markers.spellCreate["spelltype"] = key if vexpower.options.markers.openTab["Edit"] then vexpower.options.markers.add(true) end vexpower.options.markers.load() vexpower.initialize.core(true) end,
								get = function() return vexpower.options.markers.spellCreate["spelltype"] end,
								},
							Spellidentify = {
								name = "How to identify the spell",
								order=3, type = "select", style = "dropdown", disabled = not(vexpower.options.markers.spellCreate["active"]),
								values = {["name"] = "By Spellname", ["id"] = "By Spell-ID",},
								set = function(self,key) vexpower.options.markers.spellCreateIdentify = key vexpower.initialize.core(true) end,
								get = function() return vexpower.options.markers.spellCreateIdentify end,
								},
							Spellname = {
								name = "Spellname",
								desc = "Enter a name of the spell", disabled = not(vexpower.options.markers.spellCreate["active"]),
								order=4, type = "input", multiline = false, hidden = vexpower.options.markers.spellCreateIdentify=="id",
								set = function(info,val) vexpower.options.markers.spellCreate["identifier"]["name"]=val vexpower.options.markers.spellCreate["identifier"]["id"]="" if vexpower.options.markers.openTab["Edit"] then vexpower.options.markers.add(true) end	vexpower.initialize.core(true)	end,
								get = function() return vexpower.options.markers.spellCreate["identifier"]["name"] end,
								},
							Spellid = {
								name = "Spell-ID",
								desc = "Enter a name of the spell", disabled = not(vexpower.options.markers.spellCreate["active"]),
								order=5, type = "input", multiline = false, hidden = vexpower.options.markers.spellCreateIdentify=="name",
								set = function(info,val) vexpower.options.markers.spellCreate["identifier"]["id"]=val vexpower.options.markers.spellCreate["identifier"]["name"]="" if vexpower.options.markers.openTab["Edit"] then vexpower.options.markers.add(true) end	vexpower.initialize.core(true)	end,
								get = function() return vexpower.options.markers.spellCreate["identifier"]["id"] end,
								},
							stackActivate = {
								name = "Only activate with a specific number of stacks",
								order=6, type = "toggle", width="full", disabled = not(vexpower.options.markers.spellCreate["active"]),
								set = function(self,key) vexpower.options.markers.spellCreate["stackControl"]["active"] = key if vexpower.options.markers.openTab["Edit"] then vexpower.options.markers.add(true) end vexpower.initialize.core(true) end,
								get = function() return vexpower.options.markers.spellCreate["stackControl"]["active"] end,
								},
							Arithmetic = {
								name = "Arithmetic",
								order=7, type = "select", style = "dropdown", width="half",
								values = vexpower.options.markers.spellArithmeticDecode, disabled = (not(vexpower.options.markers.spellCreate["stackControl"]["active"]) or not(vexpower.options.markers.spellCreate["active"])),
								set = function(self,key) vexpower.options.markers.spellCreate["stackControl"]["arithmetic"]=vexpower.options.markers.spellArithmeticDecode[key] if vexpower.options.markers.openTab["Edit"] then vexpower.options.markers.add(true) end	vexpower.initialize.core(true) end,
								get = function() return vexpower.options.markers.spellArithmeticCode[vexpower.options.markers.spellCreate["stackControl"]["arithmetic"]] end,
								},
							Stacks = {
								name = "Stacks",
								validate = function (info, val)
									if string.gsub(val, "%d*", "") == "" then return true
									else return false end
									end,
								order=8, type = "input", multiline = false, disabled = (not(vexpower.options.markers.spellCreate["stackControl"]["active"]) or not(vexpower.options.markers.spellCreate["active"])),
								set = function(info,val) vexpower.options.markers.spellCreate["stackControl"]["stacks"]=val if vexpower.options.markers.openTab["Edit"] then vexpower.options.markers.add(true) end	vexpower.initialize.core(true) end,
								get = function() return vexpower.options.markers.spellCreate["stackControl"]["stacks"] end,
								},
							},
						},
						
					marker_new_add = {
						name = "create",
						order=20, type = "execute", hidden = not(vexpower.options.markers.openTab["Create"]),
						func = function(info,val) vexpower.options.markers.add() vexpower.initialize.core(true) end,
						},
					marker_new_info = {name = vexpower.options.markers.statusMsgCreated, type = "description", order=21, hidden = not(vexpower.options.markers.openTab["Create"]),},
					},
				},
			
			grpdelete = {
				name = "Delete marker",
				order=30, type ="group", dialogInline = true, hidden = not(vexpower.options.markers.openTab["delete"]),
				args = {
					marker = {
						name = "Select marker",
						order=1, type = "select", style = "dropdown",
						values = vexpower.options.markers.getList(), width="full",
						set = function(self,key) vexpower.options.markers.idEdit=vexpower.options.markers.getKeyFromCryptList(key) vexpower.options.markers.load() vexpower.initialize.core(true) end,
						get = function() return vexpower.options.markers.createCryptListKey(vexpower.options.markers.idEdit) end,
						},
					delete = {
						name = "delete", width="half",
						order=41, type = "execute", disabled = vexpower.options.markers.idEdit==0,
						func = function(info,val) vexpower.options.markers.delete() vexpower.initialize.core(true) end,
						confirm = true,
						confirmText = "Are you sure you want to delete this marker?"
						},
					marker_deleted_info= {name = vexpower.options.markers.statusMsgDeleted, type = "description", order=100},
					},
				},
			
			grpapp = {
				name = "Color & Size",
				order=40, type = "group", dialogInline = true, hidden = not(vexpower.options.markers.openTab["appearance"]),
				args = {
					width = {
						name = "Size",
						order=1, type = "range",
						desc = "Sets the width of the marker",
						step = 1, min = 1, max = 10,
						set = function(info,val) vexpower_SV_profiles[vexpower_SV_data["profile"]]["powerbar"]["markers"]["width"]=val vexpower.initialize.core(true) end,
						get = function() return vexpower_SV_profiles[vexpower_SV_data["profile"]]["powerbar"]["markers"]["width"] end,
						},
					borderwidth = {
						name = "Border Size",
						order=2, type = "range",
						desc = "Sets the width of the border",
						step = 1, min = 1, max = 10,
						set = function(info,val) vexpower_SV_profiles[vexpower_SV_data["profile"]]["powerbar"]["markers"]["border"]["size"]=val vexpower.initialize.core(true) end,
						get = function() return vexpower_SV_profiles[vexpower_SV_data["profile"]]["powerbar"]["markers"]["border"]["size"] end,
						},
					space1 = {name =" ", type = "description", order=3},
					
					bgcolor = {
						name = "Background Color",
						order=10, type = "color", hasAlpha=false,
						desc = "Set the marker's background color",
						disabled = vexpower_SV_profiles[vexpower_SV_data["profile"]]["powerbar"]["markers"]["colorLikeBG"],
						set = function(info,r,g,b,a)
							vexpower_SV_profiles[vexpower_SV_data["profile"]]["powerbar"]["markers"]["color"]["r"]=r
							vexpower_SV_profiles[vexpower_SV_data["profile"]]["powerbar"]["markers"]["color"]["g"]=g
							vexpower_SV_profiles[vexpower_SV_data["profile"]]["powerbar"]["markers"]["color"]["b"]=b
							vexpower.initialize.core(true) end,
						get = function() return vexpower_SV_profiles[vexpower_SV_data["profile"]]["powerbar"]["markers"]["color"]["r"],
							vexpower_SV_profiles[vexpower_SV_data["profile"]]["powerbar"]["markers"]["color"]["g"],
							vexpower_SV_profiles[vexpower_SV_data["profile"]]["powerbar"]["markers"]["color"]["b"] end,
						},
					bgcolor_likebar = {
						name = "Use powerbar's color",
						order=11, type = "toggle",
						set = function(self,key) vexpower_SV_profiles[vexpower_SV_data["profile"]]["powerbar"]["markers"]["colorLikeBG"]=key vexpower.initialize.core(true) end,
						get = function() return vexpower_SV_profiles[vexpower_SV_data["profile"]]["powerbar"]["markers"]["colorLikeBG"] end,
						},
					bgopacity = {
						name = "Opacity %",
						order=12, type = "range",
						desc = "Sets the opacity",
						step = 5, min = 0, max = 100,
						set = function(info,val) vexpower_SV_profiles[vexpower_SV_data["profile"]]["powerbar"]["markers"]["color"]["a"]=val/100 vexpower.initialize.core(true) end,
						get = function() return vexpower_SV_profiles[vexpower_SV_data["profile"]]["powerbar"]["markers"]["color"]["a"]*100 end
						},	
					space2 = {name =" ", type = "description", order=13},
					
					borderborder = {
						name = "Border Color",
						order=20, type = "color", hasAlpha=false,
						desc = "Set the marker's border color",
						disabled = vexpower_SV_profiles[vexpower_SV_data["profile"]]["powerbar"]["markers"]["border"]["colorLikeBG"],
						set = function(info,r,g,b,a)
							vexpower_SV_profiles[vexpower_SV_data["profile"]]["powerbar"]["markers"]["border"]["color"]["r"]=r
							vexpower_SV_profiles[vexpower_SV_data["profile"]]["powerbar"]["markers"]["border"]["color"]["g"]=g
							vexpower_SV_profiles[vexpower_SV_data["profile"]]["powerbar"]["markers"]["border"]["color"]["b"]=b
							vexpower.initialize.core(true) end,
						get = function() return vexpower_SV_profiles[vexpower_SV_data["profile"]]["powerbar"]["markers"]["border"]["color"]["r"],
							vexpower_SV_profiles[vexpower_SV_data["profile"]]["powerbar"]["markers"]["border"]["color"]["g"],
							vexpower_SV_profiles[vexpower_SV_data["profile"]]["powerbar"]["markers"]["border"]["color"]["b"] end,
						},
					bordercolor_likebar = {
						name = "Use powerbar's color",
						order=21, type = "toggle",
						set = function(self,key) vexpower_SV_profiles[vexpower_SV_data["profile"]]["powerbar"]["markers"]["border"]["colorLikeBG"]=key vexpower.initialize.core(true) end,
						get = function() return vexpower_SV_profiles[vexpower_SV_data["profile"]]["powerbar"]["markers"]["border"]["colorLikeBG"] end,
						},
					borderopacity = {
						name = "Opacity %",
						order=22, type = "range",
						desc = "Sets the opacity",
						step = 5, min = 0, max = 100,
						set = function(info,val) vexpower_SV_profiles[vexpower_SV_data["profile"]]["powerbar"]["markers"]["border"]["color"]["a"]=val/100 vexpower.initialize.core(true) end,
						get = function() return vexpower_SV_profiles[vexpower_SV_data["profile"]]["powerbar"]["markers"]["border"]["color"]["a"]*100 end
						},
					},
				},
			}
		}
end
