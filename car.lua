

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

function load(world)
    mycar = {}
    mycar.body = lp.newBody(world,450,450,"dynamic")
    mycar.shape = lp.newPolygonShape(10,20,-10,20,-10,-20,10,-20)
    mycar.fixture = lp.newFixture(mycar.body,mycar.shape,3)
end

-- update

local function accelerateCar(frame_front)
    local scalarAcceleration = 1200
    local linearAcceleration = vm.new(frame_front.x, frame_front.y)
    --TODO: Arrumar nomes de variaveis para a linha abaixo fazer mais sentido
    linearAcceleration:scale(scalarAcceleration*accelerate)
    mycar.body:applyForce(linearAcceleration.x, linearAcceleration.y)
end

local function turnCar(vel_front)
   local v = vel_front:norm2_squared()
   v = math.min(v/2500, 1)
   mycar.body:applyTorque(turn*6000*v)
end

local function brakeCar(vel_front)
    local brakeForceScale = -2
    local brake_force = vm.new(vel_front.x, vel_front.y)
    brake_force:scale(brakeForceScale)
    mycar.body:applyForce(brake_force.x,brake_force.y)
 end

local function killLateralMomentum(vel_lateral)
    local lateral_kill_impulse = vm.new(vel_lateral.x, vel_lateral.y)
    lateral_kill_impulse:scale(-1 * mycar.body:getMass())
    local v = lateral_kill_impulse:norm2_squared()
    if v > 100 then
        lateral_kill_impulse:scale( 10 / math.sqrt(v))
    end
    mycar.body:applyLinearImpulse(lateral_kill_impulse.x,lateral_kill_impulse.y)
end

local function reduceForwardMomentum(vel_front)
    local frictionScale = -0.8
    local forward_friction = vm.new(vel_front.x, vel_front.y)
    forward_friction:scale(frictionScale * mycar.body:getMass() )
    mycar.body:applyForce(forward_friction.x, forward_friction.y)
end

local function reduceAngularMomentum()
    local reductionScale = -0.5
    mycar.body:applyAngularImpulse( reductionScale * mycar.body:getInertia() * mycar.body:getAngularVelocity() )
end

function update()
    -- know the car
   
    local nright = vm.new(1,0)
    local nup = vm.new(0,-1)
    
    local vel_linear = vm.new(0,0)
    vel_linear.x, vel_linear.y = mycar.body:getLinearVelocity()

    local frame_front = vm.new(0,0)
    local frame_lateral = vm.new(0,0)

    frame_front.x, frame_front.y = mycar.body:getWorldVector(nup.x,nup.y)
    frame_lateral.x, frame_lateral.y = mycar.body:getWorldVector(nright.x,nright.y)

    local vel_front = vm.new(frame_front.x, frame_front.y)
    local vel_lateral = vm.new(frame_lateral.x, frame_lateral.y)

    vel_front:scale(vel_front:dot(vel_linear))
    vel_lateral:scale(vel_lateral:dot(vel_linear))


    if accelerate ~= 0 then
        accelerateCar(frame_front)
    end
    if turn ~= 0 then
        turnCar(vel_front)
    end
    if brake then
        brakeCar(vel_front)
    end
    killLateralMomentum(vel_lateral)
    reduceForwardMomentum(vel_front)  
    reduceAngularMomentum()
end

-- input

function keypressed(key,unicode)
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

function keyreleased(key,unicode)
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
 
function getValues()
    local wcenter = vm.new(mycar.body:getWorldCenter())
	local wvel = vm.new(mycar.body:getLinearVelocity())
	wvel:scale(0.3)
	wcenter:add(wvel)
    return mycar.body:getAngle(), wcenter:unpack() 
end

function draw()
    points = {mycar.body:getWorldPoints(mycar.shape:getPoints())}
    lg.polygon("fill",unpack(points))
end
   
end -- module
