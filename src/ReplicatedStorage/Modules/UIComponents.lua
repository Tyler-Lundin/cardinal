local UIComponents = {}
local UIUtils = require(script.Parent.UIUtils)

-- Button states
local BUTTON_STATES = {
    DEFAULT = "Default",
    HOVER = "Hover",
    PRESSED = "Pressed",
    DISABLED = "Disabled"
}

-- Button theme
local BUTTON_THEME = {
    [BUTTON_STATES.DEFAULT] = {
        BackgroundColor3 = Color3.fromRGB(45, 45, 45),
        TextColor3 = Color3.fromRGB(255, 255, 255),
        BorderColor3 = Color3.fromRGB(100, 100, 100)
    },
    [BUTTON_STATES.HOVER] = {
        BackgroundColor3 = Color3.fromRGB(55, 55, 55),
        TextColor3 = Color3.fromRGB(255, 255, 255),
        BorderColor3 = Color3.fromRGB(120, 120, 120)
    },
    [BUTTON_STATES.PRESSED] = {
        BackgroundColor3 = Color3.fromRGB(35, 35, 35),
        TextColor3 = Color3.fromRGB(200, 200, 200),
        BorderColor3 = Color3.fromRGB(80, 80, 80)
    },
    [BUTTON_STATES.DISABLED] = {
        BackgroundColor3 = Color3.fromRGB(30, 30, 30),
        TextColor3 = Color3.fromRGB(150, 150, 150),
        BorderColor3 = Color3.fromRGB(70, 70, 70)
    }
}

function UIComponents.createButton(props)
    local button = UIUtils.createTextButton({
        Name = props.Name or "Button",
        Size = props.Size or UDim2.new(0, 100, 0, 30),
        Position = props.Position or UDim2.new(0, 0, 0, 0),
        Text = props.Text or "Button",
        TextSize = props.TextSize or 14,
        AutoButtonColor = false,
        BackgroundColor3 = BUTTON_THEME[BUTTON_STATES.DEFAULT].BackgroundColor3,
        TextColor3 = BUTTON_THEME[BUTTON_STATES.DEFAULT].TextColor3,
        BorderColor3 = BUTTON_THEME[BUTTON_STATES.DEFAULT].BorderColor3,
        BorderSizePixel = 1,
    })

    -- Add hover effect
    local function updateButtonState(state)
        local theme = BUTTON_THEME[state]
        button.BackgroundColor3 = theme.BackgroundColor3
        button.TextColor3 = theme.TextColor3
        button.BorderColor3 = theme.BorderColor3
    end

    -- Create a wrapper table to hold the button and its state
    local buttonWrapper = {
        instance = button,
        isDisabled = false
    }

    -- Add event connections
    button.MouseEnter:Connect(function()
        if not buttonWrapper.isDisabled then
            updateButtonState(BUTTON_STATES.HOVER)
        end
    end)

    button.MouseLeave:Connect(function()
        if not buttonWrapper.isDisabled then
            updateButtonState(BUTTON_STATES.DEFAULT)
        end
    end)

    button.MouseButton1Down:Connect(function()
        if not buttonWrapper.isDisabled then
            updateButtonState(BUTTON_STATES.PRESSED)
        end
    end)

    button.MouseButton1Up:Connect(function()
        if not buttonWrapper.isDisabled then
            updateButtonState(BUTTON_STATES.HOVER)
        end
    end)

    -- Add disabled state functionality
    function buttonWrapper:SetDisabled(disabled)
        self.isDisabled = disabled
        if disabled then
            updateButtonState(BUTTON_STATES.DISABLED)
        else
            updateButtonState(BUTTON_STATES.DEFAULT)
        end
    end

    -- Add click event
    function buttonWrapper:Connect(callback)
        button.MouseButton1Click:Connect(function()
            if not self.isDisabled then
                callback()
            end
        end)
    end

    return buttonWrapper
end

return UIComponents 