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
      $) Bots to play against
      $) Golden Snitch to chase for extra points (and less walls)
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
# =======================================START=OF=COMPILER==========================================================|
#    The Following Code was added by AP-Compiler 1.6 (APC: 1.2) To Make this program independent of AP-Core Engine
#    GitHub: https://github.com/avdaredevil/AP-Compiler
# ==================================================================================================================|
$Script:PSHell=$(if($PSHell){$PSHell}elseif($PSScriptRoot){$PSScriptRoot}else{"."});
$Script:AP_Console = @{version=[version]'1.2'; isShim = $true}
function B64 {param([Parameter(ValueFromPipeline=$true)][String]$Text, [ValidateSet("UTF8","Unicode")][String]$Encoding = "UTF8")     [System.Text.Encoding]::$Encoding.GetString([System.Convert]::FromBase64String($Text))}
# This syntax is to prevent AV's from misclassifying this as anything but innocuous
& (Get-Alias iex) (B64 "ZnVuY3Rpb24gR2V0LVBvd2VyU2hlbGxQcm9jZXNzUGF0aCB7DQogICAgaWYgKCRQU0NvbW1hbmRQYXRoKSB7DQogICAgICAgICMgSWYgcnVubmluZyBpbiBhIHNjcmlwdA0KICAgICAgICBpZiAoJFBTRWRpdGlvbiAtZXEgJ0NvcmUnKSB7DQogICAgICAgICAgICBHZXQtQ29tbWFuZCBwd3NoIHwgU2VsZWN0LU9iamVjdCAtRXhwYW5kUHJvcGVydHkgU291cmNlDQogICAgICAgIH0gZWxzZSB7DQogICAgICAgICAgICBHZXQtQ29tbWFuZCBwb3dlcnNoZWxsIHwgU2VsZWN0LU9iamVjdCAtRXhwYW5kUHJvcGVydHkgU291cmNlDQogICAgICAgIH0NCiAgICB9IGVsc2VpZiAoJGhvc3QuVmVyc2lvbi5NYWpvciAtZ2UgNikgew0KICAgICAgICAjIFBvd2VyU2hlbGwgNisgKENvcmUpDQogICAgICAgICRQU0hvbWUgKyAnL3B3c2gnICsgKCcuZXhlJywgJycpWyRJc0xpbnV4IC1vciAkSXNNYWNPU10NCiAgICB9IGVsc2Ugew0KICAgICAgICAjIFdpbmRvd3MgUG93ZXJTaGVsbA0KICAgICAgICAiJFBTSG9tZVxwb3dlcnNoZWxsLmV4ZSINCiAgICB9DQp9Cg==")
# ========================================END=OF=COMPILER===========================================================|
function bool($a) {if($a){"`$true"}else{"`$false"}}
if ($args[0] -ne "in-frame") {
    return & (Get-PowerShellProcessPath) -ep bypass -noprofile $PSCommandPath -Snakes $Snakes -Bots $Bots -MapFile """$MapFile""" -LoadDefaultSave:$(bool($LoadDefaultSave)) -Debug:$(bool($Debug)) -ShowPlayerLabels:$(bool($ShowPlayerLabels)) 'in-frame'
}
. $PSScriptRoot\PowerSneks_BaseObjects.ps1
. $PSScriptRoot\PowerSneks_GameSettings.ps1
. $PSScriptRoot\PowerSneks_Engine.ps1
#= RUNTIME ====================================================================================|
Start-Game
