local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Teams = game:GetService("Teams")
local Players = game:GetService("Players")

-- Get modules
local GameSettings = require(ReplicatedStorage.Modules.GameSettings)

-- Create teams
local function setupTeams()
	local prisonerTeam = Instance.new("Team")
	prisonerTeam.Name = "Prisoners"
	prisonerTeam.TeamColor = BrickColor.new("Bright blue")
	prisonerTeam.Parent = Teams
	
	local guardTeam = Instance.new("Team")
	guardTeam.Name = "Guards"
	guardTeam.TeamColor = BrickColor.new("Bright red")
	guardTeam.Parent = Teams
	
	-- Create a neutral team for players who haven't selected yet
	local neutralTeam = Instance.new("Team")
	neutralTeam.Name = "Neutral"
	neutralTeam.TeamColor = BrickColor.new("Medium stone grey")
	neutralTeam.Parent = Teams
end

-- Create remotes
local function setupRemotes()
	local TeamSelectRemote = Instance.new("RemoteEvent")
	TeamSelectRemote.Name = "TeamSelectRemote"
	TeamSelectRemote.Parent = ReplicatedStorage
	
	local AnnounceRemote = Instance.new("RemoteEvent")
	AnnounceRemote.Name = "AnnounceRemote"
	AnnounceRemote.Parent = ReplicatedStorage
	
	local RebelStatusRemote = Instance.new("RemoteEvent")
	RebelStatusRemote.Name = "RebelStatusRemote"
	RebelStatusRemote.Parent = ReplicatedStorage
	
	return TeamSelectRemote, AnnounceRemote, RebelStatusRemote
end

-- Handle team selection
local function handleTeamSelection(TeamSelectRemote)
	TeamSelectRemote.OnServerEvent:Connect(function(player, teamName)
		local team = Teams:FindFirstChild(teamName)
		if not team then return end
		
		-- Check guard team capacity
		if teamName == "Guards" then
			local guardCount = 0
			local prisonerCount = 0
			
			-- Count both guards and prisoners
			for _, p in ipairs(Players:GetPlayers()) do
				if p.Team == team then
					guardCount = guardCount + 1
				elseif p.Team == Teams:FindFirstChild("Prisoners") then
					prisonerCount = prisonerCount + 1
				end
			end
			
			-- Only apply guard ratio check if we already have at least one guard
			if guardCount > 0 then
				local maxGuards = math.floor(Players.MaxPlayers * GameSettings.GUARD_RATIO)
				
				-- Allow joining guards if there are no prisoners, regardless of guard count
				if prisonerCount == 0 then
					player.Team = team
					ReplicatedStorage.AnnounceRemote:FireClient(player, "Joined Guards team!")
					return
				end
				
				-- Otherwise, check normal guard capacity
				if guardCount >= maxGuards then
					-- Notify player that guard team is full
					ReplicatedStorage.AnnounceRemote:FireClient(player, "Guard team is full!")
					return
				end
			end
		end
		
		-- Assign player to team
		player.Team = team
		ReplicatedStorage.AnnounceRemote:FireClient(player, "Joined " .. teamName .. " team!")
	end)
end

-- Initialize
local function init()
	setupTeams()
	local TeamSelectRemote, AnnounceRemote, RebelStatusRemote = setupRemotes()
	handleTeamSelection(TeamSelectRemote)
	
	-- Set new players to neutral team
	Players.PlayerAdded:Connect(function(player)
		player.Team = Teams:FindFirstChild("Neutral")
	end)
end

init() 