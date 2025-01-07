local sellPoint: Part = game.Workspace:WaitForChild("SellPoint")
local touchpoint: Part = sellPoint:FindFirstChild("Part")
local functions = require(game.ReplicatedStorage.Shared.Functions)
local cooldown = 1
local playersTouching = {}
local playersCooldown = {}
touchpoint.Touched:Connect(function(part)
    if functions.isPlayer(part) then
        local player = game.Players:GetPlayerFromCharacter(part.Parent)
        local userId = player.UserId

        if playersTouching[userId] and playersCooldown[userId] then
            task.cancel(playersCooldown[userId])
            playersCooldown[userId] = task.delay(cooldown, function()
                playersTouching[userId] = nil
                playersCooldown[userId] = nil
            end)
            return
        end

        if playersTouching[userId] == nil then
            playersTouching[userId] = true
            playersCooldown[userId] = task.delay(cooldown, function()
                playersTouching[userId] = nil
            end)
            print("Player touched the sell point")
            local stats: Folder = player:FindFirstChild("leaderstats")
            local views: IntValue = stats:FindFirstChild("Views")
            local racks: IntValue = stats:FindFirstChild("Racks")
            print(racks, views)
            print(racks.Value, views.Value)
            racks.Value += views.Value * 10
            views.Value = 0
            print(racks.Value, views.Value)
        end
    end
end)