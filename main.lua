Gamestate = require "hump.gamestate"
Constants = require "utils.constants"
Utils = require "utils.utils"
Class = require "hump.class"

-- Load game states.

States = {
   title = require "states.title",
   play = require "states.play"
}

function love.load()
   -- Register the game state dispatcher and switch into the initial state.
   Gamestate.registerEvents()
   Gamestate.switch(States.title)
end
