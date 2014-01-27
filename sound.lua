local mainMusic = {}
local chris = {}
local scale = {}

local isChrising
local sound = Class {
   init = function(self)
      chris = love.audio.newSource("assets/sounds/chris.ogg", "static")
      chris:setLooping(true)
      isChrising = false
      table.insert(scale, love.audio.newSource("assets/sounds/pegs/c1.ogg", "static"))
      table.insert(scale, love.audio.newSource("assets/sounds/pegs/d1.ogg", "static"))
      table.insert(scale, love.audio.newSource("assets/sounds/pegs/e1.ogg", "static"))
      table.insert(scale, love.audio.newSource("assets/sounds/pegs/f1.ogg", "static"))
      table.insert(scale, love.audio.newSource("assets/sounds/pegs/g1.ogg", "static"))
      table.insert(scale, love.audio.newSource("assets/sounds/pegs/a1.ogg", "static"))
      table.insert(scale, love.audio.newSource("assets/sounds/pegs/b1.ogg", "static"))
      table.insert(scale, love.audio.newSource("assets/sounds/pegs/c2.ogg", "static"))
      table.insert(scale, love.audio.newSource("assets/sounds/pegs/d2.ogg", "static"))
      table.insert(scale, love.audio.newSource("assets/sounds/pegs/e2.ogg", "static"))
      table.insert(scale, love.audio.newSource("assets/sounds/pegs/f2.ogg", "static"))
      table.insert(scale, love.audio.newSource("assets/sounds/pegs/g2.ogg", "static"))
      table.insert(scale, love.audio.newSource("assets/sounds/pegs/a2.ogg", "static"))
      table.insert(scale, love.audio.newSource("assets/sounds/pegs/b2.ogg", "static"))

      if math.random(1, 2) == 1 then
         mainMusic = love.audio.newSource("assets/sounds/bassjam.ogg", "static")
      else
         mainMusic = love.audio.newSource("assets/sounds/guitarjam.ogg", "static")
      end

      mainMusic:setLooping(true)
      mainMusic:setVolume(5)
   end
}

function sound.playGameMusic()
   if math.random(1, 2) == 1 then
      mainMusic = love.audio.newSource("assets/sounds/bassjam.ogg", "static")
   else
      mainMusic = love.audio.newSource("assets/sounds/guitarjam.ogg", "static")
   end

   mainMusic:setLooping(true)
   mainMusic:setVolume(5)
   mainMusic:rewind()
   mainMusic:play()
end

function sound.stopMusic()
   mainMusic:stop()
end

function sound.playChris()
   if isChrising == false then
      chris:setVolume(5)
      chris:play()
      isChrising = true
   end
end

function sound.stopChris()
   if isChrising == true then
      chris:stop()
      isChrising = false
   end
end

function sound.playPeg(index)
   scale[index]:setVolume(5)
   scale[index]:play()
end

return sound
