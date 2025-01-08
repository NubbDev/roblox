local TweenService = game:GetService('TweenService')

local player = game.Players.LocalPlayer
local camera = workspace.CurrentCamera

local ShopCam = workspace:WaitForChild('ShopCam')

local BlickBelt: Model = workspace:WaitForChild('BlickBelt')
local primary = BlickBelt.PrimaryPart

local blickCount = 8
local currentBlick = 1

local Shop: ScreenGui = player.PlayerGui:WaitForChild('Shop')
local LeftButton:TextButton = Shop:FindFirstChild('LeftButton')
local RightButton:TextButton = Shop:FindFirstChild('RightButton')
local ShopFrame: Frame = Shop:FindFirstChild('ShopFrame')
local BlickSelect: TextButton = ShopFrame:WaitForChild('BlickSelect')

BlickSelect.MouseButton1Click:Connect(function()
    print('BLICKY')
    Shop.ShopFrame.Visible = false
    LeftButton.Visible = true
    RightButton.Visible = true

    LeftButton.Interactable = true
    RightButton.Interactable = true


    camera.CameraType = Enum.CameraType.Scriptable
    camera.CFrame = ShopCam.CFrame

    LeftButton.MouseButton1Click:Connect(function()
        if currentBlick == 1 then
            print('FIrst item cant go back')
        
        else
            local tweenInfo:TweenInfo = TweenInfo.new(1)
            local target:table = {CFrame = primary.CFrame - Vector3.new(12,0,0)}
            local tween:Tween = TweenService:Create(primary, tweenInfo, target)
            tween:Play()
            currentBlick -= 1
        end

        
    end)

    RightButton.MouseButton1Click:Connect(function()
        if currentBlick == 8 then
            print('Last Item cant go forward')
        else
            local tweenInfo:TweenInfo = TweenInfo.new(1)
            local target:table = {CFrame = primary.CFrame + Vector3.new(12,0,0)}
            local tween:Tween = TweenService:Create(primary, tweenInfo, target)
            tween:Play()
            currentBlick += 1
        end
        
    end)



    
end)

