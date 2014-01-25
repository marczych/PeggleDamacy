-- Require any needed modules.
local Class = require "hump.class"
local constants = require "constants"
local utils = require "utils"

-- Define the class (and constructor).
Player = Class{
   init = function(self)
   end,

   ballsRemaining = constants.STARTING_BALLS
   availableSpectrum = {}
   score = 0
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

-- Used for idiomatic module loading.
return Player
