local module = {
    recording = false,
    phoneEquipped = false,
    switch = false,
    spaceBarForward = true,
    spaceBarForwardPrevious = true,
    randomIncrease = 0,
    randomSafeZone = 0,
    randomIncreaseLimits = {75, 100}, --475
    safeZonePos = {
        min = 0,
        max = 0,
    },
    spaceBarPos = {
        min = 0,
        max = 0,
    },
    currentPos = {
        min = 0,
        max = 0,
    },
    currentSafeZone = {
        min = 0,
        max = 0,
    },
}
function module:handleGame(bar, zone)
    self.currentPos = {
        min = bar.Position.X.Scale,
        max = bar.Position.X.Scale + bar.Size.X.Scale,
    }
    self.currentSafeZone = {
        min = zone.Position.X.Scale,
        max = zone.Position.X.Scale + zone.Size.X.Scale,
    }
    if self.spaceBarForward then
        if self.currentPos.max < self.spaceBarPos.max - self.randomIncrease then
            bar.Position = UDim2.new(bar.Position.X.Scale + self.randomIncrease, 0, bar.Position.Y.Scale, 0)
        else
            self.spaceBarForward = false
        end
    else
        if self.currentPos.min > self.spaceBarPos.min + self.randomIncrease then
            bar.Position = UDim2.new(bar.Position.X.Scale - self.randomIncrease, 0, bar.Position.Y.Scale, 0)
        else
            self.spaceBarForward = true
        end
    end

    if self.switch then
        self.randomIncrease = math.random(self.randomIncreaseLimits[1], self.randomIncreaseLimits[2]) / 10000
        self.randomSafeZone = math.random(
            math.floor(self.safeZonePos.min * 10000),
            math.floor(self.safeZonePos.max * 10000)
        ) / 10000

        zone.Position = UDim2.new(self.randomSafeZone, 0, zone.Position.Y.Scale, 0)
        self.switch = false
    end
    task.wait(0.01)
end

function module:endGame()
    self.recording = false
end
type moduleType = typeof(module)

return module