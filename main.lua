Game = require('src.Game')
Santa = require('src.Santa')

local game = {}

function love.load()
    width, height = love.graphics.getDimensions( )

    game = Game.new()

    local s = Santa.new()
    game.objects.santa = s;
end

function love.update(dt)
    if (love.keyboard.isDown("escape")) then
        os.exit(0)
    end

    if (love.keyboard.isDown("right")) then
        game.objects.santa:run(1)
    end

    if (love.keyboard.isDown("left")) then
        game.objects.santa:run(-1)
    end

    game:update(dt)
end

function love.keyreleased(key, scancode)
    if (scancode == "right") then
        game.objects.santa:stop()
    end

    if (scancode == "left") then
        game.objects.santa:stop()
    end
end

function love.keypressed(key, scancode)
    if (scancode == "up") then
        game.objects.santa:jump()
    end
end

function love.draw()
    game:draw()
end