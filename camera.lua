require("math")
local math = math

module("camera")do

local last = {}

load = function(x, y, ang)
    last.x = x
    last.y = y
    last.ang = ang
end

function getCamSpot(ang, x, y)
    local localmagicnumber = 70
    local angmagicnumber = 0.05
    if math.abs(x - last.x) > localmagicnumber then
       if x > last.x then
	  last.x = last.x + localmagicnumber
       else
	  last.x = last.x - localmagicnumber
       end
    else
       last.x = x
    end
    if math.abs(y - last.y) > localmagicnumber then
       if y > last.y then
	  last.y = last.y + localmagicnumber
       else
	  last.y = last.y - localmagicnumber
       end
    else
       last.y = y
    end
    
    if math.abs(ang - last.ang) > angmagicnumber then
       if ang > last.ang then
	  last.ang = last.ang + angmagicnumber
       else
	  last.ang = last.ang - angmagicnumber
       end
    else
       last.ang = ang
    end
    return last.ang, last.x, last.y
end

end