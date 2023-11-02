--Tiled functionality
local sti = require('luas.libraries/sti')

--Collectables
require('luas.Collectables.sugar')
require('luas.Collectables.egg')

local pLib = require('luas.physics')
local UI = require('luas.UI')

--world System
local world = {
    --bg=love.graphics.newImage('res/sprites/background.png');
    Maps = {
        ca = sti('res/maps/world.lua'),
    },
    walls = {},

    sugars = {},
    eggs = {}
}

function world:reSpawnCollectables()
    if world.Maps.ca.layers["CollectableArea"] and world.Maps.ca.layers["CollectableArea"].objects then
        for i, obj in pairs(world.Maps.ca.layers["CollectableArea"].objects) do
            local probability = math.random(4)
            if probability == 1 then
                local sugar = newSugar(obj.x, obj.y)
                table.insert(world.sugars, sugar)
            end
            if probability == 2 then
                local egg = newEgg(obj.x, obj.y)
                table.insert(world.eggs, egg)
            end
        end
    end
end


function world:load()
    world:reSpawnCollectables()

    if world.Maps.ca.layers["cWalls"] and world.Maps.ca.layers["cWalls"].objects then
        for i, obj in pairs(world.Maps.ca.layers["cWalls"].objects) do
            local wall = pLib.newRecCollider(obj.x, obj.y, obj.width, obj.height)
            wall:setType('static')
            table.insert(world.walls, wall)
        end
    end
end

local timer=0
function world:update(dt)
    if #self.sugars <= 5 or #self.eggs <= 3 then
        timer=timer+dt
        if timer>=8.5 then
            self:reSpawnCollectables()
        end
    end
end

function drawCollectablesCollider()
    for _, obj in ipairs(world.sugars) do
        obj:draw()
        if UI.isDebugging then
            love.graphics.rectangle("line", obj.x, obj.y, obj.width, obj.height)
        end
    end
    for _, obj in ipairs(world.eggs) do
        obj:draw()
        if UI.isDebugging then
            love.graphics.rectangle("line", obj.x, obj.y, obj.width, obj.height)
        end
    end
end

function world:draw()
    world.Maps.ca:drawLayer(world.Maps.ca.layers["Ground"])
    world.Maps.ca:drawLayer(world.Maps.ca.layers["Paths"])
    world.Maps.ca:drawLayer(world.Maps.ca.layers["Floor"])
    world.Maps.ca:drawLayer(world.Maps.ca.layers["Walls"])
    drawCollectablesCollider()

end

return world
