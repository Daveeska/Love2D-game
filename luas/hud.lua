component = {
    actionButton = {
        sprite = love.graphics.newImage("res/sprites/ui/E.png"),
        x=love.graphics.getWidth()/2-(32*4)/2,
        y=750
    },

    sugarCount = invGui(love.graphics.newImage("res/sprites/ui/SugarCount.png"), 1230, 750),
    eggCount = invGui(love.graphics.newImage("res/sprites/ui/EggCount.png"), 1430, 750),
    chcookiesCount = invGui(love.graphics.newImage("res/sprites/ui/chCookieCount.png"), 20, 750),

    --Debugging
    debug = {
    }
    --isColliding = false
}
function component.update(self, player, cam, world)
    --Positions
    self.debug.pos.value.x = player.x
    self.debug.pos.value.y = player.y

    --Current Frame
    self.debug.current_animation.value = player.current_animation.name

    --Camera Scale
    component.debug.cam_scale.value = cam.scale

    --Sugar Count
    self.debug.sugar_count.value = #world.sugars

    --Is Near X
    self.debug.near_collectables.value = player.isCollidingWCollectable
    self.debug.near_factoryarea.value = player.isCollidingWChocolateMakingArea

    --Inventory
    self.debug.invsugar.value = player.inventory.sugars
    self.debug.invegg.value = player.inventory.eggs
    self.debug.invchcookies.value = player.inventory.chcookies
end

function component.draw(self)

    --Debugging
    if self.debug.isRenderingDebugHUD then
        self:drawDebug()
    end

    --Texts
    if self.debug.near_collectables.value then
        love.graphics.draw(self.actionButton.sprite, self.actionButton.x, self.actionButton.y, nil, 4)
    end

    --Sugar Count
    self.sugarCount:draw()
    love.graphics.print(self.debug.invsugar.value, 496+750,838, nil, 2)

    --Egg Count
    self.eggCount:draw()
    love.graphics.print(self.debug.invegg.value, 1446,836, nil, 2)

    --Chocolates Cookies Counts
    self.chcookiesCount:draw()
    love.graphics.print(self.debug.invchcookies.value, 36,838, nil, 2)

end

function component:activateDebug(key)
    if key == "f3" then
        self.debug.isRenderingDebugHUD = not self.debug.isRenderingDebugHUD
    end
end

function component:drawDebug()
    --fps
    love.graphics.print(self.debug.fps.text, self.debug.fps.x, self.debug.fps.y, nil, 2)
    love.graphics.print(tostring(love.timer.getFPS()), self.debug.fps.x+60, self.debug.fps.y, nil, 2)

    --Positition
    love.graphics.print(self.debug.pos.text, self.debug.pos.x,
    self.debug.pos.y, nil, 2)

    love.graphics.print(tostring(math.floor(self.debug.pos.value.x)),
    self.debug.pos.x+100, self.debug.pos.y, nil, 2)
    love.graphics.print(tostring(math.floor(self.debug.pos.value.y)),
    self.debug.pos.x+170, self.debug.pos.y, nil, 2)
    --Current Frame
    love.graphics.print(self.debug.current_animation.text, self.debug.current_animation.x,
    self.debug.current_animation.y, nil, 2)
    love.graphics.print(tostring(self.debug.current_animation.value), self.debug.current_animation.x+190,
    self.debug.current_animation.y, nil, 2)

    --Camera Scale
    love.graphics.print(self.debug.cam_scale.text, self.debug.cam_scale.x,
    self.debug.cam_scale.y, nil, 2)
    love.graphics.print(tostring(math.floor(self.debug.cam_scale.value)), self.debug.cam_scale.x+180,
    self.debug.cam_scale.y, nil, 2)

    --Sugar Count
    love.graphics.print(self.debug.sugar_count.text, self.debug.sugar_count.x,
    self.debug.sugar_count.y, nil, 2)
    love.graphics.print(self.debug.sugar_count.value, self.debug.sugar_count.x+180,
    self.debug.sugar_count.y, nil, 2)

    --Near X
    love.graphics.print(self.debug.near_collectables.text, self.debug.near_collectables.x,
    self.debug.near_collectables.y, nil, 2)
    love.graphics.print(tostring(self.debug.near_collectables.value), self.debug.near_collectables.x+350,
    self.debug.near_collectables.y, nil, 2)

    love.graphics.print(self.debug.near_factoryarea.text, self.debug.near_factoryarea.x,
    self.debug.near_factoryarea.y, nil, 2)
    love.graphics.print(tostring(self.debug.near_factoryarea.value), self.debug.near_factoryarea.x+220,
    self.debug.near_factoryarea.y, nil, 2)

    --Inventory
    --Sugar
    love.graphics.print(self.debug.invsugar.text, self.debug.invsugar.x,
    self.debug.invsugar.y, nil, 2)
    love.graphics.print(self.debug.invsugar.value, self.debug.invsugar.x+150,
    self.debug.invsugar.y, nil, 2)
    --Egg
    love.graphics.print(self.debug.invegg.text, self.debug.invegg.x,
    self.debug.invegg.y, nil, 2)
    love.graphics.print(self.debug.invegg.value, self.debug.invegg.x+150,
    self.debug.invegg.y, nil, 2)
end
