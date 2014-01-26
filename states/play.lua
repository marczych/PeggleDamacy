local BallParticle = require "entities.ballparticle"
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
local ballsRemaining
local trailParticles
local lastTrailParticleTime

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
   blueBucket = Bucket(250, 40)
   hud = Hud()
   ball = nil
   ballsRemaining = Constants.NUM_STARTING_BALLS
   trailParticles = {}
   lastTrailParticleTime = 0
end

function Play:update(dt)
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
               -- Increase the spectrum in the section of the collected peg's wavelength
               Utils.increaseSpectrumSection(section, availableSpectrum)
               table.remove(pegs, i)
               score = score + 100
            end
            ball:bounce(normal, dt)
            break
         end
      end

      local len = ball.position - blueBucket:getLocation()
      if len:len() < ball:getRadius() + Constants.BUCKET_RADIUS then
         -- Collision between ball and bucket.
         -- Utils.increaseSpectrumSection(blueBucket.wavelength,
         --		availableSpectrum)
         score = score + 1000
         ballsRemaining = ballsRemaining + 1
         ball = nil
      end
      
      if ball and ball.position.y > Constants.SCREEN_HEIGHT + ball:getRadius() then
         -- Take the ball out of play because it hit the bottom.
         ball = nil

         if ballsRemaining == 0 then
            Gamestate.switch(States.credits)
         end
         
      end
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
   if ball then
      ball:propelTowards(Vector(x, y), 1000)
   else
      position = Vector(Constants.SCREEN_WIDTH / 2, Constants.HUD_HEIGHT + 10)

      ball = Ball(position, (Vector(x, y) - position):normalized() * 500)
      ballsRemaining = ballsRemaining - 1
   end
end

return Play
