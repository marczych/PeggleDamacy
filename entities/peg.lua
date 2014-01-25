Peg = Class{
   init = function(self)
      -- Spawn pegs in a random Vector location
      self.position = Utils.randomPegLocation()
      self.wavelength = Utils.randomWavelength()
      self.color = Utils.wavelengthToRGB(self.wavelength)
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
   love.graphics.circle("fill", position.x, position.y, Constants.PEG_RADIUS)
end

-- Used for idiomatic module loading.
return Peg
