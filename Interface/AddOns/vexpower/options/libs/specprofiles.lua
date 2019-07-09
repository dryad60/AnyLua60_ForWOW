function vexpower.options.specProfiles.getSpecDesc(spec)
	local returnvalue = ""
	local specnumber = ""
	local specActive = tostring(GetActiveSpecGroup(false, false))
	if spec == "A" then specnumber = "1"
	elseif spec == "B" then specnumber = "2"
	elseif spec == "C" then specnumber = "3"
	else specnumber = "4"
	end
	
	if GetSpecializationInfo(specnumber) ~= nil then
		returnvalue = 'For this class spec '..specnumber..' is: '..vexpower.options.specProfiles.getSpecName(specnumber)
	else
		returnvalue = 'For this class spec '..specnumber..' is '..vexpower.options.specProfiles.getSpecName(specnumber)
	end
	if specActive == specnumber then returnvalue = returnvalue..'". This spec is currently active.' end

	return returnvalue
end

function vexpower.options.specProfiles.getSpecName(id)
	local returnvalue = ""
	if GetSpecializationInfo(id) ~= nil then
		returnvalue = select(2 ,GetSpecializationInfo(id))
	else
		returnvalue = "not available"
	end
	return returnvalue
end
