math.randomseed(os.time())
require("luas.player")

function love.load()
    camera = require('luas.libraries.camera')
    cam = camera()
    cam.scale = 2.3

    require('luas.world')
    require('luas.hud')
end

function love.wheelmoved(x, y)
    if component.debug.isRenderingDebugHUD == true then
        if y > 0 then
            cam.scale = cam.scale + 0.1
        elseif y < 0 then
            cam.scale = cam.scale - 0.1
        end
    end
end

function love.keypressed(key)
    if key == "f3" and component.debug.isRenderingDebugHUD == false then
        component.debug.isRenderingDebugHUD = true
    elseif key == "f3" and component.debug.isRenderingDebugHUD == true then
        component.debug.isRenderingDebugHUD = false
    end
end

function love.update(dt)
    Player:update(dt)
    rWorld:update(dt)

    --Camera system
    cam:lookAt(Player.x, Player.y)

    local w = love.graphics.getWidth()
    local h = love.graphics.getHeight()

    if cam.x < w / 2 / cam.scale then
        cam.x = w / 2 / cam.scale
    end

    if cam.y < h / 2 / cam.scale then
        cam.y = h / 2 / cam.scale
    end

    local mapW = rWorld.Maps.ca.width * rWorld.Maps.ca.tilewidth
    local mapH = rWorld.Maps.ca.height * rWorld.Maps.ca.tileheight

    if cam.x > (mapW - w / 2 / cam.scale) then
        cam.x = (mapW - w / 2 / cam.scale)
    end

    if cam.y > (mapH - h / 2 / cam.scale) then
        cam.y = (mapH - h / 2 / cam.scale)
    end

    component:update(Player, cam, rWorld)
end

function love.draw()
    cam:attach()
    rWorld:draw()
    Player:draw()
    if component.debug.isRenderingDebugHUD == true then
        pWorld:draw()
    end
    cam:detach()
    component:draw()
end
