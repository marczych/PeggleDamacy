--Import your crap
------------------------
local Utils = require "utils.utils"
local Class = require "hump.class"
local Vector = require "hump.vector"
local Constants = require "utils.constants"

-------- Class ----------
-------------------------
local Bucket = Class {
	init = function(self, xCoord, colour)
		self.location = xCoord 
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
	love.graphics.rectangle("fill", 
		self.location-(Constants.BUCKET_WIDTH/2), 
		Constants.SCREEN_HEIGHT-Constants.BUCKET_HEIGHT,
		Constants.BUCKET_WIDTH, Constants.BUCKET_HEIGHT)
end


--RETURN
return Bucket
