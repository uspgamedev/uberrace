

require("math")
local math = math

require("love.graphics")
local lg = love.graphics
require("love.physics")
local lp = love.physics


module("car") do

-- load

local mycar = nil

local accelerate = 0
local brake = 0
local turnLeft = 0
local turnRight = 0

load = function(world)
    mycar = {}
    mycar.body = lp.newBody(world,150,150,"dynamic")
    mycar.shape = lp.newPolygonShape(0,-15, 0,15, 60,0)
    mycar.fixture = lp.newFixture(mycar.body,mycar.shape,1)
end

-- update

rotateVec = function(ang,x,y)
    return math.cos(ang)*x - math.sin(ang)*y, math.sin(ang)*x + math.cos(ang)*y
end

update = function()
    local ang = mycar.body:getAngle()
    local vel_x = 0
    local vel_y = 0
    vel_x, vel_y = mycar.body:getLinearVelocity()
    local vel_front = 0
    local vel_drift = 0
    vel_front, vel_drift = rotateVec(-ang,vel_x,vel_y)

    local friction_front = -vel_front*0.05
    if accelerate == -1 and vel_front > 0.5 then
        friction_front = -vel_front*0.5
    end

    local friction_drift = -vel_drift*0.5
    friction_front, friction_drift = rotateVec(ang,friction_front,friction_drift)

    mycar.body:applyForce(friction_front,friction_drift)
    
    if accelerate == 1 then
        mycar.body:applyForce(math.cos(ang)*200,math.sin(ang)*200)
    elseif accelerate == -1 and vel_front <= 0.5 then
        mycar.body:applyForce(-math.cos(ang)*100,-math.sin(ang)*100)
    end
    if turn ~= 0 then
    end

end

-- input

keypressed = function(key,unicode)
    if key == "up" then
        accelerate = 1
    end
    if key == "down" then
        accelerate = -1
    end
    if key == "left" then
        turn = -1
    end
    if key == "right" then
        turn = 1
    end
end

keyreleased = function(key,unicode)
    if key == "up" or key == "down" then
        accelerate = 0
    end
    if key == "left" or key == "right" then
        turn = 0
    end
end

-- graphical

draw = function()
    lg.polygon("fill", mycar.body:getWorldPoints(mycar.shape:getPoints()))
end
    

end -- module