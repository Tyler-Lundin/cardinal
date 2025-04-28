local SharedUtils = {}

function SharedUtils.printDebug(message, ...)
    print("[DEBUG]", message, ...)
end

function SharedUtils.formatTime(seconds)
    local minutes = math.floor(seconds / 60)
    local remainingSeconds = seconds % 60
    return string.format("%02d:%02d", minutes, remainingSeconds)
end

return SharedUtils 