local LSM3 = LibStub("LibSharedMedia-3.0", true)
local LSM2 = LibStub("LibSharedMedia-2.0", true)
local SML = LibStub("SharedMedia-1.0", true)

Media = {}
Media.revision = tonumber(string.sub("$Revision$", 12, -3)) or 1

Media.registry = { ["font"] = {} }

function Media:Register(mediatype, key, data, langmask)
	if LSM3 then
		LSM3:Register(mediatype, key, data, langmask)
	end
	if LSM2 then
		LSM2:Register(mediatype, key, data)
	end
	if SML then
		SML:Register(mediatype, key, data)
	end
	if not Media.registry[mediatype] then
		Media.registry[mediatype] = {}
	end
	table.insert(Media.registry[mediatype], { key, data, langmask})
end

function Media.OnEvent(this, event, ...)
	if not LSM3 then
		LSM3 = LibStub("LibSharedMedia-3.0", true)
		if LSM3 then
			for m,t in pairs(Media.registry) do
				for _,v in ipairs(t) do
					LSM3:Register(m, v[1], v[2], v[3])
				end
			end
		end
	end
	if not LSM2 then
		LSM2 = LibStub("LibSharedMedia-2.0", true)
		if LSM2 then
			for m,t in pairs(Media.registry) do
				for _,v in ipairs(t) do
					LSM2:Register(m, v[1], v[2])
				end
			end
		end
	end
	if not SML then
		SML = LibStub("SharedMedia-1.0", true)
		if SML then
			for m,t in pairs(Media.registry) do
				for _,v in ipairs(t) do
					SML:Register(m, v[1], v[2])
				end
			end
		end
	end
end

Media.frame = CreateFrame("Frame")
Media.frame:SetScript("OnEvent", Media.OnEvent)
Media.frame:RegisterEvent("ADDON_LOADED")

		if not Media then return end
		local revision = tonumber(string.sub("$Revision: 63551 $", 12, -3))
		Media.revision = (revision > Media.revision) and revision or Media.revision
	 
-- borders --

Media:Register("border", "fer01", [[Interface\AddOns\Ferous Media\Borders\fer1.tga]])
Media:Register("border", "fer02", [[Interface\AddOns\Ferous Media\Borders\fer2.tga]])
Media:Register("border", "fer03", [[Interface\AddOns\Ferous Media\Borders\fer3.tga]])
Media:Register("border", "fer04", [[Interface\AddOns\Ferous Media\Borders\fer4.tga]])
Media:Register("border", "fer05", [[Interface\AddOns\Ferous Media\Borders\fer5.tga]])
Media:Register("border", "fer06", [[Interface\AddOns\Ferous Media\Borders\fer6.tga]])
Media:Register("border", "fer07", [[Interface\AddOns\Ferous Media\Borders\fer7.tga]])
Media:Register("border", "fer08", [[Interface\AddOns\Ferous Media\Borders\fer8.tga]])
Media:Register("border", "fer09", [[Interface\AddOns\Ferous Media\Borders\fer9.tga]])
Media:Register("border", "fer10", [[Interface\AddOns\Ferous Media\Borders\fer10.tga]])
Media:Register("border", "fer11", [[Interface\AddOns\Ferous Media\Borders\fer11.tga]])
Media:Register("border", "fer12", [[Interface\AddOns\Ferous Media\Borders\fer12.tga]])
Media:Register("border", "fer13", [[Interface\AddOns\Ferous Media\Borders\fer13.tga]])

-- FONTS --

Media:Register("font", "AUROE", [[Interface\AddOns\Ferous Media\Fonts\AUROE___.ttf]])
Media:Register("font", "AURORA", [[Interface\AddOns\Ferous Media\Fonts\AURORA__.ttf]])
Media:Register("font", "BAVAE", [[Interface\AddOns\Ferous Media\Fonts\BAVAE___.ttf]])
Media:Register("font", "BAVARG", [[Interface\AddOns\Ferous Media\Fonts\BAVARG__.ttf]])
Media:Register("font", "FRUCE", [[Interface\AddOns\Ferous Media\Fonts\FRUCE___.ttf]])
Media:Register("font", "FRUCRG", [[Interface\AddOns\Ferous Media\Fonts\FRUCRG__.ttf]])
Media:Register("font", "GROS", [[Interface\AddOns\Ferous Media\Fonts\GROS____.ttf]])
Media:Register("font", "GROSE", [[Interface\AddOns\Ferous Media\Fonts\GROSE___.ttf]])
Media:Register("font", "MARKEN", [[Interface\AddOns\Ferous Media\Fonts\MARKEN__.ttf]])
Media:Register("font", "MEMOE", [[Interface\AddOns\Ferous Media\Fonts\MEMOE___.ttf]])
Media:Register("font", "MEMORIA", [[Interface\AddOns\Ferous Media\Fonts\MEMORIA_.ttf]])
Media:Register("font", "MUNIE", [[Interface\AddOns\Ferous Media\Fonts\MUNIE___.ttf]])
Media:Register("font", "MUNIRG", [[Interface\AddOns\Ferous Media\Fonts\MUNIRG__.ttf]])
Media:Register("font", "SEMPE", [[Interface\AddOns\Ferous Media\Fonts\SEMPE___.ttf]])
Media:Register("font", "SEMPRG", [[Interface\AddOns\Ferous Media\Fonts\SEMPRG__.ttf]])


-- bar textures (statusbar) --

Media:Register("statusbar", "fer01", [[Interface\AddOns\Ferous Media\StatusBars\fer1.tga]])
Media:Register("statusbar", "fer02", [[Interface\AddOns\Ferous Media\StatusBars\fer2.tga]])
Media:Register("statusbar", "fer03", [[Interface\AddOns\Ferous Media\StatusBars\fer3.tga]])
Media:Register("statusbar", "fer04", [[Interface\AddOns\Ferous Media\StatusBars\fer4.tga]])
Media:Register("statusbar", "fer05", [[Interface\AddOns\Ferous Media\StatusBars\fer5.tga]])
Media:Register("statusbar", "fer06", [[Interface\AddOns\Ferous Media\StatusBars\fer6.tga]])
Media:Register("statusbar", "fer07", [[Interface\AddOns\Ferous Media\StatusBars\fer7.tga]])
Media:Register("statusbar", "fer08", [[Interface\AddOns\Ferous Media\StatusBars\fer8.tga]])
Media:Register("statusbar", "fer09", [[Interface\AddOns\Ferous Media\StatusBars\fer9.tga]])
Media:Register("statusbar", "fer10", [[Interface\AddOns\Ferous Media\StatusBars\fer10.tga]])
Media:Register("statusbar", "fer11", [[Interface\AddOns\Ferous Media\StatusBars\fer11.tga]])
Media:Register("statusbar", "fer12", [[Interface\AddOns\Ferous Media\StatusBars\fer12.tga]])
Media:Register("statusbar", "fer13", [[Interface\AddOns\Ferous Media\StatusBars\fer13.tga]])
Media:Register("statusbar", "fer14", [[Interface\AddOns\Ferous Media\StatusBars\fer14.tga]])
Media:Register("statusbar", "fer15", [[Interface\AddOns\Ferous Media\StatusBars\fer15.tga]])
Media:Register("statusbar", "fer16", [[Interface\AddOns\Ferous Media\StatusBars\fer16.tga]])
Media:Register("statusbar", "fer17", [[Interface\AddOns\Ferous Media\StatusBars\fer17.tga]])
Media:Register("statusbar", "fer18", [[Interface\AddOns\Ferous Media\StatusBars\fer18.tga]])
Media:Register("statusbar", "fer19", [[Interface\AddOns\Ferous Media\StatusBars\fer19.tga]])
Media:Register("statusbar", "fer20", [[Interface\AddOns\Ferous Media\StatusBars\fer20.tga]])
Media:Register("statusbar", "fer21", [[Interface\AddOns\Ferous Media\StatusBars\fer21.tga]])
Media:Register("statusbar", "fer22", [[Interface\AddOns\Ferous Media\StatusBars\fer22.tga]])
Media:Register("statusbar", "fer23", [[Interface\AddOns\Ferous Media\StatusBars\fer23.tga]])
Media:Register("statusbar", "fer24", [[Interface\AddOns\Ferous Media\StatusBars\fer24.tga]])
Media:Register("statusbar", "fer25", [[Interface\AddOns\Ferous Media\StatusBars\fer25.tga]])
Media:Register("statusbar", "fer26", [[Interface\AddOns\Ferous Media\StatusBars\fer26.tga]])
Media:Register("statusbar", "fer27", [[Interface\AddOns\Ferous Media\StatusBars\fer27.tga]])
Media:Register("statusbar", "fer28", [[Interface\AddOns\Ferous Media\StatusBars\fer28.tga]])
Media:Register("statusbar", "fer29", [[Interface\AddOns\Ferous Media\StatusBars\fer29.tga]])
Media:Register("statusbar", "fer30", [[Interface\AddOns\Ferous Media\StatusBars\fer30.tga]])
Media:Register("statusbar", "fer31", [[Interface\AddOns\Ferous Media\StatusBars\fer31.tga]])
Media:Register("statusbar", "fer32", [[Interface\AddOns\Ferous Media\StatusBars\fer32.tga]])
Media:Register("statusbar", "fer33", [[Interface\AddOns\Ferous Media\StatusBars\fer33.tga]])
Media:Register("statusbar", "fer34", [[Interface\AddOns\Ferous Media\StatusBars\fer34.tga]])
Media:Register("statusbar", "fer35", [[Interface\AddOns\Ferous Media\StatusBars\fer35.tga]])
Media:Register("statusbar", "fer36", [[Interface\AddOns\Ferous Media\StatusBars\fer36.tga]])
Media:Register("statusbar", "fer37", [[Interface\AddOns\Ferous Media\StatusBars\fer37.tga]])