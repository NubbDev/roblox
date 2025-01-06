local Functions = {}

Functions.isPlayer = function(part: BasePart): boolean
    return part.Parent:IsA("Model") and part.Parent:FindFirstChild("Humanoid") ~= nil
end


return Functions