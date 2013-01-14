-------------
-- Require --
-------------

require("car")

---------------
-- CALLBACKS --
---------------

-- Main Callbacks

love.load = function()
    car.load()
end

love.update = function(dt)
    car.update(dt)
end

love.draw = function()
    car.draw()
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