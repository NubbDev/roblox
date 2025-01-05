local workspace = game:GetService("Workspace") :: Workspace
local part1: Part? = workspace:WaitForChild("MyPart")
local playersTouchingPart: {string} = {}

local function isPlayer(part: BasePart): boolean
    return part.Parent:IsA("Model") and part.Parent:FindFirstChild("Humanoid") ~= nil
end

if part1 ~= nil then
    part1.Touched:Connect(function(otherPart)
        local index = table.find(playersTouchingPart, otherPart.Parent)
        print(index)
        if isPlayer(otherPart) and index ~= nil then
            table.insert(playersTouchingPart, otherPart.Parent)
        end
    end)
    part1.TouchEnded:Connect(function(otherPart)
        if isPlayer(otherPart) then
            local index = table.find(playersTouchingPart, otherPart.Parent)
            if index then
                table.remove(playersTouchingPart, index)
            end
        end
    end)
end

game.Players.PlayerAdded:Connect(function(player)
    print("Player joined the diddy party: " .. player.Name)
end)