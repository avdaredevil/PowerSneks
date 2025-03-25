# using module ../PowerSneks_BaseObjects.ps1
# using module ./1_Game.ps1

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
