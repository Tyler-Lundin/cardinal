-- ReplicatedStorage/Modules/MouseController.lua

local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")
local player = Players.LocalPlayer

local MouseController = {}

-- Internal state
local menusOpen = 0
local isQHeld = false

function MouseController:_updateMouseState()
    if menusOpen > 0 or isQHeld then
        -- A menu is open or Q is held => Unlock mouse and show cursor
        player.CameraMode = Enum.CameraMode.Classic
        player.CameraMinZoomDistance = 0
        player.CameraMaxZoomDistance = 10 -- Allow free view while menus open
        UserInputService.MouseBehavior = Enum.MouseBehavior.Default
        UserInputService.MouseIconEnabled = true
    else
        -- No menus open and Q not held => Lock first person and hide cursor
        player.CameraMinZoomDistance = 0
        player.CameraMaxZoomDistance = 0
        player.CameraMode = Enum.CameraMode.LockFirstPerson
        UserInputService.MouseBehavior = Enum.MouseBehavior.LockCenter
        UserInputService.MouseIconEnabled = false
    end
end

-- Handle Q key input
UserInputService.InputBegan:Connect(function(input, gameProcessed)
    if input.KeyCode == Enum.KeyCode.Q and not gameProcessed then
        isQHeld = true
        MouseController:_updateMouseState()
    end
end)

UserInputService.InputEnded:Connect(function(input, gameProcessed)
    if input.KeyCode == Enum.KeyCode.Q and not gameProcessed then
        isQHeld = false
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


