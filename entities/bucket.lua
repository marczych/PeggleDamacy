--Import your crap
------------------------
local Utils = require "utils.utils"
local Class = require "hump.class"
local Vector = require "hump.vector"
local Constants = require "utils.constants"

-------- Class ----------
-------------------------
local Bucket = Class {
	init = function(self, colour)
		self.location = xCoord 
		self.color = colour
		self.swing = .5
		self.positive = true
	end,
}

--Update
--------------------------
function Bucket:update(dt)
	if(self.positive) then
		self.swing = self.swing + dt*.25
	else
		self.swing = self.swing - dt*.25
	end

	if(self.swing >= 1) then
		self.positive = false
	end
	if (self.swing <= 0) then
		self.positive = true
	end

	self.location = Utils.numberInterpolate(0, 0, Constants.SCREEN_WIDTH,
		self.swing)
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
