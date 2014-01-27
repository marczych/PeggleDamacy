local BackGround = require "entities.background"
local background = BackGround()
local imgTitle = love.graphics.newImage("assets/images/endtitle.png")

local credits = {}
local pegCount
local score

function credits:enter(self, pegsCollected, totalScore)
   -- Create and set a default 55 point font
   titleFont = love.graphics.newFont(55)

   -- Create and set a default 30 point font
   creditFont = love.graphics.newFont(30)

   pegCount = pegsCollected
   score = totalScore
   Sound.playChris()
end

function credits:update(dt)
end

function credits:draw()
   love.graphics.setColor(0, 40, 60)
   background:draw()

   love.graphics.setColor(200, 255, 200)
   love.graphics.draw(imgTitle, Constants.SCREEN_WIDTH/8 , 0)

   -- Use the larger title font
   love.graphics.setFont(titleFont)
   love.graphics.setColor(50, 200, 150)
   percentage = pegCount / Constants.NUM_STARTING_PEGS
   if percentage > .75 then
      love.graphics.print("You Win!", 75, Constants.SCREEN_HEIGHT * .4)
   else
      love.graphics.print("You Lose!", 75, Constants.SCREEN_HEIGHT * .4)
   end
   love.graphics.print("Score: " .. score, 75, 350)

   -- Use the credit font
   love.graphics.setFont(creditFont)
   love.graphics.setColor(50, 200, 150)

   love.graphics.print("You collected:\n" .. pegCount .. " out of " .. 65 .. " pegs", 75, 500)

   love.graphics.print("Marc Zych!", 500, 350)
   love.graphics.print("Katherine Blizard!", 550, 400)
   love.graphics.print("Taylor Arnicar!", 600, 450)
   love.graphics.print("Chris Patton!", 650, 500)
   love.graphics.print("Thomas Soria!", 700, 550)

   love.graphics.print("(Press any key to restart)", 325, 650)
end

function credits:keypressed(key, unicode)
   Gamestate.switch(States.title)
end

return credits
