local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Players = game:GetService("Players")

-- Create Remotes folder if it doesn't exist
local function createRemotesFolder()
    print("Checking for Remotes folder...")
    local remotesFolder = ReplicatedStorage:FindFirstChild("Remotes")
    if not remotesFolder then
        print("Remotes folder not found, creating...")
        remotesFolder = Instance.new("Folder")
        remotesFolder.Name = "Remotes"
        remotesFolder.Parent = ReplicatedStorage
        print("Remotes folder created successfully")
    else
        print("Remotes folder already exists")
    end
    return remotesFolder
end

-- Handle team selection
local function onTeamSelected(player, selectedTeam)
    print("Team selection received for player:", player.Name, "Selected team:", selectedTeam)
    
    -- Get the teams
    local teams = game:GetService("Teams")
    local prisonerTeam = teams:FindFirstChild("Prisoners")
    local guardTeam = teams:FindFirstChild("Guards")
    print("Found teams - Prisoners:", prisonerTeam ~= nil, "Guards:", guardTeam ~= nil)
    
    -- Check if the player is already on a team
    if player.Team then
        print("Player is currently on team:", player.Team.Name)
        -- If they're already on the selected team, do nothing
        if player.Team.Name == selectedTeam then
            print("Player is already on selected team, no change needed")
            return
        end
    else
        print("Player is not on any team")
    end
    
    -- Use the existing TeamSelectRemote
    local teamSelectRemote = ReplicatedStorage:FindFirstChild("TeamSelectRemote")
    if teamSelectRemote then
        print("Found TeamSelectRemote, firing event...")
        teamSelectRemote:FireServer(player, selectedTeam)
        print("TeamSelectRemote event fired")
    else
        print("ERROR: TeamSelectRemote not found!")
    end
end

-- Initialize
print("Initializing TeamManager...")
local remotesFolder = createRemotesFolder()

-- Set up the remote event
print("Setting up SelectTeam remote event...")
local selectTeamEvent = Instance.new("RemoteEvent")
selectTeamEvent.Name = "SelectTeam"
selectTeamEvent.Parent = remotesFolder
print("SelectTeam remote event created successfully")

-- Connect the remote event
selectTeamEvent.OnServerEvent:Connect(onTeamSelected)
print("SelectTeam event connected successfully")

print("TeamManager initialization complete") 