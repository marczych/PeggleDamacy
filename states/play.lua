--Import shit
--------------------
local BG = require "entities.background"


local play = {}
local Background = BG()

function play:enter()
	
end

function play:update(dt)

end

function play:draw()
   love.graphics.setColor(125, 100, 200)
   love.graphics.print("Play!", 200, 200)
   
   Background.draw()
end

function play:keypressed(key, unicode)
end

return play
