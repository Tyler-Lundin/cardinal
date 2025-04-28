local UIUtils = {}

function UIUtils.createFrame(props)
    local frame = Instance.new("Frame")
    for prop, value in pairs(props) do
        frame[prop] = value
    end
    return frame
end

function UIUtils.createTextLabel(props)
    local label = Instance.new("TextLabel")
    for prop, value in pairs(props) do
        label[prop] = value
    end
    return label
end

function UIUtils.createTextButton(props)
    local button = Instance.new("TextButton")
    for prop, value in pairs(props) do
        button[prop] = value
    end
    return button
end

return UIUtils 