--Import shit
--------------------
local BG = require "entities.background"


local play = {}

local Background = BG()
local Ball = require "entities.ball"
local ball = Ball()

function play:enter()
	
end

function play:update(dt)
   ball:update(dt)
end

function play:draw()
   love.graphics.setColor(125, 100, 200)
   love.graphics.print("Play!", 200, 200)
   
   Background:draw()

   ball:draw()
end

function play:keypressed(key, unicode)
end

return play
