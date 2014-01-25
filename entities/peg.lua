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

Peg = Class{
   init = function(self)
      -- Spawn pegs in a random Vector location
      self.position = Utils.randomPegLocation()
      self.wavelength = Utils.randomWavelength()
      self.color = Utils.wavelengthToRGB(self.wavelength)
      self.spriteIndex = math.floor( math.random(#possibleSprites))
      
   end
}

-- Update everything about the peg
function Peg:update(dt)
   -- Don't think this is really necessary.
   self.time = self.time + dt

end

function Peg:draw()
   self:drawAtPosition(self.position)
end

-- Draw the peg on screen!
function Peg:drawAtPosition(position)
   -- TODO: use self.color instead
   love.graphics.setColor(self.color.r, self.color.g, self.color.b)
   --love.graphics.circle("fill", position.x, position.y, Constants.PEG_RADIUS)
   love.graphics.draw(possibleSprites[self.spriteIndex], position.x,
   	position.y)
end

-- Used for idiomatic module loading.
return Peg
