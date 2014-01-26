BallParticle = Class{
   init = function(self, position, initialTime)
      self.position = position + Vector(math.random(-1, 1), math.random(-1, 1)):normalized() *
       Constants.BALL_PARTICLE_RANDOM_POSITION_AMOUNT
      self.initialTime = initialTime
   end
}

function BallParticle:draw(time)
   percentGone = self:getTimeRemaining(time) / Constants.BALL_PARTICLE_LIFE_TIME_IN_MS

   love.graphics.setColor(255, 255, 255, (1 - percentGone) * 255)
   love.graphics.circle("fill", self.position.x, self.position.y, Constants.BALL_PARTICLE_RADIUS)
end

function BallParticle:isDead(time)
   return self:getTimeRemaining(time) > Constants.BALL_PARTICLE_LIFE_TIME_IN_MS
end

function BallParticle:getTimeRemaining(time)
   return (time - self.initialTime)*1000
end

return BallParticle
