Ball = Class{
   init = function(self)
      self.x = 0
      self.y = 0
   end
}

function Ball:update(dt)
   self.x = self.x + dt
   self.y = self.y + dt
end

function Ball:draw()
   love.graphics.setColor(100, 150, 200)
   love.graphics.circle("fill", self.x, self.y, Constants.BALL_INITIAL_SIZE)
end

return Ball
