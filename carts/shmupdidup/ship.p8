pico-8 cartridge // http://www.pico-8.com
version 36
__lua__
-- Ship object and fuctions
-- BY THE_ORONCO

SHIP_SPR_NEUTRAL = 0
SHIP_SPR_LEFT = 1
SHIP_SPR_RIGHT = 2
SHIP_HEIGHT = 8
SHIP_SHOT_FOLLOW = 0.1

--[[**
    Shoot a normal shot by adding it to the shots list.
    bullet: Table<*,number>
]]
function shoot_normal()
    shots.add({
            ["x"] = ship.x+2, 
            ["y"] = ship.y-4, 
            ["dx"] = ship.dx * SHIP_SHOT_FOLLOW ,
            ["dy"] = min(-1 + ship.dy * SHIP_SHOT_FOLLOW , -1),
            ["sprite"] = 64,
            ["speed"] = 3
        })
end

--[[**
    Moves the vector in the direction of the normalized vector. The vector needs to be in the form of a table containing only numerical values.
    vec: Table<*,number>
]]
function move(vec)
    -- restrict the ship movement to the given limits
    ship.dx = vec.x*ship.speed
    local newX = ship.x + ship.dx
    if (newX < ship.limits.left) newX = ship.limits.left
    if (newX > ship.limits.right) newX = ship.limits.right
    ship.x = newX
    
    ship.dy = vec.y*ship.speed
    local newY = ship.y + ship.dy
    if (newY < ship.limits.top) newY = ship.limits.top
    if (newY > ship.limits.bottom) newY = ship.limits.bottom
    ship.y = newY

    -- choos the apropriate movement sprite for the given move direction
    if     vec.x == 0 then ship.sprites.ship = SHIP_SPR_NEUTRAL
    elseif vec.x > 0  then ship.sprites.ship = SHIP_SPR_RIGHT
    else                   ship.sprites.ship = SHIP_SPR_LEFT end

end

--[[**
    Draws the ship and all its components.
]]
function draw_ship()
    -- TODO: make thrust a trail instead of a sprite
    spr(ship.sprites.thrust, ship.x - ship.dx, ship.y - ship.dy + SHIP_HEIGHT - 2)
    spr(ship.sprites.ship, ship.x, ship.y)
    -- change to the next sprite in the thrust animation
    local nextThrustNumber = (((ship.sprites.thrust - 16 ) + 1) % 6) + 16
    ship.sprites.thrust = nextThrustNumber
end

--[[**
    Updates the ships internal state and all its components by 1 cycle.
]]
function update_ship()
    
end

ship = {
    ["x"]=64, 
    ["y"]=64,
    ["dx"] = 0,
    ["dy"] = 0,
    ["sprites"] = {
        ["thrust"] = 16,
        ["ship"] = 0,
    },
    ["draw"] = draw_ship,
    ["update"] = update_ship,
    ["shoot"] = {
        ["normal"] = shoot_normal
    },
    ["speed"] = 2,
    ["move"] = move,
    ["limits"] = {
        ["top"] = 0,
        ["bottom"] = 128 - SHIP_HEIGHT,
        ["left"] = 0,
        ["right"] = 128 - SHIP_HEIGHT,
    },
}