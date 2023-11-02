local hitbox = {

    x=0,
    y=0,

    width = 30,
    height = 30,

    sprite = love.graphics.newImage("res/sprites/HitBox.png"),
}

function hitbox:draw()
    love.graphics.draw(self.sprite, self.x, self.y, nil, 2.2)
end

function hitbox:update(dt, player)
    self.x = player.x-28
    self.y = player.y+15
end

return hitbox
