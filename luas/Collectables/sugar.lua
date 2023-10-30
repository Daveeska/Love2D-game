function newSugar(x,y)
    return {
        sprite = love.graphics.newImage("res/sprites/Sugar.png"),
        x=x,
        y=y,

        height = 33,
        width = 37,

        id = 0,
        draw = function (self)
            love.graphics.draw(self.sprite, self.x, self.y)
        end,
    }
end
