local BallParticle = require "entities.ballparticle"

local Ball = Class{
   init = function(self, position, velocity)
      self.radius = Constants.BALL_INITIAL_RADIUS
      self.position = position
      self.velocity = velocity
      self.attachedPegs = {}
      self.trailParticles = {}
      self.lastTrailParticleTime = 0
   end
}

function Ball:update(dt)
   self:updatePosition(dt)

   time = love.timer.getTime()

   if (time - self.lastTrailParticleTime)*1000 > Constants.BALL_PARTICLES_QUANTUM_IN_MS then
      self.lastTrailParticleTime = time
      table.insert(self.trailParticles, BallParticle(self.position, time))
   end

   if self.position.y < self:getRadius() + Constants.HUD_HEIGHT then
      self:bounce(Vector(0, 1), dt)
   end

   if self.position.x < self:getRadius() then
      self:bounce(Vector(1, 0), dt)
   end

   if self.position.x > Constants.SCREEN_WIDTH - self:getRadius() then
      self:bounce(Vector(-1, 0), dt)
   end
end

function Ball:updatePosition(dt)
   self.velocity = self.velocity + Vector(0, Constants.BALL_ACCELERATION) * dt
   self.position = self.position + (self.velocity * dt)
end

function Ball:bounce(normal, dt)
   normal = normal:normalized()

   self.velocity = (2 * normal * self.velocity * normal - self.velocity) *
    -Constants.BALL_BOUNCE_MOMENTUM_RETAIN_PERCENTAGE

   self:updatePosition(dt)
end

function Ball:attachPeg(peg)
   peg.position = peg.position - self.position
   table.insert(self.attachedPegs, peg)
end

function Ball:getRadius()
   return self.radius + math.max(#self.attachedPegs, 1) * 1.4
end

function Ball:propelTowards(position, intensity)
   direction = position - self.position
   self.velocity = self.velocity + (direction:normalized() * intensity)
end

function Ball:draw()
   time = love.timer.getTime()
   for i, particle in ipairs(self.trailParticles) do
      particle:draw(time)

      if particle:isDead(time) then
         table.remove(self.trailParticles, i)
      end
   end

   love.graphics.setColor(100, 150, 200)
   love.graphics.circle("fill", self.position.x, self.position.y, self:getRadius())

   for i, peg in ipairs(self.attachedPegs) do
      peg:drawAtPosition(self.position + peg.position)
   end
end

return Ball
