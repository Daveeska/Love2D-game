math.randomseed(os.time())

love.graphics.setDefaultFilter("nearest", "nearest")

local player = require("luas.player")
local world = require('luas.world')
local UI = require('luas.UI')
local pLib = require('luas.physics')
local cam = require('luas.player.camera')
local shadows = require('luas.shadows')

function love.load()
    world:load()
    shadows:load()
end

function love.wheelmoved(x, y)
    if UI.debugVar.isRenderingDebugHUD == true then
        if y > 0 then
            cam.scale = cam.scale + 0.1
        elseif y < 0 then
            cam.scale = cam.scale - 0.1
        end
    end
end

function love.keypressed(key)
    UI:activateDebug(key)
    player:makeChocolate(key)
end

function love.update(dt)
    player:update(dt)
    world:update(dt)

    shadows:update()

    cam:update()

    pLib.updateCollider(dt)

    UI:update()
end

function love.draw()
    shadows.lighter:addPolygon(player.shadow)
    cam:attach()
        world:draw()
        player:draw()

        shadows:drawLights()
        shadows.lighter:drawLights()

        if UI.isDebugging then
            pLib.drawCollider()
        end

    cam:detach()

    UI:draw()
    shadows.lighter:removePolygon(player.shadow)
end
