local ReplicatedStorage = game.ReplicatedStorage
local ReplicatedPlayers = ReplicatedStorage:WaitForChild("Player")
local ItemsList = ReplicatedPlayers:WaitForChild("Items")

local player = game.Players.LocalPlayer
while not player.Backpack:FindFirstChild("Phone") do
    task.wait(0.001)
end
local streamGUI = player.PlayerGui:WaitForChild("StartRecording")
local phone: Tool = player.Backpack:WaitForChild("Phone")

phone.Equipped:Connect(function()
    streamGUI.Enabled = true
end)

phone.Unequipped:Connect(function()
    streamGUI.Enabled = false
end)