local function debugItem(text, value)
    return {
        text = text,
        value = value,
    }
end

local debugVar = {
    fps = debugItem("FPS: ", 0),

    posX = debugItem("Pos(x): ", 0),
    posY = debugItem("Pos(y): ", 0),

    cam_scale = debugItem("Camera Scale: ", 1),
    current_animation = debugItem("Current Frame: ", ""),

    sugar_count = debugItem("Total Sugar: ", 0),
    egg_count = debugItem("Total Egg: ", 0),

    invsugar = debugItem("Inv.Sugar: ", 0),
    invegg = debugItem("Inv.egg: ", 0),
    invchcookies = debugItem("Inv.chcookies: ", 0),

    near_collectables = debugItem("Is Colliding With Collectable: ", false),
    near_factoryarea = debugItem("Is Inside Factory: ", false),

    total_walls = debugItem("Total Walls: ", 22),
    total_shadow_walls = debugItem("Total Shadows Walls: ", 99)
}

function debugVar:update()
    local plr = require("luas.player")
    local wrld = require("luas.world")
    local lighter = require("luas.shadows")

    self.fps.value = love.timer.getFPS()

    self.posX.value = math.floor(plr.x)
    self.posY.value = math.floor(plr.y)

    self.current_animation.value = plr.current_animation.name

    self.cam_scale.value = plr.camera.scale

    self.sugar_count.value = #wrld.sugars
    self.egg_count.value = #wrld.eggs

    self.near_collectables.value = plr.isCollidingWCollectable
    self.near_factoryarea.value = plr.isCollidingWChocolateMakingArea

    self.invsugar.value = plr.inventory.sugars
    self.invegg.value = plr.inventory.eggs
    self.invchcookies.value = plr.inventory.chcookies

    self.total_walls.value = #wrld.walls
    self.total_shadow_walls.value = #lighter.lighter.polygons
end

function debugVar:draw()
    local num = 1
    for i, obj in pairs(debugVar) do
        if type(obj) == "table" then
            love.graphics.print(obj.text .. tostring(obj.value), 0, num * 20-20, nil, 2)
            if num % 5 == 0 then
                num = num + 3
            else
                num = num + 1
            end
        end
    end
end

return debugVar
