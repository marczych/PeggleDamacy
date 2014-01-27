local mainMusic = {}
local scale = {}

local sound = Class {
   init = function(self)
      --table.insert(scale, love.audio.newSource("assets/sounds/c1.ogg", "static"))
      --table.insert(scale, love.audio.newSource("assets/sounds/d1.ogg", "static"))
      --table.insert(scale, love.audio.newSource("assets/sounds/e1.ogg", "static"))
      --table.insert(scale, love.audio.newSource("assets/sounds/f1.ogg", "static"))
      --table.insert(scale, love.audio.newSource("assets/sounds/g1.ogg", "static"))
      --table.insert(scale, love.audio.newSource("assets/sounds/a1.ogg", "static"))
      --table.insert(scale, love.audio.newSource("assets/sounds/b1.ogg", "static"))
      --table.insert(scale, love.audio.newSource("assets/sounds/c2.ogg", "static"))
      --table.insert(scale, love.audio.newSource("assets/sounds/d2.ogg", "static"))
      --table.insert(scale, love.audio.newSource("assets/sounds/e2.ogg", "static"))
      --table.insert(scale, love.audio.newSource("assets/sounds/f2.ogg", "static"))
      --table.insert(scale, love.audio.newSource("assets/sounds/g2.ogg", "static"))
      --table.insert(scale, love.audio.newSource("assets/sounds/a2.ogg", "static"))
      --table.insert(scale, love.audio.newSource("assets/sounds/b2.ogg", "static"))

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
   mainMusic:setVolume(5)
   mainMusic:rewind()
   mainMusic:play()
end

return sound
