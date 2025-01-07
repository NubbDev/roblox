local DataStoreService = game:GetService('DataStoreService')

local myStore = DataStoreService:GetDataStore('myStore')

game.Players.PlayerAdded:Connect(function(player)
    local stats = Instance.new("Folder")
    stats.Name = "leaderstats"
    
    local views = Instance.new("IntValue")
    views.Name = "Views"
    
    local currency = Instance.new("IntValue")
    currency.Name = "Racks"

    local totalViews = Instance.new("IntValue")
    totalViews.Name = "TotalViews"

    totalViews.Parent = stats
    views.Parent = stats
    currency.Parent = stats
    stats.Parent = player


    local data
    local success, errorMessage = pcall(function()

        data = myStore:GetAsync(player.UserId..'-racks')
    end)

    if success then
        data = player.leaderstats.Racks.Value
        print('loaded sucessfully, '..player.Name..' racks are '..data)

    else
        print('Data was NOT retreived')
        warn(errorMessage)
    end
end)


game.Players.PlayerRemoving:Connect(function(player)

    local success, errorMessage = pcall(function()
        myStore:SetAsync(player.UserId..'-racks', player.leaderstats.Racks.Value)--save data

    end)

    if success then
        local racks = myStore:GetAsync(player.UserId..'-racks')

        print('Data successfully saved.')
        print('racks are '..racks)

    else
        print('Player data not saved.')
        warn(errorMessage)
    end
    task.wait(2)
end)