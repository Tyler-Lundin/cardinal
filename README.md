# Prison Royale

A Roblox game where players take on the roles of prisoners, guards, and rebels in a prison setting.

## Project Structure

```
PrisonRoyale/
├── default.project.json
├── src/
│   ├── ReplicatedStorage/
│   │   ├── Modules/
│   │   │   └── GameSettings.lua
│   │   ├── Remotes/
│   │   │   ├── AnnounceRemote.lua
│   │   │   └── RebelStatusRemote.lua
│   │   ├── ServerScriptService/
│   │   │   └── Main.server.lua
│   │   ├── StarterPlayer/
│   │   │   └── StarterPlayerScripts/
│   │   │       └── ClientMain.client.lua
│   │   ├── StarterGui/
│   │   │   └── HUDGui.lua
│   │   └── Teams/ (Created manually in Studio)
│   └── README.md
```

## Setup Instructions

1. Install Rojo and VS Code
2. Clone this repository
3. Open the project in VS Code
4. Start Rojo server
5. Open Roblox Studio and connect to Rojo
6. Create Teams folder manually in Studio

## Development

- Use Rojo for local development
- All scripts are organized in the `src` directory
- Teams are managed in Studio (not synced with Rojo)
- Game settings are in `GameSettings.lua`

## Features

- Multiple game modes (Classic, Team Deathmatch, Escape)
- Rebel system with random selection
- Team-based gameplay
- Real-time game state updates
- Basic HUD with time and team information

## Contributing

1. Fork the repository
2. Create a feature branch
3. Commit your changes
4. Push to the branch
5. Create a Pull Request 