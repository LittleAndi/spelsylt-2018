Santa = {
    animations = {},
    currentTime = 0,
    currentAnimation = 1,
    currentTime = 0,
    duration = 1.0,
    currentDirection = 1
}

function Santa:new(o)
    o = o or {}
    setmetatable(o, self)
    self.__index = self

    self.animations = {}
    self.animations[1] = self:addAnimationSprite('assets/santa/idle%03d.png', 16)
    self.animations[2] = self:addAnimationSprite('assets/santa/run%03d.png', 11)
    self.animations[3] = self:addAnimationSprite('assets/santa/jump%03d.png', 16)
    self.animations[4] = self:addAnimationSprite('assets/santa/dead%03d.png', 17)
    self.animations[5] = self:addAnimationSprite('assets/santa/walk%03d.png', 13)
    self.animations[6] = self:addAnimationSprite('assets/santa/slide%03d.png', 11)
    self.currentAnimation = 1
    self.duration = 1.0
    self.currentDirection = 1

    return o
end

function Santa:walk(newDirection)
    self.currentAnimation = 5
    self.duration = 0.5
    self.currentDirection = newDirection
end

function Santa:run(newDirection)
    self.currentAnimation = 2
    self.duration = 0.3
    self.currentDirection = newDirection
end

function Santa:stop()
    self.currentAnimation = 1
    self.duration = 1.0
end

function Santa:addAnimationSprite(path, imageCount)
    local animationSprite = {}
    animationSprite.quads = {}
    
    for i=0, imageCount-1 do
        print(string.format(path, i))
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
end

function Santa:draw()    
    local animationSprite = self.animations[self.currentAnimation]
    local spriteNum = math.floor(self.currentTime / self.duration * #animationSprite.quads) + 1
    if (self.animations[self.currentAnimation].quads[spriteNum] ~= nil) then
        love.graphics.draw(self.animations[self.currentAnimation].quads[spriteNum], 100, 100)
    end
end

return Santa