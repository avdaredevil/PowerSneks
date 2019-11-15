# Using module .\PowerSneks_Engine.ps1
class SnakeBot : Snake {
    [int[][]]$FoodCoords = @()
    SnakeBot([int[]]$Coords, [Game]$Game) : base($Coords, $Game) {}
    incrementScore(){
        ([Snake]$this).incrementScore()
        $this.ScanForFoodCoords()
    }
    ScanForFoodCoords() {
        $G = $this.Game.Grid
        $Food = $(gv SymbolMap | % Value).Food
        $this.FoodCoords = @()
        0..($G.length-1) | % {
            $y = $_
            0..($G[$y].length-1) | % {
                $x = $_
                if ($G[$y][$x] -eq $Food) {
                    $this.FoodCoords += ,@($x, $y)
                }
            }
        }
    }
    [int[]] closestFood() {
        if (!$this.FoodCoords.length) {$this.ScanForFoodCoords()}
        $c = $this.FoodCoords | % {
            $x, $y = $_
            [PSCustomObject]@{x=$x;y=$y;d=([Game]::CoordsDistance($_, $this.Head))}
        } | sort d | select -f 1 | % {$x,$y}
        return $c
    }
    [boolean]NavigateToFood([Direction[]]$GoodDir) {
        $tryTurn = {
            param($d)
            if ($d -in $GoodDir) {$this.turn($d);return $true}
            return $false
        }
        $cdir = $this.BodyDirection
        $x, $y = $this.Head
        $fx, $fy = $this.closestFood()
        Place-BufferedContent ("X: {0,3} -> {1,3}" -f ($x, $fx)) 2 2
        Place-BufferedContent ("Y: {0,3} -> {1,3}" -f ($y, $fy)) 2 3
        if (($cdir -eq [Direction]::Left -or $cdir -eq [Direction]::Right) -and $fy -ne $y) {
            return $tryTurn.invoke($(if ($fy -gt $y) {[Direction]::Down} else {[Direction]::Up}))
        }
        if ($fx -eq $x) {return $true}
        return $tryTurn.invoke($(if ($fx -gt $x) {[Direction]::Right} else {[Direction]::Left}))
    }
    tick() {
        $G = $this.Game
        [Direction[]]$GoodDir = @()
        
        :A do {
            $BodyHash = @{}
            foreach ($c in $this.Body) {
                $BodyHash."$c" = 1
            }
            foreach ($dir in (0..3)) {
                if ($dir -eq [int](($this.BodyDirection+2)%4)) {continue}
                $x, $y = [Game]::WarpCoords((Modify-Coord $this.Head[0] $this.Head[1] $dir))
                if ($G.Grid[$y][$x] -eq $(gv SymbolMap | % Value).Food) {$this.turn($dir);break A}
                if ($G.Grid[$y][$x] -eq $(gv SymbolMap | % Value).Space -and !$BodyHash."$x $y") {
                    $GoodDir += $dir
                }
            }
            
            # If we continue
            $x, $y = [Game]::WarpCoords((Modify-Coord $this.Head[0] $this.Head[1] $this.BodyDirection))
            if ($G.Grid[$y][$x] -ne $(gv SymbolMap | % Value).Wall) {if ($this.NavigateToFood($GoodDir)) {break A}}
            
            # We need to turn
            if (!$GoodDir.length) {$G.shootLaser();break} # No option but to laser
            $this.turn($GoodDir[(Get-Random $GoodDir.length)])             # Turn to any valid direction
        } while (0)
        ([Snake]$this).tick()
    }
}