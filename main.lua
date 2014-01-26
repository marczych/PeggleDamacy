Gamestate = require "hump.gamestate"
Vector = require "hump.vector"
Constants = require "utils.constants"
Utils = require "utils.utils"
Class = require "hump.class"

-- Load game states.

States = {
   title = require "states.title",
   instructions = require "states.instructions",
   play = require "states.play",
   credits = require "states.credits"
}

function love.load()
   -- Register the game state dispatcher and switch into the initial state.
   Gamestate.registerEvents()
   Gamestate.switch(States.title)
end
