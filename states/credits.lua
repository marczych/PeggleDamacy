local BackGround = require "entities.background"
local background = BackGround()
local imgTitle = love.graphics.newImage("assets/images/endtitle.png")

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
   love.graphics.setColor(175, 40, 60)
   background:draw()

   -- Use the larger title font 
   --love.graphics.setFont(titleFont)
   love.graphics.setColor(200, 255, 200)
   --love.graphics.print("Peggle Damacy!", 310, Constants.SCREEN_HEIGHT * .2)
   love.graphics.draw(imgTitle, 0, 0)

   -- Use the credit font
   love.graphics.setFont(creditFont)
   love.graphics.setColor(50, 200, 150)

   love.graphics.print("Marc Zych!", 220, 260)
   love.graphics.print("Katherine Blizard!", 250, 320)
   love.graphics.print("Taylor Arnicar!", 290, 380)
   love.graphics.print("Chris Patton!", 320, 440)
   love.graphics.print("Thomas Soria!", 350, 500)
end

function credits:keypressed(key, unicode)
   Gamestate.switch(States.title)
end

return credits 
