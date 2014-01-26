local possibleSprites = {
   love.graphics.newImage("assets/images/peg1.png"),
   love.graphics.newImage("assets/images/peg2.png"),
   love.graphics.newImage("assets/images/peg3.png"),
   love.graphics.newImage("assets/images/peg4.png"),
   love.graphics.newImage("assets/images/peg5.png"),
   love.graphics.newImage("assets/images/peg6.png"),
   love.graphics.newImage("assets/images/peg7.png"),
   love.graphics.newImage("assets/images/peg8.png"),
   love.graphics.newImage("assets/images/peg9.png"),
   love.graphics.newImage("assets/images/peg10.png"),
   love.graphics.newImage("assets/images/peg11.png"),
   love.graphics.newImage("assets/images/peg12.png"),
   love.graphics.newImage("assets/images/peg13.png"),
   love.graphics.newImage("assets/images/peg14.png"),
   love.graphics.newImage("assets/images/peg15.png"),
   love.graphics.newImage("assets/images/peg16.png"),
   love.graphics.newImage("assets/images/peg17.png"),
   love.graphics.newImage("assets/images/peg18.png"),
   love.graphics.newImage("assets/images/peg19.png")
}

local Peg = Class{
   init = function(self)
      -- Spawn pegs in a random Vector location
      self.position = nil
      self.wavelength = Utils.randomWavelength()
      self.color = Utils.wavelengthToRGB(self.wavelength)
      self.spriteIndex = math.floor(math.random(#possibleSprites))
      self.seed = math.random(1, 1000000)
   end
}

function Peg:draw(collectable)
   self:drawAtPosition(self.position, collectable)
end

-- Draw the peg on screen!
function Peg:drawAtPosition(position, collectable)
   if collectable then
      self:drawCollectableState(position)

      love.graphics.setColor(240,240,240)
   else
      love.graphics.setColor(150,150,150,150)
   end

   love.graphics.circle("fill", position.x,
    position.y,
    Constants.PEG_RADIUS)

   if collectable then
      love.graphics.setColor(50, 50, 50)
      love.graphics.circle("line", position.x,
       position.y,
       Constants.PEG_RADIUS)
   end

   self:setPastellizedColor()
   love.graphics.draw(possibleSprites[self.spriteIndex],
    position.x-Constants.PEG_RADIUS,
    position.y-Constants.PEG_RADIUS)
end

--Pastellize the color w/o changing hue
function Peg:setPastellizedColor()
   local pastelR
   local pastelG
   local pastelB
   local delta
   if self.color.r > self.color.g and self.color.r > self.color.b then
      delta = 255 - self.color.r
   elseif self.color.g > self.color.r and self.color.g > self.color.b then
      delta = 255 - self.color.g
   else
      delta = 255 - self.color.b
   end

   pastelR = self.color.r + delta
   pastelG = self.color.g + delta
   pastelB = self.color.b + delta
   local alpha = 255

   if collectable then
      alpha = 150
   end

   love.graphics.setColor(pastelR, pastelG, pastelB)
end

function Peg:drawCollectableState(position)
   time = love.timer.getTime()

   love.graphics.setColor(200, 0, 0, 50)
   love.graphics.circle("fill", position.x, position.y, 15 + math.sin(((self.seed + time)/100) * 500) * 4)

   love.graphics.setColor(0, 200, 0, 50)
   love.graphics.circle("fill", position.x, position.y, 15 + math.sin(((self.seed + time)/100) * 200) * 6)

   love.graphics.setColor(0, 0, 200, 50)
   love.graphics.circle("fill", position.x, position.y, 15 + math.sin(((self.seed + time)/100) * 300) * 5)
end

-- Used for idiomatic module loading.
return Peg
