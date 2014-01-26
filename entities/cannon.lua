local Cannon = Class{
   init = function(self, pegs)
      self.pegs = pegs
      self.position = Vector(Constants.SCREEN_WIDTH / 2,
                             Constants.HUD_HEIGHT + 10)
      self.power = Vector(0, 0)
   end
}

function Cannon:update(dt)
   local x, y = love.mouse.getPosition()
   self.power = (Vector(x, y) - self.position):normalized() * 500
end

function Cannon:draw()
   love.graphics.setColor(100, 150, 200)
   love.graphics.circle("fill", self.position.x, self.position.y, Constants.BALL_INITIAL_RADIUS)
   love.graphics.circle("line", self.position.x, self.position.y, Constants.BALL_INITIAL_RADIUS * 2)

   arrow = self.power:normalized() * 200
   endpoint = self.position + arrow

   local x, y = love.mouse.getPosition()

   endpoint.y = endpoint.y + math.abs(arrow.x / 3) + arrow.y / 5
   -- Account for -y force
   if arrow.y < 0 then
      endpoint.y = endpoint.y - arrow.y / 3
   end

   dx = endpoint.x - self.position.x
   dy = endpoint.y - self.position.y

   -- Trail
   minClearence = Constants.PEG_RADIUS + Constants.BALL_INITIAL_RADIUS
   trailRadius = 4
   increment = 5
   for i = 1, 10, 1 do
      if i < 5 then increment = increment + 5 end
      if i > 6 then increment = increment - 5 end

      trailPos = Vector(self.position.x + (dx / 10) * i,
       self.position.y + (dy / 10) * i - increment, 4)

      for i, peg in ipairs(self.pegs) do
         dif = peg.position - trailPos
         if (math.abs(dif.x) < minClearence) and
            (math.abs(dif.y) < minClearence) then
            return Cannon:endTrail(trailPos, peg.position, self.position)
         end
      end

      if i == 10 then
         trailRadius = Constants.BALL_INITIAL_RADIUS
      end

      love.graphics.circle("line", self.position.x + (dx / 10) * i,
       self.position.y + (dy / 10) * i - increment, trailRadius)
   end
end

function Cannon:endTrail(trailPos, pegPos, from)
   direction = (pegPos - from):normalized()
   minClearence = Constants.PEG_RADIUS + Constants.BALL_INITIAL_RADIUS

   while math.abs(pegPos.x - trailPos.x) < minClearence and
         math.abs(pegPos.y - trailPos.y) < minClearence - 5 do
      trailPos = trailPos - direction
   end

   love.graphics.circle("line", trailPos.x, trailPos.y,
    Constants.BALL_INITIAL_RADIUS)
end

return Cannon
