Peg = Class{
   init = function(self)
      self.location = Utils.randomLocation()
      self.wavelength = Utils.randomWavelength()
      self.color = Utils.wavelengthToRGB(wavelength)
   end
}

-- Update everything about the peg
function Peg:update(dt)
   -- Don't think this is really necessary.
   self.time = self.time + dt

   -- TODO: Collision detection - attach this peg to the ball
   --       and remove it its current location?

end

-- Draw the peg on screen!
function Peg:draw()
end

-- Used for idiomatic module loading.
return Peg
