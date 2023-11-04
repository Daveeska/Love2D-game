local anim8 = require("luas.libraries.anim8.anim8")
local pLib = require("luas.physics")
local world = require("luas.world")
local UI = require("luas.UI")

require("globalfunc")

local player = {
    x = 0,
    y = 0,

    width = 23,
    height = 30,

    scale = 2,

    speed = 200,

    animations = {},
    inventory = {
        sugars = 0,
        eggs = 0,
        chcookies = 0
    },

    hitbox = require("luas.player.hitbox"),
    camera = require("luas.player.camera"),

    --Debug Information
    isCollidingWCollectable = false,
    isCollidingWChocolateMakingArea = false
}

--Animations
player.spriteSheet = loadpurpleimg("res/sprites/player-sheet.png")
player.grid = anim8.newGrid(15, 30, player.spriteSheet:getDimensions())

player.time_between_frames = 0.13

player.animations.down = {
    anim = anim8.newAnimation(player.grid('1-5', 1), player.time_between_frames),
    name = "down"
}

player.animations.left = {
    anim = anim8.newAnimation(player.grid('1-3', 2), player.time_between_frames),
    name = "left"
}
player.animations.up = {
    anim = anim8.newAnimation(player.grid('1-5', 3), player.time_between_frames),
    name = "up"
}
player.animations.right = {
    anim = anim8.newAnimation(player.grid('1-3', 4), player.time_between_frames),
    name = "right"
}

player.current_animation = player.animations.left

--Collider
player.collider = pLib.newBSGRecCollider(14, 460, player.width, player.height, 5)
player.collider:setFixedRotation(true)

--Shadows
local box = {
    x = player.x,
    y = player.y,
    width = 23,
    height = 55
}

function box:update()
    box.x, box.y = player.x - 7, player.y - 13
    player.shadow = boxToPolygon(box)
end

player.shadow = boxToPolygon(box)

function player:update(dt)
    self:control(dt)
    self:animate(dt)
    self:collide()

    box:update()

    --Hitbox
    self.hitbox:update(dt, self)

    self.x = self.collider:getX() - 4
    self.y = self.collider:getY() - 24
end

local function index(t, val)
    for i, v in ipairs(t) do
        if v == val then
            return i
        end
    end

    return nil
end

function player:collide()
    self.isCollidingWCollectable = false
    self.isCollidingWChocolateMakingArea = false

    --Sugars
    for _, obj in ipairs(world.sugars) do
        if pLib.collideWith(self, obj) then
            self.isCollidingWCollectable = true
            self:take(obj, "sugars")
        end
    end
    --Eggs
    for _, obj in ipairs(world.eggs) do
        if pLib.collideWith(self, obj) then
            self.isCollidingWCollectable = true
            self:take(obj, "eggs")
        end
    end
    if pLib.collideWith(self, world.Maps.ca.layers["ChocolateArea"].objects[1]) then
        self.isCollidingWChocolateMakingArea = true
    end
end

function player:makeChocolate(key)
    if key == "e" and self.isCollidingWChocolateMakingArea then
        if self.inventory.sugars >= 10 and self.inventory.sugars >= 4 then
            self.inventory.sugars = self.inventory.sugars - 10
            self.inventory.eggs = self.inventory.eggs - 4
            self.inventory.chcookies = self.inventory.chcookies + 1
        end
    end
end

function player:take(obj, item)
    if love.keyboard.isDown("e") then
        self.inventory[item] = self.inventory[item] + 1
        table.remove(world[item], index(world[item], obj))
    end
end

function player.animate(self, dt)
    local isMoving = false

    if love.keyboard.isDown("w") then
        self.current_animation = self.animations.up
        isMoving = true
    end

    if love.keyboard.isDown("a") then
        self.current_animation = self.animations.left
        isMoving = true
    end

    if love.keyboard.isDown("s") then
        self.current_animation = self.animations.down
        isMoving = true
    end

    if love.keyboard.isDown("d") then
        self.current_animation = self.animations.right
        isMoving = true
    end

    --Checking if frame is standing still or animating
    if isMoving == false then
        self.current_animation.anim:gotoFrame(1)
    end

    self.current_animation.anim:update(dt)
end

local function bool_to_number(value)
    return value and 1 or 0
end

local function normalize(vector)
    local magnitude = 0

    -- Calculate the magnitude of the vector
    for i = 1, #vector do
        magnitude = magnitude + vector[i] * vector[i]
    end
    magnitude = math.sqrt(magnitude)

    -- Normalize the vector only if its magnitude is greater than 1
    if magnitude > 1 then
        for i = 1, #vector do
            vector[i] = vector[i] / magnitude
        end
    end

    return vector
end

function player.control(self, dt)
    local inputX = bool_to_number(love.keyboard.isDown("d")) - bool_to_number(love.keyboard.isDown("a"))
    local vx = inputX * self.speed * dt
    local inputY = bool_to_number(love.keyboard.isDown("w")) - bool_to_number(love.keyboard.isDown("s"))
    local vy = inputY * self.speed * -1 * dt

    local normalizedVector = normalize({ vx, vy })

    self.collider:setLinearVelocity(normalizedVector[1] * self.speed, normalizedVector[2] * self.speed)
end

function player.draw(self)
    if UI.isDebugging then
        love.graphics.rectangle("fill", box.x, box.y, box.width, box.height)
    end
    self.current_animation.anim:draw(self.spriteSheet, self.x, self.y, nil, self.scale, nil, 6, 9)
end

return player
