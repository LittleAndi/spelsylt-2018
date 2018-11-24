local Santa = {
    animations = {},
    currentTime = 0,
    currentAnimation = 1,
    currentTime = 0,
    duration = 1.0,
    direction = 1,
    posX = 100,
    posY = 400,
    jumpBaseY = 0,
    isJumping = false,
    jumpTime = 0,
    speedX = 0.0,
    speedY = 0.0
}

function Santa.new()
    local santa = Santa;

    santa.animations = {}
    santa.animations[1] = santa:addAnimationSprite('assets/santa/idle%03d.png', 16)
    santa.animations[2] = santa:addAnimationSprite('assets/santa/run%03d.png', 11)
    santa.animations[3] = santa:addAnimationSprite('assets/santa/jump%03d.png', 16)
    santa.animations[4] = santa:addAnimationSprite('assets/santa/dead%03d.png', 17)
    santa.animations[5] = santa:addAnimationSprite('assets/santa/walk%03d.png', 13)
    santa.animations[6] = santa:addAnimationSprite('assets/santa/slide%03d.png', 11)
    santa.currentAnimation = 1
    santa.currentTime = 0
    santa.duration = 1.0
    santa.direction = 1
    santa.posX = 100
    santa.posY = 200
    santa.jumpBaseY = 0
    santa.isJumping = false
    santa.jumpTime = 0
    santa.speedX = 0.0
    santa.speedY = 0.0

    print('new')

    return santa
end

function Santa:walk(newDirection)
    if self.isJumping == false then
        self.currentAnimation = 5
    end
    self.duration = 0.5
    self.direction = newDirection
    self.speedX = 200.0
end

function Santa:run(newDirection)
    if self.isJumping == false then
        self.currentAnimation = 2
    end
    self.duration = 0.3
    self.direction = newDirection
    self.speedX = 400.0
end

function Santa:jump()
    if self.isJumping == false then
        self.currentAnimation = 3
        self.speedY = 100.0
        self.jumpTime = 0.0
        self.jumpBaseY = self.posY
        self.isJumping = true
    end
end

function Santa:land()
    self.currentAnimation = 1
    self.speedY = 0.0
    self.jumpTime = 0.0
    self.isJumping = false
end

function Santa:stop()
    self.currentAnimation = 1
    self.duration = 1.0
    self.speedX = 0.0
end

function Santa:addAnimationSprite(path, imageCount)
    local animationSprite = {}
    animationSprite.quads = {}
    
    for i=0, imageCount-1 do
        --print(string.format(path, i))
        table.insert(animationSprite.quads, love.graphics.newImage(string.format(path, i)))
    end

    animationSprite.currentTime = 0    
    return animationSprite
end

function Santa:update(dt)
    self.currentTime = self.currentTime + dt
    if self.currentTime >= self.duration then
        self.currentTime = self.currentTime - self.duration
    end

    self.posX = self.posX + self.direction * self.speedX * dt

    if self.isJumping then
        self.jumpTime = self.jumpTime + dt
        self.posY = self.jumpBaseY - math.floor(math.sin(self.jumpTime * math.pi) * self.speedY)
        if (self.posY >= self.jumpBaseY) then
            Santa:land()
        end
    end
end

function Santa:draw()    
    local animationSprite = self.animations[self.currentAnimation]
    
    local spriteNum = 0

    if self.isJumping then
        spriteNum = math.floor(self.jumpTime / 1.0 * #animationSprite.quads) + 1    
    else
        spriteNum = math.floor(self.currentTime / self.duration * #animationSprite.quads) + 1
    end

    if (animationSprite.quads[spriteNum] ~= nil) then
        love.graphics.draw(animationSprite.quads[spriteNum], self.posX, self.posY)
    end

    love.graphics.print("Pos X: "..tostring(self.posX), 10, 30)
    love.graphics.print("Pos Y: "..tostring(self.posY), 10, 50)
    love.graphics.print("Is jumping: "..tostring(self.isJumping), 10, 70)
    love.graphics.print("JumpBase Y: "..tostring(self.jumpBaseY), 10, 90)
    love.graphics.print("Current ani: "..tostring(self.currentAnimation), 10, 110)

end

return Santa