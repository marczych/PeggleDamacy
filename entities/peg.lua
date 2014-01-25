Peg = Class{
   init = function(self)
      -- Spawn pegs in a random Vector location
      self.position = Utils.randomPegLocation()
      -- self.wavelength = Utils.randomWavelength()
      -- self.color = Utils.wavelengthToRGB(wavelength)
   end
}

-- Update everything about the peg
function Peg:update(dt)
   -- Don't think this is really necessary.
   self.time = self.time + dt

   -- TODO: Collision detection - attach this peg to the ball
   --       and remove it its current location?

end

function Peg:draw()
   self:drawAtPosition(self.position)
end

-- Draw the peg on screen!
function Peg:drawAtPosition(position)
   -- TODO: use self.color instead
   love.graphics.setColor(250, 150, 100)
   love.graphics.circle("fill", position.x, position.y, Constants.PEG_RADIUS)
end

-- Used for idiomatic module loading.
return Peg