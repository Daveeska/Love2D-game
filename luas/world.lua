wf = require('luas/libraries/windfield')
pWorld = wf.newWorld(0, 0)
sti = require('luas.libraries/sti')

--Collectables
sgr = require('luas.Collectables.sugar')
egg = require('luas.Collectables.egg')

function pWorld.updateall(dt)
    pWorld:update(dt)
end

function pWorld.drawall()
    pWorld:draw()
end

--rWorld System
rWorld = {
    --bg=love.graphics.newImage('res/sprites/background.png');
    Maps = {
        ca = sti('res/maps/world.lua'),
    },
    walls = {},

    sugars = {},
    eggs = {}
}

if rWorld.Maps.ca.layers["CollectableArea"] and rWorld.Maps.ca.layers["CollectableArea"].objects then
    for i, obj in pairs(rWorld.Maps.ca.layers["CollectableArea"].objects) do
        local probability = math.random(4)
        if probability == 1 then
            local sugar = newSugar(obj.x, obj.y)
            table.insert(rWorld.sugars, sugar)
        end
        if probability == 2 then
            local egg = newEgg(obj.x, obj.y)
            table.insert(rWorld.eggs, egg)
        end
    end
end

if rWorld.Maps.ca.layers["cWalls"] and rWorld.Maps.ca.layers["cWalls"].objects then
    for i, obj in pairs(rWorld.Maps.ca.layers["cWalls"].objects) do
        local wall = pWorld:newRectangleCollider(obj.x, obj.y, obj.width, obj.height)
        wall:setType('static')
        table.insert(rWorld.walls, wall)
    end
end

function rWorld:update(dt)
    pWorld:update(dt)
end

function rWorld:draw()
    rWorld.Maps.ca:drawLayer(rWorld.Maps.ca.layers["Ground"])
    rWorld.Maps.ca:drawLayer(rWorld.Maps.ca.layers["Paths"])
    for _, obj in ipairs(rWorld.sugars) do
        obj:draw()
        if component.debug.isRenderingDebugHUD then
            love.graphics.rectangle("line", obj.x, obj.y, obj.width, obj.height)
        end
    end
    for _, obj in ipairs(rWorld.eggs) do
        obj:draw()
        if component.debug.isRenderingDebugHUD then
            love.graphics.rectangle("line", obj.x, obj.y, obj.width, obj.height)
        end
    end
    rWorld.Maps.ca:drawLayer(rWorld.Maps.ca.layers["Floor"])
    rWorld.Maps.ca:drawLayer(rWorld.Maps.ca.layers["Walls"])
end
