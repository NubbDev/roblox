local player = game.Players.LocalPlayer

local Racks : IntValue = player.leaderstats.Racks
local Views : IntValue = player.leaderstats.Views



local PlayerStats : ScreenGui = player.PlayerGui:WaitForChild('PlayerStats')
local StatFrame: Frame = PlayerStats:WaitForChild('StatFrame')
local MoneyStats: TextLabel = StatFrame:WaitForChild('MoneyStats')
local ViewStats: TextLabel = StatFrame:WaitForChild('ViewStats')


MoneyStats.Text = 'Racks: '.. Racks.Value
ViewStats.Text = 'Views: '.. Views.Value


Racks:GetPropertyChangedSignal('Value'):Connect(function()
    MoneyStats.Text = 'Racks: '.. Racks.Value

end)

Views:GetPropertyChangedSignal('Value'):Connect(function()
    ViewStats.Text = 'Views: '.. Views.Value

end)