local function debugItem(text, x, y, value)
    return {
        text=text,
        value=value,
        x=x,
        y=y
    }
end

local debugVar= {
    fps=debugItem("FPS: ", 0,0, 0),
    pos=debugItem("Pos(x,y):       ,", 0,20,{x=0,y=0}),
    current_animation=debugItem("Current Frame: ",0,40,""),
    cam_scale=debugItem("Camera Scale: ", 0,60,1),
    sugar_count=debugItem("Total Sugar: ", 0,80,0),
    near_collectables=debugItem("Is Colliding With Collectable: ", 0,100,false),
    invsugar=debugItem("Inv.Sugar: ", 0, 120,0),
    invegg=debugItem("Inv.egg: ", 0, 140,0),
    invchcookies=debugItem("Inv.chcookies: ", 0,140,0),
    near_factoryarea=debugItem("Is Inside Factory: ", 0,180,false),
}

function debugVar:update()
    local plr = require("luas.player")
    local wrld = require("luas.world")

    self.pos.value.x = plr.x
    self.pos.value.y = plr.y

    self.current_animation.value = plr.current_animation.name

    self.cam_scale.value = plr.camera.scale

    self.sugar_count.value = #wrld.sugars

    self.near_collectables.value = plr.isCollidingWCollectable
    self.near_factoryarea.value = plr.isCollidingWChocolateMakingArea

    self.invsugar.value = plr.inventory.sugars
    self.invegg.value = plr.inventory.eggs
    self.invchcookies.value = plr.inventory.chcookies
end

function debugVar:draw()
    for i, obj in pairs(debugVar) do
        love.graphics.print(obj.text, obj.x, obj.y)
    end
end

return debugVar
