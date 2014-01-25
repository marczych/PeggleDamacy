local Gamestate = require "hump.gamestate"

local title = {}

function title:enter()

end

function title:update(dt)

end

function title:draw()
   love.graphics.print("Peggle Damacy!", 200, 200)
end

function title:keypressed(key, unicode)
   Gamestate.switch(play)
end

return title
