#= GLOBAL-OBJECTS =============================================================================|
enum Direction {Left;Up;Right;Down}
enum LifeState {Alive;Dead}
enum GameMode {SinglePlayer;MultiPlayer}

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
