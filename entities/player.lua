Player = Class{
   init = function(self)
      self.ballsRemaining = constants.STARTING_BALLS
      self.availableSpectrum = {}
      self.score = 0
   end
}

-- Not much to update here yet.
function Player:update(dt)
   -- Don't think this is really necessary.
   self.time = self.time + dt

   -- TODO: Update score.
   -- TODO: Update ballsRemaining.
   -- TODO: Update availableSpectrum.

end

-- Since the player is never drawn, do we even need this function?
function Player:draw()
end

return Player
