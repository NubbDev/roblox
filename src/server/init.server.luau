local ReplicatedStorage = game:GetService("ReplicatedStorage")
local shared = ReplicatedStorage:WaitForChild("Shared")
local Functions = require(shared:WaitForChild("Functions")) :: {
    isPlayer: (part: BasePart) -> boolean
}

local part = Instance.new("")

local part1: Part? = workspace:WaitForChild("MyPart")
local playersTouchingPart: {string} = {}

local function handleDamage(player: Player, damage: number) 
    local humanoid: Humanoid? = player:FindFirstChild("Humanoid")
    if humanoid then
        humanoid.Health = humanoid.Health - damage
    end
end

local function handlePartTouch(otherPart: BasePart)
    if Functions.isPlayer(otherPart) then
        print("Touch began!")
        local Player: Player = otherPart.Parent
        if not part1:GetAttribute("Touched") then
            part1:SetAttribute("Touched", true)
            local index: number? = table.find(playersTouchingPart, Player.Name)
            if not index then
                table.insert(playersTouchingPart, Player.Name)
                local storedIndex = table.find(playersTouchingPart, Player.Name)
                handleDamage(Player, 10)
                task.delay(1, function()
                    table.remove(playersTouchingPart, storedIndex)
                    part1:SetAttribute("Touched", false)
                end)
            end
        end
    end
end

if part1 ~= nil then
    part1.Touched:Connect(handlePartTouch)
    -- part1.Touched:Connect(function(otherPart)
    --     if Functions.isPlayer(otherPart) then
    --         local player: Player = otherPart.Parent
    --         local index: number? = table.find(playersTouchingPart, player.Name)
    --         if (index == nil) then
    --             table.insert(playersTouchingPart, player.Name)
    --             print(player.Name .. " is touching the part!")
    --             print("Players touching the part: " .. #playersTouchingPart)
    --             print("Players touching the part: " .. table.concat(playersTouchingPart, ", "))
    --         end
    --     end
    -- end)
    -- part1.TouchEnded:Connect(function(otherPart)
    --     if Functions.isPlayer(otherPart) then
    --         local player: Player = otherPart.Parent
    --         local index: number? = table.find(playersTouchingPart, player.Name)
    --         if (index == nil) then
    --             table.remove(playersTouchingPart, index)
    --             print(player.Name .. " is not touching the part!")
    --             print("Players touching the part: " .. #playersTouchingPart)
    --             print("Players touching the part: " .. table.concat(playersTouchingPart, ", "))
    --         end
    --     end
    -- end)
end

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