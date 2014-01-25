Ball = Class{
   init = function(self)
      self.position = Vector(Constants.SCREEN_WIDTH / 2, 0)
      self.velocity = Vector(0, 0)
   end
}

function Ball:update(dt)
   self:updatePosition(dt)

   if self.position.y > Constants.SCREEN_HEIGHT then
      self:bounce(Vector(0, 1))
      self:updatePosition(dt)
   end
end

function Ball:updatePosition(dt)
   self.velocity = self.velocity + Vector(0, Constants.BALL_ACCELERATION) * dt
   self.position = self.position + (self.velocity * dt)
end

-- Source is a vector pointing to the source, normalized or not.
function Ball:bounce(source)
   self.velocity = (self.velocity + (source:normalized() * Constants.BALL_BOUNCE_MOMENTUM_RETAIN_PERCENTAGE)) * -1
end

function Ball:draw()
   love.graphics.setColor(100, 150, 200)
   love.graphics.circle("fill", self.position.x, self.position.y, Constants.BALL_INITIAL_SIZE)
end

return Ball
