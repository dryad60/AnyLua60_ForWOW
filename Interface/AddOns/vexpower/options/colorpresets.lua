function vexpower.options.colorpresets.panel()	
	return {
		type = "group",
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
					edit = {name ='\n', type = "description", order=5, width="normal"},
					},
				},
			spacetestmode = {name ="\n", type = "description", order=2},
			grpinfo = {
				name = "Information",
				order=10, type ="group", dialogInline = true,
				args = {
					info = {name = "Color Sets contain colors for the ComboPointBar. They can be loaded manually in this optionpanel or for new chars automatically depending on their class. To allow the addon to automatically load a Color Set for a specific class go to the option panel 'ComboPoints'->'Layout'", type = "description", order=1},
					},
				},
			space1 = {name = " ", type = "description", order=11, fontSize="medium"},
			grpoptiontabs = {
				name = "Toggle Option Tabs",
				order=12, type ="group", dialogInline = true,
				args = {
					load = {
						name = "Load",
						order=1, type = "execute", width="half",
						func = function(info,val) vexpower.options.colorpresets.toggleTab("Load") vexpower.initialize.core(true) end,
						},
					Add = {
						name = "Create",
						order=2, type = "execute", width="half",
						func = function(info,val) vexpower.options.colorpresets.toggleTab("Create") vexpower.initialize.core(true) end,
						},
					Update = {
						name = "Update",
						order=3, type = "execute", width="half",
						func = function(info,val) vexpower.options.colorpresets.toggleTab("Edit") vexpower.initialize.core(true) end,
						},
					Delete = {
						name = "Delete",
						order=4, type = "execute", width="half",
						func = function(info,val) vexpower.options.colorpresets.toggleTab("Delete") vexpower.initialize.core(true) end,
						},
					Defaults = {
						name = "Defaults",
						order=5, type = "execute", width="half",
						func = function(info,val) vexpower.options.colorpresets.toggleTab("Defaults") vexpower.initialize.core(true) end,
						},
					},
				},
			spaceoptiontabs = {name =" ", type = "description", order=13},
			
			grpload = {
				name = function ()
						if vexpower.options.colorpresets.openTab["Load"] then
							return "Load and overwrite the currently used colors"
						elseif vexpower.options.colorpresets.openTab["Create"] then
							return "Create a new color set"
						elseif vexpower.options.colorpresets.openTab["Edit"] then
							return "Edit a color set"
						elseif vexpower.options.colorpresets.openTab["Delete"] then
							return "Delete a color set"
						elseif vexpower.options.colorpresets.openTab["Defaults"] then
							return "Load predefined color sets"
						end
					end,
				order=20, type ="group", dialogInline = true,
				args = {
					profile = {
						name = "Select color set",
						order=1, type = "select", style = "dropdown", width="double", hidden=not(vexpower.options.colorpresets.openTab["Edit"]) and not(vexpower.options.colorpresets.openTab["Load"]) and not(vexpower.options.colorpresets.openTab["Delete"]),
						values = vexpower.options.colorpresets.getList(true),
						set = function(self,key) vexpower.options.colorpresets.editName=key vexpower.options.colorpresets.loadData() vexpower.initialize.core(true) end,
						get = function() return vexpower.options.colorpresets.editName end,
						},
					name = {
						name = "Name",
						order=2, type = "input", multiline = false, hidden = not(vexpower.options.colorpresets.openTab["Create"]), width="double",
						set = function(info,val) vexpower.options.colorpresets.editName=val vexpower.initialize.core(true)	end,
						get = function() return vexpower.options.colorpresets.editName end,
						},
					load = {
						name = "Load",
						order=10, type = "execute", hidden=not(vexpower.options.colorpresets.openTab["Load"]),
						confirm = true, disabled=vexpower_SV_profiles[vexpower_SV_data["profile"]]["CPBar"]["design"]["colors"]["classPresets"]["activate"],
						confirmText = "Are you sure you want to overwrite the current ComboPoint colors with this color set?",
						func = function(info,val) vexpower.options.colorpresets.activate() vexpower.initialize.core(true) end,
						},
					delete = {
						name = "Delete",
						order=10, type = "execute", hidden=not(vexpower.options.colorpresets.openTab["Delete"]),
						confirm = true,
						confirmText = "Are you sure you want to overwrite the current ComboPoint colors with this color set?",
						func = function(info,val) vexpower.options.colorpresets.delete() vexpower.initialize.core(true) end,
						},
					defaults = {
						name = "Load addon default color sets",
						order=10, type = "execute", hidden=not(vexpower.options.colorpresets.openTab["Defaults"]),
						confirm = true, width="double",
						confirmText = "Are you sure you want to load the default color sets? This may overwrite existing color sets with the same name",
						func = function(info,val) vexpower.options.colorpresets.loadDefaults() vexpower.initialize.core(true) end,
						},
					warning = {
						name ="|CFFff0000Disabled feature|r: You have 'load invidividual color sets for ech class instead of one color set for all classes' enabled! Overwriting the combopoints by loading a color set will have no effect! Go to 'ComboPoints'->'Layout' to disable this feature.",
						type = "description", order=1, width="full", order=11,
						hidden = not(vexpower_SV_profiles[vexpower_SV_data["profile"]]["CPBar"]["design"]["colors"]["classPresets"]["activate"]) or not(vexpower.options.colorpresets.openTab["Load"]),
						},
						
					grpColors = {
						name = "Colors",
						order=20, type ="group", dialogInline = true, hidden=not(vexpower.options.colorpresets.openTab["Edit"]) and not(vexpower.options.colorpresets.openTab["Create"]),
						args = {
							-- Color CP 1 ----------------------
							framecolors1 = {
								name = "Color of the 1st 'ComboPoint'", width="double",
								order=110, type = "color", hasAlpha=false,
								set = function(info,r,g,b) 
									vexpower.options.colorpresets.colorset["1"]["r"] = r
									vexpower.options.colorpresets.colorset["1"]["g"] = g
									vexpower.options.colorpresets.colorset["1"]["b"] = b 
									if vexpower.options.colorpresets.openTab["Edit"] then vexpower.options.colorpresets.save() end
									end,
								get = function() return
									vexpower.options.colorpresets.colorset["1"]["r"],
									vexpower.options.colorpresets.colorset["1"]["g"],
									vexpower.options.colorpresets.colorset["1"]["b"] end,
								},
							opacity1 = {
								name = "Opacity %",
								order=111, type = "range",
								desc = "Sets the opacity",
								step = 5, min = 0, max = 100,
								set = function(info,val) vexpower.options.colorpresets.colorset["1"]["a"] = val/100 
									if vexpower.options.colorpresets.openTab["Edit"] then vexpower.options.colorpresets.save() end end,
								get = function() return vexpower.options.colorpresets.colorset["1"]["a"]*100 end
								},
								
							-- Color CP 2 ----------------------
							framecolors2 = {
								name = "Color of the 2nd 'ComboPoint'", width="double",
								order=120, type = "color", hasAlpha=false,
								set = function(info,r,g,b) 
									vexpower.options.colorpresets.colorset["2"]["r"] = r
									vexpower.options.colorpresets.colorset["2"]["g"] = g
									vexpower.options.colorpresets.colorset["2"]["b"] = b 
									if vexpower.options.colorpresets.openTab["Edit"] then vexpower.options.colorpresets.save() end
									end,
								get = function() return
									vexpower.options.colorpresets.colorset["2"]["r"],
									vexpower.options.colorpresets.colorset["2"]["g"],
									vexpower.options.colorpresets.colorset["2"]["b"] end,
								},
							opacity2 = {
								name = "Opacity %",
								order=121, type = "range",
								desc = "Sets the opacity",
								step = 5, min = 0, max = 100,
								set = function(info,val) vexpower.options.colorpresets.colorset["2"]["a"] = val/100 
									if vexpower.options.colorpresets.openTab["Edit"] then vexpower.options.colorpresets.save() end end,
								get = function() return vexpower.options.colorpresets.colorset["2"]["a"]*100 end
								},
								
							-- Color CP 3 ----------------------
							framecolors3 = {
								name = "Color of the 3rd 'ComboPoint'", width="double",
								order=130, type = "color", hasAlpha=false,
								set = function(info,r,g,b) 
									vexpower.options.colorpresets.colorset["3"]["r"] = r
									vexpower.options.colorpresets.colorset["3"]["g"] = g
									vexpower.options.colorpresets.colorset["3"]["b"] = b 
									if vexpower.options.colorpresets.openTab["Edit"] then vexpower.options.colorpresets.save() end
									end,
								get = function() return
									vexpower.options.colorpresets.colorset["3"]["r"],
									vexpower.options.colorpresets.colorset["3"]["g"],
									vexpower.options.colorpresets.colorset["3"]["b"] end,
								},
							opacity3 = {
								name = "Opacity %",
								order=131, type = "range",
								desc = "Sets the opacity",
								step = 5, min = 0, max = 100,
								set = function(info,val) vexpower.options.colorpresets.colorset["3"]["a"] = val/100 
									if vexpower.options.colorpresets.openTab["Edit"] then vexpower.options.colorpresets.save() end end,
								get = function() return vexpower.options.colorpresets.colorset["3"]["a"]*100 end
								},
								
							-- Color CP 4 ----------------------
							framecolors4 = {
								name = "Color of the 4th 'ComboPoint'", width="double",
								order=140, type = "color", hasAlpha=false,
								set = function(info,r,g,b) 
									vexpower.options.colorpresets.colorset["4"]["r"] = r
									vexpower.options.colorpresets.colorset["4"]["g"] = g
									vexpower.options.colorpresets.colorset["4"]["b"] = b 
									if vexpower.options.colorpresets.openTab["Edit"] then vexpower.options.colorpresets.save() end
									end,
								get = function() return
									vexpower.options.colorpresets.colorset["4"]["r"],
									vexpower.options.colorpresets.colorset["4"]["g"],
									vexpower.options.colorpresets.colorset["4"]["b"] end,
								},
							opacity4 = {
								name = "Opacity %",
								order=141, type = "range",
								desc = "Sets the opacity",
								step = 5, min = 0, max = 100,
								set = function(info,val) vexpower.options.colorpresets.colorset["4"]["a"] = val/100
									if vexpower.options.colorpresets.openTab["Edit"] then vexpower.options.colorpresets.save() end end,
								get = function() return vexpower.options.colorpresets.colorset["4"]["a"]*100 end
								},
								
							-- Color CP 5 ----------------------
							framecolors5 = {
								name = "Color of the 5th 'ComboPoint'", width="double",
								order=150, type = "color", hasAlpha=false,
								set = function(info,r,g,b) 
									vexpower.options.colorpresets.colorset["5"]["r"] = r
									vexpower.options.colorpresets.colorset["5"]["g"] = g
									vexpower.options.colorpresets.colorset["5"]["b"] = b 
									if vexpower.options.colorpresets.openTab["Edit"] then vexpower.options.colorpresets.save() end
									end,
								get = function() return
									vexpower.options.colorpresets.colorset["5"]["r"],
									vexpower.options.colorpresets.colorset["5"]["g"],
									vexpower.options.colorpresets.colorset["5"]["b"] end,
								},
							opacity5 = {
								name = "Opacity %",
								order=151, type = "range",
								desc = "Sets the opacity",
								step = 5, min = 0, max = 100,
								set = function(info,val) vexpower.options.colorpresets.colorset["5"]["a"] = val/100 
									if vexpower.options.colorpresets.openTab["Edit"] then vexpower.options.colorpresets.save() end end,
								get = function() return vexpower.options.colorpresets.colorset["5"]["a"]*100 end
								},
								
							-- Color CP 6 ----------------------
							framecolors6 = {
								name = "Color of the 6th 'ComboPoint'", width="double",
								order=160, type = "color", hasAlpha=false,
								set = function(info,r,g,b) 
									vexpower.options.colorpresets.colorset["6"]["r"] = r
									vexpower.options.colorpresets.colorset["6"]["g"] = g
									vexpower.options.colorpresets.colorset["6"]["b"] = b 
									if vexpower.options.colorpresets.openTab["Edit"] then vexpower.options.colorpresets.save() end
									end,
								get = function() return
									vexpower.options.colorpresets.colorset["6"]["r"],
									vexpower.options.colorpresets.colorset["6"]["g"],
									vexpower.options.colorpresets.colorset["6"]["b"] end,
								},
							opacity6 = {
								name = "Opacity %",
								order=161, type = "range",
								desc = "Sets the opacity",
								step = 5, min = 0, max = 100,
								set = function(info,val) vexpower.options.colorpresets.colorset["6"]["a"] = val/100 
									if vexpower.options.colorpresets.openTab["Edit"] then vexpower.options.colorpresets.save() end end,
								get = function() return vexpower.options.colorpresets.colorset["6"]["a"]*100 end
								},
								
							-- Color CP 7 ----------------------
							framecolors7 = {
								name = "Color of the 7th 'ComboPoint'", width="double",
								order=170, type = "color", hasAlpha=false,
								set = function(info,r,g,b) 
									vexpower.options.colorpresets.colorset["7"]["r"] = r
									vexpower.options.colorpresets.colorset["7"]["g"] = g
									vexpower.options.colorpresets.colorset["7"]["b"] = b 
									if vexpower.options.colorpresets.openTab["Edit"] then vexpower.options.colorpresets.save() end
									end,
								get = function() return
									vexpower.options.colorpresets.colorset["7"]["r"],
									vexpower.options.colorpresets.colorset["7"]["g"],
									vexpower.options.colorpresets.colorset["7"]["b"] end,
								},
							opacity7 = {
								name = "Opacity %",
								order=171, type = "range",
								desc = "Sets the opacity",
								step = 5, min = 0, max = 100,
								set = function(info,val) vexpower.options.colorpresets.colorset["7"]["a"] = val/100 
									if vexpower.options.colorpresets.openTab["Edit"] then vexpower.options.colorpresets.save() end end,
								get = function() return vexpower.options.colorpresets.colorset["7"]["a"]*100 end
								},
								
							-- Color CP 8 ----------------------
							framecolors8 = {
								name = "Color of the 8th 'ComboPoint'", width="double",
								order=180, type = "color", hasAlpha=false,
								set = function(info,r,g,b) 
									vexpower.options.colorpresets.colorset["8"]["r"] = r
									vexpower.options.colorpresets.colorset["8"]["g"] = g
									vexpower.options.colorpresets.colorset["8"]["b"] = b 
									if vexpower.options.colorpresets.openTab["Edit"] then vexpower.options.colorpresets.save() end
									end,
								get = function() return
									vexpower.options.colorpresets.colorset["8"]["r"],
									vexpower.options.colorpresets.colorset["8"]["g"],
									vexpower.options.colorpresets.colorset["8"]["b"] end,
								},
							opacity8 = {
								name = "Opacity %",
								order=181, type = "range",
								desc = "Sets the opacity",
								step = 5, min = 0, max = 100,
								set = function(info,val) vexpower.options.colorpresets.colorset["8"]["a"] = val/100 
									if vexpower.options.colorpresets.openTab["Edit"] then vexpower.options.colorpresets.save() end end,
								get = function() return vexpower.options.colorpresets.colorset["8"]["a"]*100 end
								},
								
							-- Color CP 9 ----------------------
							framecolors9 = {
								name = "Color of the 9th 'ComboPoint'", width="double",
								order=190, type = "color", hasAlpha=false,
								set = function(info,r,g,b) 
									vexpower.options.colorpresets.colorset["9"]["r"] = r
									vexpower.options.colorpresets.colorset["9"]["g"] = g
									vexpower.options.colorpresets.colorset["9"]["b"] = b 
									if vexpower.options.colorpresets.openTab["Edit"] then vexpower.options.colorpresets.save() end
									end,
								get = function() return
									vexpower.options.colorpresets.colorset["9"]["r"],
									vexpower.options.colorpresets.colorset["9"]["g"],
									vexpower.options.colorpresets.colorset["9"]["b"] end,
								},
							opacity9 = {
								name = "Opacity %",
								order=191, type = "range",
								desc = "Sets the opacity",
								step = 5, min = 0, max = 100,
								set = function(info,val) vexpower.options.colorpresets.colorset["9"]["a"] = val/100 
									if vexpower.options.colorpresets.openTab["Edit"] then vexpower.options.colorpresets.save() end end,
								get = function() return vexpower.options.colorpresets.colorset["9"]["a"]*100 end
								},
								
							-- Color CP 10 ----------------------
							framecolors10 = {
								name = "Color of the 10th 'ComboPoint'", width="double",
								order=200, type = "color", hasAlpha=false,
								set = function(info,r,g,b) 
									vexpower.options.colorpresets.colorset["10"]["r"] = r
									vexpower.options.colorpresets.colorset["10"]["g"] = g
									vexpower.options.colorpresets.colorset["10"]["b"] = b 
									if vexpower.options.colorpresets.openTab["Edit"] then vexpower.options.colorpresets.save() end
									end,
								get = function() return
									vexpower.options.colorpresets.colorset["10"]["r"],
									vexpower.options.colorpresets.colorset["10"]["g"],
									vexpower.options.colorpresets.colorset["10"]["b"] end,
								},
							opacity10 = {
								name = "Opacity %",
								order=201, type = "range",
								desc = "Sets the opacity",
								step = 5, min = 0, max = 100,
								set = function(info,val) vexpower.options.colorpresets.colorset["10"]["a"] = val/100 
									if vexpower.options.colorpresets.openTab["Edit"] then vexpower.options.colorpresets.save() end end,
								get = function() return vexpower.options.colorpresets.colorset["10"]["a"]*100 end
								},
								
							-- Color CP FadeOut ----------------------
							framecolorsChange = {
								name = "Color of the 'FadeOut'-effect", width="double",
								order=300, type = "color", hasAlpha=false,
								set = function(info,r,g,b) 
									vexpower.options.colorpresets.colorset["used"]["r"] = r
									vexpower.options.colorpresets.colorset["used"]["g"] = g
									vexpower.options.colorpresets.colorset["used"]["b"] = b 
									if vexpower.options.colorpresets.openTab["Edit"] then vexpower.options.colorpresets.save() end
									end,
								get = function() return
									vexpower.options.colorpresets.colorset["used"]["r"],
									vexpower.options.colorpresets.colorset["used"]["g"],
									vexpower.options.colorpresets.colorset["used"]["b"] end,
								},
							opacityChange = {
								name = "Opacity %",
								order=301, type = "range",
								desc = "Sets the opacity",
								step = 5, min = 0, max = 100,
								set = function(info,val) vexpower.options.colorpresets.colorset["used"]["a"] = val/100 
									if vexpower.options.colorpresets.openTab["Edit"] then vexpower.options.colorpresets.save() end end,
								get = function() return vexpower.options.colorpresets.colorset["used"]["a"]*100 end
								},
								
							-- Color CP Recolor ----------------------
							framecolorsX = {
								name = "Color of the 'Recolor'-effect", width="double",
								order=310, type = "color", hasAlpha=false,
								set = function(info,r,g,b) 
									vexpower.options.colorpresets.colorset["change"]["r"] = r
									vexpower.options.colorpresets.colorset["change"]["g"] = g
									vexpower.options.colorpresets.colorset["change"]["b"] = b 
									if vexpower.options.colorpresets.openTab["Edit"] then vexpower.options.colorpresets.save() end
									end,
								get = function() return
									vexpower.options.colorpresets.colorset["change"]["r"],
									vexpower.options.colorpresets.colorset["change"]["g"],
									vexpower.options.colorpresets.colorset["change"]["b"] end,
								},
							opacityX = {
								name = "Opacity %",
								order=311, type = "range",
								desc = "Sets the opacity",
								step = 5, min = 0, max = 100,
								set = function(info,val) vexpower.options.colorpresets.colorset["change"]["a"] = val/100 
									if vexpower.options.colorpresets.openTab["Edit"] then vexpower.options.colorpresets.save() end end,
								get = function() return vexpower.options.colorpresets.colorset["change"]["a"]*100 end
								},
							},
						},
						
					space1 = {name = " ", type = "description", order=400, fontSize="medium"},
					create = {
						name = "Create",
						order=401, type = "execute", hidden=not(vexpower.options.colorpresets.openTab["Create"]),
						confirm = vexpower_SV_colorsets[vexpower.options.colorpresets.editName]~=nil,
						confirmText = "Are you sure you want to overwrite the Color Set?",
						func = function(info,val) vexpower.options.colorpresets.save(true) vexpower.initialize.core(true) end,
						},
					status = {name = vexpower.options.colorpresets.statusMsg, type = "description", order=600, fontSize="medium"},
					},
				},
			}
		}
end
