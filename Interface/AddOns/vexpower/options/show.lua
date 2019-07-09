function vexpower.options.show.panel()
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
			
			grpallow = {
				name = "General Settings",
				order=10, type ="group", dialogInline = true,
				args = {
					activateenergy = {
						name = "Show the Powerbar",
						order=3, type = "toggle", width="full",
						disabled = not(vexpower_SV_profiles[vexpower_SV_data["profile"]]["data"]["show"]["enableAddon"]),
						set = function(self,key) vexpower_SV_profiles[vexpower_SV_data["profile"]]["powerbar"]["show"]["show"]=key vexpower.initialize.core(true) end,
						get = function() return vexpower_SV_profiles[vexpower_SV_data["profile"]]["powerbar"]["show"]["show"] end,
						},
					activatecps = {
						name = "Show the Combopoints",
						order=4, type = "toggle", width="full",
						disabled = not(vexpower_SV_profiles[vexpower_SV_data["profile"]]["data"]["show"]["enableAddon"]),
						set = function(self,key) vexpower_SV_profiles[vexpower_SV_data["profile"]]["CPBar"]["show"]["show"]=key vexpower.initialize.core(true) end,
						get = function() return vexpower_SV_profiles[vexpower_SV_data["profile"]]["CPBar"]["show"]["show"] end,
						},
					},
				},
			space1 = {name =" ", type = "description", order=11},
			grpooc = {
				name = "'Out of Combat' Settings",
				order=30, type ="group", dialogInline = true, hidden=not(vexpower_SV_profiles[vexpower_SV_data["profile"]]["data"]["advancedOptions"]),
				args = {
					grpPB = {
						name = "Powerbar Settings",
						order=1, type ="group", dialogInline = true, hidden=not(vexpower_SV_profiles[vexpower_SV_data["profile"]]["data"]["advancedOptions"]),
						args = {
							infightonly = {
								name = "Hide the Powerbar when 'Out of Combat'",
								order=1, type = "toggle", width="full",
								disabled = not(vexpower_SV_profiles[vexpower_SV_data["profile"]]["data"]["show"]["enableAddon"]),
								set = function(self,key) vexpower_SV_profiles[vexpower_SV_data["profile"]]["powerbar"]["show"]["hideOOC"]=key vexpower.initialize.core(true) end,
								get = function() return vexpower_SV_profiles[vexpower_SV_data["profile"]]["powerbar"]["show"]["hideOOC"] end,
								},
							stillShow = {name ="\nStill show the Powerbar when:", type = "description", order=2, fontSize="medium",},
							stealth = {
								name = "stealthed",
								order=3, type = "toggle",
								disabled = not(vexpower_SV_profiles[vexpower_SV_data["profile"]]["powerbar"]["show"]["hideOOC"]) or not(vexpower_SV_profiles[vexpower_SV_data["profile"]]["data"]["show"]["enableAddon"]),
								desc = "Shows the energy bar when stealthed even when the 'out of combat'-setting is enabled and you are out of combat",
								set = function(self,key) vexpower_SV_profiles[vexpower_SV_data["profile"]]["powerbar"]["show"]["inStealth"]=key vexpower.initialize.core(true) end,
								get = function() return vexpower_SV_profiles[vexpower_SV_data["profile"]]["powerbar"]["show"]["inStealth"] end,
								},
							targetSet = {
								name = "targeting",
								order=4, type = "toggle",
								disabled = not(vexpower_SV_profiles[vexpower_SV_data["profile"]]["powerbar"]["show"]["hideOOC"]) or not(vexpower_SV_profiles[vexpower_SV_data["profile"]]["data"]["show"]["enableAddon"]),
								desc = "Shows the energy bar when targeting anything even when the 'out of combat'-setting is enabled and you are out of combat",
								set = function(self,key) vexpower_SV_profiles[vexpower_SV_data["profile"]]["powerbar"]["show"]["whenTargeting"]=key vexpower.initialize.core(true) end,
								get = function() return vexpower_SV_profiles[vexpower_SV_data["profile"]]["powerbar"]["show"]["whenTargeting"] end,
								},
							targetAttackable = {
								name = "only when targeting an attackable unit",
								order=5, type = "toggle", width="full",
								disabled =
									not(vexpower_SV_profiles[vexpower_SV_data["profile"]]["powerbar"]["show"]["hideOOC"])
									or not(vexpower_SV_profiles[vexpower_SV_data["profile"]]["data"]["show"]["enableAddon"]),
								desc = "Shows the energy bar when targeting an ->attackable<- unit even when the 'out of combat'-setting is enabled and you are out of combat. The bar will NOT be shown when targeting a friendly unit!",
								set = function(self,key) vexpower_SV_profiles[vexpower_SV_data["profile"]]["powerbar"]["show"]["whenTargetingAttackable"]=key vexpower.initialize.core(true) end,
								get = function() return vexpower_SV_profiles[vexpower_SV_data["profile"]]["powerbar"]["show"]["whenTargetingAttackable"] end,
								},
							},
						},
					space1 = {name =" ", type = "description", order=5},
					
					grpCP = {
						name = "ComboPoint Settings",
						order=10, type ="group", dialogInline = true, hidden=not(vexpower_SV_profiles[vexpower_SV_data["profile"]]["data"]["advancedOptions"]),
						args = {
							infightonlyCP = {
								name = "When 'Out of Combat': Hide the ComboPoints",
								order=1, type = "toggle", width="full",
								disabled = not(vexpower_SV_profiles[vexpower_SV_data["profile"]]["data"]["show"]["enableAddon"]),
								set = function(self,key) vexpower_SV_profiles[vexpower_SV_data["profile"]]["CPBar"]["show"]["hideOOC"]=key vexpower.initialize.core(true) end,
								get = function() return vexpower_SV_profiles[vexpower_SV_data["profile"]]["CPBar"]["show"]["hideOOC"] end,
								},
							stillShow = {name ="\nStill show the Powerbar when:", type = "description", order=2, fontSize="medium",},
							stealthCP = {
								name = "stealthed",
								order=3, type = "toggle",
								disabled = not(vexpower_SV_profiles[vexpower_SV_data["profile"]]["CPBar"]["show"]["hideOOC"]) or not(vexpower_SV_profiles[vexpower_SV_data["profile"]]["data"]["show"]["enableAddon"]),
								desc = "Shows the combopoints when stealthed even when the 'out of combat'-setting is enabled and you are out of combat",
								set = function(self,key) vexpower_SV_profiles[vexpower_SV_data["profile"]]["CPBar"]["show"]["inStealth"]=key vexpower.initialize.core(true) end,
								get = function() return vexpower_SV_profiles[vexpower_SV_data["profile"]]["CPBar"]["show"]["inStealth"] end,
								},
							targetSetCP = {
								name = "targeting",
								order=4, type = "toggle",
								disabled = not(vexpower_SV_profiles[vexpower_SV_data["profile"]]["CPBar"]["show"]["hideOOC"]) or not(vexpower_SV_profiles[vexpower_SV_data["profile"]]["data"]["show"]["enableAddon"]),
								desc = "Shows the combopoints when targeting a unit even when the 'out of combat'-setting is enabled and you are out of combat",
								set = function(self,key) vexpower_SV_profiles[vexpower_SV_data["profile"]]["CPBar"]["show"]["whenTargeting"]=key vexpower.initialize.core(true) end,
								get = function() return vexpower_SV_profiles[vexpower_SV_data["profile"]]["CPBar"]["show"]["whenTargeting"] end,
								},
							targetAttackableCP = {
								name = "only when targeting an attackable unit",
								order=5, type = "toggle", width="full",
								disabled =
									not(vexpower_SV_profiles[vexpower_SV_data["profile"]]["CPBar"]["show"]["hideOOC"])
									or not(vexpower_SV_profiles[vexpower_SV_data["profile"]]["data"]["show"]["enableAddon"]),
								desc = "Shows the combopoints when targeting an ->attackable<- unit even when the 'out of combat'-setting is enabled and you are out of combat. The bar will NOT be shown when targeting a friendly unit!",
								set = function(self,key) vexpower_SV_profiles[vexpower_SV_data["profile"]]["CPBar"]["show"]["whenTargetingAttackable"]=key vexpower.initialize.core(true) end,
								get = function() return vexpower_SV_profiles[vexpower_SV_data["profile"]]["CPBar"]["show"]["whenTargetingAttackable"] end,
								},
							},
						},
					frame_subspace2 = {name =" \n ", type = "description", order=20, hidden=not(vexpower_SV_profiles[vexpower_SV_data["profile"]]["data"]["advancedOptions"]),},
					infightdelay = {
						name = "Delay 'Out of Combat' by X seconds", hidden=not(vexpower_SV_profiles[vexpower_SV_data["profile"]]["data"]["advancedOptions"]),
						order=21, type = "range", width="double",
						desc = "Sets the time the recoloring (optionpanel 'powerbar') and the fade out effects are delayed when leaving combat",
						step = 1, min = 0, max = 30,
						set = function(info,val) vexpower_SV_profiles[vexpower_SV_data["profile"]]["data"]["show"]["infightdelay"]=val vexpower.initialize.core(true) end,
						get = function() return vexpower_SV_profiles[vexpower_SV_data["profile"]]["data"]["show"]["infightdelay"] end
						},
					},
				},
			space3 = {name =" ", type = "description", order=31, hidden=not(vexpower_SV_profiles[vexpower_SV_data["profile"]]["data"]["advancedOptions"]),},
			grpPetBattle = {
				name = "'Pet Battle' Settings",
				order=35, type ="group", dialogInline = true, hidden=not(vexpower_SV_profiles[vexpower_SV_data["profile"]]["data"]["advancedOptions"]),
				args = {
					notInPetBattleEnergy = {
						name = "When in a pet battle: Hide the Powerbar",
						order=1, type = "toggle", width="full",
						disabled = not(vexpower_SV_profiles[vexpower_SV_data["profile"]]["data"]["show"]["enableAddon"]),
						set = function(self,key) vexpower_SV_profiles[vexpower_SV_data["profile"]]["powerbar"]["show"]["hideInPetBattle"]	=key vexpower.initialize.core(true) end,
						get = function() return vexpower_SV_profiles[vexpower_SV_data["profile"]]["powerbar"]["show"]["hideInPetBattle"]	 end,
						},
					space1 = {name =" ", type = "description", order=4},
					notInPetBattleCP = {
						name = "When in a pet battle: Hide the ComboPoints",
						order=10, type = "toggle", width="full",
						disabled = not(vexpower_SV_profiles[vexpower_SV_data["profile"]]["data"]["show"]["enableAddon"]),
						set = function(self,key) vexpower_SV_profiles[vexpower_SV_data["profile"]]["CPBar"]["show"]["hideInPetBattle"]=key vexpower.initialize.core(true) end,
						get = function() return vexpower_SV_profiles[vexpower_SV_data["profile"]]["CPBar"]["show"]["hideInPetBattle"] end,
						},
					},
				},
			space_petBattle = {name =" ", type = "description", order=36, hidden=not(vexpower_SV_profiles[vexpower_SV_data["profile"]]["data"]["advancedOptions"]),},
			
			grppowertypes = {
				name = "Powertype settings",
				order=40, type ="group", dialogInline = true, hidden=not(vexpower_SV_profiles[vexpower_SV_data["profile"]]["data"]["advancedOptions"]),
				args = {
					powerbar = {
						name = "Show PowerBar when powertype is",
						order=1, type ="group", dialogInline = true,
						args = {
							marker_new_powertype_rage = {
								name = "|CFF"..vexpower.data.lib.getColor.powertypeHex("RAGE").."Rage|r",
								order=1, type = "toggle", width="half",
								set = function(self,key) vexpower_SV_profiles[vexpower_SV_data["profile"]]["powerbar"]["show"]["powertypes"]["RAGE"] = key vexpower.initialize.core(true) end,
								get = function() return vexpower_SV_profiles[vexpower_SV_data["profile"]]["powerbar"]["show"]["powertypes"]["RAGE"] end,
								},
							marker_new_powertype_mana = {
								name = "|CFF"..vexpower.data.lib.getColor.powertypeHex("MANA").."Mana|r",
								order=2, type = "toggle", width="half",
								set = function(self,key) vexpower_SV_profiles[vexpower_SV_data["profile"]]["powerbar"]["show"]["powertypes"]["MANA"] = key vexpower.initialize.core(true) end,
								get = function() return vexpower_SV_profiles[vexpower_SV_data["profile"]]["powerbar"]["show"]["powertypes"]["MANA"] end,
								},
							marker_new_powertype_focus = {
								name = "|CFF"..vexpower.data.lib.getColor.powertypeHex("FOCUS").."Focus|r",
								order=3, type = "toggle", width="half",
								set = function(self,key) vexpower_SV_profiles[vexpower_SV_data["profile"]]["powerbar"]["show"]["powertypes"]["FOCUS"] = key vexpower.initialize.core(true) end,
								get = function() return vexpower_SV_profiles[vexpower_SV_data["profile"]]["powerbar"]["show"]["powertypes"]["FOCUS"] end,
								},
							marker_new_powertype_energy = {
								name = "|CFF"..vexpower.data.lib.getColor.powertypeHex("ENERGY").."Energy|r",
								order=4, type = "toggle", width="half",
								set = function(self,key) vexpower_SV_profiles[vexpower_SV_data["profile"]]["powerbar"]["show"]["powertypes"]["ENERGY"] = key vexpower.initialize.core(true) end,
								get = function() return vexpower_SV_profiles[vexpower_SV_data["profile"]]["powerbar"]["show"]["powertypes"]["ENERGY"] end,
								},
							marker_new_powertype_rp = {
								name = "|CFF"..vexpower.data.lib.getColor.powertypeHex("RUNIC_POWER").."Runic Power|r",
								order=5, type = "toggle",
								set = function(self,key) vexpower_SV_profiles[vexpower_SV_data["profile"]]["powerbar"]["show"]["powertypes"]["RUNIC_POWER"] = key vexpower.initialize.core(true) end,
								get = function() return vexpower_SV_profiles[vexpower_SV_data["profile"]]["powerbar"]["show"]["powertypes"]["RUNIC_POWER"] end,
								},
							marker_new_powertype_pain = {
								name = "|CFF"..vexpower.data.lib.getColor.powertypeHex("PAIN").."Pain|r",
								order=6, type = "toggle", width="half",
								set = function(self,key) vexpower_SV_profiles[vexpower_SV_data["profile"]]["powerbar"]["show"]["powertypes"]["PAIN"] = key vexpower.initialize.core(true) end,
								get = function() return vexpower_SV_profiles[vexpower_SV_data["profile"]]["powerbar"]["show"]["powertypes"]["PAIN"] end,
								},
							marker_new_powertype_fury = {
								name = "|CFF"..vexpower.data.lib.getColor.powertypeHex("FURY").."Fury|r",
								order=7, type = "toggle", width="half",
								set = function(self,key) vexpower_SV_profiles[vexpower_SV_data["profile"]]["powerbar"]["show"]["powertypes"]["FURY"] = key vexpower.initialize.core(true) end,
								get = function() return vexpower_SV_profiles[vexpower_SV_data["profile"]]["powerbar"]["show"]["powertypes"]["FURY"] end,
								},
							marker_new_powertype_insanity = {
								name = "|CFF"..vexpower.data.lib.getColor.powertypeHex("INSANITY").."Insanity|r",
								order=8, type = "toggle", width="half",
								set = function(self,key) vexpower_SV_profiles[vexpower_SV_data["profile"]]["powerbar"]["show"]["powertypes"]["INSANITY"] = key vexpower.initialize.core(true) end,
								get = function() return vexpower_SV_profiles[vexpower_SV_data["profile"]]["powerbar"]["show"]["powertypes"]["INSANITY"] end,
								},
							marker_new_powertype_maelstrom = {
								name = "|CFF"..vexpower.data.lib.getColor.powertypeHex("MAELSTROM").."Maelstrom|r",
								order=9, type = "toggle",
								set = function(self,key) vexpower_SV_profiles[vexpower_SV_data["profile"]]["powerbar"]["show"]["powertypes"]["MAELSTROM"] = key vexpower.initialize.core(true) end,
								get = function() return vexpower_SV_profiles[vexpower_SV_data["profile"]]["powerbar"]["show"]["powertypes"]["MAELSTROM"] end,
								},
							marker_new_powertype_lunarp = {
								name = "|CFF"..vexpower.data.lib.getColor.powertypeHex("LUNAR_POWER").."Lunar Power|r",
								order=10, type = "toggle",
								set = function(self,key) vexpower_SV_profiles[vexpower_SV_data["profile"]]["powerbar"]["show"]["powertypes"]["LUNAR_POWER"] = key vexpower.initialize.core(true) end,
								get = function() return vexpower_SV_profiles[vexpower_SV_data["profile"]]["powerbar"]["show"]["powertypes"]["LUNAR_POWER"] end,
								},
							},
						},
					space = {name ="\n", type = "description", order=2},
					combopoints = {
						name = "Show ComboPointBar when powertype is",
						order=3, type ="group", dialogInline = true,
						args = {
							marker_new_powertype_rage = {
								name = "|CFF"..vexpower.data.lib.getColor.powertypeHex("RAGE").."Rage|r",
								order=1, type = "toggle", width="half",
								set = function(self,key) vexpower_SV_profiles[vexpower_SV_data["profile"]]["CPBar"]["show"]["powertypes"]["RAGE"] = key vexpower.initialize.core(true) end,
								get = function() return vexpower_SV_profiles[vexpower_SV_data["profile"]]["CPBar"]["show"]["powertypes"]["RAGE"] end,
								},
							marker_new_powertype_mana = {
								name = "|CFF"..vexpower.data.lib.getColor.powertypeHex("MANA").."Mana|r",
								order=2, type = "toggle", width="half",
								set = function(self,key) vexpower_SV_profiles[vexpower_SV_data["profile"]]["CPBar"]["show"]["powertypes"]["MANA"] = key vexpower.initialize.core(true) end,
								get = function() return vexpower_SV_profiles[vexpower_SV_data["profile"]]["CPBar"]["show"]["powertypes"]["MANA"] end,
								},
							marker_new_powertype_focus = {
								name = "|CFF"..vexpower.data.lib.getColor.powertypeHex("FOCUS").."Focus|r",
								order=3, type = "toggle", width="half",
								set = function(self,key) vexpower_SV_profiles[vexpower_SV_data["profile"]]["CPBar"]["show"]["powertypes"]["FOCUS"] = key vexpower.initialize.core(true) end,
								get = function() return vexpower_SV_profiles[vexpower_SV_data["profile"]]["CPBar"]["show"]["powertypes"]["FOCUS"] end,
								},
							marker_new_powertype_energy = {
								name = "|CFF"..vexpower.data.lib.getColor.powertypeHex("ENERGY").."Energy|r",
								order=4, type = "toggle", width="half",
								set = function(self,key) vexpower_SV_profiles[vexpower_SV_data["profile"]]["CPBar"]["show"]["powertypes"]["ENERGY"] = key vexpower.initialize.core(true) end,
								get = function() return vexpower_SV_profiles[vexpower_SV_data["profile"]]["CPBar"]["show"]["powertypes"]["ENERGY"] end,
								},
							marker_new_powertype_rp = {
								name = "|CFF"..vexpower.data.lib.getColor.powertypeHex("RUNIC_POWER").."Runic Power|r",
								order=5, type = "toggle",
								set = function(self,key) vexpower_SV_profiles[vexpower_SV_data["profile"]]["CPBar"]["show"]["powertypes"]["RUNIC_POWER"] = key vexpower.initialize.core(true) end,
								get = function() return vexpower_SV_profiles[vexpower_SV_data["profile"]]["CPBar"]["show"]["powertypes"]["RUNIC_POWER"] end,
								},
							marker_new_powertype_pain = {
								name = "|CFF"..vexpower.data.lib.getColor.powertypeHex("PAIN").."Pain|r",
								order=6, type = "toggle", width="half",
								set = function(self,key) vexpower_SV_profiles[vexpower_SV_data["profile"]]["CPBar"]["show"]["powertypes"]["PAIN"] = key vexpower.initialize.core(true) end,
								get = function() return vexpower_SV_profiles[vexpower_SV_data["profile"]]["CPBar"]["show"]["powertypes"]["PAIN"] end,
								},
							marker_new_powertype_fury = {
								name = "|CFF"..vexpower.data.lib.getColor.powertypeHex("FURY").."Fury|r",
								order=7, type = "toggle", width="half",
								set = function(self,key) vexpower_SV_profiles[vexpower_SV_data["profile"]]["CPBar"]["show"]["powertypes"]["FURY"] = key vexpower.initialize.core(true) end,
								get = function() return vexpower_SV_profiles[vexpower_SV_data["profile"]]["CPBar"]["show"]["powertypes"]["FURY"] end,
								},
							marker_new_powertype_insanity = {
								name = "|CFF"..vexpower.data.lib.getColor.powertypeHex("INSANITY").."Insanity|r",
								order=8, type = "toggle", width="half",
								set = function(self,key) vexpower_SV_profiles[vexpower_SV_data["profile"]]["CPBar"]["show"]["powertypes"]["INSANITY"] = key vexpower.initialize.core(true) end,
								get = function() return vexpower_SV_profiles[vexpower_SV_data["profile"]]["CPBar"]["show"]["powertypes"]["INSANITY"] end,
								},
							marker_new_powertype_maelstrom = {
								name = "|CFF"..vexpower.data.lib.getColor.powertypeHex("MAELSTROM").."Maelstrom|r",
								order=9, type = "toggle",
								set = function(self,key) vexpower_SV_profiles[vexpower_SV_data["profile"]]["CPBar"]["show"]["powertypes"]["MAELSTROM"] = key vexpower.initialize.core(true) end,
								get = function() return vexpower_SV_profiles[vexpower_SV_data["profile"]]["CPBar"]["show"]["powertypes"]["MAELSTROM"] end,
								},
							marker_new_powertype_lunarp = {
								name = "|CFF"..vexpower.data.lib.getColor.powertypeHex("LUNAR_POWER").."Lunar Power|r",
								order=10, type = "toggle",
								set = function(self,key) vexpower_SV_profiles[vexpower_SV_data["profile"]]["CPBar"]["show"]["powertypes"]["LUNAR_POWER"] = key vexpower.initialize.core(true) end,
								get = function() return vexpower_SV_profiles[vexpower_SV_data["profile"]]["CPBar"]["show"]["powertypes"]["LUNAR_POWER"] end,
								},
							},
						},
					},
				},
			space4 = {name =" ", type = "description", order=41, hidden=not(vexpower_SV_profiles[vexpower_SV_data["profile"]]["data"]["advancedOptions"]),},
			
			grpvehicle = {
				name = "Vehicle settings",
				order=50, type ="group", dialogInline = true, hidden=not(vexpower_SV_profiles[vexpower_SV_data["profile"]]["data"]["advancedOptions"]),
				args = {
					vehiclehidePower = {
						name = "When in a vehicle: Show the Powerbar",
						order=1, type = "toggle", width="double",
						disabled = not(vexpower_SV_profiles[vexpower_SV_data["profile"]]["data"]["show"]["enableAddon"]),
						set = function(self,key) vexpower_SV_profiles[vexpower_SV_data["profile"]]["powerbar"]["show"]["hideInVehicle"]=not(key) vexpower.initialize.core(true) end,
						get = function() return not(vexpower_SV_profiles[vexpower_SV_data["profile"]]["powerbar"]["show"]["hideInVehicle"]) end,
						},
					vehicleEnergy= {
						name = "Show vehicle-power",
						order=2, type = "toggle",
						disabled = not(vexpower_SV_profiles[vexpower_SV_data["profile"]]["data"]["show"]["enableAddon"]) or vexpower_SV_profiles[vexpower_SV_data["profile"]]["powerbar"]["show"]["hideInVehicle"],
						set = function(self,key) vexpower_SV_profiles[vexpower_SV_data["profile"]]["powerbar"]["show"]["vehicleEnergy"]=key vexpower.initialize.core(true) end,
						get = function() return vexpower_SV_profiles[vexpower_SV_data["profile"]]["powerbar"]["show"]["vehicleEnergy"] end,
						},
					vehiclehideCPs = {
						name = "When in a vehicle: Show the ComboPoints",
						order=10, type = "toggle", width="double",
						disabled = not(vexpower_SV_profiles[vexpower_SV_data["profile"]]["data"]["show"]["enableAddon"]),
						set = function(self,key) vexpower_SV_profiles[vexpower_SV_data["profile"]]["CPBar"]["show"]["hideInVehicle"]=not(key) vexpower.initialize.core(true) end,
						get = function() return not(vexpower_SV_profiles[vexpower_SV_data["profile"]]["CPBar"]["show"]["hideInVehicle"]) end,
						},
					vehicleCPs= {
						name = "Show vehicle-CPs",
						order=11, type = "toggle",
						disabled = not(vexpower_SV_profiles[vexpower_SV_data["profile"]]["data"]["show"]["enableAddon"]) or vexpower_SV_profiles[vexpower_SV_data["profile"]]["CPBar"]["show"]["hideInVehicle"],
						set = function(self,key) vexpower_SV_profiles[vexpower_SV_data["profile"]]["CPBar"]["show"]["vehicleCPs"]=key vexpower.initialize.core(true) end,
						get = function() return vexpower_SV_profiles[vexpower_SV_data["profile"]]["CPBar"]["show"]["vehicleCPs"] end,
						},
					info = {name = "Showing vehicle-CPs is experimentel, activating it may cause errors in vehicles", type = "description", order=20},
					},
				},
			space5 = {name =" ", type = "description", order=51, hidden=not(vexpower_SV_profiles[vexpower_SV_data["profile"]]["data"]["advancedOptions"]),},
			
			grpeffect = {
				name = "'FadeOut'-Effect",
				order=60, type ="group", dialogInline = true, hidden=not(vexpower_SV_profiles[vexpower_SV_data["profile"]]["data"]["advancedOptions"]),
				args = {
					info = {name = "When a frame shall become hidden it fades out, instead of instantly disappearing.\n", type = "description", order=1},
					fadeout= {
						name = "Activate",
						order=10, type = "toggle", width="full",
						disabled = not(vexpower_SV_profiles[vexpower_SV_data["profile"]]["data"]["show"]["enableAddon"]),
						set = function(self,key) vexpower_SV_profiles[vexpower_SV_data["profile"]]["data"]["show"]["fadeoutEffect"]=key vexpower.initialize.core(true) end,
						get = function() return vexpower_SV_profiles[vexpower_SV_data["profile"]]["data"]["show"]["fadeoutEffect"] end,
						},
					space = {name = " ", type = "description", order=20},
					fadeoutTime = {
						name = "Duration (seconds)",
						order=30, type = "range", width="double",
						desc = "Sets the time the fade out effects last",
						step = 0.1, min = 0.1, max = 5,
						set = function(info,val) vexpower_SV_profiles[vexpower_SV_data["profile"]]["data"]["show"]["fadeOutTime"]=val vexpower.initialize.core(true) end,
						get = function() return vexpower_SV_profiles[vexpower_SV_data["profile"]]["data"]["show"]["fadeOutTime"] end
						},
					},
				},
			}
		}
end
