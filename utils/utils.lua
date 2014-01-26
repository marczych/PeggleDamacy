local Utils = {}
-- Make sure we get "real random" numbers
math.randomseed(os.time())

-- Don't allow pegs to spawn in the top 25%, bottom 10%, or in the
-- left 5% or right 5% of the screen. Return a random Vector of x & y
-- coordinates to spawn the peg.
function Utils.randomPegLocation(existingPegs)
   potentialLocation = nil

   -- Keep trying new positions as long as we haven't found a good one yet
   while Utils.invalidPosition(potentialLocation, existingPegs) do
      potentialLocation = Vector(math.random(Constants.SCREEN_WIDTH * .05, Constants.SCREEN_WIDTH * .95),
      math.random(Constants.SCREEN_HEIGHT * .25, Constants.SCREEN_HEIGHT * .90))
   end

   return potentialLocation;
end

function Utils.invalidPosition(potentialLocation, existingPegs)
   -- This is needed because of the way invalidPosition is written above
   if potentialLocation == nil then
      return true 
   end

   for i, peg in ipairs(existingPegs) do
      if potentialLocation:dist(Vector(peg.position.x, peg.position.y)) < 40 then
         return true
      end
   end
   return false
end


-- Given a peg of a given wavelength, which section of the available
-- spectrum can collect it? Return 1-indexed section, or Nil
function Utils.getSection(pegWavelength, availableSpectrum)
   for i, spectrumSection in ipairs(availableSpectrum) do
      if pegWavelength >= spectrumSection.lower and pegWavelength <= spectrumSection.upper then
         return i
      end
   end
   return false
end

-- Increase the spectrum in the section of the collected peg's wavelength
function Utils.increaseSpectrumSection(section, availableSpectrum)
   -- We assume the peg's wavelength is only inside one spectrum section.
   availableSpectrum[section].lower = availableSpectrum[section].lower - Constants.SPECTRUM_SECTION_INCREASE
   availableSpectrum[section].upper = availableSpectrum[section].upper + Constants.SPECTRUM_SECTION_INCREASE
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

function Utils.calculateSpectrumColors()
   local colors = {}
   for wv = Constants.MIN_WAVELENGTH, Constants.MAX_WAVELENGTH do
      colors[wv] = Utils.wavelengthToRGB(wv)
   end
   return colors
end

return Utils
