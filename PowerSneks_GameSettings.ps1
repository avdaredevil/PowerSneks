# =======================================START=OF=COMPILER==========================================================|
#    The Following Code was added by AP-Compiler Version [1.4] To Make this program independent of AP-Core Engine
#    GitHub: https://github.com/avdaredevil/AP-Compiler
# ==================================================================================================================|
$Script:PSHell=$(if($PSHell){$PSHell}elseif($PSScriptRoot){$PSScriptRoot}else{"."});
function B64 {param([Parameter(ValueFromPipeline=$true)][String]$Text, [ValidateSet("UTF8","Unicode")][String]$Encoding = "UTF8")
    [System.Text.Encoding]::$Encoding.GetString([System.Convert]::FromBase64String($Text))}
# This syntax is to prevent AV's from misclassifying this as anything but innocuous
& (Get-Alias iex) (B64 "ZnVuY3Rpb24gV3JpdGUtQVAgew0KICAgIFtDbWRsZXRCaW5kaW5nKCldDQogICAgcGFyYW0oW1BhcmFtZXRlcihWYWx1ZUZyb21QaXBlbGluZT0kdHJ1ZSwgTWFuZGF0b3J5PSRUcnVlKV0kVGV4dCxbU3dpdGNoXSROb1NpZ24sW1N3aXRjaF0kUGxhaW5UZXh0LFtWYWxpZGF0ZVNldCgiQ2VudGVyIiwiUmlnaHQiLCJMZWZ0IildW1N0cmluZ10kQWxpZ249J0xlZnQnLFtTd2l0Y2hdJFBhc3NUaHJ1KQ0KICAgIGJlZ2luIHskVFQgPSBAKCl9DQogICAgUHJvY2VzcyB7JFRUICs9ICwkVGV4dH0NCiAgICBFTkQgew0KICAgICAgICAkQmx1ZSA9ICQoaWYgKCRXUklURV9BUF9MRUdBQ1lfQ09MT1JTKXszfWVsc2V7J0JsdWUnfSkNCiAgICAgICAgaWYgKCRUVC5jb3VudCAtZXEgMSkgeyRUVCA9ICRUVFswXX07JFRleHQgPSAkVFQNCiAgICAgICAgaWYgKCR0ZXh0LmNvdW50IC1ndCAxIC1vciAkdGV4dC5HZXRUeXBlKCkuTmFtZSAtbWF0Y2ggIlxbXF0kIikgew0KICAgICAgICAgICAgcmV0dXJuICRUZXh0IHwgPyB7IiRfIn0gfCAlIHsNCiAgICAgICAgICAgICAgICBXcml0ZS1BUCAkXyAtTm9TaWduOiROb1NpZ24gLVBsYWluVGV4dDokUGxhaW5UZXh0IC1BbGlnbiAkQWxpZ24gLVBhc3NUaHJ1OiRQYXNzVGhydQ0KICAgICAgICAgICAgfQ0KICAgICAgICB9DQogICAgICAgIGlmICghJHRleHQgLW9yICR0ZXh0IC1ub3RtYXRjaCAiXigoPzxOTkw+eCl8KD88TlM+bnM/KSl7MCwyfSg/PHQ+XD4qKSg/PHM+WytcLSFcKlwjXEBfXSkoPzx3Pi4qKSIpIHtyZXR1cm4gJFRleHR9DQogICAgICAgICR0YiAgPSAiICAgICIqJE1hdGNoZXMudC5sZW5ndGgNCiAgICAgICAgJENvbCA9IEB7JysnPScyJzsnLSc9JzEyJzsnISc9JzE0JzsnKic9JEJsdWU7JyMnPSdEYXJrR3JheSc7J0AnPSdHcmF5JzsnXyc9J3doaXRlJ31bKCRTaWduID0gJE1hdGNoZXMuUyldDQogICAgICAgIGlmICghJENvbCkge1Rocm93ICJJbmNvcnJlY3QgU2lnbiBbJFNpZ25dIFBhc3NlZCEifQ0KICAgICAgICAkU2lnbiA9ICQoaWYgKCROb1NpZ24gLW9yICRNYXRjaGVzLk5TKSB7IiJ9IGVsc2UgeyJbJFNpZ25dICJ9KQ0KICAgICAgICBBUC1SZXF1aXJlICJmdW5jdGlvbjpBbGlnbi1UZXh0IiB7ZnVuY3Rpb24gR2xvYmFsOkFsaWduLVRleHQoJGFsaWduLCR0ZXh0KSB7JHRleHR9fQ0KICAgICAgICAkRGF0YSA9ICIkdGIkU2lnbiQoJE1hdGNoZXMuVykiO2lmICghJERhdGEpIHtyZXR1cm59DQogICAgICAgICREYXRhID0gQWxpZ24tVGV4dCAtQWxpZ24gJEFsaWduICIkdGIkU2lnbiQoJE1hdGNoZXMuVykiDQogICAgICAgIGlmICgkUGxhaW5UZXh0KSB7cmV0dXJuICREYXRhfQ0KICAgICAgICBXcml0ZS1Ib3N0IC1Ob05ld0xpbmU6JChbYm9vbF0kTWF0Y2hlcy5OTkwpIC1mICRDb2wgJERhdGENCiAgICAgICAgaWYgKCRQYXNzVGhydSkge3JldHVybiAkRGF0YX0NCiAgICB9DQp9CgpmdW5jdGlvbiBNYWtlLVJlYWRPbmx5IHtwYXJhbSgkbykNCg0KICAgIGlmICghJG8uR2V0RW51bWVyYXRvciAtYW5kICRvLkdldFR5cGUoKS5OYW1lIC1lcSAiSGFzaHRhYmxlIikge1dyaXRlLUFQICIhSW52YWxpZCBvYmplY3QgcGFzc2VkLCBtdXN0IGJlIGEgaGFzaHRhYmxlIjtyZXR1cm59DQogICAgJG5ldyA9IFtQc0N1c3RvbU9iamVjdF1Ae30NCiAgICAkby5HZXRFbnVtZXJhdG9yKCkgfCAlIHskdiA9ICRfLnZhbHVlOyRuZXcgfCBBZGQtTWVtYmVyICRfLmtleSAtRm9yY2UgLU1lbWJlclR5cGUgU2NyaXB0UHJvcGVydHkgeyR2fS5HZXROZXdDbG9zdXJlKCl9DQogICAgcmV0dXJuICRuZXcNCn0KCmZ1bmN0aW9uIEFsaWduLVRleHQge3BhcmFtKFtQYXJhbWV0ZXIoTWFuZGF0b3J5PSRUcnVlKV1bU3RyaW5nW11dJFRleHQsIFtWYWxpZGF0ZVNldCgiQ2VudGVyIiwiUmlnaHQiLCJMZWZ0IildW1N0cmluZ10kQWxpZ249J0NlbnRlcicpDQoNCiAgICBpZiAoJFRleHQuY291bnQgLWd0IDEpIHsNCiAgICAgICAgJGFucyA9IEAoKQ0KICAgICAgICBmb3JlYWNoICgkbG4gaW4gJFRleHQpIHskQW5zICs9IEFsaWduLVRleHQgJGxuICRBbGlnbn0NCiAgICAgICAgcmV0dXJuICgkYW5zKQ0KICAgIH0gZWxzZSB7DQogICAgICAgICRXaW5TaXplID0gW2NvbnNvbGVdOjpCdWZmZXJXaWR0aA0KICAgICAgICAkQ2xlYW5UZXh0U2l6ZSA9IChTdHJpcC1Db2xvckNvZGVzICgiIiskVGV4dCkpLkxlbmd0aA0KICAgICAgICBpZiAoJENsZWFuVGV4dFNpemUgLWdlICRXaW5TaXplKSB7DQogICAgICAgICAgICAkQXBwZW5kZXIgPSBAKCIiKTsNCiAgICAgICAgICAgICRqID0gMA0KICAgICAgICAgICAgZm9yZWFjaCAoJHAgaW4gMC4uKCRDbGVhblRleHRTaXplLTEpKXsNCiAgICAgICAgICAgICAgICBpZiAoKCRwKzEpJSR3aW5zaXplIC1lcSAwKSB7JGorKzskQXBwZW5kZXIgKz0gIiJ9DQogICAgICAgICAgICAgICAgIyAiIiskaisiIC0gIiskcA0KICAgICAgICAgICAgICAgICRBcHBlbmRlclskal0gKz0gJFRleHQuY2hhcnMoJHApDQogICAgICAgICAgICB9DQogICAgICAgICAgICByZXR1cm4gKEFsaWduLVRleHQgJEFwcGVuZGVyICRBbGlnbikNCiAgICAgICAgfSBlbHNlIHsNCiAgICAgICAgICAgIGlmICgkQWxpZ24gLWVxICJDZW50ZXIiKSB7DQogICAgICAgICAgICAgICAgcmV0dXJuICgiICIqW21hdGhdOjp0cnVuY2F0ZSgoJFdpblNpemUtJENsZWFuVGV4dFNpemUpLzIpKyRUZXh0KQ0KICAgICAgICAgICAgfSBlbHNlaWYgKCRBbGlnbiAtZXEgIlJpZ2h0Iikgew0KICAgICAgICAgICAgICAgIHJldHVybiAoIiAiKigkV2luU2l6ZS0kQ2xlYW5UZXh0U2l6ZS0xKSskVGV4dCkNCiAgICAgICAgICAgIH0gZWxzZSB7DQogICAgICAgICAgICAgICAgcmV0dXJuICgkVGV4dCkNCiAgICAgICAgICAgIH0NCiAgICAgICAgfQ0KICAgIH0NCn0KCmZ1bmN0aW9uIEdldC1QYXRoIHtwYXJhbSgkbWF0Y2gsIFtzdHJpbmddJFBhdGhWYXIgPSAiUEFUSCIpDQoNCiAgICAkUHRoID0gW0Vudmlyb25tZW50XTo6R2V0RW52aXJvbm1lbnRWYXJpYWJsZSgkUGF0aFZhcikNCiAgICAkSXNVbml4ID0gJFBTVmVyc2lvblRhYmxlLlBsYXRmb3JtIC1lcSAiVW5peCINCiAgICAkUGF0aFNlcCA9ICQoaWYgKCRJc1VuaXgpIHsiOiJ9IGVsc2UgeyI7In0pDQogICAgaWYgKCEkUHRoKSB7cmV0dXJuIEAoKX0NCiAgICBTZXQtUGF0aCAkUHRoIC1QYXRoVmFyICRQYXRoVmFyDQogICAgJGQgPSAoJFB0aCkuc3BsaXQoJFBhdGhTZXApDQogICAgaWYgKCRtYXRjaCkgeyRkIC1tYXRjaCAkbWF0Y2h9IGVsc2UgeyRkfQ0KfQoKZnVuY3Rpb24gQVAtQ29udmVydFBhdGgge3BhcmFtKFtQYXJhbWV0ZXIoTWFuZGF0b3J5PSRUcnVlKV1bU3RyaW5nXSRQYXRoKQ0KDQogICAgcmV0dXJuICRQYXRoIC1yZXBsYWNlIA0KICAgICAgICAiPERlcD4iLCI8TGliPlxEZXBlbmRlbmNpZXMiIC1yZXBsYWNlIA0KICAgICAgICAiPExpYj4iLCI8SG9tZT5cQVAtTGlicmFyaWVzIiAtcmVwbGFjZSANCiAgICAgICAgIjxDb21wKG9uZW50cyk/PiIsIjxIb21lPlxBUC1Db21wb25lbnRzIiAtcmVwbGFjZSANCiAgICAgICAgIjxIb21lPiIsJFBTSGVsbH0KCmZ1bmN0aW9uIFN0cmlwLUNvbG9yQ29kZXMge3BhcmFtKCRTdHIpDQoNCiAgICAkU3RyIHwgJSB7JF8gLXJlcGxhY2UgIiQoW3JlZ2V4XTo6ZXNjYXBlKCIkKEdldC1Fc2NhcGUpWyIpKVxkKyhcO1xkKykqbSIsIiJ9DQp9CgpmdW5jdGlvbiBBUC1SZXF1aXJlIHtwYXJhbShbUGFyYW1ldGVyKE1hbmRhdG9yeT0kVHJ1ZSldW0FsaWFzKCJGdW5jdGlvbmFsaXR5IiwiTGlicmFyeSIpXVtTdHJpbmddJExpYiwgW1NjcmlwdEJsb2NrXSRPbkZhaWwsIFtTd2l0Y2hdJFBhc3NUaHJ1KQ0KDQogICAgJExvYWRNb2R1bGUgPSB7DQogICAgICAgIHBhcmFtKCRGaWxlLFtib29sXSRJbXBvcnQpDQogICAgICAgIHRyeSB7SW1wb3J0LU1vZHVsZSAkRmlsZSAtZWEgc3RvcDtyZXR1cm4gMX0gY2F0Y2gge30NCiAgICAgICAgJExpYj1BUC1Db252ZXJ0UGF0aCAiPExJQj4iOyRMRiA9ICIkTGliXCRGaWxlIg0KICAgICAgICBbc3RyaW5nXSRmID0gaWYodGVzdC1wYXRoIC10IGxlYWYgJExGKXskTEZ9ZWxzZWlmKHRlc3QtcGF0aCAtdCBsZWFmICIkTEYuZGxsIil7IiRMRi5kbGwifQ0KICAgICAgICBpZiAoJGYgLWFuZCAkSW1wb3J0KSB7SW1wb3J0LU1vZHVsZSAkZn0NCiAgICAgICAgcmV0dXJuICRmDQogICAgfQ0KICAgICRTdGF0ID0gJChzd2l0Y2ggLXJlZ2V4ICgkTGliLnRyaW0oKSkgew0KICAgICAgICAiXkludGVybmV0IiAgICAgICAgICAgICAgIHt0ZXN0LWNvbm5lY3Rpb24gZ29vZ2xlLmNvbSAtQ291bnQgMSAtUXVpZXR9DQogICAgICAgICJeZGVwOiguKikiICAgICAgICAgICAgICAge0dldC1XaGVyZSAkTWF0Y2hlc1sxXX0NCiAgICAgICAgIl4obGlifG1vZHVsZSk6KC4qKSIgICAgICB7JExvYWRNb2R1bGUuaW52b2tlKCRNYXRjaGVzWzJdLCAkdHJ1ZSl9DQogICAgICAgICJeKGxpYnxtb2R1bGUpX3Rlc3Q6KC4qKSIgeyRMb2FkTW9kdWxlLmludm9rZSgkTWF0Y2hlc1syXSl9DQogICAgICAgICJeZnVuY3Rpb246KC4qKSIgICAgICAgICAge2djbSAkTWF0Y2hlc1sxXSAtZWEgU2lsZW50bHlDb250aW51ZX0NCiAgICAgICAgIl5zdHJpY3RfZnVuY3Rpb246KC4qKSIgICB7VGVzdC1QYXRoICJGdW5jdGlvbjpcJCgkTWF0Y2hlc1sxXSkifQ0KICAgICAgICBkZWZhdWx0IHtXcml0ZS1BUCAiIUludmFsaWQgc2VsZWN0b3IgcHJvdmlkZWQgWyQoIiRMaWIiLnNwbGl0KCc6JylbMF0pXSI7dGhyb3cgJ0JBRF9TRUxFQ1RPUid9DQogICAgfSkNCiAgICBpZiAoISRTdGF0IC1hbmQgJE9uRmFpbCkgeyRPbkZhaWwuSW52b2tlKCl9DQogICAgaWYgKCRQYXNzVGhydSAtb3IgISRPbkZhaWwpIHtyZXR1cm4gJFN0YXR9DQp9CgpmdW5jdGlvbiBHZXQtRXNjYXBlIHtbQ2hhcl0weDFifQoKZnVuY3Rpb24gR2V0LVdoZXJlIHsNCiAgICBbQ21kbGV0QmluZGluZyhEZWZhdWx0UGFyYW1ldGVyU2V0TmFtZT0iTm9ybWFsIildDQogICAgcGFyYW0oDQogICAgICAgIFtQYXJhbWV0ZXIoTWFuZGF0b3J5PSR0cnVlLCBQb3NpdGlvbj0wKV1bc3RyaW5nXSRGaWxlLA0KICAgICAgICBbU3dpdGNoXSRBbGwsDQogICAgICAgIFtQYXJhbWV0ZXIoUGFyYW1ldGVyU2V0TmFtZT0nTm9ybWFsJyldW1BhcmFtZXRlcihQYXJhbWV0ZXJTZXROYW1lPSdTY2FuJyldW1N3aXRjaF0kTWFudWFsU2NhbiwNCiAgICAgICAgW1BhcmFtZXRlcihQYXJhbWV0ZXJTZXROYW1lPSdTY2FuJyldW1N3aXRjaF0kRGJnLA0KICAgICAgICBbUGFyYW1ldGVyKFBhcmFtZXRlclNldE5hbWU9J1NjYW4nKV1bc3RyaW5nXSRQYXRoVmFyID0gIlBBVEgiDQogICAgKQ0KICAgICRJc1ZlcmJvc2UgPSAkRGJnIC1vciAkUFNCb3VuZFBhcmFtZXRlcnMuQ29udGFpbnNLZXkoJ1ZlcmJvc2UnKSAtb3IgJFBTQm91bmRQYXJhbWV0ZXJzLkNvbnRhaW5zS2V5KCdEZWJ1ZycpDQogICAgJFdoZXJlQmluRXhpc3RzID0gR2V0LUNvbW1hbmQgIndoZXJlIiAtZWEgU2lsZW50bHlDb250aW51ZQ0KICAgICRJc1VuaXggPSAkUFNWZXJzaW9uVGFibGUuUGxhdGZvcm0gLWVxICJVbml4Ig0KICAgIGlmICgkRmlsZSAtZXEgIndoZXJlIiAtb3IgJEZpbGUgLWVxICJ3aGVyZS5leGUiKSB7cmV0dXJuICRXaGVyZUJpbkV4aXN0c30NCiAgICBpZiAoJFdoZXJlQmluRXhpc3RzIC1hbmQgISRNYW51YWxTY2FuKSB7DQogICAgICAgICRPdXQ9JG51bGwNCiAgICAgICAgaWYgKCRJc1VuaXgpIHsNCiAgICAgICAgICAgICRPdXQgPSB3aGljaCAkZmlsZSAyPiRudWxsDQogICAgICAgIH0gZWxzZSB7JE91dCA9IHdoZXJlLmV4ZSAkZmlsZSAyPiRudWxsfQ0KICAgICAgICANCiAgICAgICAgaWYgKCEkT3V0KSB7cmV0dXJufQ0KICAgICAgICBpZiAoJEFsbCkge3JldHVybiAkT3V0fQ0KICAgICAgICByZXR1cm4gQCgkT3V0KVswXQ0KICAgIH0NCiAgICBmb3JlYWNoICgkRm9sZGVyIGluIChHZXQtUGF0aCAtUGF0aFZhciAkUGF0aFZhcikpIHsNCiAgICAgICAgaWYgKCRJc1VuaXgpIHsNCiAgICAgICAgICAgICRMb29rdXAgPSAiJEZvbGRlci8kRmlsZSINCiAgICAgICAgICAgIGlmICgkSXNWZXJib3NlKSB7V3JpdGUtQVAgIipDaGVja2luZyBbJExvb2t1cF0ifQ0KICAgICAgICAgICAgaWYgKCEoVGVzdC1QYXRoIC1QYXRoVHlwZSBMZWFmICRMb29rdXApKSB7Y29udGludWV9DQogICAgICAgICAgICBSZXNvbHZlLVBhdGggJExvb2t1cCB8ICUgUGF0aA0KICAgICAgICAgICAgaWYgKCEkQWxsKSB7cmV0dXJufQ0KICAgICAgICB9IGVsc2Ugew0KICAgICAgICAgICAgZm9yZWFjaCAoJEV4dGVuc2lvbiBpbiAoR2V0LVBhdGggLVBhdGhWYXIgUEFUSEVYVCkpIHsNCiAgICAgICAgICAgICAgICAkTG9va3VwID0gIiRGb2xkZXIvJEZpbGUkRXh0ZW5zaW9uIg0KICAgICAgICAgICAgICAgIGlmICgkSXNWZXJib3NlKSB7V3JpdGUtQVAgIipDaGVja2luZyBbJExvb2t1cF0ifQ0KICAgICAgICAgICAgICAgIGlmICghKFRlc3QtUGF0aCAtUGF0aFR5cGUgTGVhZiAkTG9va3VwKSkge2NvbnRpbnVlfQ0KICAgICAgICAgICAgICAgIFJlc29sdmUtUGF0aCAkTG9va3VwIHwgJSBQYXRoDQogICAgICAgICAgICAgICAgaWYgKCEkQWxsKSB7cmV0dXJufQ0KICAgICAgICAgICAgfQ0KICAgICAgICB9DQogICAgfQ0KfQo=")
# ========================================END=OF=COMPILER===========================================================|
#= INIT =======================================================================================|
[int[]]$Script:Win = @(([Console]::WindowHeight-2), [Console]::WindowWidth)
$Script:TitleBkp   = [Console]::Title
$Script:BkColBkp   = [Console]::BackGroundColor
#= SETTINGS ===================================================================================|
$Script:SaveFile  = "$env:APPDATA\AP-PowerSneks\AP-PowerSneks.Map.Save"
$Script:CharMap   = Make-ReadOnly @{
    Space        = ' '
    Symbol       = Make-ReadOnly @{
        Food = "♣"
        Wall = "█"
        Space = " "
    }
    SnakeMoves   = @("▪","▪","▪","▪")
    Wall         = Make-ReadOnly @{
        Top      = "▀"
        Bottom   = "▄"
        Vertical = "█"
    }
    Laser        = "█"
}
$Script:SymbolMap = @{
    Wall  = 'W'
    Food  = 'F'
    Space = ' '
}
$Script:ColorMap  = Make-ReadOnly @{
    Space = 'Black'
    Wall  = 'DarkRed'
    Food  = 'Yellow'
    Laser = 'Yellow'
    Game  = Make-ReadOnly @{
        Background     = 'Black' #[Console]::BackgroundColor
        ConsoleText    = 'Yellow'
        ConsoleTextBg  = 'Red'
        ConsoleBorder  = 'DarkRed'
    }
    Snake = Make-ReadOnly @{
        Head = "DarkGreen"
        Body = "Red"
    }
}
$Script:GameKnobs = Make-ReadOnly @{
    ScoreIncr    = 10
    Obstruction  = Make-ReadOnly @{
        MaxWidth           = 2/5      # 4/5 is hella fun!
        MaxHeight          = 2/5
        SnakeDistanceRatio = 5/120    # How Many blocks away should the Snake Spawn from an Obstruction
    }
    Laser        = Make-ReadOnly  @{
        PrintDelay   = 15       # Laser draw delay per block in ms
        InitialCount = 1        # Starting Count for lasers
        AquireCost   = 3        # How many food items to eat before acquiring laser 
        BombRadius   = @(6, 3)  # Radius for explosion near snake 
    }
    Sleep        = Make-ReadOnly  @{
        Tick        = 40
        SlowTime    = 80  # Additional delay per tick
        AdjPerFood  = -.15
        CursorRatio = 70/35 # Cursor height:width ratio
    }
    SnakeStartSz = 5
    SlowTimeDeteriorate = 4/5  # SlowTime preservation per tick
}
$Script:LIB = Make-ReadOnly @{
    Cell = [Management.Automation.Host.BufferCell]
    CellType = [Management.Automation.Host.BufferCellType]
    Rect = [Management.Automation.Host.Rectangle]
    Coord = [System.Management.Automation.Host.Coordinates]
}
$Script:MapToSymbol = @{}
$Script:SymbolMap.getEnumerator() | % {
    $Script:MapToSymbol[$_.Value] = $_.Key
}
$Script:MapToSymbol = Make-ReadOnly $Script:MapToSymbol
#= MAIN-GAME ==================================================================================|
function Get-PlayerSpawn([Game]$Game) {
    $c = @(-1, -1)
    $tmout = 100
    $H, $W = $(gv win | % Value)
    while (1) {
        $x,$y = $c = $Game.getEmptyCoord()
        if (--$tmout -gt 0 -and $x -lt (.1*$W) -or $x -gt (.9*$W) -or $y -lt (.45*$H) -or $y -gt (.95*$H)) {continue}
        break
    }
    return $c
}
function Start-Game([ScriptBlock]$CustomHook = {}) {
    [Console]::CursorVisible = $False
    cls
    $Map = $null
    if (($MapFile -ne '/*\') -and (Test-path -type leaf $MapFile)) {
        $Map = $MapFile
    } elseif ($LoadDefaultSave) {
        $Map = $SaveFile
    }
    $Game = [Game]::New($Map, $Trail)
    if (!$Game.Players -and ($Snakes -or $Bots)) {
        if ($Snakes) {
            1..$Snakes | % {
                $c = Get-PlayerSpawn $Game
                $Game.attachPlayer([Snake]::new($c, $Game))
            }
        }
        if ($Bots) {
            1..$Bots | % {
                $c = Get-PlayerSpawn $Game
                $Game.attachPlayer([SnakeBot]::new($c, $Game))
            }
        }
    }
    $Game.Debug = gv Debug | % Value
    $Game.Run({
        param($Tick)
        try {
            if (!($Tick % 500)) {
                $c = $Game.getEmptyCoord()
                # Eventually a boss maybe?
            } elseif (!($Tick % 100)) {
                $c = $Game.getEmptyCoord()
                $Game.attachLiveObject([GoldenSnitch]::New($c, $Game))
            }
            $CustomHook.Invoke($Game, $Tick)
        } catch {
            Write-Host Error ($_ | Out-String)
        }
    }.GetNewClosure())
}
function Write-ToPos ([string]$str, [int]$x = 0, [int]$y = 0, [ConsoleColor]$bgc = [console]::BackgroundColor, [ConsoleColor]$fgc = [Console]::ForegroundColor) {
    if ($x -lt 0 -or $y -lt 0 -or $x -gt [Console]::WindowWidth -or $y -gt [Console]::WindowHeight) {return}
    
    try {
        $Host.UI.RawUI.SetBufferContents(
            $Lib.Rect::new($x, ($WTY+$y), $x, $y),
            $Lib.Cell::new(
                $str[0],
                $fgc,
                $bgc,
                $Lib.CellType::Complete))
    } catch {}
}
function Modify-Coord ([int]$x, [int]$y, [Direction]$bgc, [int]$Scale = 1) {
    switch ([int]$bgc) {
        0 {$x-=$Scale}
        1 {$y-=$Scale}
        2 {$x+=$Scale}
        3 {$y+=$Scale}
    }
    return @($x,$y)
}
function Place-BufferedContent($Text, $x, $y, [ConsoleColor]$ForegroundColor=[Console]::ForegroundColor, [ConsoleColor]$BackgroundColor=[Console]::BackgroundColor) {
    $crd = [Management.Automation.Host.Coordinates]::new($x,$y)
    $b = $Host.UI.RawUI
    $arr = $b.NewBufferCellArray(@($Text), $ForegroundColor, $BackgroundColor)
    $x = [Console]::BufferWidth-1-$Text.length
    $b.SetBufferContents($crd, $arr)
}