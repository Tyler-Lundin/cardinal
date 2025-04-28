local InitialMenu = {}

-- Game rules text
local GAME_RULES = [[
Prison Royale Rules:

1. Teams:
   - Guards: Maintain order, prevent escapes
   - Prisoners: Try to escape or rebel
   - Warden: Selected from Guards, has special abilities

2. Gameplay:
   - 20-minute rounds
   - Guards can use weapons
   - Prisoners can find weapons or rebel
   - Warden can give orders to Guards

3. Objectives:
   - Guards: Prevent escapes, maintain order
   - Prisoners: Escape or overthrow the prison
]]

local MouseController = require(game:GetService("ReplicatedStorage").Modules.MouseController)

function InitialMenu.create()
    print("InitialMenu.create() called")
    local playerGui = game:GetService("Players").LocalPlayer:WaitForChild("PlayerGui")
    print("Got PlayerGui")
    
    -- Disable default Roblox UI
    game:GetService("StarterGui"):SetCoreGuiEnabled(Enum.CoreGuiType.All, false)
    
    -- Create main screen GUI
    local screenGui = Instance.new("ScreenGui") 
    screenGui.Name = "InitialMenu"
    screenGui.ResetOnSpawn = false
    screenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
    screenGui.DisplayOrder = 100 -- High z-index to ensure it's on top
    screenGui.IgnoreGuiInset = true -- <<<<<< ADD THIS LINE
    print("Created ScreenGui")
    
    -- Notify MouseController that a menu is open
    MouseController.menuOpened()
    
    -- Create main container
    local mainFrame = Instance.new("Frame")
    mainFrame.Name = "MainFrame"
    mainFrame.Size = UDim2.new(1, 0, 1, 0)
    mainFrame.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
    mainFrame.BackgroundTransparency = 0.2
    mainFrame.Parent = screenGui
    print("Created main frame")
    
    -- Create rules container
    local rulesFrame = Instance.new("Frame")
    rulesFrame.Name = "RulesFrame"
    rulesFrame.Size = UDim2.new(0.6, 0, 0.7, 0)
    rulesFrame.Position = UDim2.new(0.2, 0, 0.15, 0)
    rulesFrame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
    rulesFrame.BorderSizePixel = 0
    rulesFrame.Parent = mainFrame
    print("Created rules frame")
    
    -- Create rules title
    local rulesTitle = Instance.new("TextLabel")
    rulesTitle.Name = "RulesTitle"
    rulesTitle.Size = UDim2.new(1, 0, 0, 50)
    rulesTitle.Position = UDim2.new(0, 0, 0, 0)
    rulesTitle.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
    rulesTitle.Text = "Game Rules"
    rulesTitle.TextColor3 = Color3.fromRGB(255, 255, 255)
    rulesTitle.TextSize = 24
    rulesTitle.Font = Enum.Font.GothamBold
    rulesTitle.Parent = rulesFrame
    print("Created rules title")
    
    -- Create rules text
    local rulesText = Instance.new("TextLabel")
    rulesText.Name = "RulesText"
    rulesText.Size = UDim2.new(1, -40, 1, -60)
    rulesText.Position = UDim2.new(0, 20, 0, 50)
    rulesText.BackgroundTransparency = 1
    rulesText.Text = GAME_RULES
    rulesText.TextColor3 = Color3.fromRGB(200, 200, 200)
    rulesText.TextSize = 18
    rulesText.TextWrapped = true
    rulesText.TextXAlignment = Enum.TextXAlignment.Left
    rulesText.TextYAlignment = Enum.TextYAlignment.Top
    rulesText.Font = Enum.Font.Gotham
    rulesText.Parent = rulesFrame
    print("Created rules text")
    
    -- Create team selection container
    local teamFrame = Instance.new("Frame")
    teamFrame.Name = "TeamFrame"
    teamFrame.Size = UDim2.new(0.3, 0, 0.2, 0)
    teamFrame.Position = UDim2.new(0.35, 0, 0.87, 0)
    teamFrame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
    teamFrame.BorderSizePixel = 0
    teamFrame.Parent = mainFrame
    print("Created team frame")
    
    -- Create team title
    local teamTitle = Instance.new("TextLabel")
    teamTitle.Name = "TeamTitle"
    teamTitle.Size = UDim2.new(1, 0, 0, 40)
    teamTitle.Position = UDim2.new(0, 0, 0, 0)
    teamTitle.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
    teamTitle.Text = "Select Your Team"
    teamTitle.TextColor3 = Color3.fromRGB(255, 255, 255)
    teamTitle.TextSize = 20
    teamTitle.Font = Enum.Font.GothamBold
    teamTitle.Parent = teamFrame
    print("Created team title")
    
    -- Create prisoner button
    local prisonerButton = Instance.new("TextButton")
    prisonerButton.Name = "PrisonerButton"
    prisonerButton.Size = UDim2.new(0.4, 0, 0.6, 0)
    prisonerButton.Position = UDim2.new(0.05, 0, 0.4, 0)
    prisonerButton.BackgroundColor3 = Color3.fromRGB(50, 50, 200) -- Blue for prisoners
    prisonerButton.Text = "Prisoner"
    prisonerButton.TextColor3 = Color3.fromRGB(255, 255, 255)
    prisonerButton.TextSize = 18
    prisonerButton.Font = Enum.Font.GothamBold
    prisonerButton.Parent = teamFrame
    print("Created prisoner button")
    
    -- Create guard button
    local guardButton = Instance.new("TextButton")
    guardButton.Name = "GuardButton"
    guardButton.Size = UDim2.new(0.4, 0, 0.6, 0)
    guardButton.Position = UDim2.new(0.55, 0, 0.4, 0)
    guardButton.BackgroundColor3 = Color3.fromRGB(200, 50, 50) -- Red for guards
    guardButton.Text = "Guard"
    guardButton.TextColor3 = Color3.fromRGB(255, 255, 255)
    guardButton.TextSize = 18
    guardButton.Font = Enum.Font.GothamBold
    guardButton.Parent = teamFrame
    print("Created guard button")
    
    -- Parent the screen GUI
    screenGui.Parent = playerGui
    print("Parented screen GUI to PlayerGui")
    
    -- Add cleanup connection
    local cleanupConnection
    cleanupConnection = screenGui.Destroying:Connect(function()
        cleanupConnection:Disconnect() -- Prevent multiple cleanup calls
        MouseController.menuClosed()
        -- Re-enable default Roblox UI
        game:GetService("StarterGui"):SetCoreGuiEnabled(Enum.CoreGuiType.All, true)
    end)
    
    return {
        screenGui = screenGui,
        prisonerButton = prisonerButton,
        guardButton = guardButton,
        destroy = function()
            if screenGui and screenGui.Parent then
                screenGui:Destroy()
            end
        end
    }
end

return InitialMenu 