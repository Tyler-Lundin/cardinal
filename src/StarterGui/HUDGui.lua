local ReplicatedStorage = game:GetService("ReplicatedStorage")
local GameSettings = require(ReplicatedStorage.Modules.GameSettings)

-- Create basic HUD structure
local function createHUD()
    local screenGui = Instance.new("ScreenGui")
    screenGui.Name = "HUDGui"
    screenGui.ResetOnSpawn = false
    
    -- Main container
    local mainFrame = Instance.new("Frame")
    mainFrame.Name = "MainFrame"
    mainFrame.Size = UDim2.new(1, 0, 1, 0)
    mainFrame.BackgroundTransparency = 1
    mainFrame.Parent = screenGui
    
    -- Time display
    local timeLabel = Instance.new("TextLabel")
    timeLabel.Name = "TimeLabel"
    timeLabel.Size = UDim2.new(0, 200, 0, 50)
    timeLabel.Position = UDim2.new(0.5, -100, 0, 10)
    timeLabel.BackgroundTransparency = 0.5
    timeLabel.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
    timeLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
    timeLabel.TextSize = 24
    timeLabel.Text = "Time: 0:00"
    timeLabel.Parent = mainFrame
    
    -- Team display
    local teamLabel = Instance.new("TextLabel")
    teamLabel.Name = "TeamLabel"
    teamLabel.Size = UDim2.new(0, 200, 0, 30)
    teamLabel.Position = UDim2.new(0, 10, 0, 10)
    teamLabel.BackgroundTransparency = 0.5
    teamLabel.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
    teamLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
    teamLabel.TextSize = 18
    teamLabel.Text = "Team: Prisoner"
    teamLabel.Parent = mainFrame
    
    return screenGui
end

-- Initialize HUD
local hud = createHUD()
hud.Parent = game.Players.LocalPlayer:WaitForChild("PlayerGui")

-- Placeholder for HUD (round timer, announcements, rebel indicator, etc.)

return hud 