local userInput = game:GetService('UserInputService')
local players = game:GetService('Players')
local player = game.Players.LocalPlayer
local sprintSpeed = 32
local walkSpeed = 16
local sprintJump = 75
local walkJump = 50
userInput.InputBegan:Connect(function(input)
    if input.KeyCode == Enum.KeyCode.LeftShift then
        player.Character.Humanoid.WalkSpeed = sprintSpeed
        player.Character.Humanoid.JumpPower = sprintJump
    end
end)

userInput.InputEnded:Connect(function(input)
    if input.KeyCode == Enum.KeyCode.LeftShift then
        player.Character.Humanoid.WalkSpeed = walkSpeed
        player.Character.Humanoid.JumpPower = walkJump
    end
end)