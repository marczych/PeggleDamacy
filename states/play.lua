--Import shit
--------------------
local BackGround = require "entities.background"


local play = {}

local Ball = require "entities.ball"
local ball = Ball()
local background = BackGround()


function play:enter()
	
end

function play:update(dt)
   ball:update(dt)
   background:update(dt)
end

function play:draw()
   love.graphics.setColor(125, 100, 200)
   love.graphics.print("Play!", 200, 200)
   
   background:draw()
   ball:draw()
end

function play:keypressed(key, unicode)
end

return play
