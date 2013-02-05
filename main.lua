-------------
-- Require --
-------------

require("track")
require("car")

---------------
-- CALLBACKS --
---------------

-- Main Callbacks

love.load = function()
    love.graphics.setMode(1800, 1000, false, true, 0)
    love.physics.setMeter(64)
    world = love.physics.newWorld(0,0,false)

    track.load(world)
    car.load(world)
end

love.update = function(dt)
    world:update(dt)
    car.update(dt)
end

function love.draw()
   
   love.graphics.translate(900,500)
   love.graphics.scale(0.5, 0.5)
   local ang = 0
   local wcenter = {}
   ang, wcenter.x, wcenter.y = car.camspot()
   love.graphics.rotate(-ang)
   love.graphics.translate(-wcenter.x,-wcenter.y)
   car.draw()
   track.draw()
end

-- Mouse Callbacks

love.mousepressed = function(x,y,button)
    
end

love.mousereleased = function(x,y,button)
    
end

-- Keyboard Callbacks

love.keypressed = function(key,unicode)
    car.keypressed(key,unicode)
end

love.keyreleased = function(key,unicode)
    car.keyreleased(key,unicode)
end

-- Window Callbacks

love.focus = function(f)
    
end

love.quit = function()
    
end
