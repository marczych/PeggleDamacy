local BackGround = require "entities.background"
local background = BackGround()

local credits = {}

function credits:enter()
   -- Create and set a default 55 point font
   titleFont = love.graphics.newFont(55)

   -- Create and set a default 30 point font
   creditFont = love.graphics.newFont(30)
end

function credits:update(dt)
end

function credits:draw()
   background:draw()

   -- Use the larger title font 
   love.graphics.setFont(titleFont)
   love.graphics.print("Peggle Damacy!", 350, Constants.SCREEN_HEIGHT * .2)

   -- Use the credit font
   love.graphics.setFont(creditFont)

   love.graphics.print("Marc Zych!", 220, 260)
   love.graphics.print("Katherine Blizard!", 240, 320)
   love.graphics.print("Taylor Arnicar!", 260, 380)
   love.graphics.print("Chris Patton!", 280, 440)
end

function credits:keypressed(key, unicode)
   Gamestate.switch(States.title)
end

return credits 
