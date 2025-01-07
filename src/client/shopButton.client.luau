local player = game.Players.LocalPlayer
print(player.Name)

local Shop: ScreenGui = player.PlayerGui:WaitForChild('Shop')

local MainGui: ScreenGui = player.PlayerGui:FindFirstChild('MainGui')

local ShopButton: TextButton = MainGui:FindFirstChild('ShopButton')

ShopButton.MouseButton1Click:Connect(function()
    Shop.Enabled = true
    print('opened shop')
end)