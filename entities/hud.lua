local Hud = Class{
   init = function(self)
   end
}

function Hud:init()
end

function Hud:update(dt)
end

function Hud:draw()
   love.graphics.print('HUD!', Constants.SCREEN_WIDTH / 2, Constants.HUD_HEIGHT / 2)
end

return Hud
