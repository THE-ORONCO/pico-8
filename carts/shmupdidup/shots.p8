pico-8 cartridge // http://www.pico-8.com
version 36
__lua__
-- shots
-- BY THE_ORONCO

SHOT_HIGHT = 8

--[[**
    Draw the postion/state of the given shot depending on its internal state.

    TODO: add an age so that shots can fade away depending on their age

    shot: Table<*, number>
]]
function draw_shot(shot)
    spr(shot.sprite, shot.x, shot.y)
end

--[[**
    Draw the postion/state of all shots depending on their internal state.
]]
function draw_shots()
    foreach(shots, draw_shot)
end

--[[**
    Update the postion/state of the given shot depending on its internal state.

    TODO: add an age so that shots can fade away depending on their age

    shot: Table<*, number>
]]
function update_shot(shot)
    if shot.update == nil then
        shot.x = shot.x + shot.dx * shot.speed
        shot.y = shot.y + shot.dy * shot.speed
    else 
        shot.update()
    end
end

--[[**
    Update the postion/state of all shots depending on their internal state.
]]
function update_shots()
    foreach(shots, update_shot)
    -- TODO: handle shot deletion during updates with age and stuff
    -- TODO: remove shots outside of limits
end



--[[**
    Add a shot into the total shot list. If there are already the max amount of shots saved the oldes one will be overridden.
    shot: Table<*, number>
]]
function add_shot(shot)
    shots[shots.slot] = shot
    shots.slot = (shots.slot + 1) % shots.max
end

shots = {
    ["max"] = 10000,
    ["limits"] = {
        ["top"] = 0-SHOT_HIGHT,
        ["bottom"] = 128,
        ["left"] = 0-SHOT_HIGHT,
        ["right"] = 128,
    },
    ["draw"] = draw_shots,
    ["slot"] = 0,
    ["update"] = update_shots,
    ["add"] = add_shot,
}