# SnakeMadNess
> Snake game written in PowerShell which uses any windows console {`cmd.exe`, `powershell.exe`} and draws out a custom native code based game. Useful and fun game for aspiring programmers and techies.

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
- Compiles AP-Programs Independent of the AP-Modules file
- Reads And Calculates all the Modules needed!
- Adds code with comment in a neat BASE64 Code
- Has a blacklisting system
- Code layout detection
- Inject Point Detection

## Commands
> 
Key Code         | Usage 
---------------- | -----
`q`,`x`,`ESC`    | Quit Game
`←`,`A`,`num4`   | Turn Left
`→`,`D`,`num6`   | Turn Right
`↑`,`W`,`num8`   | Turn Up
`↓`,`S`,`num5`   | Turn Down
`+`              | Speed Up Game [*Experimental*]
`-`              | Slow Down Game [*Experimental*]
`p`              | Pause Game [**NOT_IMPLEMENTED**]
`0`              | Add more food to the game [**Cheat Code**]
`f12`            | Full Screen
`Tab`            | Save Current Game State
`f5`             | Refresh view [*fast*]
