local functions = require(game.ReplicatedStorage.Shared.Functions)

type CallbackFunction = (player: Player, part: BasePart) -> ()

type DebounceHandler = {
    playersTouching: {[number]: boolean},
    playersCooldown: {[number]: any},
    cooldown: number,
    run: (part: BasePart) -> (),
    callback: CallbackFunction
}

local function DebounceHandler(cooldown: number, callback: CallbackFunction): DebounceHandler
    local instance: DebounceHandler = {
        playersTouching = {},
        playersCooldown = {},
        cooldown = cooldown,
        callback = callback,
    }

    function instance:run(part: BasePart)
        if functions.isPlayer(part) then
            local player = game.Players:GetPlayerFromCharacter(part.Parent)
            local userId = player.UserId

            if self.playersTouching[userId] and self.playersCooldown[userId] then
                task.cancel(self.playersCooldown[userId])
                self.playersCooldown[userId] = task.delay(cooldown, function()
                    self.playersTouching[userId] = nil
                    self.playersCooldown[userId] = nil
                end)
                return
            end

            if self.playersTouching[userId] == nil then
                self.playersTouching[userId] = true
                self.playersCooldown[userId] = task.delay(cooldown, function()
                    self.playersTouching[userId] = nil
                    self.playersCooldown[userId] = nil
                end)
                self.callback(player, part)
            end
        end
    end
    return instance
end

return DebounceHandler