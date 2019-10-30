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
Standard Single Player | Multiplater (w/ Debug Console)
--- | ---
![Standard Single Player](https://user-images.githubusercontent.com/5303018/67819656-4fe37300-fa73-11e9-9539-bd7cf05c1f5a.png) | ![Multiplater (w/ Debug Console)](https://user-images.githubusercontent.com/5303018/67819723-9d5fe000-fa73-11e9-8ade-a39dd99e91b4.png)


## Usage
```PowerShell
.\AP-Snakes.ps1 [[-MapFile] <string>] [-Trail] [-LoadDefaultSave]
```
- Will draw a game to match the dimensions of the console window
- `Trail` mode is for debugging to see where the snake has been throughout the duration of the game
- `LoadDefaultSave` loads game from a previous save [File: `AP-Snakes.Map.Save`]
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
- CPU cycle and sleep time adjustment as game progresses

## Commands
Key Code         | Usage 
---------------- | -----
`q`,`x`,`ESC`    | Quit Game
`←`   , `→`   , `↑`   , `↓`    | Move Snake (left/right/up/down) (Player 1)
`A`   , `D`   , `W`   , `S`    | Move Snake (left/right/up/down) (Player 2)
`num4`, `num6`, `num8`, `num5` | Move Snake (left/right/up/down) (Player 3)
`space`,`l`,`z`,`ctrl` | Laser Beam
`+`              | Speed Up Game [*Increases Tick speed*]
`-`              | Slow Down Game [*Increases Tick speed*]
`p`              | Pause Game
`f12`            | Full Screen
`Tab`            | Save Current Game State
`f5`             | Refresh view [*fast*]
`\``             | Enable dev console on game (also enable-able via the `-debug` cmdline flag)
`0`              | Add more food to the game [**Cheat Code**]

## Set Up PowerShell [If you've never run a script in PowerShell]
- Open PowerShell with Admin Access
- Run `Set-ExecutionPolicy Bypass`
- This allows scripts to be run in PowerShell
- cd to the *Folder* where you downloaded/cloned [PowerSneks.ps1](PowerSneks.ps1)
- `./PowerSneks.ps1`*`<arguments>`*

