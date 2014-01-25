Ball = Class{
   init = function(self)
      self.position = Vector(Constants.SCREEN_WIDTH / 2, 0)
   end
}

function Ball:update(dt)
   self.position = self.position + (Vector(10, 10) * dt)
end

function Ball:draw()
   love.graphics.setColor(100, 150, 200)
   love.graphics.circle("fill", self.position.x, self.position.y, Constants.BALL_INITIAL_SIZE)
end

return Ball
