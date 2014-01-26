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
local availableSpectrum

local Play = {}

function Play:enter()
   pegs = {}
   -- Initialize all of the pegs
   for i = 1, Constants.NUM_STARTING_PEGS do
      table.insert(pegs, Peg())
   end

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
   ball = nil
end

function Play:update(dt)
   background:update(dt)
   blueBucket:update(dt)  --Test bucket. ok to remove and do something better

   if ball then
      ball:update(dt)

      ballAndPegSize = ball:getRadius() + Constants.PEG_RADIUS

      for i, peg in ipairs(pegs) do
         normal = ball.position - peg.position
         if normal:len() < ballAndPegSize then
            local section = Utils.getSection(peg.wavelength, availableSpectrum)
            if section then
               ball:attachPeg(peg)
               -- Increase the spectrum in the section of the collected peg's wavelength
               Utils.increaseSpectrumSection(section, availableSpectrum)
               table.remove(pegs, i)
               score = score + 100
            end
            ball:bounce(normal, dt)
            break
         end
      end
   end

   hud:update(dt)
end

function Play:draw()
   love.graphics.setColor(255, 255, 255)

   background:draw()
   blueBucket:draw()

   if ball then
      ball:draw()
   end

   for _, peg in pairs(pegs) do
      peg:draw(Utils.getSection(peg.wavelength, availableSpectrum))
   end

   hud:draw(score, availableSpectrum)
end

function Play:keypressed(key, unicode)
   if not ball then
      return
   end

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
   if ball then
      ball:propelTowards(Vector(x, y), 1000)
   else
      position = Vector(Constants.SCREEN_WIDTH / 2, Constants.HUD_HEIGHT + 10)

      ball = Ball(position, (Vector(x, y) - position):normalized() * 500)
   end
end

return Play
