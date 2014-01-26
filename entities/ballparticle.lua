BallParticle = Class{
   init = function(self, position, initialTime, randomness)
      self.position = position + Vector(math.random(-1, 1), math.random(-1, 1)):normalized() * randomness
      self.initialTime = initialTime
   end
}

function BallParticle:draw(time)
   percentGone = self:getTimeRemaining(time) / Constants.BALL_PARTICLE_LIFE_TIME_IN_MS

   love.graphics.setColor(Utils.randomSparkleColorValue(), Utils.randomSparkleColorValue(), Utils.randomSparkleColorValue(), math.max(math.min(percentGone, 1), 0) * 255)
   love.graphics.circle("fill", self.position.x, self.position.y, Constants.BALL_PARTICLE_RADIUS)
end

function BallParticle:isDead(time)
   return self:getTimeRemaining(time) < 0
end

function BallParticle:getTimeRemaining(time)
   return Constants.BALL_PARTICLE_LIFE_TIME_IN_MS - (time - self.initialTime)*1000
end

return BallParticle
