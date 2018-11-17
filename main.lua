function love.load()
    santa = {}
    santa.sprites = {}    
    santa.sprites[1] = newAnimation('assets/santa/idle%03d.png', 16, 1.0, 200, 50, 0)
    santa.sprites[2] = newAnimation('assets/santa/run%03d.png', 11, 0.5, 200, 150, 0)
    santa.sprites[3] = newAnimation('assets/santa/jump%03d.png', 16, 1.0, 200, 250, -100)
    santa.sprites[4] = newAnimation('assets/santa/dead%03d.png', 17, 1.0, 200, 350, 0)
    santa.sprites[5] = newAnimation('assets/santa/walk%03d.png', 13, 0.5, 200, 450, 0)
    santa.sprites[6] = newAnimation('assets/santa/slide%03d.png', 11, 0.5, 200, 550, 0)
    santa.x = 50
    santa.y = 400
    santa.xmotion = 0
    santa.ymotion = 0
    santa.rotation = 0
    santa.direction = 1
end

function love.update(dt)
    if (love.keyboard.isDown("escape")) then
        os.exit(0)
    end

    if (love.keyboard.isDown("right")) then
        santa.xmotion = 3
        santa.direction = 1
    end

    if (love.keyboard.isDown("left")) then
        santa.xmotion = -3
        santa.direction = -1
    end

    for i=1, #santa.sprites do
        updateAnimation(santa.sprites[i], dt)
    end
end

function updateAnimation(animation, dt)
    animation.currentTime = animation.currentTime + dt
    if animation.currentTime >= animation.duration then
        animation.currentTime = animation.currentTime - animation.duration
    end

    animation.y = animation.ybase + math.sin((animation.currentTime / animation.duration) * math.pi) * animation.ymotion

    animation.x = animation.x + santa.xmotion;
end

function love.keyreleased(key, scancode)
    if (scancode == "right" and santa.xmotion > 0) then
        santa.xmotion = 0
    end

    if (scancode == "left" and santa.xmotion < 0) then
        santa.xmotion = 0
    end
end

function love.draw()
    for i=1, #santa.sprites do
        drawAnimation(santa.sprites[i])
    end
end

function drawAnimation(animation)
    local spriteNum = math.floor(animation.currentTime / animation.duration * #animation.quads) + 1
    if (animation.quads[spriteNum] ~= nil) then
        love.graphics.draw(animation.quads[spriteNum], animation.x, animation.y, santa.rotation * math.pi, santa.direction, 1)
    end
end

function newAnimation(path, images, duration, ybase, xbase, ymotion)
    local animation = {}
    animation.quads = {}
    animation.ybase = ybase
    animation.y = animation.ybase
    animation.x = xbase
    animation.ymotion = ymotion
    animation.xmotion = 0

    for i=0, images-1 do
        table.insert(animation.quads, love.graphics.newImage(string.format(path, i)))
    end

    animation.currentTime = 0
    animation.duration = duration or 1

    return animation
end