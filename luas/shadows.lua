local Lighter = require('luas.libraries.lighter')
local world = require('luas.world')

local shadows = {
    lighter = Lighter(),
    lightCanvas = love.graphics.newCanvas(love.graphics.getDimensions())
}

shadows.light = shadows.lighter:addLight(500,500, 10000, 1, 1, 1)


function shadows:load()
    for i in ipairs(world.sWalls) do
        shadows.lighter:addPolygon(world.sWalls[i])
    end
end

-- Call after your light positions have been updated
function shadows:preDrawLights()
  love.graphics.setCanvas({ self.lightCanvas, stencil = true})
  love.graphics.clear(0.4, 0.4, 0.4) -- Global illumination level
  shadows.lighter:drawLights()
  love.graphics.setCanvas()
end

-- Call after you have drawn your scene (but before UI)
function shadows:drawLights()
  love.graphics.setBlendMode("multiply", "premultiplied")
  love.graphics.draw(self.lightCanvas)
  love.graphics.setBlendMode("alpha")
end

function shadows:update()
    self:preDrawLights()

    local lX, lY = 100,100
    self.lighter:updateLight(self.light, lX, lY)

end

return shadows
