# PowerSneks

> Snake game written in PowerShell which uses any windows console (`cmd.exe`, `powershell.exe`, even VSCode!) and draws out a custom native code based game. Useful and fun game for aspiring programmers and techies. Features:

- Robust Game engine:
  - Capable of handling multiple snakes / objects
  - Mod capabilities by extending engine and providing your own Game Hook / Classes (as long as you implement the appropriate interfaces)
  - Saving / Restoring complete state (Snakes, directions, objects, Game Grid, Tick Speed, etc)
- Level Mechanics:
  - Obstruction creation
  - Laser beams
  - Moving snitches (with random point values)
- Customization Segment:
  - Allows you to Customize `$Script:GameKnobs` to adjust everything from Sleep Times, Obstruction sizes, Render sizes, Colors, Symbols, SaveMaps, Laser Logic, etc

## Screenshots

Standard Single Player | Multiplayer (w/ Debug Console) | Scoreboard during gameplay
--- | --- | ---
![Standard Single Player](https://user-images.githubusercontent.com/5303018/67819656-4fe37300-fa73-11e9-9539-bd7cf05c1f5a.png) | ![Multiplayer (w/ Debug Console)](https://user-images.githubusercontent.com/5303018/67819723-9d5fe000-fa73-11e9-8ade-a39dd99e91b4.png) | ![PowerSneks Scoreboard](https://user-images.githubusercontent.com/5303018/69590755-59de9000-0fa5-11ea-8393-259a8b1d06fb.png)

Gameplay Gif |
--- |
![PowerSneks Gameplay](./docs/PowerSneks.gif)

## Usage

```PowerShell
.\PowerSneks.ps1 [[-Snakes] <int:1>] [[-Bots] <int:0>] [[-MapFile] <string>] [-LoadDefaultSave] [-ShowPlayerLabels] [-Debug]
```

- Will draw a game to match the dimensions of the console window
- `Snake` is the number of human players (controls cut off after 2 players), `Bots` is the number of bots in the game
- `Debug` mode is for debugging to see snake positions, object distances, active render, current block, tick
- `LoadDefaultSave` loads game from a previous save [File: `%appdata%\AP-PowerSneks.Map.Save`]
- `MapFile` is the save-file path you want to load the game from
- *__Note__: If you've never run PowerShell Scripts before refer to __Setup PowerShell Section__ Below*

## Features

- In house Game Engine, and View overlay + Grid System
- Color Scheming
- Level Making
- MAP Saving and Loading
- Obstruction Creation
- Laser Beams To cut through walls
- Warping of Obstructions and Snake
- Game-Console with Laser and Score count
- Debug console like Minecraft for the game Engine
- CPU cycle and sleep time adjustment as game progresses
- Bots to play against
- Golden Snitch to chase for extra points (and less walls)

## Commands

Key Code         | Usage
---------------- | -----
`q`, `x`, `ESC`       | Quit Game
`←`   , `→`   , `↑`   , `↓`    | Move Snake (left/right/up/down) (Player 1)
`A`   , `D`   , `W`   , `S`    | Move Snake (left/right/up/down) (Player 2)
`J`   , `L`   , `I`   , `K`    | Move Snake (left/right/up/down) (Player 3)
`num4`, `num6`, `num8`, `num5` | Move Snake (left/right/up/down) (Player 4)
`end`, `r-ctrl`, `🔙` | Laser Beam (Player 1)
`l-ctrl`, `c`         | Laser Beam (Player 2)
`space`, `{`          | Laser Beam (Player 3)
`0`, `num-enter`      | Laser Beam (Player 4)
`+`                   | Speed Up Game [*Increases Tick speed*]
`-`                   | Slow Down Game [*Increases Tick speed*]
`p`                   | Pause Game
`f12`                 | Full Screen
`Tab`                 | Save Current Game State
`f5`                  | Refresh view [*fast*]
``` ` ```             | Enable dev console on game (also enable-able via the `-debug` cmdline flag)
`.`                   | Add more food to the game [__Cheat Code__]

## Files

#### Game Launchers

File | Description
--- | ---
`PowerSneks.ps1` | Main Game launcher, use this to start the game
`ToBots.ps1` | Use a saved game and convert all players to bots (*best use for this file, use `-LoadDefaultSave`*)

#### Base Files

File | Description
--- | ---
`PowerSneks_BaseObjects.ps1` | Contains enums and base object definitions that the game engine relies on
`PowerSneks_GameSettings.ps1` | Contains all the tinkerable variables that can be modified before launching the game engine
`PowerSneks_Engine.ps1` | Loads all entities mentioned below, and exposes functions that are needed to draw or start the game
`Sockets.ps1` | *__TODO__: Add LAN based multiplayer support for the game*

#### Game Entity Files

*The Number before the file name is the order in which the files are loaded into the game engine (since they depend on each other)*

File | Description
--- | ---
`entities/1_Game.ps1` | Contains the `Game` and `Scoreboard` class definitions
`entities/2_Snake.ps1` | Contains the `Snake` class definition
`entities/3_Bot.ps1` | Contains the `SnakeBot` class definition which can kinda play the game (super basic AI)
`entities/3_GoldenSnitch.ps1` | Contains the `GoldenSnitch`, which is a special moving object that gives extra points (without creating walls)

## Set Up PowerShell [If you've never run a script in PowerShell]

- Open PowerShell with Admin Access
- Run `Set-ExecutionPolicy Bypass`
- This allows scripts to be run in PowerShell
- cd to the *Folder* where you downloaded/cloned [PowerSneks.ps1](PowerSneks.ps1)
- `./PowerSneks.ps1`*`<arguments>`*
