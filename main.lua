-------------
-- Require --
-------------

require("track")
require("car")
require("camera")

---------------
-- CALLBACKS --
---------------

-- Main Callbacks

function love.load()
    love.graphics.setMode(1800, 1000, false, true, 0)
    love.physics.setMeter(64)
    world = love.physics.newWorld(0,0,false)

    track.load(world)
    car.load(world)
    camera.load(450,450,0)
end

function love.update(dt)
    world:update(dt)
    car.update(dt)
end

function love.draw()
   
    love.graphics.translate(900,500)
    love.graphics.scale(0.5, 0.5)
    local ang = 0
    local wcenter = {}
    ang, wcenter.x, wcenter.y = camera.getCamSpot(car.getValues())
    love.graphics.rotate(-ang)
    love.graphics.translate(-wcenter.x,-wcenter.y)
    car.draw()
    track.draw()
end

-- Mouse Callbacks

function love.mousepressed(x,y,button)
    
end

function love.mousereleased(x,y,button)
    
end

-- Keyboard Callbacks

function love.keypressed(key,unicode)
    car.keypressed(key,unicode)
end

function love.keyreleased(key,unicode)
    car.keyreleased(key,unicode)
end

-- Window Callbacks

function love.focus(f)
    
end

function love.quit()
    
end
