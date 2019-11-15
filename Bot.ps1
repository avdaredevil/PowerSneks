<#
|===============================================================>|
  AP-Snakes 2 [PowerSneks] by APoorv Verma [AP] on 10/25/2019
|===============================================================>|
      $) Color Scheming                   1
      $) Level Making                   0 * 2
      $) MAP Saving and Loading           3
      $) Obstruction Creation
      $) Laser Beams To cut through walls
      $) Warping of Obstructions and Snake
      $) Game-Console with Laser and Score count
      $) CPU cycle and sleep time adjustment as game progresses
      $) Snake Grows upon eating food
      $) Restore Console Properties upon Close
      $) OO Design
      $) Multiobject support / Multiplayer!
|===============================================================>|
#>
param(
    [int]$Snakes=1,
    [ValidatePattern("[A-z]?:?.?\\.*\..*|\/\*\\")][String]$MapFile='/*\',
    [Switch]$ShowPlayerLabels,
    [Switch]$LoadDefaultSave,
    [Switch]$Debug
)
. $PSScriptRoot\PowerSneks_BaseObjects.ps1
. $PSScriptRoot\PowerSneks_GameSettings.ps1
. $PSScriptRoot\PowerSneks_Engine.ps1
. $PSScriptRoot\BotClass.ps1

$SN = $Snakes
$Snakes = 0
#= RUNTIME ====================================================================================|
Start-Game {param($Game, $Tick)
    try {
        if ($Tick -eq 1) {
            if ($Game.Players.Length) {
                $bt = $Game.Players | % {$_.SerializeState()}
                $Game.Players.clear()
                foreach ($e in $bt) {
                    $b = [SnakeBot]::new($c, $Game)
                    $Game.attachPlayer($b)
                    $b.DeserializeState(($e | ConvertTo-Json | ConvertFrom-Json))
                    $b.respawn()
                }
                return
            }
            1..$SN | % {
                $c = Get-PlayerSpawn $Game
                $Game.attachPlayer([SnakeBot]::new($c, $Game))
            }
        }
        if ($Game.isMultiPlayer() -and ($Tick -lt 100 -and !($Tick % 5)) -or !($Tick % 100)) {
            $Game.Players | % {$_.ScanForFoodCoords()}
        }
    } catch {Write-Host "BOT CRASHED, $_"}
}