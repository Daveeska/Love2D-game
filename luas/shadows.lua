local Lighter = require('luas.libraries.lighter')
local world = require('luas.world')

local shadows = {
    lighter = Lighter(),
    lightCanvas = love.graphics.newCanvas(love.graphics.getDimensions())
}

shadows.worldLight = shadows.lighter:addLight(0, 0, 3000, 0.43, 0.482, 0.223, 1)
--shadows.r1light = shadows.lighter:addLight(0, 0, 300, 1, 1, 1)


function shadows:load()
    for i in ipairs(world.sWalls) do
        shadows.lighter:addPolygon(world.sWalls[i])
    end
end

-- Call after your worldLight positions have been updated
function shadows:preDrawLights()
    love.graphics.setCanvas({ self.lightCanvas, stencil = true })
    love.graphics.clear(0.4, 0.4, 0.4) -- Global illumination level
    self.lighter:drawLights()
    love.graphics.setCanvas()
end

-- Call after you have drawn your scene (but before UI)
function shadows:drawLights()
    love.graphics.setBlendMode("multiply", "premultiplied")
    love.graphics.draw(self.lightCanvas)
    love.graphics.setBlendMode("alpha")
end

function shadows:update()
    self.lighter:updateLight(self.worldLight, 0, 0)
    --self.r1light:updateLight(self.r1light, 4, 450)
    self:preDrawLights()
end

return shadows
