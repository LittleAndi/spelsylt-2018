Game = require('src.Game')
Santa = require('src.Santa')

function love.load()
    width, height = love.graphics.getDimensions( )

    print("load")

    game = Game:new()

    local s = Santa:new(nil)
    game:add(s)
end

function love.update(dt)
    if (love.keyboard.isDown("escape")) then
        os.exit(0)
    end

    if (love.keyboard.isDown("right")) then
        Santa:run(1)
    end

    if (love.keyboard.isDown("left")) then
        Santa:run(-1)
    end

    game:update(dt)
end

function love.keyreleased(key, scancode)
    if (scancode == "right") then
        Santa:stop()
    end

    if (scancode == "left") then
        Santa:stop()
    end
end

function love.draw()
    game:draw()
end