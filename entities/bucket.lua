--Import your crap
------------------------
local Utils = require "utils.utils"
local Class = require "hump.class"
local Vector = require "hump.vector"
local Constants = require "utils.constants"

-------- Class ----------
-------------------------
local Bucket = Class {
	init = function(self, locat, colour)
		self.location = locat
		self.color = colour
	end,
}

--Update
--------------------------
function Bucket:update(dt)
	--TODO just animate I guess. If we were reall dumb we could move these
	--Or something
end

--Draw
--------------------------
function Bucket:draw()
	love.graphics.rectangle("fill", self.location.x, self.location.y, 40,80)
end


--RETURN
return Bucket
