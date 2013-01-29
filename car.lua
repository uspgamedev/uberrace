

require("math")
local math = math

require("love.graphics")
local lg = love.graphics
require("love.physics")
local lp = love.physics


require("vector")
local vm = vector.meta

module("car",package.seeall) do

-- load

local mycar = nil

local accelerate = 0
local brake = false
local turn = 0

load = function(world)
    mycar = {}
    mycar.body = lp.newBody(world,450,450,"dynamic")
    mycar.shape = lp.newPolygonShape(10,20,-10,20,-10,-20,10,-20)
    mycar.fixture = lp.newFixture(mycar.body,mycar.shape,5)
    mycar.body:setAngularDamping(10)
end

-- update

update = function()
    -- know the car
   
    local nright = { x = 1 , y = 0 }
    local nup = { x = 0 , y = -1 }
    setmetatable(nright,vm)
    setmetatable(nup,vm)

    local vel_linear = { x = 0, y = 0 }
    setmetatable(vel_linear,vm)
    vel_linear.x, vel_linear.y = mycar.body:getLinearVelocity()

    local vel_front = { x = 0, y = 0 }
    local vel_lateral = { x = 0, y = 0}
    setmetatable(vel_front,vm)
    setmetatable(vel_lateral,vm)

    vel_front.x, vel_front.y = mycar.body:getWorldVector(nup.x,nup.y)
    vel_lateral.x, vel_lateral.y = mycar.body:getWorldVector(nright.x,nright.y)

    local frame_front = vm.new(vel_front.x, vel_front.y)
    local frame_lateral = vm.new(vel_lateral.x, vel_lateral.y)

    vel_front:scale(vel_front:dot(vel_linear))
    vel_lateral:scale(vel_lateral:dot(vel_linear))


    -- move the car

    if accelerate ~= 0 then
        local accel = vm.new(frame_front.x, frame_front.y)
        accel:scale(600*accelerate)
        mycar.body:applyForce(accel.x, accel.y)
    end


    -- turn the car

    local v = vel_front:norm2_squared()
    if v <= 2500 then
        v = v/2500
    else
        v = 1
    end

    if turn ~= 0 then
        mycar.body:applyTorque(turn*22000*v)
    end


    -- brake the car

    if brake then
       local brake_force = vm.new(vel_front.x, vel_front.y)
       brake_force:scale(-0.9)
       mycar.body:applyForce(brake_force.x,brake_force.y)
    end

    -- kill lateral momentum

    local lateral_kill_impulse = vel_lateral
    setmetatable(lateral_kill_impulse,vm)
    lateral_kill_impulse:scale(-1 * mycar.body:getMass())
    v = lateral_kill_impulse:norm2_squared()
    if v > 100 then
        lateral_kill_impulse:scale( 10 / math.sqrt(v))
    end
    mycar.body:applyLinearImpulse(lateral_kill_impulse.x,lateral_kill_impulse.y)

    -- reduce forward momentum

    local forward_friction = vm.new(vel_front.x, vel_front.y)
    forward_friction:scale(-0.8 * mycar.body:getMass() )
    mycar.body:applyForce(forward_friction.x, forward_friction.y)

    -- reduce angular momentum
    mycar.body:applyAngularImpulse( -0.5 * mycar.body:getInertia() * mycar.body:getAngularVelocity() )
    

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
    if key == " " then
        brake = true
    end
end

keyreleased = function(key,unicode)
    if key == "up" or key == "down" then
        accelerate = 0
    end
    if key == "left" or key == "right" then
        turn = 0
    end
    if key == " " then
        brake = false
    end
end

-- graphical

draw = function()
    lg.polygon("fill", mycar.body:getWorldPoints(mycar.shape:getPoints()))
end
    

end -- module
