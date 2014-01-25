Ball = Class{
   init = function(self)
      self.position = Vector(Constants.SCREEN_WIDTH / 2, 0)
      self.velocity = Vector(200, 0)
   end
}

function Ball:update(dt)
   self:updatePosition(dt)

   if self.position.y > Constants.SCREEN_HEIGHT - Constants.BALL_INITIAL_RADIUS then
      self:bounce(Vector(0, -1))
      self:updatePosition(dt)
   end

   if self.position.x < 0 + Constants.BALL_INITIAL_RADIUS then
      self:bounce(Vector(1, 0))
      self:updatePosition(dt)
   end

   if self.position.x > Constants.SCREEN_WIDTH - Constants.BALL_INITIAL_RADIUS then
      self:bounce(Vector(-1, 0))
      self:updatePosition(dt)
   end
end

function Ball:updatePosition(dt)
   self.velocity = self.velocity + Vector(0, Constants.BALL_ACCELERATION) * dt
   self.position = self.position + (self.velocity * dt)
end

function Ball:bounce(normal)
   normal = normal:normalized()

   self.velocity = (2 * normal * self.velocity * normal - self.velocity) * -Constants.BALL_BOUNCE_MOMENTUM_RETAIN_PERCENTAGE
end

function Ball:draw()
   love.graphics.setColor(100, 150, 200)
   love.graphics.circle("fill", self.position.x, self.position.y, Constants.BALL_INITIAL_RADIUS * 2)
end

return Ball
