--Import shit
--------------------
local BackGround = require "entities.background"
local Bucketz = require "entities.bucket"
local Vector = require "hump.vector"
local Constants = require "utils.constants"

local play = {}

local Ball = require "entities.ball"
local ball = Ball()
local background = BackGround()
local blueBucket = Bucketz(Vector(0, Constants.SCREEN_HEIGHT))


function play:enter()
	
end

function play:update(dt)
   ball:update(dt)
   background:update(dt)
   blueBucket:update(dt)  --Test bucket. ok to remove and do something better
end

function play:draw()
   love.graphics.setColor(125, 100, 200)
   love.graphics.print("Play!", 200, 200)
   
   background:draw()
   ball:draw()
   blueBucket:draw()
end

function play:keypressed(key, unicode)
end

return play
