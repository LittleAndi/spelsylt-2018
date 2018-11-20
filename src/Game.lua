Game = { stuff = {} }

function Game:new()
    o = {}
    setmetatable(o, self)
    self.__index = self

    self.stuff = {}

    return o
end

function Game:update(dt)
    for i=1, #self.stuff do
        self.stuff[i]:update(dt)
    end
end

function Game:draw()
    love.graphics.print("Current FPS: "..tostring(love.timer.getFPS( )), 10, 10)

    for i=1, #self.stuff do
        self.stuff[i]:draw()
    end
end

function Game:add(stuff)
    self.stuff[#self.stuff + 1] = stuff
end

return Game