
require("love.graphics")
local lg = love.graphics

require("love.physics")
local lp = love.physics

module("track") do


load = function(world)
    walls = {}
    walls[1] = {}
    walls[1].body = lp.newBody(world,0,0,"static")
    walls[1].shape = lp.newChainShape(true, 50,50, 500,50, 500,300, 50,300)
    walls[1].fixture = lp.newFixture(walls[1].body,walls[1].shape)
end

draw = function()
    lg.line(walls[1].body:getWorldPoints(walls[1].shape:getPoints()))
end


end -- module