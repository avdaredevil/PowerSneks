# using module ../PowerSneks_BaseObjects.ps1
# using module ./1_Game.ps1

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
