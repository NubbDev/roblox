local updateViews: RemoteEvent = game.ReplicatedStorage.Events.UpdateViews

updateViews.OnServerEvent:Connect(function(player)
    local stats: Folder = player:FindFirstChild("leaderstats")
    local views: IntValue = stats:FindFirstChild("Views")
    local totalViews: IntValue = stats:FindFirstChild("TotalViews")

    views.Value += 1
    totalViews.Value += 1
end)