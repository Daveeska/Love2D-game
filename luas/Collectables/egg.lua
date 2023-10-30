function newEgg(x,y)
    return {
        sprite = love.graphics.newImage("res/sprites/Eggs.png"),
        x=x,
        y=y,

        width = 14,
        height = 26,

        id = 1,
        draw = function (self)
            love.graphics.draw(self.sprite, self.x, self.y)
        end,
    }
end
