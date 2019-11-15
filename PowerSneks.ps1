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
    [int]$Bots=0,
    [ValidatePattern("[A-z]?:?.?\\.*\..*|\/\*\\")][String]$MapFile='/*\',
    [Switch]$LoadDefaultSave,
    [Switch]$Debug,
    [Switch]$ShowPlayerLabels
)
. $PSScriptRoot\PowerSneks_BaseObjects.ps1
. $PSScriptRoot\PowerSneks_GameSettings.ps1
. $PSScriptRoot\PowerSneks_Engine.ps1
. $PSScriptRoot\BotClass.ps1
#= RUNTIME ====================================================================================|
Start-Game
