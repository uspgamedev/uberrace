

require("math")
local math = math
require("love.graphics")
local lg = love.graphics

module("car") do

-- movement

local x = 300
local y = 200
local vel = 0
local ang = 1.6
local angvel = 3

local accel = 0
local friction = 0.03

local spin = 0

set_x = function(newx)
    x = newx
end
set_y = function(newy)
    y = newy
end
set_ang = function(newang)
    ang = newang
end

turn = function(turn_angle)
   ang = ang + turn_angle
end

move = function(distance)
    x = x + math.sin(ang) * distance
	y = y - math.cos(ang) * distance
end

-- update

update = function(dt)

	vel = vel*(1 - friction) + accel
		
    if spin ~= 0 then
	    turn(spin*angvel*dt)
	end
	
	move(vel*dt)
end

-- input

keypressed = function(key,unicode)
    if key == "up" then
	    accel = 30
	end
    if key == "down" then
	    accel = -30
	end
    if key == "left" then
	    spin = -1
	end
    if key == "right" then
	    spin = 1
	end
end

keyreleased = function(key,unicode)
    if key == "up" or key == "down" then
	    accel = 0
	end
    if key == "left" or key == "right" then
	    spin = 0
	end
end

-- graphical

local mycar = nil

load = function()
    mycar = lg.newImage("images/car.png")
end

draw = function()
    lg.draw(mycar,x,y,ang,1,1,18,55,0,0)
end

end -- module car