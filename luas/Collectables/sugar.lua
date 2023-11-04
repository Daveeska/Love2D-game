function newSugar(x,y)
    return {
        sprite = loadpurpleimg("res/sprites/Sugar.png"),
        x=x,
        y=y,

        height = 33*.7,
        width = 27*.7,

        id = 0,
        draw = function (self)
            love.graphics.draw(self.sprite, self.x, self.y, nil, .7)
        end,
    }
end
