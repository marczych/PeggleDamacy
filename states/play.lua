--Import shit
--------------------
local BackGround = require "entities.background"
local Bucketz = require "entities.bucket"
local Vector = require "hump.vector"
local Constants = require "utils.constants"

local play = {}

local Ball = require "entities.ball"
local ball = Ball()
local Peg = require "entities.peg"
-- All of the pegs in the level
local pegs = {}
local background = BackGround()
local blueBucket = Bucketz(250)


function play:enter()
   -- Initialize all of the pegs
   for i = 1, 50 do
      pegs[i] = Peg()
   end
end

function play:update(dt)
   ball:update(dt)
   background:update(dt)
   blueBucket:update(dt)  --Test bucket. ok to remove and do something better

   ballAndPegSize = ball.radius + Constants.PEG_RADIUS

   for i, peg in ipairs(pegs) do
      normal = ball.position - peg.position
      if normal:len() < ballAndPegSize then
         ball:bounce(normal, dt)
         break
      end
   end
end

function play:draw()
   love.graphics.setColor(125, 100, 200)
   
   background:draw()
   ball:draw()
   blueBucket:draw()

   for i = 1, 50 do
      pegs[i]:draw()
   end
end

function play:keypressed(key, unicode)
   if key == 'j' then
      ball.velocity = ball.velocity * 1.1
   end
end

return play
