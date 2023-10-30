local anim8 = require("luas.libraries.anim8.anim8")
local world = require("luas.world")
local lphysics = require("luas.lphysics")
local chocolatecookies = require("luas.foods.ChocoCookies")

love.graphics.setDefaultFilter("nearest", "nearest")

Player = {
    x=0,
    y=0,

    width=23,
    height=30,

    scale=2,

    speed=200,

    animations = {},
    inventory = {
        sugars = 0,
        eggs = 0
    },

    --Debug Information
    isCollidingWCollectable=false
}

--Animations
Player.spriteSheet = love.graphics.newImage('res/sprites/player-sheet.png');
Player.grid = anim8.newGrid(15,30,Player.spriteSheet:getDimensions())

Player.time_between_frames = 0.13

Player.animations.down = {
    anim= anim8.newAnimation(Player.grid('1-5', 1), Player.time_between_frames),
    name="down"
}

Player.animations.left = {
    anim=anim8.newAnimation(Player.grid('1-3', 2), Player.time_between_frames),
    name="left"
}
Player.animations.up = {
    anim=anim8.newAnimation(Player.grid('1-5', 3), Player.time_between_frames),
    name="up"
}
Player.animations.right = {
    anim=anim8.newAnimation(Player.grid('1-3', 4), Player.time_between_frames),
    name="right"
}

Player.current_animation = Player.animations.left

--Collider
Player.collider = pWorld:newBSGRectangleCollider(14,460,Player.width,Player.height,5)
Player.collider:setFixedRotation(true)

function Player:update(dt)
    self:control(dt)
    self:animate(dt)
    self:collide()

    self.x = self.collider:getX()-4
    self.y = self.collider:getY()-24
end

local function index(t, val)
  for i, v in ipairs(t) do
    if v == val then
      return i
    end
  end

  return nil
end


function Player:collide()
    self.isCollidingWCollectable=false
    --Sugars
    for _,obj in ipairs(rWorld.sugars) do
        if collideWith(self, obj) then
            self.isCollidingWCollectable=true
            self:take(obj, "sugars")
        end
    end
    --Eggs
    for _,obj in ipairs(rWorld.eggs) do
        if collideWith(self, obj) then
            self.isCollidingWCollectable=true
            self:take(obj, "eggs")
        end
    end
    --[[
    if collideWith(self, rWorld.Maps.ca.layers["ChocolateArea"].objects[1]) then
        if key=="E" then
            self:makeChocolate()
        end
    end
    --]]
end

function Player:makeChocolate()
end

function Player:take(obj, item)
    if love.keyboard.isDown("e") then
        self.inventory[item] = self.inventory[item] + 1
        table.remove(rWorld[item], index(rWorld[item], obj))
    end
end

function Player.animate(self, dt)
    local isMoving=false

    if love.keyboard.isDown("w") then
        self.current_animation = self.animations.up
        isMoving=true
    end

    if love.keyboard.isDown("a") then
        self.current_animation = self.animations.left
        isMoving=true
    end

    if love.keyboard.isDown("s") then
        self.current_animation = self.animations.down
        isMoving=true
    end

    if love.keyboard.isDown("d") then
        self.current_animation = self.animations.right
        isMoving=true
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

function Player.control(self, dt)
    local inputX = bool_to_number(love.keyboard.isDown("d")) - bool_to_number(love.keyboard.isDown("a"))
    local vx = inputX * self.speed * dt
    local inputY = bool_to_number(love.keyboard.isDown("w")) - bool_to_number(love.keyboard.isDown("s"))
    local vy = inputY * self.speed * -1 * dt

    local normalizedVector = normalize({vx, vy})

    self.collider:setLinearVelocity(normalizedVector[1] * self.speed, normalizedVector[2] * self.speed)
end

function Player.draw(self)
    self.current_animation.anim:draw(self.spriteSheet, self.x, self.y, nil, self.scale, nil, 6, 9)
end
