Ball = Class{
   init = function(self)
      self.position = Vector(Constants.SCREEN_WIDTH / 2, 0)
      self.velocity = Vector(200, 0)
      self.radius = Constants.BALL_INITIAL_RADIUS
      self.attachedPegs = {}
   end
}

function Ball:update(dt)
   self:updatePosition(dt)

   if self.position.y > Constants.SCREEN_HEIGHT - self:getRadius() then
      self:bounce(Vector(0, -1), dt)
   end

   if self.position.x < 0 + self:getRadius() then
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
   peg.position = self.position - peg.position
   table.insert(self.attachedPegs, peg)
end

function Ball:getRadius()
   return self.radius * math.max(#self.attachedPegs, 1)
end

function Ball:draw()
   love.graphics.setColor(100, 150, 200)
   love.graphics.circle("fill", self.position.x, self.position.y, self:getRadius())

   love.graphics.setColor(250, 150, 100)
   for i, peg in ipairs(self.attachedPegs) do
      position = self.position + peg.position

      love.graphics.circle("fill", position.x, position.y, Constants.PEG_RADIUS)
   end
end

return Ball
