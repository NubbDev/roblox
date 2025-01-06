local player = game.Players.LocalPlayer
local randomIncreaseLimits = {75, 475}
while not player.Backpack:FindFirstChild("Phone") do
    task.wait(0.001)
end
local phone: Tool = player.Backpack:WaitForChild("Phone")
local streamGUI: ScreenGui = player.PlayerGui:WaitForChild("StartRecording")
local spaceBarGui: ScreenGui = player.PlayerGui:WaitForChild("SpaceBarGame")

local streamFrame: Frame = streamGUI:WaitForChild("Frame")
local recordButton: TextButton = streamFrame:WaitForChild("RecordButton")

local spaceBarFrame: Frame = spaceBarGui:FindFirstChild("GameFrame")
local spaceBarBackground: Frame = spaceBarFrame:FindFirstChild("Background")
local safeZone: Frame = spaceBarFrame:FindFirstChild("GreenBar")
local spaceBar: Frame = spaceBarFrame:FindFirstChild("BlueBar")

local recording = false
local phoneEquipped = false

local function handleGame()
    local spaceBarForward = true
    local spaceBarForwardPrevious = true
    local randomIncrease = math.random(randomIncreaseLimits[1], randomIncreaseLimits[2]) / 10000
    local uiSize = {
        x = spaceBarBackground.Size.X.Offset,
        y = spaceBarBackground.Size.Y.Offset
    }
    -- local safeZonePos = {
    --     maxX = spaceBarBackground.Position.X.Offset,
    --     minX = safeZone.Position.X.Offset,
    -- }
    local spaceBarPos = {
        min = spaceBarBackground.Position.X.Scale,
        max = spaceBarBackground.Position.X.Scale + spaceBarBackground.Size.X.Scale,
    }

    while recording do
        print(randomIncrease)
        local currentSpaceBarPos = {
            min = spaceBar.Position.X.Scale,
            max = spaceBar.Position.X.Scale + spaceBar.Size.X.Scale,
        }

        if spaceBarForward then
            if currentSpaceBarPos.max < spaceBarPos.max - randomIncrease then
                spaceBar.Position = UDim2.new(spaceBar.Position.X.Scale + randomIncrease, 0, spaceBar.Position.Y.Scale, 0)
            else
                spaceBarForward = false
            end
        else
            if currentSpaceBarPos.min > spaceBarPos.min + randomIncrease then
                spaceBar.Position = UDim2.new(spaceBar.Position.X.Scale - randomIncrease, 0, spaceBar.Position.Y.Scale, 0)
            else
                spaceBarForward = true
            end
        end

        if spaceBarForwardPrevious ~= spaceBarForward then
            spaceBarForwardPrevious = spaceBarForward
            randomIncrease = math.random(randomIncreaseLimits[1], randomIncreaseLimits[2]) / 10000
        end

        task.wait(0.01)
    end
    spaceBarGui.Enabled = false
end

recordButton.MouseButton1Click:Connect(function()
    recording = true
    streamGUI.Enabled = false
    local timeDelay = 0.5
    task.delay(timeDelay, function()
        spaceBarGui.Enabled = true
    end)
    task.wait(timeDelay)
    task.delay(1000, function()
        recording = false
        if phoneEquipped then
            streamGUI.Enabled = true
        end
    end)
    task.spawn(handleGame)
end)

phone.Equipped:Connect(function()
    streamGUI.Enabled = true
    phoneEquipped = true
    recording = false
end)

phone.Unequipped:Connect(function()
    streamGUI.Enabled = false
    phoneEquipped = false
    recording = false
end)

