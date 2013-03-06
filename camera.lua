require("math")
local math = math

module("camera")do

local last = {}

function load(x, y, ang)
    last.x = x
    last.y = y
    last.ang = ang
end

function getCamSpot(ang, x, y)
    local localmagicnumber = 70
    local angmagicnumber = 0.05
--TODO: Verificar se travada enventual acontece so aqui
    if x > last.x then
        last.x = math.min(last.x + localmagicnumber, x)
    else
        last.x = math.max(last.x - localmagicnumber, x)
    end
    if y > last.y then
        last.y = math.min(last.y + localmagicnumber, y)
    else
        last.y = math.max(last.y - localmagicnumber, y)
    end

    if ang > last.ang then
        last.ang = math.min(last.ang + angmagicnumber, ang)
    else
        last.ang = math.max(last.ang - angmagicnumber, ang)
    end
    return last.ang, last.x, last.y
end

end