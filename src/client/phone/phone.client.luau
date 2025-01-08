local userInput = game:GetService('UserInputService')
local player = game.Players.LocalPlayer
local defaults = require(game.ReplicatedStorage.Shared.PlayerDefaults)
local state = require(player.PlayerScripts.Client.phone.state)
local updateViews: RemoteEvent = game.ReplicatedStorage.Events.UpdateViews

while not player.Backpack:FindFirstChild("Phone") do
    task.wait(0.001)
end

local phone: Tool = player.Backpack:WaitForChild("Phone")
local streamGUI: ScreenGui = player.PlayerGui:WaitForChild("StartRecording")
local spaceBarGui: ScreenGui = player.PlayerGui:WaitForChild("SpaceBarGame")

local streamFrame: Frame = streamGUI:FindFirstChild("Frame")
local recordButton: TextButton = streamFrame:FindFirstChild("RecordButton")

local spaceBarFrame: Frame = spaceBarGui:FindFirstChild("GameFrame")
local spaceBarBackground: Frame = spaceBarFrame:FindFirstChild("Background")
local safeZone: Frame = spaceBarFrame:FindFirstChild("GreenBar")
local spaceBar: Frame = spaceBarFrame:FindFirstChild("BlueBar")

local function setPlayerMovement(walk: number, jump: number)
    player.Character.Humanoid.WalkSpeed = walk
    player.Character.Humanoid.JumpPower = jump
end

local function reset()
    setPlayerMovement(defaults.walking.speed, defaults.walking.jump)
    state:endGame()
end

state.safeZonePos = {
    min = spaceBarBackground.Position.X.Scale,
    max = (spaceBarBackground.Position.X.Scale + spaceBarBackground.Size.X.Scale) - safeZone.Size.X.Scale,
}

state.spaceBarPos = {
    min = spaceBarBackground.Position.X.Scale,
    max = (spaceBarBackground.Position.X.Scale + spaceBarBackground.Size.X.Scale) - spaceBar.Size.X.Scale,
}

local function handleGame()
    state.randomIncrease = math.random(state.randomIncreaseLimits[1], state.randomIncreaseLimits[2]) / 10000
    state.randomSafeZone = math.random(
        math.floor(state.safeZonePos.min * 10000),
        math.floor(state.safeZonePos.max * 10000)
    ) / 10000
    safeZone.Position = UDim2.new(state.randomSafeZone, 0, safeZone.Position.Y.Scale, 0)
    while state.recording do
        state:handleGame(spaceBar, safeZone)
    end
    spaceBarGui.Enabled = false
end

recordButton.MouseButton1Click:Connect(function()
    state.recording = true
    streamGUI.Enabled = false
    local timeDelay = 0.5
    task.delay(timeDelay, function()
        spaceBarGui.Enabled = true
        setPlayerMovement(0, 0)
    end)
    task.wait(timeDelay)
    task.delay(10, function()
        reset()
        if state.phoneEquipped then
            streamGUI.Enabled = true
        end
    end)
    task.spawn(handleGame)
end)

phone.Equipped:Connect(function()
    streamGUI.Enabled = true
    state.phoneEquipped = true
    state:endGame()
end)

phone.Unequipped:Connect(function()
    streamGUI.Enabled = false
    state.phoneEquipped = false
    reset()
end)

userInput.InputBegan:Connect(function(input)
    if state.recording and (input.KeyCode == Enum.KeyCode.Space or input.KeyCode == Enum.KeyCode.ButtonA) then
        if state.currentPos.min <= state.currentSafeZone.max and state.currentPos.max >= state.currentSafeZone.min then
            state.switch = true
            updateViews:FireServer()
            print("You hit the green zone!")
        else
            print("You missed!")
        end
    end
end)
