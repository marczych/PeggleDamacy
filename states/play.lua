local BallParticle = require "entities.ballparticle"
local BackGround = require "entities.background"
local Cannon = require "entities.cannon"
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
local ballsRemaining
local trailParticles
local lastTrailParticleTime

local Play = {}
local pegsCollected

function Play:enter()
   pegs = {}
   -- Initialize all of the pegs
   for i = 1, Constants.NUM_STARTING_PEGS do
      newPeg = Peg()
      newPeg.position = Utils.randomPegLocation(pegs)
      table.insert(pegs, newPeg)
   end

   score = 0
   -- A set of lower and upper wavelength bounds that define what color
   -- pegs the player can collect
   -- Start with the greens.
   availableSpectrum = {
      {
         lower = Constants.STARTING_LOWER_WAVELENGTH,
         upper = Constants.STARTING_UPPER_WAVELENGTH
      }
   }

   background = BackGround()
   blueBucket = Bucket(250, 40)
   cannon = Cannon(pegs)
   hud = Hud()
   ball = nil
   ballsRemaining = Constants.NUM_STARTING_BALLS
   trailParticles = {}
   lastTrailParticleTime = 0
   pegsCollected = Constants.NUM_STARTING_PEGS
end

function Play:update(dt)
   -- Slow the whole game down a bit
   -- Making the ball travel a little slower makes the game more suspenseful and fun
   dt = dt * 0.8

   -- Slow motion.
   if love.keyboard.isDown(" ") then
      dt = dt / 5
   end

   background:update(dt)
   blueBucket:update(dt)  --Test bucket. ok to remove and do something better

   for i, particle in ipairs(trailParticles) do
      if particle:isDead(time) then
         table.remove(trailParticles, i)
      end
   end

   if ball then
      ball:update(dt)

      time = love.timer.getTime()

      if (time - lastTrailParticleTime)*1000 > Constants.BALL_PARTICLES_QUANTUM_IN_MS then
         lastTrailParticleTime = time
         table.insert(trailParticles, BallParticle(ball.position, time, ball:getRadius()))
      end

      ballAndPegSize = ball:getRadius() + Constants.PEG_RADIUS

      for i, peg in ipairs(pegs) do
         normal = ball.position - peg.position
         if normal:len() < ballAndPegSize then
            local section = Utils.getSection(peg.wavelength, availableSpectrum)
            if section then
               ball:attachPeg(peg)
               pegsCollectedThisBall = pegsCollectedThisBall + 1;
               pegsCollected = pegsCollected - 1
               -- Increase the spectrum in the section of the collected peg's wavelength
               Utils.increaseSpectrumSection(section, availableSpectrum)
               table.remove(pegs, i)
               score = score + 100 + (25 * pegsCollectedThisBall)
            end
            ball:bounce(normal, dt)
            break
         end
      end

      local len = ball.position - blueBucket:getCollisionLocation()
      if len:len() < ball:getRadius() + Constants.BUCKET_RADIUS then
         -- Collision between ball and bucket.
         score = score + 1000
         ballsRemaining = ballsRemaining + 1
         ball = nil
      elseif ball and ball.position.y > Constants.SCREEN_HEIGHT + ball:getRadius() then
         -- Take the ball out of play because it hit the bottom.
         ball = nil

         if ballsRemaining == 0 then
            Gamestate.switch(States.credits, pegsCollected, score)
         end
      end

      if not ball then
         cannon = Cannon(pegs)
      end
   end

   if cannon then
      cannon:update(dt)
   end

   hud:update(dt)
end

function Play:draw()
   love.graphics.setColor(255, 255, 255)

   background:draw()
   blueBucket:draw()

   time = love.timer.getTime()
   for i, particle in ipairs(trailParticles) do
      particle:draw(time)
   end

   if ball then
      ball:draw()
   end

   if cannon then
      cannon:draw()
   end

   for _, peg in pairs(pegs) do
      peg:draw(Utils.getSection(peg.wavelength, availableSpectrum))
   end

   hud:draw(score, ballsRemaining, availableSpectrum)
end

function Play:keypressed(key, unicode)
   if not ball then
      return
   end

   if key == 'r' then
      Play.enter()
   end

   -- TODO: remove these
   if key == 'c' then
      ballsRemaining = 0
   end
   if key == 'j' then
      ball.velocity = ball.velocity * 1.1
   end
   if key == 'k' then
      ball.velocity = ball.velocity * 0.8
   end
end

function Play:mousepressed(x, y, button)
   -- If a ball is already in play
   if ball then
      ball:propelTowards(Vector(x, y), 1000)

   -- Otherwise, fire a ball
   else
      ballsRemaining = ballsRemaining - 1
      pegsCollectedThisBall = 0;
      if (cannon) then
         ball = Ball(cannon.position, cannon.power)
         cannon = nil
      end
   end
end

return Play
