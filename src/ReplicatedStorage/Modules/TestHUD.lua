local TestHUD = {}
local UIUtils = require(script.Parent.UIUtils)
local UIComponents = require(script.Parent.UIComponents)

function TestHUD.create()
    local playerGui = game:GetService("Players").LocalPlayer:WaitForChild("PlayerGui")
    
    -- Create main screen GUI
    local screenGui = Instance.new("ScreenGui")
    screenGui.Name = "TestHUD"
    screenGui.ResetOnSpawn = false
    
    -- Create main container
    local mainFrame = UIUtils.createFrame({
        Name = "MainFrame",
        Size = UDim2.new(0, 200, 0, 150),
        Position = UDim2.new(0.5, -100, 0.5, -75),
        BackgroundColor3 = Color3.fromRGB(45, 45, 45),
        BorderSizePixel = 0,
    })
    
    -- Create title
    local title = UIUtils.createTextLabel({
        Name = "Title",
        Size = UDim2.new(1, 0, 0, 30),
        Position = UDim2.new(0, 0, 0, 0),
        BackgroundColor3 = Color3.fromRGB(35, 35, 35),
        Text = "Test HUD",
        TextColor3 = Color3.fromRGB(255, 255, 255),
        TextSize = 18,
    })
    
    -- Create counter display
    local counter = UIUtils.createTextLabel({
        Name = "Counter",
        Size = UDim2.new(1, 0, 0, 40),
        Position = UDim2.new(0, 0, 0, 40),
        BackgroundTransparency = 1,
        Text = "Counter: 0",
        TextColor3 = Color3.fromRGB(255, 255, 255),
        TextSize = 24,
    })
    
    -- Create increment button using new component
    local incrementButton = UIComponents.createButton({
        Name = "IncrementButton",
        Size = UDim2.new(0.4, 0, 0, 30),
        Position = UDim2.new(0.05, 0, 0, 90),
        Text = "Increment",
        TextSize = 14,
    })
    incrementButton.instance.Parent = mainFrame
    
    -- Create reset button using new component
    local resetButton = UIComponents.createButton({
        Name = "ResetButton",
        Size = UDim2.new(0.4, 0, 0, 30),
        Position = UDim2.new(0.55, 0, 0, 90),
        Text = "Reset",
        TextSize = 14,
    })
    resetButton.instance.Parent = mainFrame
    
    -- Parent all elements
    mainFrame.Parent = screenGui
    title.Parent = mainFrame
    counter.Parent = mainFrame
    screenGui.Parent = playerGui
    
    return {
        screenGui = screenGui,
        counter = counter,
        incrementButton = incrementButton,
        resetButton = resetButton
    }
end

-- Make sure the module is properly exposed
return TestHUD 