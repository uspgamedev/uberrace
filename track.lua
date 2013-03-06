
local pairs = pairs

require("love.graphics")
local lg = love.graphics

require("love.physics")
local lp = love.physics

require("vector")
local vector = vector.meta

local print = print

module("track") do


function load(world)
    walls = {}
    walls[1] = {}
    walls[1].body = lp.newBody(world,0,0,"static")
    walls[1].shape = lp.newChainShape(true, 50,50, 17500,50, 17500,9500, 50,9500)
    walls[1].fixture = lp.newFixture(walls[1].body,walls[1].shape)
    walls[2] = {}
    walls[2].body = lp.newBody(world,0,0,"static")
    walls[2].shape = lp.newChainShape(true, 1050,1050, 16500,1000, 16500,8500,1000,8500)
    walls[2].fixture = lp.newFixture(walls[2].body,walls[2].shape)
end

function draw()
   lg.line(walls[1].body:getWorldPoints(walls[1].shape:getPoints()))
   lg.line(walls[2].body:getWorldPoints(walls[2].shape:getPoints()))
end


end -- module