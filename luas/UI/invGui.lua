function invGui(sprite, x, y)
    return {
        sprite=sprite,
        x=x,
        y=y,
        draw = function()
            love.graphics.draw(sprite, x, y, nil, 4)
        end
    }
end
