--Require any Modules
--------------------------------
local Class = require "hump.class"
local Constants = require "utils.constants"
local Utils = require "utils.utils"

local imgBackground = love.graphics.newImage("assets/images/background.png")
local imgParallax = love.graphics.newImage("assets/images/parallax1.png")

--Class Definition n Constructor
--------------------------------
local Background = Class{
	init = function(self)

		self.parallax1 = 0
		self.parallax2 = .2
		self.parallax3 = .5

		self.isPaused = false
	end
}

--Update
-------------------------------
function Background:update(dt)
	local scroll = (.01 * dt)
	self.parallax1 = self.parallax1 + scroll
	self.parallax2 = self.parallax2 + (scroll*2)
	self.parallax3 = self.parallax3 + (scroll*4)

	if(self.parallax1 >= 1) then
		self.parallax1 = 0
	end

	if(self.parallax2 >= 1) then
		self.parallax2 = 0;
	end

	if(self.parallax3 >= 1) then
		self.parallax3 = 0;
	end
end

function Background:togglePause()
	self.isPaused = not self.isPaused
end

--Draw
-------------------------------
function Background:draw(dt)
	love.graphics.draw(imgBackground, 500, 500)	
end
