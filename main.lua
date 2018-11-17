function love.load()
    sprites = {}
    sprites[1] = newAnimation('assets/santa/idle%03d.png', 16, 1.0, 200, 50, 0)
    sprites[2] = newAnimation('assets/santa/run%03d.png', 11, 0.5, 200, 150, 0)
    sprites[3] = newAnimation('assets/santa/jump%03d.png', 16, 1.0, 200, 250, -100)
    sprites[4] = newAnimation('assets/santa/dead%03d.png', 17, 1.0, 200, 350, 0)
    sprites[5] = newAnimation('assets/santa/walk%03d.png', 13, 0.5, 200, 450, 0)
    sprites[6] = newAnimation('assets/santa/slide%03d.png', 11, 0.5, 200, 550, 0)
end

function love.update(dt)
    if (love.keyboard.isDown("escape")) then
        os.exit(0)
    end
    
    for i=1, #sprites do
        updateAnimation(sprites[i], dt)
    end
end

function updateAnimation(animation, dt)
    animation.currentTime = animation.currentTime + dt
    if animation.currentTime >= animation.duration then
        animation.currentTime = animation.currentTime - animation.duration
    end

    animation.y = animation.ybase + math.sin((animation.currentTime / animation.duration) * math.pi) * animation.ymotion
end

function love.draw()
    for i=1, #sprites do
        drawAnimation(sprites[i])
    end
end

function drawAnimation(animation)
    local spriteNum = math.floor(animation.currentTime / animation.duration * #animation.quads) + 1
    if (animation.quads[spriteNum] ~= nil) then
        love.graphics.draw(animation.quads[spriteNum], animation.x, animation.y)
    end
end

function newAnimation(path, images, duration, ybase, xbase, ymotion)
    local animation = {}
    animation.quads = {}
    animation.ybase = ybase
    animation.y = animation.ybase
    animation.x = xbase
    animation.ymotion = ymotion

    for i=0, images-1 do
        table.insert(animation.quads, love.graphics.newImage(string.format(path, i)))
    end

    animation.currentTime = 0
    animation.duration = duration or 1

    return animation
end