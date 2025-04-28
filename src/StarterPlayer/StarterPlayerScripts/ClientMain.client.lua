-- Prison Royale Client Core

local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")

print("[Client] Starting initialization")

-- Modules
local GameSettings = require(ReplicatedStorage.Modules.GameSettings)
local InitialMenu = require(ReplicatedStorage.Modules.InitialMenu)

-- Remotes
local TeamSelectRemote = ReplicatedStorage:WaitForChild("TeamSelectRemote")
local AnnounceRemote = ReplicatedStorage:WaitForChild("AnnounceRemote")
local RebelStatusRemote = ReplicatedStorage:WaitForChild("RebelStatusRemote")

-- Local State
local player = Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")

local gameState = {
	isGameRunning = false,
	roundTime = 0,
	isRebel = false
}

-- Camera Setup
local function setupCamera()
	print("[Camera] Setting up...")
	
	-- Lock zoom levels
	player.CameraMinZoomDistance = 0
	player.CameraMaxZoomDistance = 0
	
	-- Force first person
	player.CameraMode = Enum.CameraMode.LockFirstPerson
	
	print("[Camera] Setup complete")
end

local function handleTeamSelection(menu)
	print("[TeamSelection] Hooking buttons...")
	
	local function requestTeam(teamName)
		if TeamSelectRemote then
			TeamSelectRemote:FireServer(teamName)
		end
		if menu.screenGui then
			menu.screenGui:Destroy()
		end
		setupCamera() -- 👈 Move setupCamera() HERE, after team selected
	end
	
	menu.prisonerButton.MouseButton1Click:Connect(function()
		print("[TeamSelection] Prisoner selected")
		requestTeam("Prisoners")
	end)
	
	menu.guardButton.MouseButton1Click:Connect(function()
		print("[TeamSelection] Guard selected")
		requestTeam("Guards")
	end)
	
	-- Guard Button State Update
	local function updateGuardButton()
		local guardCount = 0
		
		for _, plr in ipairs(Players:GetPlayers()) do
			if plr.Team and plr.Team.Name == "Guards" then
				guardCount += 1
			end
		end
		
		local maxGuards = math.floor(#Players:GetPlayers() * GameSettings.GuardRatio)
		maxGuards = math.max(1, maxGuards) -- Always at least 1 guard
		
		menu.guardButton.Text = ("Guard (%d/%d)"):format(guardCount, maxGuards)
		menu.guardButton.Active = (guardCount < maxGuards)
		menu.guardButton.BackgroundTransparency = (guardCount < maxGuards) and 0 or 0.5
	end
	
	Players.PlayerAdded:Connect(updateGuardButton)
	Players.PlayerRemoving:Connect(updateGuardButton)
	updateGuardButton()
end


-- Initialization
local function init()
	print("[Init] Starting full init")
	
	-- Setup camera immediately
	setupCamera()
	player.CharacterAdded:Connect(function()
		task.wait(0.1) -- Small buffer so humanoid exists
		setupCamera()
	end)
	
	-- Create and handle the initial menu
	local success, menu = pcall(function()
		return InitialMenu.create()
	end)
	
	if not success then
		warn("[Init] Failed to create InitialMenu:", menu)
		return
	end
	
	handleTeamSelection(menu)
	print("[Init] Team selection menu active")
	
	-- Announcement Handler
	AnnounceRemote.OnClientEvent:Connect(function(message)
		print("[Announcement]", message)
		-- TODO: Future HUD integration
	end)
	
	-- Rebel Status Handler
	RebelStatusRemote.OnClientEvent:Connect(function(playerFired, isRebel)
		if playerFired == player then
			gameState.isRebel = isRebel
			print(("[RebelStatus] Now %s"):format(isRebel and "a Rebel" or "Neutral"))
		end
	end)
	
	print("[Init] Client fully initialized")
end

init()

-- Export game state
return {
	gameState = gameState
}
