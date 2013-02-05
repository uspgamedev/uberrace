

local setmetatable = setmetatable

require("math")
local math = math

module("vector") do

methods = {}

function methods:rotate(ang)
    local x = math.cos(ang)*self.x - math.sin(ang)*self.y
    self.y  = math.sin(ang)*self.x + math.cos(ang)*self.y
    self.x  = x
end

function methods:dot(vec)
    return self.x * vec.x + self.y * vec.y
end

function methods:scale(scalar)
    self.x = self.x * scalar
    self.y = self.y * scalar
end

function methods:norm2_squared()
    return self.x * self.x + self.y * self.y
end

function methods:norm2()
    return math.sqrt(self:norm2_squared())
end

function methods:add(vec)
    self.x = self.x + vec.x
	self.y = self.y + vec.y
end

function methods:unpack()
   return self.x, self.y
end

meta = { __index = methods }

function meta.new(xval,yval)
    vec = { x = xval, y = yval }
    setmetatable(vec,meta)
    return vec
end

end -- module
