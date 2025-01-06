local ReplicatedStorage = game:GetService('ReplicatedStorage')
local shared = ReplicatedStorage:WaitForChild('Shared')

-- print(shared)
local brianSteeleCase = require(shared:WaitForChild('freeThugger'))

-- print(brianSteeleCase.thugsParole)