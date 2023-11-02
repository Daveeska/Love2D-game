local camera = require('luas.libraries.camera')
local cam = camera()
cam.scale = 2.3

function cam:update()
    local player = require("luas.player")
    local world = require("luas.world")

    --Camera system
    self:lookAt(player.x, player.y)

    local w = love.graphics.getWidth()
    local h = love.graphics.getHeight()

    if self.x < w / 2 / self.scale then
        self.x = w / 2 / self.scale
    end

    if self.y < h / 2 / self.scale then
        self.y = h / 2 / self.scale
    end

    local mapW = world.Maps.ca.width * world.Maps.ca.tilewidth
    local mapH = world.Maps.ca.height * world.Maps.ca.tileheight

    if self.x > (mapW - w / 2 / self.scale) then
        self.x = (mapW - w / 2 / self.scale)
    end

    if self.y > (mapH - h / 2 / self.scale) then
        self.y = (mapH - h / 2 / self.scale)
    end
end

return cam
