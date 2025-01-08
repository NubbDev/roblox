local sellPoint: Part = game.Workspace:WaitForChild("SellPoint")
local touchpoint: Part = sellPoint:FindFirstChild("Part")
local debounceHandler = require(game.ReplicatedStorage.Shared.TouchingDebounce)(0.5, function(player)
    print("Player touched the sell point");
    local stats: Folder = player:FindFirstChild("leaderstats")
    local views: IntValue = stats:FindFirstChild("Views")
    local racks: IntValue = stats:FindFirstChild("Racks")
    racks.Value += views.Value * 10
    views.Value = 0
end)
touchpoint.Touched:Connect(function(part)
    debounceHandler:run(part)
end)