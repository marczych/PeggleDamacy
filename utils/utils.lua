local Utils = {}
-- Make sure we get "real random" numbers
math.randomseed(os.time())

-- Don't allow pegs to spawn in the top 20%, bottom 5%, or in the
-- left 5% or right 5% of the screen. Return a random Vector of x & y
-- coordinates to spawn the peg.
-- TODO: don't allow pegs to spawn in a location where another peg already exists.
function Utils.randomPegLocation()
   return Vector(math.random(Constants.SCREEN_WIDTH * .05, Constants.SCREEN_WIDTH * .95), 
   math.random(Constants.SCREEN_HEIGHT * .2, Constants.SCREEN_HEIGHT * .95))
end

function Utils.canCollect(pegWavelength, availableSpectrum) 
   print ("peg wavelength: " .. pegWavelength)
   for i, spectrumSection in ipairs(availableSpectrum) do
      print (spectrumSection.lower .. ", " .. spectrumSection.upper)
      if pegWavelength >= spectrumSection.lower and pegWavelength <= spectrumSection.upper then
         print ("Collected!")
         return true
      end
   end
   print ("Bounced!")
   return false 
end

function Utils.clamp(x, lower, upper)
   return math.max(lower, math.min(upper, x))
end

function Utils.randomWavelength()
   return math.floor(math.random(Constants.MIN_WAVELENGTH, Constants.MAX_WAVELENGTH))
end

function Utils.numberInterpolate(oldValue, min, max, u)
	return oldValue + (max-min)*u
end
--TODO vector interpolates

function Utils.wavelengthToRGB(wavelength)
   local r, g, b

   wavelength = Utils.clamp(wavelength, Constants.MIN_WAVELENGTH, Constants.MAX_WAVELENGTH)

   -- violet
   if wavelength < 410 then
      r = 0.6 - 0.41 * (410 - wavelength) / 30;
      g = 0;
      b = 0.39 + 0.6 * (410 - wavelength) / 30;
   -- purple to blue
   elseif wavelength < 440 then
      r = 0.19 - 0.19 * (440 - wavelength) / 30;
      g = 0;
      b = 1;
   -- blue to teal
   elseif wavelength < 490 then
      r = 0;
      g = 1 - (490 - wavelength) / 50;
      b = 1;
   -- teal to green
   elseif wavelength < 510 then
      r = 0;
      g = 1;
      b = (510 - wavelength) / 20;
   -- green to yellow
   elseif wavelength < 580 then
      r = 1 - (580 - wavelength) / 70;
      g = 1;
      b = 0;
   -- yellow to orange
   elseif wavelength < 640 then
      r = 1;
      g = (640 - wavelength) / 60;
      b = 0;
   -- red
   elseif wavelength < 700 then
      r = 1;
      g = 0;
      b = 0;
   -- dark red
   else
      r = 0.35 + 0.65 * (Constants.MAX_WAVELENGTH - wavelength) / 80;
      g = 0;
      b = 0;
   end

   return {
      r = r * 255,
      g = g * 255,
      b = b * 255
   }
end

return Utils
