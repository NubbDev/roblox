local ReplicatedStorage = game:GetService("ReplicatedStorage")
local shared = ReplicatedStorage:WaitForChild("Shared")
local Functions = require(shared:WaitForChild("Functions")) :: {
    isPlayer: (part: BasePart) -> boolean
}

local part1: Part? = workspace:WaitForChild("MyPart")
local playersTouchingPart: {string} = {}

game.Players.PlayerAdded:Connect(function(player)
    print("Player joined the diddy party: " .. player.Name)
end)




-- saltys part rq

game:GetService('Players').PlayerAdded:Connect(function(player)
    local deaths = 0
    player.CharacterAdded:Connect(function(character)
        local humanoid = character:WaitForChild('Humanoid')
        humanoid.Died:Connect(function()
            deaths += 1
            print(player.Name .. ' got packed up ' .. deaths .. ' times')
            
        end)
    end)
end)