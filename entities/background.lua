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

		--parallax update
		self.parallax1 = 0
		self.parallax2 = .2
		self.parallax3 = .5

		--parallax draw
		self.pos1 = 0;
		self.pos2 = 0;
		self.pos3 = 0;

		self.isPaused = false
	end,
}

--Update
-------------------------------
function Background:update(dt)
	local scroll = (.01 * dt)
	self.parallax1 = self.parallax1 + scroll
	self.parallax2 = self.parallax2 + (scroll*2)
	self.parallax3 = self.parallax3 + (scroll*4)

	if(self.parallax1 >= 2) then
		self.parallax1 = 0
	end

	if(self.parallax2 >= 2) then
		self.parallax2 = 0;
	end

	if(self.parallax3 >= 2) then
		self.parallax3 = 0;
	end
end

function Background:togglePause()
	self.isPaused = not self.isPaused
end

--Draw
-------------------------------
function Background:draw(dt)
	love.graphics.draw(imgBackground, 0, 0)	
	
	self.pos1 = Utils.numberInterpolate(0, 0, Constants.SCREEN_HEIGHT, self.parallax1)
	self.pos2 = Utils.numberInterpolate(0, 0, Constants.SCREEN_HEIGHT, self.parallax2)
	self.pos3 = Utils.numberInterpolate(0, 0, Constants.SCREEN_HEIGHT, self.parallax3)

	love.graphics.draw(imgParallax, 0, self.pos1)
	love.graphics.draw(imgParallax, -10, self.pos1-Constants.SCREEN_HEIGHT)
	love.graphics.draw(imgParallax, 20, self.pos2)
	love.graphics.draw(imgParallax, -20, self.pos2-Constants.SCREEN_HEIGHT)
	love.graphics.draw(imgParallax, 40, self.pos3)
	love.graphics.draw(imgParallax, -40, self.pos3-Constants.SCREEN_HEIGHT)
end


-- Return the class so lua is not confused about booleans
---------------------------------------------------------
-- Very important you know
return Background
