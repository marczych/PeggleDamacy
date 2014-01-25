local Constants = require "utils.constants"

function love.conf(t)
   t.window.width = Constants.SCREEN_WIDTH
   t.window.height = Constants.SCREEN_HEIGHT
end
