local BackGround = require "entities.background"
local Bucket = require "entities.bucket"
local Ball = require "entities.ball"
local Peg = require "entities.peg"
local Hud = require "entities.hud"

local background
local blueBucket
local ball
local pegs
local score
local hud

local Play = {}

function Play:enter()
   pegs = {}
   -- Initialize all of the pegs
   for i = 1, Constants.NUM_STARTING_PEGS do
      table.insert(pegs, Peg())
   end

   ball = Ball()
   score = 0
   -- A set of lower and upper wavelength bounds that define what color 
   -- pegs the player can collect
   -- Start with the greens.
   availableSpectrum = {
      {
         lower=450, 
         upper=600
      }
   }

   background = BackGround()
   blueBucket = Bucket(250)
   hud = Hud()
end

function Play:update(dt)
   ball:update(dt)
   background:update(dt)
   blueBucket:update(dt)  --Test bucket. ok to remove and do something better

   ballAndPegSize = ball:getRadius() + Constants.PEG_RADIUS
   

   for i, peg in ipairs(pegs) do
      normal = ball.position - peg.position
      if normal:len() < ballAndPegSize then
         if Utils.canCollect(peg.wavelength, availableSpectrum) then
            ball:attachPeg(peg)
            -- TODO: Increase the availableSpectrum
            table.remove(pegs, i)
            score = score + 100
         end
         ball:bounce(normal, dt)
         break
      end
   end

   hud:update(dt)
end

function Play:draw()
   love.graphics.setColor(255, 255, 255)

   background:draw()
   ball:draw()
   blueBucket:draw()

   for _, peg in pairs(pegs) do
      peg:draw()
   end

   hud:draw()
end

function Play:keypressed(key, unicode)
   if key == 'j' then
      ball.velocity = ball.velocity * 1.1
   end
   if key == 'k' then
      ball.velocity = ball.velocity * 0.8
   end
   if key == 'r' then
      Play.enter()
   end
end

function Play:mousepressed(x, y, button)
   ball:propelTowards(Vector(x, y), 1000)
end

return Play
