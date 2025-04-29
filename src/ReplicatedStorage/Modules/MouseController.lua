-- ReplicatedStorage/Modules/MouseController.lua

local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")
local player = Players.LocalPlayer

local MouseController = {}

-- Internal state
local menusOpen = 0
local isMouseUnlocked = false

function MouseController:_updateMouseState()
    if menusOpen > 0 or isMouseUnlocked then
        -- A menu is open or F2 is toggled => Unlock mouse and show cursor
        player.CameraMode = Enum.CameraMode.Classic
        player.CameraMinZoomDistance = 0
        player.CameraMaxZoomDistance = 0 -- Disable zoom completely
        UserInputService.MouseBehavior = Enum.MouseBehavior.Default
        UserInputService.MouseIconEnabled = true
    else
        -- No menus open and F2 not toggled => Lock first person and hide cursor
        player.CameraMinZoomDistance = 0
        player.CameraMaxZoomDistance = 0
        player.CameraMode = Enum.CameraMode.LockFirstPerson
        UserInputService.MouseBehavior = Enum.MouseBehavior.LockCenter
        UserInputService.MouseIconEnabled = false
    end
end

-- Handle F2 key input
UserInputService.InputBegan:Connect(function(input, gameProcessed)
    if input.KeyCode == Enum.KeyCode.F2 and not gameProcessed then
        isMouseUnlocked = not isMouseUnlocked
        MouseController:_updateMouseState()
    end
end)

function MouseController.menuOpened()
    menusOpen += 1
    MouseController:_updateMouseState()
end

function MouseController.menuClosed()
    menusOpen = math.max(menusOpen - 1, 0)
    MouseController:_updateMouseState()
end

return MouseController


