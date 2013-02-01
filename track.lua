
local pairs = pairs

require("love.graphics")
local lg = love.graphics

require("love.physics")
local lp = love.physics

require("vector")
local vector = vector.meta

local print = print

module("track") do


load = function(world)
    walls = {}
    walls[1] = {}
    walls[1].body = lp.newBody(world,0,0,"static")
    walls[1].shape = lp.newChainShape(true, 50,50, 1750,50, 1750,950, 50,950)
    walls[1].fixture = lp.newFixture(walls[1].body,walls[1].shape)
end

function draw(ang, x, y)
   print("ang "..ang)
   print("x "..x)
   print("y "..y)
  
   --
   lg.push()
   lg.rotate(-ang)
   lg.translate(-x,-y)
   lg.line(walls[1].shape:getPoints())
    --lg.line(walls[1].body:getWorldPoints(walls[1].shape:getPoints()))
   lg.pop()
end


end -- module