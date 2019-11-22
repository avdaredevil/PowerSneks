#= INTERFACES =================================================================================|
class Serializeable {
    [object]serializeState() {return @{}}
    deSerializeState([Object]$State) {
        $State.psobject.Properties | % {
            try {
                # Write-Host Importing $_.Name = ($_.Value | Out-String)
                $this.($_.Name) = $_.Value
            } catch {<#Write-Host Error $_#>}
        }
        if (!($State.Head -is [string])) {return}
        $this.Head = $State.Head.split(' ')
    }
}
class LiveObject : Serializeable {
    [int]$Id          = -1
    [int]$Size        = 1
    [int]$Score       = 0
    [int[]]$Head      = @(0,0)
    [LifeState]$State = [LifeState]::Alive

    
    tick() {throw 'Implement'}
    die() {$this.State = [LifeState]::Dead}
    draw() {$this.draw($false)}
    draw([bool]$Spawn) {throw 'Implement'}
    respawn() {$this.draw($true)}
    incrementScore() {$this.Score += $(gv GameKnobs | % Value).ScoreIncr}
    [bool] isAlive() {return $this.State -eq [LifeState]::Alive}
}
class Player : LiveObject {
    [bool]$canCollide = $true

    erase() {throw 'Implement'}
    checkSelfCollision() {throw 'Implement'}
    collided([string]$Reason) {throw 'Implement'}
    [bool]checkForCollision([int[]]$Coords) {return $this.checkForCollision(@($Coords))}
    [bool]checkForCollision([int[][]]$coords) {throw 'Implement'}
    [int[][]]getCollideablePoints() {throw 'Implement'}
}
#= CLASSES ====================================================================================|

class Game : LiveObject {
    [int]$Score = 0
    [int]$Ticks = 0
    [int]$quits_issued = 0
    [Collections.ArrayList]$Players = @()
    [Collections.ArrayList]$LiveObjects = @()
    [char[][]]$Grid
    [ScoreBoard]$ScoreBoard
    [GameMode]$GameMode = [GameMode]::SinglePlayer
    [Decimal]$SleepAdj = 0
    [Decimal]$SlowTime = 0
    [Bool]$Paused = $false
    [Bool]$Debug = $false
    [Management.Automation.Host.BufferCell[,]]$GameBkp

    Game($Map, [bool]$Trail) {
        [Console]::BackgroundColor = $(gv ColorMap | % Value).Game.Background
        [Console]::Title = "PowerSneks by AP"
        if ($Trail) {$this.Tail = '.'}
        $this.ScoreBoard = [ScoreBoard]::new($this, [Console]::Title)
        $this.loadMap($Map, $true)
    }
    run() {$this.run({})}
    run([ScriptBlock]$Code) {
        $Sleep = $(gv GameKnobs | % Value).Sleep.Tick
        $this.ticks = 0
        $i = 0
        while ($this.isAlive()) {
            if (!$this.paused) {
                $this.ticks++                
                $Code.Invoke($this.ticks)
            }
            $i = ($i + 1) % 5
            try {$this.tick()}
            catch {
                if ("$_" -eq 'Quit') {$this.ScoreBoard.RenderScores();continue}
                $this.quit()
                $this.ScoreBoard.Write('Error: $_')
                Write-Host ($_ | Out-String)
                continue
            }
            $PixRatio = $(if (!$this.isMultiPlayer() -and $this.Players[0].Direction%2) {$(gv GameKnobs | % Value).Sleep.CursorRatio} else {1})
            if ($this.SlowTime) {
                $this.SlowTime = [Math]::Max($this.SlowTime * $(gv GameKnobs | % Value).SlowTimeDeteriorate, 3)-3
            }
            $SS = [Math]::Max((($Sleep + $this.SleepAdj + $this.SlowTime) * $PixRatio), 0)
            if ($this.Debug) {Place-BufferedContent "Sleeping for $SS$('.' * $i)$(' '*5)" 3 4}
            sleep -m $SS
        }
    }
    loadMap($Map) {$this.loadMap($Map, $false)}
    loadMap($Map, [bool]$OptimizeForFirstLoad) {
        $this.Grid = 0..($(gv win | % Value)[0]-1)
        0..($(gv win | % Value)[0]-1) | % {
            $W = $(gv SymbolMap | % Value).Wall
            $Char = $(gv SymbolMap | % Value).Space
            if ($_ -in @(0, ($(gv win | % Value)[0]-1))) {$Char = $W}
            $this.Grid[$_] = @($W)+((,$Char)*($(gv win | % Value)[1]-2))+@(,$W)
        }
        $this.drawDefaultGrid()
        if ($Map) {
            $GRID_s = @()
            $Launch = @{}
            $Loader = 0
            if ($Map -is [array]) {
                $Grid_s = $Map
                $this.drawGrid($OptimizeForFirstLoad)
                $this.ScoreBoard.write()
                $this.refreshScreen()
            } else {
                cat "$Map" | % {
                    if ($_ -match "AP\|\-*>") {$Loader++;} else {
                        if ($Loader -eq 1) {$Tr = $_.split("=").trim().trim(".");$Launch += @{$TR[0] = ($TR[1..($tr.count-1)] -join(""))}}
                        if ($Loader -eq 2) {$GRID_s += ,@("$_".toCharArray())}
                    }
                }
            }
            if ($Grid_s.count -eq 0) {$this.ScoreBoard.Write("Invalid Map File ... Will Load Normal Game");return}
            $i=$j=0
            1..$GRID_s.length | % {$i=$_-1
                if ($i -ge $this.Grid.length) {return}
                1..$this.Grid[$i].length | % {$j=$_-1
                    if ($j -ge $this.Grid[$i].length) {return}
                    $this.Grid[$i][$j] = $GRID_s[$i][$j]
                }
            }
            $this.drawGrid($OptimizeForFirstLoad)
            $this.deSerializeState(($Launch.Game | ConvertFrom-Json))
            $this.ScoreBoard.write()
            $this.refreshScreen()
            return
        }
        $this.generateFood()
    }
    drawDefaultGrid() {
        $Wall  = @()
        $WFill = @()
        0..3 | % {
            $Wall  += $Lib.Rect::new(0,0,0,0)
            $WFill += New-Object System.Management.Automation.Host.BufferCell
            if ($_%2 -eq 0) {$Wall[$_].Bottom = $(gv win | % Value)[0]-1}
            else {$Wall[$_].Left++;$Wall[$_].Right = $(gv win | % Value)[1]-2}
        }
        # -------------
        "Left","Right" | % {$Wall[2].$_   = $(gv win | % Value)[1]-1}
        "Top","Bottom" | % {$Wall[3].$_   = $(gv win | % Value)[0]-1}
        $Ch = $(gv CharMap | % Value).Wall
        0,2 | % {$WFill[$_].Character = $Ch.Vertical} #475
        $WFill[1].Character = $Ch.Top
        $WFill[3].Character = $Ch.Bottom
        # -------------
        0..3 | % {$WFill[$_].ForegroundColor = $(gv ColorMap | % Value).Wall;$WFill[$_].BackgroundColor = $(gv ColorMap | % Value).Game.Background}
        #= BASIC-WALL =============|
        0..3 | % {$Global:Host.UI.RawUI.SetBufferContents($Wall[$_],$WFill[$_])}
        $OWall = $Wall[0,2,3]
        "Top","Bottom" | % {$prp = $_;0..2 | % {$OWall[$_].$prp += 2}}
        0..2 | % {$Global:Host.UI.RawUI.SetBufferContents($OWall[$_],$WFill[0])}
        "Top","Bottom" | % {$prp = $_;0..2 | % {$OWall[$_].$prp -= 2}}
    }
    drawGrid() {$this.drawGrid($false)}
    drawGrid([bool]$FastLoad) {$this.drawGrid($FastLoad, 'Loading Map', -1)}
    drawGrid([bool]$FastLoad, [int]$Lines) {$this.drawGrid($FastLoad, 'Loading Map', $Lines)}
    drawGrid([bool]$FastLoad, [String]$Message) {$this.drawGrid($FastLoad, $Message, -1)}
    drawGrid([int]$Lines) {$this.drawGrid($false, 'Loading Map', $Lines)}
    drawGrid([String]$Message, [int]$Lines) {$this.drawGrid($false, $Message, $Lines)}
    drawGrid([bool]$FastLoad, [String]$Message, [int]$Lines) {
        $H, $W = $(gv win | % Value)
        $Lines = $(if ($Lines -gt 0) {[Math]::Min($H-1, $Lines)} else {$H-1})
        foreach ($p in 0..$Lines) {
            $this.ScoreBoard.write("$Message : $([Math]::Floor($p/$Lines*100))%")
            foreach ($d in ($W-1)..0) {
                if ($p -gt 32) {
                    # [Console]::CursorLeft=0*([Console]::CursorTop=0)
                    # Write-AP "nx-<",
                    #     "nx!$(print-list $p,$d)",
                    #     "nx# vs ",
                    #     "nx+$(print-list $GRID.length,$GRID[$p].length)",
                    #     "nx# vs ",
                    #     "nx*$(print-list $win)",
                    #     "nx->"
                }
                $Kt = $this.Grid[$p][$d]
                if ($FastLoad -and $Kt -eq $(gv SymbolMap | % Value).Space -and !($p -in 0,($H-1)) -and !($d -in 0,($W-1))) {continue}
                $this.RenderPoint($d, $p)
            }
        }
    }
    pause() {
        $this.paused = !$this.paused
        if (!$this.paused) {
            $this.ScoreBoard.write()
            $Global:Host.UI.RawUI.SetBufferContents($(gv Lib | % Value).Coord::new(0,0), $this.GameBKP)
            return
        }
        $Area = $(gv Lib | % Value).Rect::new(0, 0, $(gv win | % Value)[1]+1, $(gv win | % Value)[0]-2)
        $this.GameBKP = $Global:Host.UI.RawUI.GetBufferContents($Area)
        $Fill = $(gv Lib | % Value).Cell::new(' ', 'Black', 'Black', 0)
        $Global:Host.UI.RawUI.SetBufferContents($Area, $Fill)

        $Colm = $(gv Lib | % Value).Rect::new(0, 0, 0, $(gv win | % Value)[0]-2)
        $Fill = $(gv Lib | % Value).Cell::new($(gv CharMap | % Value).Symbol.Food, 'DarkGray', $(gv ColorMap | % Value).Game.Background, 0)
        1..[Math]::Floor($(gv win | % Value)[1]/3) | % {
            $Colm.Right = ($Colm.Left = $_ * 3 - 2)
            # Write-Host ($Colm | Out-String)
            $Global:Host.UI.RawUI.SetBufferContents($Colm, $Fill)
        }
        $this.ScoreBoard.write('This game is now paused, press "p" to unpause!')
    }
    attachPlayer([Player]$obj) {
        $obj.Id = @($this.Players).Length + 1
        $this.Players += $obj
        if ($obj.Id -gt 1) {$this.GameMode = [GameMode]::MultiPlayer}
        $this.ScoreBoard.Write()
    }
    attachLiveObject([LiveObject]$obj) {
        $obj.Id = @($this.LiveObjects).Length + 1
        $this.LiveObjects += $obj
    }
    [bool]isMultiPlayer() {return $this.GameMode -eq [GameMode]::MultiPlayer}
    sendPlayer([Direction]$Dir) {$this.sendPlayer($Dir, 1)}
    sendPlayer([Direction]$Dir, [int]$Player) {
        $P1, $P2 = $this.Players
        if (!$this.isMultiPlayer()) {$P1.turn($Dir)}
        $this.Players | ? {$_.ID -eq $Player} | % {$_.turn($Dir)}
    }
    ShootLaser($P) {
        if (!($P -is [Player])) {Write-Host 'Object passed is not an instance of Player!' ($P | Out-String);$this.quit();return}
        #if ($this.isMultiPlayer()) {$this.ScoreBoard.write("Lasers are not permitted in multiplayer!");return}
        if ($P.Lasers -le 0 -and $P.Lasers -ne -100) {$this.ScoreBoard.write("- - - - - - - - P$($P.Id) No More Lasers - - - - - - - -");return}
        if ($P.Lasers -gt 0) {$P.Lasers--}
        $x, $y = $P.Head
        $Laser = $(gv CharMap | % Value).Laser
        if ($P.Direction -in 0,2) {
            $Set = 0..($(gv win | % Value)[1]-1)
            if ($P.Direction -eq 0) {[Array]::Reverse($Set)}
            foreach ($p in $Set){
                if ($this.Grid[$y][$p] -eq $(gv SymbolMap | % Value).Wall){
                    $this.Grid[$y][$p] = $(gv SymbolMap | % Value).Space
                    Write-ToPos $Laser -y $y -x $p -fgc $(gv ColorMap | % Value).Laser
                    sleep -m $(gv GameKnobs | % Value).Laser.PrintDelay
                    $this.RenderPoint($p, $y)
                }
            }
        } else {
            $Set = 0..($(gv win | % Value)[0]-1)
            if ($P.Direction -eq 1) {[Array]::Reverse($Set)}
            foreach ($p in $Set){
                if ($this.Grid[$p][$x] -eq $(gv SymbolMap | % Value).Wall){
                    $this.Grid[$p][$x] = $(gv SymbolMap | % Value).Space
                    Write-ToPos $Laser -y $p -x $x -fgc $(gv ColorMap | % Value).Laser
                    sleep -m $(gv GameKnobs | % Value).Laser.PrintDelay
                    $this.RenderPoint($x, $p)
                }
            }
        }
        $this.ScoreBoard.write()
    }
    readKeys() {
        while ($Global:Host.UI.RawUI.KeyAvailable) {
            $Store = $Global:Host.UI.RawUI.ReadKey("NoEcho,IncludeKeydown,IncludeKeyUp")
            if (!$Store.KeyDown) {Continue}
            
            #Critical Hotkeys
            If (KeyPressed "q","x","~~Escape~~" $Store) {$this.ScoreBoard.write(". . . QUIT Signal . . .");$this.quit()}
            ElseIf (KeyPressed "p"  $Store) {$this.pause()}
            ElseIf (KeyPressed "~~F1~~"  $Store) {$this.ScoreBoard.RenderScores()}
            ElseIf (KeyPressed '`'  $Store) {
                $this.Debug = !$this.Debug
                if ($this.Debug) {return}
                $this.drawGrid('Removing debug statements', 10)
                $this.ScoreBoard.Write()
                'Players','LiveObjects' | % {
                    foreach ($ob in $this.$_) {
                        if ($ob.head[1] -gt 10) {continue}
                        $ob.draw($true)
                    }
                }
            }
            
            #Game Hotkeys
            $P2 = $(if($this.isMultiPlayer()) {1}else{0})
            if ($this.paused) {continue}
            ElseIf (KeyPressed "~~left~~"  $Store) {$this.sendPlayer(0)}
            ElseIf (KeyPressed "~~up~~"    $Store) {$this.sendPlayer(1)}
            ElseIf (KeyPressed "~~right~~" $Store) {$this.sendPlayer(2)}
            ElseIf (KeyPressed "~~down~~"  $Store) {$this.sendPlayer(3)}
            ElseIf (KeyPressed "A" $Store) {$this.sendPlayer(0, 2)}
            ElseIf (KeyPressed "W" $Store) {$this.sendPlayer(1, 2)}
            ElseIf (KeyPressed "D" $Store) {$this.sendPlayer(2, 2)}
            ElseIf (KeyPressed "S" $Store) {$this.sendPlayer(3, 2)}
            ElseIf (KeyPressed "S" $Store) {$this.sendPlayer(3, 2)}
            ElseIf (KeyPressed "-"  $Store) {$this.SleepAdj += 2}
            ElseIf (KeyPressed "+"  $Store) {$this.SleepAdj -= 2}
            ElseIf (KeyPressed "~~Control~~","L"  $Store) {$this.ShootLaser($this.Players[0])}
            ElseIf (KeyPressed "~~space~~","Z"  $Store) {$this.ShootLaser($this.Players[$P2])}
            ElseIf (KeyPressed "0s" $Store) {$this.generateFood()}
            ElseIf (KeyPressed "123" $Store) {$this.ScoreBoard.write("Loading Full Screen");cmd /c start /max cmd /k "mode con cols=239 lines=84&powershell -ep bypass -noprofile $PSCommandPath";$this.quit()}
            ElseIf (KeyPressed "~~Tab~~" $Store) {$this.ScoreBoard.write(". . . Saving Game State . . .");$this.SaveMap();$this.ScoreBoard.write(". . . Saved Game State . . .")}
            ElseIf (KeyPressed "116" $Store) {$this.refreshScreen()}
        }
    }
    saveMap() {$this.saveMap($(gv SaveFile | % Value))}
    saveMap($File) {
        md (Split-Path $File) -Force | Out-Null
        attrib -h -r -s +a $File 2>&1 | Out-Null
        "This is a Save File from PowerSneks by Apoorv Verma [AP]
        Copyright 2020. All Rights Reserved
        AP|--------------------------------->
            >>Game......= $($this.serializeState() | ConvertTo-Json -Compress)
            >>Window....= $(gv win | % Value)
        AP|--------------------------------->" | % {$_.replace((" "*4),"").replace(">>",(" "*4))} | out-file -Encoding ascii $File
        $this.Grid | % {$_ -join("")} | Out-File -Append -Encoding ascii $File
        attrib +h +r +s -a $File 2>&1 | Out-Null
    }
    [object] serializeState() {
        return @{
            Score = $this.Score
            Ticks = $this.Ticks
            Players = $this.Players | % {$_.serializeState()}
            LiveObjects = $this.LiveObjects | % {$_.serializeState()}
            GameMode = $this.GameMode
            SleepAdj = $this.SleepAdj
        }
    }
    deSerializeState([Object]$State) {
        ([Serializeable]$this).deSerializeState($state)
        'Players','LiveObjects' | % {$cl = $_
            $this.$cl = @($State.$cl | ? {$_.Class} | % {
                # Write-Host Loading $_.Class
                $o = New-Object $_.Class (0,0),$this
                $o.deSerializeState($_)
                if ($o.respawn) {$o.respawn()}
                return $o
            })
        }
        $this.ScoreBoard.Write()
    }
    refreshScreen() {
        $OP = $(if([console]::WindowHeight -gt 3){-1}else{1})
        [console]::WindowHeight += $OP
        [console]::WindowHeight -= $OP
    }
    [int[]] getEmptyCoord() {
        $H, $W = $(gv win | % Value)
        $TmOut = .5*$W*$H
        while ($true) {
            $y = Get-Random -min 0 -max $H
            $x = Get-Random -min 0 -max $W
            # Write-AP "*Finding $x,$y = [$($this.Grid[$y][$x])]"
            if ($tmout -le 0) {break}
            $TmOut--
            if ($this.Grid[$y][$x] -eq $(gv SymbolMap | % Value).Space) {return $x,$y}
        }
        $this.ScoreBoard.write("Game Took Too Long to Find Coords")
        $this.quit()
        return -1,-1
    }
    quit() {
        $this.quits_issued++
        [Console]::Title = $(gv TitleBkp | % Value)
        [Console]::BackGroundColor = $(gv BkColBkp | % Value)
        $Global:Host.UI.RawUI.FlushInputBuffer()
        [Console]::CursorTop = $(gv win | % Value)[0]+2
        $this.die()
        if ($this.quits_issued -gt 20) {
            $this.ScoreBoard.write('Game cannot quit gracefully, force quitting!')
            exit
        }
        throw 'Quit'
    }
    generateFood() {
        $x, $y = $this.getEmptyCoord()
        $this.Grid[$y][$x] = $(gv SymbolMap | % Value).Food
        Write-ToPos $(gv CharMap | % Value).Symbol.Food -y $y -x $x -fgc $(gv ColorMap | % Value).Food
    }
    tick() {
        $this.readKeys()
        if ($this.paused) {return}
        $ToRemove = @()
        foreach ($Ob in $this.LiveObjects) {
            if ($this.Debug) {Place-BufferedContent ("Ticking: {0,-16} {1}" -f "LiveObject $($Ob.ID)",$This.Ticks) 3 3}
            $ob.tick()
            if ($ob.isAlive()) {$ob.draw()}
        }
        if ($this.Debug) {
            $Dirs = $($this.Players | % {$_.Direction} | select -f 4)
            $Curs = $($this.Players | % {"{$($_.Head -join ', ')}"} | select -f 4)
            $c = "       P> Direction: $Dirs | Old Position: $Curs"
            Place-BufferedContent $c ($(gv win | % Value)[1]-2-$c.length) 3
        }
        foreach ($Player in $this.Players) {
            if ($this.Debug) {Place-BufferedContent ("Ticking: {0,-16} {1}" -f "Player $($Player.ID)",$This.Ticks) 3 3}
            $Player.tick()
        }
        if ($this.Debug) {
            $c = "       New Position: $($this.Players | % {"{$($_.Head -join ', ')}"} | select -f 4)"
            Place-BufferedContent $c ($(gv win | % Value)[1]-2-$c.length) 4
        }
        foreach ($Player in $this.Players) {
            if ($this.Debug) {Place-BufferedContent ("Drawing: {0,-16} {1}" -f "Player $($Player.ID)",$This.Ticks) 3 3}
            $Player.draw()
            if ($Player.isAlive()) {continue}
            $ToRemove += $Player
        }
        $ToRemove | % {$this.Players.Remove($_)};$ToRemove = @()
        foreach ($Ob in $this.LiveObjects) {
            if ($Ob.isAlive()) {continue}
            $ToRemove += $Ob
        }
        $ToRemove | % {$this.LiveObjects.Remove($_)}
        [int]$RemainingPlayers = @($this.Players).length
        if ($this.Debug) {
            $C = "[$(if($this.isMultiPlayer()){' Multi'}else{'Single'})Player] Loaded Players: $RemainingPlayers"
            Place-BufferedContent $C -y 2 -x ($(gv win | % Value)[1]-$C.length-2)
        }
        if ($this.isMultiPlayer() -and $RemainingPlayers -eq 1) {
            $this.ScoreBoard.Write("Player $($this.Players[0].Id) has won the game!")
            $this.quit()
            return
        }
        if ($RemainingPlayers -eq 0) {$this.quit()}
    }
    digestFood($x, $y) {
        $this.incrementScore()
        $this.Grid[$y][$x] = $(gv CharMap | % Value).Space
        $this.generateFood()
        $this.SleepAdj += $(gv GameKnobs | % Value).Sleep.AdjPerFood
        $this.createObstruction()
        $this.ScoreBoard.write()
    }
    createObstruction() {
        $Coord = @()
        $H, $W = $(gv win | % Value)
        $tmout = 40 # Since this is tmout x (.5 * H * W) which gets pretty big
        $HDist, $WDist = $H, $W | % {[Math]::Ceiling($(gv GameKnobs | % Value).Obstruction.SnakeDistanceRatio*$_)}
        $ValidatePoint = {param($tx,$ty,$px,$py)
            return (
                [Math]::Abs($tx-$px) -gt $WDist
            ) -and (
                [Math]::Abs($ty-$py) -gt $HDist
            )
        }
        While ($True) {
            $x, $y = $Coord = $this.getEmptyCoord()
            $fail = 0
            foreach ($P in $this.Players) {
                $px, $py = $P.Head
                if (!$ValidatePoint.invoke($x, $y, $px, $py)) {$fail++;break}
            }
            if (!$fail) {break}
            if ($tmout-- -le 0) {$this.ScoreBoard.Write("Game Took Too Long to Find Non-Impact Coords");$this.quit();return}
        }
        $x, $y = $Coord
        $xLen = get-random -min 1 -max ($W*$(gv GameKnobs | % Value).Obstruction.MaxWidth+1)
        $yLen = get-random -min 1 -max ($H*$(gv GameKnobs | % Value).Obstruction.MaxHeight+1)
        $Items2Respawn = @()
        foreach ($p in $y..($y+$yLen)) {
            foreach ($d in $x..($x+$xLen)) {
                $nx,$ny = [Game]::WarpCoords($d,$p)
                if ($this.Grid[$ny][$nx] -eq $(gv SymbolMap | % Value).Wall) {continue}
                if ($this.Grid[$ny][$nx] -eq $(gv SymbolMap | % Value).Food) {
                    $this.generateFood()
                } else {
                    foreach ($Ob in $this.Players) {
                        if (![Game]::CoordsEqual($Ob.Head, ($nx, $ny))) {continue}
                        $Items2Respawn += $Ob
                        $Ob.erase()
                    }
                    foreach ($Ob in $this.LiveObjects) {
                        if (!$Ob.canCollide -or ![Game]::CoordsEqual($Ob.Head, ($nx, $ny))) {continue}
                        $Items2Respawn += $Ob
                        if ($Ob.erase) {$Ob.erase()}
                    }
                }
                $this.Grid[$ny][$nx] = $(gv SymbolMap | % Value).Wall
                Write-ToPos $(gv CharMap | % Value).Wall.Vertical -y $ny -x $nx -fgc $(gv ColorMap | % Value).Wall -bgc $(gv ColorMap | % Value).Wall
            }
        }
        $this.SlowTime = $(gv GameKnobs | % Value).Sleep.SlowTime
        foreach ($p in $Items2Respawn) {
            $P.Head = $this.getEmptyCoord()
            $P.respawn()
        }
        if ($Items2Respawn) {$this.readySetGo()}
    }
    readySetGo() {
        $Global:Host.UI.RawUI.FlushInputBuffer()
        $this.ScoreBoard.write(". . . READY . . .")
        Start-Sleep -s 1
        $this.ScoreBoard.write(". . . STEADY . . .")
        Start-Sleep -s 1
        $this.ScoreBoard.write(". . . ! GO ! . . .")
    }
    checkCollision([Player]$Obj, [int[]]$pt) {$this.checkCollision($obj, $pt[0], $pt[1])}
    checkCollision([Player]$Obj, [int]$x, [int]$y) {
        $Symbol = $this.Grid[$y][$x]
        $Key = $(gv MapToSymbol | % Value).$Symbol
        if (!$Key) {Write-Error "Cannot translate $Symbol to Key, fatal";$this.exit();return}
        if ($this.Debug) {Place-BufferedContent "Current Block: $Key       " 2 2}
        if ($Key -eq 'Food') {
            $this.digestFood($x,$y)
            $obj.incrementScore()
            return
        }
        if ($Key -eq 'Wall') {
            $obj.collided("Player $($Obj.Id) hit a wall!")
            if ($this.isMultiPlayer()) {$obj.erase()}
            return
        }
        foreach ($o in $this.LiveObjects) {
            if (!$o.collided) {continue}
            $dist = [Game]::CoordsDistance($o.head, $obj.Head) - $o.Size
            if ($this.Debug) {Place-BufferedContent "Distance-O: $dist     " 3 5}
            if ($dist -gt 0) {continue}
            if (!$o.checkForCollision($obj.getCollideablePoints())) {continue}
            $o.collided($obj)
        }
        if (!$this.isMultiPlayer()) {return}
        foreach ($p in $this.Players) {
            if ($p.Id -eq $Obj.Id) {continue}
            $dist = [Game]::CoordsDistance($p.head, $obj.Head) - $p.Size
            if ($this.Debug) {Place-BufferedContent "Distance-P: $dist     " 3 5}
            if ($dist -gt 0) {continue}
            if (!$p.checkForCollision($obj.getCollideablePoints())) {continue}
            $obj.collided("Player $($Obj.ID) died by colliding into Player $($p.ID)")
        }
    }
    RenderPoint([int[]]$Coord) {$this.RenderPoint($Coord[0], $Coord[1])}
    RenderPoint([int]$x, [int]$y) {
        $Symbol = $this.Grid[$y][$x]
        $Key = JS-OR $(gv MapToSymbol | % Value).$Symbol 'Space'
        $Char = $(gv CharMap | % Value).Symbol.$Key
        if ($Key -eq 'Wall' -and $x -notin (0, $(gv win | % Value)[1])) {
            if ($y -eq 0) {$Char = $(gv CharMap | % Value).Wall.Top}
            if ($y -eq $(gv win | % Value)[0]-1) {$Char = $(gv CharMap | % Value).Wall.Bottom}
        }
        Write-ToPos $Char $x $y -fgc $(gv ColorMap | % Value).$Key
    }
    static [bool] CoordsEqual([int[]]$A,[int[]]$B) {
        return $A[0] -eq $B[0] -and $A[1] -eq $B[1]
    }
    static [int] CoordsDistance([int[]]$A,[int[]]$B) {
        return [Math]::Abs($A[0] - $B[0]) + [Math]::Abs($A[1] - $B[1])
    }
    static [int[]] WarpCoords([int[]]$c) {return [Game]::WarpCoords($c[0], $c[1])}
    static [int[]] WarpCoords($x, $y) {
        $H, $W = $(gv win | % Value)
        if ($x -lt 0) {$x += $W}
        if ($y -lt 0) {$y += $H}
        return ($x%$W), ($y%$H)
    }
}
class Snake : Player {
    [String]$Class               = 'Snake'
    [Int]$Size                   = 1
    [Int]$Consumption            = 0
    [Int]$Lasers                 = $(gv GameKnobs | % Value).Laser.InitialCount
    [Int]$GrowFactor             = $(gv GameKnobs | % Value).SnakeStartSz
    [Direction]$Direction        = [Direction]::Up
    [Direction]$BodyDirection    = [Direction]::Up
    [Collections.Queue]$Body     = [Collections.Queue]::new()
    [Collections.Queue]$ErasePts = [Collections.Queue]::new()
    [Game]$Game

    Snake([int[]]$Coords, [Game]$Game) {
        $this.Head = $Coords
        $this.Game = $Game
    }
    [object] serializeState() {
        return @{
            Class = $this.Class
            Id = $this.Id
            Size = 1
            Score = $this.Score
            Lasers = $this.Lasers
            Consumption = $this.Consumption
            GrowFactor = $this.GrowFactor + @($this.Body).length
            Direction = $this.Direction
            BodyDirection = $this.BodyDirection
            Head = [int[]]$this.Head
        }
    }
    draw([bool]$Spawn) {
        $y = -1
        while ($this.ErasePts.Count) {
            if ($y -eq -1) {$y = $this.ErasePts.Dequeue()}
            $this.Game.RenderPoint($this.ErasePts.Dequeue(), $y)
        }
        $x, $y = $this.Head
        $ch = if ($this.Game.isMultiPlayer() -and $(gv ShowPlayerLabels | % Value)) {$this.ID} else {$(gv CharMap | % Value).SnakeMoves[$this.Direction]}
        Write-ToPos $CH $x $y -fgc $(gv ColorMap | % Value).Snake.Head
        if ($Spawn) {
            $this.Body.GetEnumerator() | % {
                $x, $y = $_
                Write-ToPos $(gv CharMap | % Value).SnakeMoves[$this.BodyDirection] $x $y -fgc $(gv ColorMap | % Value).Snake.Body
            }
        } else {
            $x, $y = @($this.Body)[-1]
            Write-ToPos $(gv CharMap | % Value).SnakeMoves[$this.BodyDirection] $x $y -fgc $(gv ColorMap | % Value).Snake.Body
        }
        if ($Spawn) {return}
        if ($this.GrowFactor) {$this.Size++;$this.GrowFactor--}
        else {
            $x, $y = $this.Body.Dequeue()
            $this.Game.RenderPoint($x, $y)
        }
        $this.checkSelfCollision()
        $this.Game.checkCollision($this, $this.Head)
    }
    respawn() {
        $this.erase()
        $this.GrowFactor += $this.size - 1
        $this.size = 1
        $this.Body.Clear()
        ([LiveObject]$this).respawn()
        $this.alert()
    }
    alert() {
        $this.ErasePts.Enqueue($this.Head[1])
        ($this.Head[0]-2)..($this.Head[0]+2) | % {
            if ($_ -eq $This.Head[0]) {return}
            $nx, $ny = [Game]::WarpCoords($_, $this.Head[1])
            Write-ToPos '!' $nx $ny -fgc 'Yellow'
            $this.ErasePts.Enqueue($nx)
        }
    }
    incrementScore() {
        ([LiveObject]$this).incrementScore()
        $this.GrowFactor++
        $this.Consumption++
        if (!($this.Consumption % $(gv GameKnobs | % Value).Laser.AquireCost)) {
            $this.Lasers++
        }
    }
    checkSelfCollision() {
        foreach ($p in $this.Body) {
            if (![Game]::CoordsEqual($this.Head, $p)) {continue}
            $this.collided()
            return
        }
    }
    [bool]checkForCollision([int[][]]$Coords) {
        $Hash = @{}
        foreach ($c in $this.Body) {
            $Hash."$c" = 1
        }
        foreach ($c in $Coords) {
            if ($Hash."$c") {return $true}
        }
        return $false
    }
    [int[][]]getCollideablePoints() {
        return [int[][]]@(,$this.head)
    }
    turn([Direction]$Dir) {
        if ($this.size -gt 1 -and $this.BodyDirection -eq (($Dir+2)%4)) {return} # Cannot move into body
        $this.Direction = $Dir
    }
    tick() {
        $x, $y = $this.Head
        $this.Body.Enqueue(($x, $y))
        $this.Head = [Game]::WarpCoords((Modify-Coord $x $y $this.Direction))
        $this.BodyDirection = $this.Direction
    }
    collided() {$this.collided('Snake bit itself!')}
    collided([String]$Reason) {
        $this.die()
        $this.Game.ScoreBoard.write($Reason)
    }
    erase() {
        $this.Body.ToArray() | % {
            $x, $y = $_
            $this.Game.RenderPoint($x, $y)
        }
        $this.Game.RenderPoint($this.Head)
    }
}
class ScoreBoard {
    [String]$FallBackTitle = ''
    [Management.Automation.Host.Rectangle]$ScoreBoard
    [Management.Automation.Host.BufferCell]$SBFiller
    [Game]$Game
    [Bool]$ShowingScores
    [Hashtable]$ScoreMap = @{}
    [Management.Automation.Host.BufferCell[,]]$BufferBkp

    ScoreBoard([Game]$Game, [String]$Title) {
        $this.FallBackTitle = $Title
        $this.Game = $Game
        $W, $H = gv win | % Value
        $this.ScoreBoard = $(gv Lib | % Value).Rect::new(1, $W, $H-2, $W)
        $this.SBFiller = $(gv Lib | % Value).Cell::new(' ', $(gv ColorMap | % Value).Game.ConsoleText, $(gv ColorMap | % Value).Game.ConsoleTextBg, 0)
        $Global:Host.UI.RawUI.SetBufferContents($this.ScoreBoard,$this.SBFiller)
        $this.Write()
    }
    RenderScores() {
        $LIB = gv Lib | % Value
        if ($this.Game.paused -and !$this.ShowingScores) {return}
        $this.ShowingScores = !$this.ShowingScores
        $this.Game.paused = $this.ShowingScores
        $Global:PowerSneks_Scores = $this.ScoreMap
        $SortingOrder = @{Expression='Score'; Descending=$true},'Player'
        $Table = $this.ScoreMap.GetEnumerator() | % {[PsCustomObject]@{Player=$_.Key;'                 '='';Score=$_.Value}} | sort $SortingOrder | Out-String
        $Table = ("PowerSneks Score-Board`n$('-'*22)`n*-*`n"+$Table) -Split "`n|\s{30,}" | % {"$_".TrimEnd()} | ? {"$_" -replace '\s+'}
        $TW = ($Table | % Length | Measure -Max | % Maximum)+2
        $TH = ($Table.Length) + 2
        $H, $W = gv win | % Value
        $X, $Y = (($W - $TW) / 2),(($H - $TH) / 2) | % {[Math]::Floor($_)}
        if (!$this.ShowingScores) {
            $Global:Host.UI.RawUI.SetBufferContents($LIB.Coord::new($X-1,$Y-1), $this.BufferBkp)
            return
        }
        $Area = $LIB.Rect::new($X-1, $Y-1, $X+$TW+1+1, $Y+$TH+2+1)
        $this.BufferBkp = $Global:Host.UI.RawUI.GetBufferContents($Area)
        $Fill = $LIB.Cell::new(' ', 'Black', 'DarkRed', 0)
        $Global:Host.UI.RawUI.SetBufferContents($Area, $Fill)

        $Area = $LIB.Rect::new($X, $Y, $X+$TW+1, $Y+$TH+2)
        $Fill = $LIB.Cell::new(' ', 'Black', 'Red', 0)
        $Global:Host.UI.RawUI.SetBufferContents($Area, $Fill)

        1..[Math]::Floor($TH-1) | % {
            $Color = 'white'
            if ($_ -le 5) {$Color = 'yellow'}
            $L = $Table[$_-1]
            if (!$L -or !$L.trim() -or $L -eq '*-*') {return}
            if ($L.Length -ne $TW) {
                $L = $(' '*(($TW-$L.Length)/2))+$L
            }
            $L = $L -replace '- -+ -','-                   -' -replace '-',([char]9472)
            Place-BufferedContent "$L" -x ($X+1) -y ($Y+$_) -b Red -f $Color
        }
    }
    Write() {$this.write($this.FallBackTitle)}
    Write([String]$title) {
        $title = $title
        $Colors = $(gv ColorMap | % Value).Game
        $SB, $SF = $this.ScoreBoard, $this.SBFiller
        $Global:Host.UI.RawUI.SetBufferContents($SB, $SF)
        $this.Game.Players | % {
            $this.ScoreMap[$_.Id] = $_.Score
        }
        $Lasers = JS-OR (($this.Game.Players | % {$_.Lasers} | % {if ($_ -eq -100) {[char]8734} else {$_}}) -join '|') '0'
        $Scores = JS-OR (($this.Game.Players | % {$_.Score}) -join '|') '0'
        $LaserText = " Lasers : $Lasers "
        $ScoreText = " SCORE : $Scores "
        $OffSetS = $ScoreText.Length
        $OffSetL = 1 + $LaserText.Length
        $OffSet  = $OffSetS+$OffsetL
        $Area = $SB.Right-$SB.Left-$Offset
        $Y = $(gv win | % Value)[0]
        if ($Title.length -gt $Area) {$Title = $Title.substring(0,$Area-3)+"..."}
        Place-BufferedContent (Align-Text $Title).substring([Math]::Floor($OffSet/2)) 1 $Y -f $Colors.ConsoleText -b $Colors.ConsoleTextBg
        # Dividers
        $X_Off = $SB.Left + $Area
        $DIV = $(gv CharMap | % Value).Wall.Vertical
        $X_Off,($X_Off + $OffsetL) | % {
            Place-BufferedContent $DIV $_ $Y -f $Colors.ConsoleBorder -b $Colors.ConsoleTextBg
        }
        Place-BufferedContent $LaserText ($X_Off+1) $Y -f $Colors.ConsoleText -b $Colors.ConsoleTextBg
        Place-BufferedContent $ScoreText ($X_Off+$OffsetL+1) $Y -f $Colors.ConsoleText -b $Colors.ConsoleTextBg
    }
}
class GoldenSnitch : LiveObject {
    [int]$Size                = 2
    [String]$Class            = 'GoldenSnitch'
    [Direction]$Direction
    [int]$Life
    [int]$Points
    [int[]]$OldHead
    [int[]]$Head
    [Game]$Game

    GoldenSnitch([int[]]$Coords, [Game]$Game) {
        $this.Direction = Get-Random -min 0 -max 4
        $this.Points = Get-Random -min 1 -max 5
        $this.Life = Get-Random -min 20 -max 130
        $this.Game = $Game
        $this.Head = $Coords
    }
    [object] serializeState() {
        return @{
            Class = $this.Class
            Id = $this.Id
            Life = $this.Life
            Points = $this.Points
            Direction = $this.Direction
            Head = [int[]]$this.Head
        }
    }
    draw([bool]$Spawn) {
        $x, $y = $this.OldHead
        $this.Game.RenderPoint($x, $y)
        ($x-1),($x+1) | % {
            $nx, $y = [Game]::WarpCoords($_, $y)
            $this.Game.RenderPoint($nx, $y)
        }
        $x, $y = $this.Head
        $ch = '*'
        Write-ToPos $CH $x $y -fgc $(
            if($this.life -gt 90){'darkgreen'}elseif($this.life -gt 50){'green'}elseif($this.life -gt 25){'Yellow'}else{'Red'}
        )
        ($x-1),($x+1) | % {
            $nx, $y = [Game]::WarpCoords($_, $y)
            Write-ToPos '~' $nx $y -fgc 'Blue'
        }
    }
    incrementScore() {}
    checkSelfCollision() {}
    [bool]checkForCollision([int[][]]$Coords) {
        foreach ($c in $Coords) {
            if ([Game]::CoordsDistance($c, $this.Head) -gt 1) {continue}
            return $True
        }
        return $False
    }
    [int[][]]getCollideablePoints() {
        return [int[][]]@(,$this.head)
    }
    turn([Direction]$Dir) {
        if ($this.BodyDirection -eq (($Dir+2)%4)) {return} # Cannot move into body
        $this.Direction = $Dir
    }
    tick() {
        if ($this.Life-- -le 0) {$this.die();$this.erase();return}
        $x, $y = $this.OldHead = $this.Head
        $this.Head = [Game]::WarpCoords((Modify-Coord $x $y $this.Direction))
    }
    collided([Object]$Collider) {
        $this.die()
        $this.erase()
        1..$this.Points | % {
            $Collider.incrementScore()
            $Collider.Game.incrementScore()
        }
        $Collider.draw($true)
        $Collider.Game.ScoreBoard.Write("You caught a snitch worth $($this.points) points")
    }
    erase() {
        $x,$y = $this.Head
        $this.Game.RenderPoint($x, $y)
        $this.Game.RenderPoint(([Game]::WarpCoords(($x-1), $y)))
        $this.Game.RenderPoint(([Game]::WarpCoords(($x+1), $y)))
    }
}