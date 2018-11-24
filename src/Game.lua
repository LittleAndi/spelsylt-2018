local Game = {
    objects = {}
}

function Game.new()
    local game = Game;
    return game;
end

function Game:update(dt)
    for _,o in pairs(self.objects) do
        o:update(dt)
    end
end

function Game:draw()
    love.graphics.print("Current FPS: "..tostring(love.timer.getFPS( )), 10, 10)

    for _,o in pairs(self.objects) do
        o:draw()
    end
end

function Game:add(object)
    table.insert(self.objects, object)
end

return Game