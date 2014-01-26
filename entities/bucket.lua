-------- Class ----------
-------------------------
local imgBucket = love.graphics.newImage("assets/images/bucket.png")

local Bucket = Class {

   init = function(self, wavelengt)
      self.location = 0
      self.color = wavelengt 
      self.swing = .5
      self.positive = true

      self.leftDot = 0
      self.rightDot = 0;
   end,
}

local sideRadius = Constants.BUCKET_WALL

--Update
--------------------------
function Bucket:update(dt)
   if(self.positive) then
      self.swing = self.swing + dt*.25
   else
      self.swing = self.swing - dt*.25
   end

   if(self.swing >= 1) then
      self.positive = false
   end
   if (self.swing <= 0) then
      self.positive = true
   end

   self.location = Utils.numberInterpolate(0, 0, Constants.SCREEN_WIDTH,
    self.swing)
   self.rightDot = self.location + Constants.BUCKET_WIDTH/2 + sideRadius
   self.leftDot = self.location - Constants.BUCKET_WIDTH/2 - sideRadius
end

function Bucket:getLocation()
	return Vector(self.location-(Constants.BUCKET_WIDTH/2),
	Constants.SCREEN_HEIGHT-Constants.BUCKET_HEIGHT)
end

function Bucket:getCollisionLocation()
	return Vector(self.location,
	Constants.SCREEN_HEIGHT-Constants.BUCKET_HEIGHT+20)
end


--Draw
--------------------------
function Bucket:draw()

   --TODO set color right
   love.graphics.setColor(255,255,255)

    love.graphics.draw(imgBucket, self.location-(Constants.BUCKET_WIDTH/2),
    	Constants.SCREEN_HEIGHT-Constants.BUCKET_HEIGHT)

end


--RETURN
return Bucket
