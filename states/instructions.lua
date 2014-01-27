local BackGround = require "entities.background"
local background = BackGround()

local imgTitle = love.graphics.newImage("assets/images/instructions.png")

local title = {}

function title:enter()
end

function title:update(dt)
	background:update(dt)
end

function title:draw()
   love.graphics.setColor(255, 255, 255)
   background:draw()
   --love.graphics.print("Peggle Damacy!", 200, 200)
   love.graphics.draw(imgTitle, Constants.SCREEN_WIDTH/8, 20)
end

function title:mousepressed(key, unicode)
   Sound.stopChris()
   Gamestate.switch(States.play)
end

return title
