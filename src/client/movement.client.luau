local defaults = require(game.ReplicatedStorage.Shared.PlayerDefaults)
local userInput = game:GetService('UserInputService')
local TS = game:GetService('TweenService')
local player = game.Players.LocalPlayer
local camera = game.Workspace.CurrentCamera

local interval = 0.5
local cameraTween: Tween? = nil
local sprintTween: Tween? = nil


userInput.InputBegan:Connect(function(input)
    if input.KeyCode == Enum.KeyCode.LeftShift then
        local data: Humanoid = { WalkSpeed = defaults.sprinting.speed, JumpPower = defaults.sprinting.jump }

        if cameraTween then cameraTween:Cancel() end
        if sprintTween then sprintTween:Cancel() end
        cameraTween = TS:Create(camera, TweenInfo.new(interval), {FieldOfView = defaults.sprinting.fov})
        sprintTween = TS:Create(player.Character.Humanoid, TweenInfo.new(interval), data)
        cameraTween:Play()
        sprintTween:Play()
    end
end)

userInput.InputEnded:Connect(function(input)
    if input.KeyCode == Enum.KeyCode.LeftShift then
        local data: Humanoid = { WalkSpeed = defaults.walking.speed, JumpPower = defaults.walking.jump }
        
        if cameraTween then cameraTween:Cancel() end
        if sprintTween then sprintTween:Cancel() end
        
        cameraTween = TS:Create(camera, TweenInfo.new(interval), {FieldOfView = defaults.walking.fov})
        sprintTween = TS:Create(player.Character.Humanoid, TweenInfo.new(interval), data)
        cameraTween:Play()
        sprintTween:Play()
    end
end)