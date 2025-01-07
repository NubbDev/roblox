local player = game.Players.LocalPlayer

local Shop: ScreenGui = player.PlayerGui:WaitForChild('Shop')

local ShopFrame: Frame = Shop:FindFirstChild('ShopFrame')
local Exit: TextButton = ShopFrame:FindFirstChild('Exit')

Exit.MouseButton1Click:Connect(function()
    Shop.Enabled = false
end)