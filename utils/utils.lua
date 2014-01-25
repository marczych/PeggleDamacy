local Utils = {}

function Utils.clamp (x, lower, upper)
   return math.max(lower, math.min(upper, x))
end

function Utils.randomWavelength ()
   return math.floor(math.random(380, 780))
end

function Utils.wavelengthToRGB (wavelength)
   local r, g, b

   wavelength = Utils.clamp(wavelength, 380, 780)

   -- violet
   if wavelength < 410 then
      r = 0.6 - 0.41 * (410 - waveLength) / 30;
      g = 0;
      b = 0.39 + 0.6 * (410 - waveLength) / 30;
   -- purple to blue
   elseif wavelength < 440 then
      r = 0.19 - 0.19 * (440 - waveLength) / 30;
      g = 0;
      b = 1;
   -- blue to teal
   elseif wavelength < 490 then
      r = 0;
      g = 1 - (490 - waveLength) / 50;
      b = 1;
   -- teal to green
   elseif wavelength < 510 then
      r = 0;
      g = 1;
      b = (510 - waveLength) / 20;
   -- green to yellow
   elseif wavelength < 580 then
      r = 1 - (580 - waveLength) / 70;
      g = 1;
      b = 0;
   -- yellow to orange
   elseif wavelength < 640 then
      r = 1;
      g = (640 - waveLength) / 60;
      b = 0;
   -- red
   elseif wavelength < 700 then
      r = 1;
      g = 0;
      b = 0;
   -- dark red
   else
      r = 0.35 + 0.65 * (780 - waveLength) / 80;
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
