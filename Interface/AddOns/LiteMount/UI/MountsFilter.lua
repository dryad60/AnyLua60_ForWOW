--[[----------------------------------------------------------------------------

  LiteMount/UI/MountsFilter.lua

  Options frame for the mount list.

  Copyright 2011-2020 Mike Battersby

----------------------------------------------------------------------------]]--

local _, LM = ...

local L = LM.Localize


--[[--------------------------------------------------------------------------]]--

LiteMountFilterMixin = {}

function LiteMountFilterMixin:OnLoad()
    LM.UIFilter.RegisterCallback(self, "OnFilterChanged", "Update")
end

function LiteMountFilterMixin:Update()
    if LM.UIFilter.IsFiltered() then
        self.FilterButton.ClearButton:Show()
    else
        self.FilterButton.ClearButton:Hide()
    end
end

function LiteMountFilterMixin:Attach(parent, fromPoint, frame, toPoint, xOff, yOff)
    self:SetParent(parent)
    self:ClearAllPoints()
    self:SetPoint(fromPoint, frame, toPoint, xOff, yOff)
end

--[[--------------------------------------------------------------------------]]--

LiteMountSearchBoxMixin = {}

function LiteMountSearchBoxMixin:OnTextChanged()
    SearchBoxTemplate_OnTextChanged(self)
    LM.UIFilter.SetSearchText(self:GetText())
end

--[[--------------------------------------------------------------------------]]--

LiteMountFilterClearMixin = {}

function LiteMountFilterClearMixin:OnClick()
    LM.UIFilter.Clear()
end

--[[--------------------------------------------------------------------------]]--

LiteMountFilterButtonMixin = {}

function LiteMountFilterButtonMixin:OnClick()
    ToggleDropDownMenu(1, nil, self.FilterDropDown, self, 74, 15)
end

function LiteMountFilterButtonMixin:Initialize(level)
    local info = UIDropDownMenu_CreateInfo()
    info.keepShownOnClick = true

    if level == 1 then
        info.isNotRadio = true

        info.text = COLLECTED
        info.arg1 = "COLLECTED"
        info.checked = function ()
                return LM.UIFilter.IsFlagChecked("COLLECTED")
            end
        info.func = function (_, _, _, v)
                LM.UIFilter.SetFlagFilter("COLLECTED", v)
            end
        UIDropDownMenu_AddButton(info, level)

        info.text = NOT_COLLECTED
        info.arg1 = "NOT_COLLECTED"
        info.checked = function ()
                return LM.UIFilter.IsFlagChecked("NOT_COLLECTED")
            end
        info.func = function (_, _, _, v)
                LM.UIFilter.SetFlagFilter("NOT_COLLECTED", v)
            end
        UIDropDownMenu_AddButton(info, level)

        info.text = MOUNT_JOURNAL_FILTER_UNUSABLE
        info.arg1 = "UNUSABLE"
        info.checked = function ()
                return LM.UIFilter.IsFlagChecked("UNUSABLE")
            end
        info.func = function (_, _, _, v)
                LM.UIFilter.SetFlagFilter("UNUSABLE", v)
            end
        UIDropDownMenu_AddButton(info, level)

        info.text = L.LM_HIDDEN
        info.arg1 = "HIDDEN"
        info.checked = function ()
                return LM.UIFilter.IsFlagChecked("HIDDEN")
            end
        info.func = function (_, _, _, v)
                LM.UIFilter.SetFlagFilter("HIDDEN", v)
            end
        UIDropDownMenu_AddButton(info, level)

        info.checked = nil
        info.func = nil
        info.isNotRadio = nil
        info.hasArrow = true
        info.notCheckable = true

        info.text = L.LM_PRIORITY
        info.value = 1
        UIDropDownMenu_AddButton(info, level)

        info.text = L.LM_FLAGS
        info.value = 2
        UIDropDownMenu_AddButton(info, level)

        info.text = SOURCES
        info.value = 3
        UIDropDownMenu_AddButton(info, level)
    elseif level == 2 then
        info.hasArrow = false
        info.isNotRadio = true
        info.notCheckable = true

        if UIDROPDOWNMENU_MENU_VALUE == 3 then -- Sources
            info.text = CHECK_ALL
            info.func = function ()
                    LM.UIFilter.SetAllSourceFilters(true)
                    UIDropDownMenu_Refresh(self, false, 2)
                end
            UIDropDownMenu_AddButton(info, level)

            info.text = UNCHECK_ALL
            info.func = function ()
                    LM.UIFilter.SetAllSourceFilters(false)
                    UIDropDownMenu_Refresh(self, false, 2)
                end
            UIDropDownMenu_AddButton(info, level)

            info.notCheckable = false

            for i = 1,LM.UIFilter.GetNumSources() do
                if LM.UIFilter.IsValidSourceFilter(i) then
                    info.text = LM.UIFilter.GetSourceText(i)
                    info.arg1 = i
                    info.func = function (_, _, _, v)
                            LM.UIFilter.SetSourceFilter(i, v)
                        end
                    info.checked = function ()
                            return LM.UIFilter.IsSourceChecked(i)
                        end
                    UIDropDownMenu_AddButton(info, level)
                end
            end

        elseif UIDROPDOWNMENU_MENU_VALUE == 2 then -- Flags
            local flags = LM.UIFilter.GetFlags()

            info.text = CHECK_ALL
            info.func = function ()
                    LM.UIFilter:SetAllFlagFilters(true)
                    UIDropDownMenu_Refresh(self, false, 2)
                end
            UIDropDownMenu_AddButton(info, level)

            info.text = UNCHECK_ALL
            info.func = function ()
                    LM.UIFilter:SetAllFlagFilters(false)
                    UIDropDownMenu_Refresh(self, false, 2)
                end
            UIDropDownMenu_AddButton(info, level)

            info.notCheckable = false

            for _,f in ipairs(flags) do
                info.text = LM.UIFilter.GetFlagText(f)
                info.arg1 = f
                info.func = function (_, _, _, v)
                        LM.UIFilter.SetFlagFilter(f, v)
                    end
                info.checked = function ()
                        return LM.UIFilter.IsFlagChecked(f)
                    end
                UIDropDownMenu_AddButton(info, level)
            end
        elseif UIDROPDOWNMENU_MENU_VALUE == 1 then -- Priority
            local priorities = LM.UIFilter.GetPriorities()

            info.text = CHECK_ALL
            info.func = function ()
                    LM.UIFilter:SetAllPriorityFilters(true)
                    UIDropDownMenu_Refresh(self, false, 2)
                end
            UIDropDownMenu_AddButton(info, level)

            info.text = UNCHECK_ALL
            info.func = function ()
                    LM.UIFilter:SetAllPriorityFilters(false)
                    UIDropDownMenu_Refresh(self, false, 2)
                end
            UIDropDownMenu_AddButton(info, level)

            info.notCheckable = false

            for _,p in ipairs(priorities) do
                info.text = LM.UIFilter.GetPriorityText(p)
                info.arg1 = p
                info.func = function (_, _, _, v)
                        LM.UIFilter.SetPriorityFilter(p, v)
                    end
                info.checked = function ()
                        return LM.UIFilter.IsPriorityChecked(p)
                    end
                UIDropDownMenu_AddButton(info, level)
            end

        end
    end
end

function LiteMountFilterButtonMixin:OnLoad()
    UIDropDownMenu_Initialize(self.FilterDropDown, self.Initialize, "MENU")
end
