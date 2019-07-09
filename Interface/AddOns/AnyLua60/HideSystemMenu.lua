local dummy=function() end
MicroButtonAndBagsBar:Hide();
MicroButtonAndBagsBar.Show = dummy
CharacterMicroButton:ClearAllPoints()
CharacterMicroButton:SetPoint("CENTER",UIParent,"BOTTOMRIGHT",-275,-20)
CharacterMicroButton.SetPoint = dummy
