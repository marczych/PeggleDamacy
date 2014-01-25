local BackGround = require "entities.background"
local Bucket = require "entities.bucket"
local Ball = require "entities.ball"
local Peg = require "entities.peg"

local background
local blueBucket
local ball
local pegs
local score

local Play = {}

function Play:enter()
   pegs = {}
   -- Initialize all of the pegs
   for i = 1, 50 do
      table.insert(pegs, Peg())
   end

   ball = Ball()
   score = 0
   background = BackGround()
   blueBucket = Bucket(250)
end

function Play:update(dt)
   ball:update(dt)
   background:update(dt)
   blueBucket:update(dt)  --Test bucket. ok to remove and do something better

   ballAndPegSize = ball:getRadius() + Constants.PEG_RADIUS

   for i, peg in ipairs(pegs) do
      normal = ball.position - peg.position
      if normal:len() < ballAndPegSize then
         ball:bounce(normal, dt)
         ball:attachPeg(peg)
         score = score + 100
         table.remove(pegs, i)
         break
      end
   end
end

function Play:draw()
   love.graphics.setColor(255, 255, 255)

   background:draw()
   ball:draw()
   blueBucket:draw()

   for _, peg in pairs(pegs) do
      peg:draw()
   end
end

function Play:keypressed(key, unicode)
   if key == 'j' then
      ball.velocity = ball.velocity * 1.1
   end
   if key == 'r' then
      Play.enter()
   end
end

return Play
