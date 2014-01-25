local Gamestate = require "hump.gamestate"
local Constants = require "utils.constants"
local Utils = require "utils.utils"

-- Load game states.
title = require "states.title"

function love.load()
   -- Register the game state dispatcher and switch into the initial state.
   Gamestate.registerEvents()
   Gamestate.switch(title)
end
