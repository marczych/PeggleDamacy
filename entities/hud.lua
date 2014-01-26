local imgLeft = love.graphics.newImage("assets/images/hudleft.png")

local Hud = Class{
   init = function(self)
      self.spectrumColors = Utils.calculateSpectrumColors()
      -- Create and set a default 20 point font
      font = love.graphics.newFont(20)
      love.graphics.setFont(font)
   end
}

function Hud:update(dt)
end

function Hud:draw(score, ballsRemaining, availableSpectra)
	--love.graphics.setColor(0, 0, 0)
	--love.graphics.rectangle("fill", 0, 0, Constants.SCREEN_WIDTH, Constants.HUD_HEIGHT)

   
	love.graphics.setColor(255, 255, 255)
   love.graphics.draw(imgLeft,0,0)
   love.graphics.print('Balls: ' .. ballsRemaining, 75, 25)
   love.graphics.print('Score: ' .. score, 35, 55)

   -- Draw the available spectrum segments
   local spectrumHeight = Constants.HUD_HEIGHT / 2
   local x0 = (Constants.SCREEN_WIDTH - 10) -
    (Constants.MAX_WAVELENGTH - Constants.MIN_WAVELENGTH)
   local y1 = spectrumHeight / 2
   local y2 = y1 + spectrumHeight

   for wv, color in pairs(self.spectrumColors) do
      local x = x0 + wv
      love.graphics.setColor(color.r, color.g, color.b)
      love.graphics.line(x, y1, x, y2)
   end
end

return Hud
