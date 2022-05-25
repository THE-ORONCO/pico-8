pico-8 cartridge // http://www.pico-8.com
version 36
__lua__
-- vector maths
-- BY THE_ORONCO

--[[**
    Calculates the normalized version of the vector. The vector needs to be in the form of a table containing only numerical values.
    vec: Table<*,number>
    returns: Table<*,number> vector with the length 1 pointing in the same direction as the given vector 
]]
function normalize(vec)
    local factor = 1/length(vec)
    local collector = {}
    for key,val in pairs(vec) do
        collector[key] = factor * val
    end

    return collector
end

--[[**
    Calculates the length of a given vector. The vector needs to be in the form of a table containing only numerical values.
    vec: Table<*,number>
    returns: number length of the given vector 
]]
function length(vec)
    local collector = 0
    for key, val in pairs(vec) do
        collector += val*val
    end

    return sqrt(collector)
end