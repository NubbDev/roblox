
game.Players.PlayerAdded:Connect(function(player)
    print("Player joined the diddy party: " .. player.Name)
end)

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