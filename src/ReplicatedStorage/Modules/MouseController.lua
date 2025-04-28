-- ReplicatedStorage/Modules/MouseController.lua

local Players = game:GetService("Players")
local player = Players.LocalPlayer

local MouseController = {}

-- Internal state
local menusOpen = 0

function MouseController:_updateMouseState()
    if menusOpen > 0 then
        -- A menu is open => Unlock mouse
        player.CameraMode = Enum.CameraMode.Classic
        player.CameraMinZoomDistance = 0
        player.CameraMaxZoomDistance = 10 -- Allow free view while menus open
    else
        -- No menus open => Lock first person
        player.CameraMinZoomDistance = 0
        player.CameraMaxZoomDistance = 0
        player.CameraMode = Enum.CameraMode.LockFirstPerson
    end
end

function MouseController.menuOpened()
    menusOpen += 1
    MouseController:_updateMouseState()
end

function MouseController.menuClosed()
    menusOpen = math.max(menusOpen - 1, 0)
    MouseController:_updateMouseState()
end

return MouseController
