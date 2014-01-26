local imgLeft = love.graphics.newImage("assets/images/hudleft.png")
local imgCannon = love.graphics.newImage("assets/images/cannon.png")
local imgMeter = love.graphics.newImage("assets/images/meter.png")

local Hud = Class{
   init = function(self)
      self.spectrumColors = Utils.calculateSpectrumColors()
      -- Create a default 20 point font
      font = love.graphics.newFont(20)
   end
}

function Hud:update(dt)
end

function Hud:draw(score, ballsRemaining, availableSpectra)
	--love.graphics.setColor(0, 0, 0)
	--love.graphics.rectangle("fill", 0, 0, Constants.SCREEN_WIDTH, Constants.HUD_HEIGHT)

   -- Draw the HUD graphic
   love.graphics.setFont(font)
	love.graphics.setColor(255, 255, 255)
   love.graphics.draw(imgLeft,0,0)

   -- Draw the HUD text
	love.graphics.setColor(0, 0, 0)
   love.graphics.print('Balls: ' .. ballsRemaining, 75, 25)
   love.graphics.print('Score: ' .. score, 45, 55)

   -- Draw the Cannon
   love.graphics.setColor(255,255,255)
   love.graphics.draw(imgCannon, Constants.SCREEN_WIDTH/2 - 100, 0)

   -- Draw the available spectrum segments
   local spectrumHeight = Constants.HUD_HEIGHT / 2
   -- Start drawing the spectrum with enough space to fit all of it with a 15 px buffer
   local x0 = (Constants.SCREEN_WIDTH - 15) - (Constants.MAX_WAVELENGTH - Constants.MIN_WAVELENGTH)
   -- We'll draw the line starting close to the top 
   local y1 = spectrumHeight /6 
   -- And we'll draw downwards for half of the HUD_HEIGHT 
   local y2 = y1 + spectrumHeight

   -- For each of the colors in the spectrum
   for wv, color in pairs(self.spectrumColors) do
      
      -- We'll draw this line of the spectrum at an offset from x0
      local x = x0 + wv - Constants.MIN_WAVELENGTH
      if(Utils.getSection(wv, availableSpectra) == false) then
	    love.graphics.setColor(128,128,128)
	else
	    love.graphics.setColor(color.r, color.g, color.b)
	end
      -- Actually draw the vertical line for this color
      love.graphics.line(x, y1, x, y2)
   end

   --Now draw the spectrum's meter
   love.graphics.setColor(255,255,255)
   love.graphics.draw(imgMeter, 
   	Constants.SCREEN_WIDTH-Constants.METER_OFFSET, 0)
end

return Hud
