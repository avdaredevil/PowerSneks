# SnakeMadNess
> Snake game written in PowerShell which uses any windows console {`cmd.exe`, `powershell.exe`} and draws out a custom native code based game. Useful and fun game for aspiring programmers and techies.

## Screenshots
>
#### Normal Mode:
![image](https://cloud.githubusercontent.com/assets/5303018/19415236/174e4be6-9338-11e6-9899-35061b2e3540.png)

## Usage
>
```PowerShell
.\AP-Snakes.ps1 [[-MapFile] <string>] [-Trail] [-LoadDefaultSave]
```
- Will draw a game to match the dimensions of the console window
- `Trail` mode is for debugging to see where the snake has been throughout the duration of the game
- `LoadDefaultSave` loads game from a previous save [File: `AP-Snakes.Map.Save`]
- `MapFile` is the save-file path you want to load the game from

## Features
>
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
> 
Key Code         | Usage 
---------------- | -----
`q`,`x`,`ESC`    | Quit Game
`←`,`A`,`num4`   | Turn Left
`→`,`D`,`num6`   | Turn Right
`↑`,`W`,`num8`   | Turn Up
`↓`,`S`,`num5`   | Turn Down
`space`,`l`,`z`,`ctrl` | Laser Beam
`+`              | Speed Up Game [*Experimental*]
`-`              | Slow Down Game [*Experimental*]
`p`              | Pause Game [**NOT_IMPLEMENTED**]
`0`              | Add more food to the game [**Cheat Code**]
`f12`            | Full Screen
`Tab`            | Save Current Game State
`f5`             | Refresh view [*fast*]
