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
    [Switch]$Trail,
    [ValidatePattern("[A-z]?:?.?\\.*\..*")][String]$MapFile='/*\',
    [int]$Snakes=1,
    [Switch]$LoadDefaultSave,
    [Switch]$Debug,
    [Switch]$ShowPlayerLabels
)
# =======================================START=OF=COMPILER==========================================================|
#    The Following Code was added by AP-Compiler Version [1.2] To Make this program independent of AP-Core Engine
#    GitHub: https://github.com/avdaredevil/AP-Compiler
# ==================================================================================================================|
$Script:PSHell=$(if($PSHell){$PSHell}elseif($PSScriptRoot){$PSScriptRoot}else{"."});
iex ([System.Text.Encoding]::UTF8.GetString([System.Convert]::FromBase64String("ZnVuY3Rpb24gUHJvY2Vzcy1UcmFuc3BhcmVuY3kge3BhcmFtKFtBbGlhcygiVHJhbnNwYXJlbmN5IiwiSW52aXNpYmlsaXR5IiwiaSIsInQiKV1bVmFsaWRhdGVSYW5nZSgwLDEwMCldW2ludF0kVHJhbnM9MCwgW1BhcmFtZXRlcihNYW5kYXRvcnk9JFRydWUpXSRQcm9jZXNzKQ0KDQogICAgaWYgKCRQcm9jZXNzIC1tYXRjaCAiXC5leGUkIikgeyRQcm9jZXNzID0gJFByb2Nlc3MucmVwbGFjZSgiLmV4ZSIsIiIpfQ0KICAgIFRyeSB7DQogICAgICAgIGlmICgkUHJvY2Vzcy5uYW1lKSB7JFByb2MgPSAkUHJvY2Vzcy5uYW1lfSBlbHNlIHskUHJvYyA9IChHZXQtUHJvY2VzcyAkUHJvY2VzcyAtRXJyb3JBY3Rpb24gU3RvcClbMF0ubmFtZX0NCiAgICB9IGNhdGNoIHsNCiAgICAgICAgaWYgKFtJbnRdOjpUcnlQYXJzZSgkUHJvY2VzcywgW3JlZl0zKSkgeyRQcm9jID0gKChHZXQtUHJvY2VzcyB8ID8geyRfLklEIC1lcSAkUHJvY2Vzc30pWzBdKS5uYW1lfQ0KICAgIH0NCiAgICBpZiAoJFByb2MgLW5vdE1hdGNoICJcLmV4ZSQiKSB7JFByb2MgPSAiJFByb2MuZXhlIn0NCiAgICBuaXJjbWQgd2luIHRyYW5zIHByb2Nlc3MgIiRQcm9jIiAoKDEwMC0kVHJhbnMpKjI1NS8xMDApIHwgT3V0LU51bGwNCn0KCmZ1bmN0aW9uIEtleVByZXNzZWRDb2RlIHtwYXJhbShbUGFyYW1ldGVyKE1hbmRhdG9yeT0kVHJ1ZSldW0ludF0kS2V5LCAkU3RvcmU9Il5eXiIpDQoNCiAgICBpZiAoISRIb3N0LlVJLlJhd1VJLktleUF2YWlsYWJsZSAtYW5kICRTdG9yZSAtZXEgIl5eXiIpIHtSZXR1cm4gJEZhbHNlfQ0KICAgIGlmICgkU3RvcmUgLWVxICJeXl4iKSB7JFN0b3JlID0gJEhvc3QuVUkuUmF3VUkuUmVhZEtleSgiSW5jbHVkZUtleVVwLE5vRWNobyIpfQ0KICAgIHJldHVybiAoJEtleSAtaW4gJFN0b3JlLlZpcnR1YWxLZXlDb2RlKQ0KfQoKZnVuY3Rpb24gUHJpbnQtTGlzdCB7cGFyYW0oJHgsIFtTd2l0Y2hdJEluUmVjdXJzZSkNCg0KICAgIGlmICgkeC5jb3VudCAtbGUgMSkge3JldHVybiA/OigkSW5SZWN1cnNlKXskeH17IlskeF0ifX0gZWxzZSB7DQogICAgICAgIHJldHVybiAiWyQoKCR4IHwgJSB7UHJpbnQtTGlzdCAkXyAtSW5SZWN1cnNlfSkgLWpvaW4gJywgJyldIg0KICAgIH0NCn0KCmZ1bmN0aW9uIEludm9rZS1UZXJuYXJ5IHtwYXJhbShbYm9vbF0kZGVjaWRlciwgW3NjcmlwdGJsb2NrXSRpZnRydWUsIFtzY3JpcHRibG9ja10kaWZmYWxzZSkNCg0KICAgIGlmICgkZGVjaWRlcikgeyAmJGlmdHJ1ZX0gZWxzZSB7ICYkaWZmYWxzZSB9DQp9CgpmdW5jdGlvbiBBUC1SZXF1aXJlIHtwYXJhbShbUGFyYW1ldGVyKE1hbmRhdG9yeT0kVHJ1ZSldW0FsaWFzKCJGdW5jdGlvbmFsaXR5IiwiTGlicmFyeSIpXVtTdHJpbmddJExpYiwgW1NjcmlwdEJsb2NrXSRPbkZhaWw9e30sIFtTd2l0Y2hdJFBhc3NUaHJ1KQ0KDQogICAgJExvYWRNb2R1bGUgPSB7DQogICAgICAgIHBhcmFtKCRGaWxlLFtib29sXSRJbXBvcnQpDQogICAgICAgIHRyeSB7SW1wb3J0LU1vZHVsZSAkRmlsZSAtZWEgc3RvcDtyZXR1cm4gMX0gY2F0Y2gge30NCiAgICAgICAgJExpYj1BUC1Db252ZXJ0UGF0aCAiPExJQj4iOyRMRiA9ICIkTGliXCRGaWxlIg0KICAgICAgICBbc3RyaW5nXSRmID0gaWYodGVzdC1wYXRoIC10IGxlYWYgJExGKXskTEZ9ZWxzZWlmKHRlc3QtcGF0aCAtdCBsZWFmICIkTEYuZGxsIil7IiRMRi5kbGwifQ0KICAgICAgICBpZiAoJGYgLWFuZCAkSW1wb3J0KSB7SW1wb3J0LU1vZHVsZSAkZn0NCiAgICAgICAgcmV0dXJuICRmDQogICAgfQ0KICAgICRTdGF0ID0gJChzd2l0Y2ggLXJlZ2V4ICgkTGliLnRyaW0oKSkgew0KICAgICAgICAiXkludGVybmV0IiAgICAgICAgICAgICAgIHt0ZXN0LWNvbm5lY3Rpb24gZ29vZ2xlLmNvbSAtQ291bnQgMSAtUXVpZXR9DQogICAgICAgICJeZGVwOiguKikiICAgICAgICAgICAgICAge2lmICgkTWF0Y2hlc1sxXSAtbmUgIndoZXJlIil7QVAtUmVxdWlyZSAiZGVwOndoZXJlIiB7JE1PREU9Mn19ZWxzZXskTU9ERT0yfTtpZiAoJE1PREUtMil7R2V0LVdoZXJlICRNYXRjaGVzWzFdfWVsc2V7dHJ5eyYgJE1hdGNoZXNbMV0gIi9mamZkamZkcyAtLWRzamFoZGhzIC1kc2phZGoiIDI+JG51bGw7InN1Y2MifWNhdGNoe319fQ0KICAgICAgICAiXihsaWJ8bW9kdWxlKTooLiopIiAgICAgIHskTG9hZE1vZHVsZS5pbnZva2UoJE1hdGNoZXNbMl0sICR0cnVlKX0NCiAgICAgICAgIl4obGlifG1vZHVsZSlfdGVzdDooLiopIiB7JExvYWRNb2R1bGUuaW52b2tlKCRNYXRjaGVzWzJdKX0NCiAgICAgICAgIl5mdW5jdGlvbjooLiopIiAgICAgICAgICB7Z2NtICRNYXRjaGVzWzFdIC1lYSBTaWxlbnRseUNvbnRpbnVlfQ0KICAgICAgICAiXnN0cmljdF9mdW5jdGlvbjooLiopIiAgIHtUZXN0LVBhdGggIkZ1bmN0aW9uOlwkKCRNYXRjaGVzWzFdKSJ9DQogICAgICAgIGRlZmF1bHQge1dyaXRlLUFQICIhSW52YWxpZCBzZWxlY3RvciBwcm92aWRlZCBbJCgiJExpYiIuc3BsaXQoJzonKVswXSldIjt0aHJvdyAnQkFEX1NFTEVDVE9SJ30NCiAgICB9KQ0KICAgIGlmICghJFN0YXQpIHskT25GYWlsLkludm9rZSgpfQ0KICAgIGlmICgkUGFzc1RocnUpIHtyZXR1cm4gJFN0YXR9DQp9CgpmdW5jdGlvbiBXcml0ZS1BUCB7DQogICAgW0NtZGxldEJpbmRpbmcoKV0NCiAgICBwYXJhbShbUGFyYW1ldGVyKFZhbHVlRnJvbVBpcGVsaW5lPSR0cnVlLCBNYW5kYXRvcnk9JFRydWUpXSRUZXh0LFtTd2l0Y2hdJE5vU2lnbixbU3dpdGNoXSRQbGFpblRleHQsW1ZhbGlkYXRlU2V0KCJDZW50ZXIiLCJSaWdodCIsIkxlZnQiKV1bU3RyaW5nXSRBbGlnbj0nTGVmdCcsW1N3aXRjaF0kUGFzc1RocnUpDQogICAgYmVnaW4geyRUVCA9IEAoKX0NCiAgICBQcm9jZXNzIHskVFQgKz0gLCRUZXh0fQ0KICAgIEVORCB7DQogICAgICAgICRCbHVlID0gJChpZiAoJFdSSVRFX0FQX0xFR0FDWV9DT0xPUlMpezN9ZWxzZXsnQmx1ZSd9KQ0KICAgICAgICBpZiAoJFRULmNvdW50IC1lcSAxKSB7JFRUID0gJFRUWzBdfTskVGV4dCA9ICRUVA0KICAgICAgICBpZiAoJHRleHQuY291bnQgLWd0IDEgLW9yICR0ZXh0LkdldFR5cGUoKS5OYW1lIC1tYXRjaCAiXFtcXSQiKSB7cmV0dXJuICRUZXh0IHw/eyIkXyJ9fCAlIHtXcml0ZS1BUCAkXyAtTm9TaWduOiROb1NpZ24gLVBsYWluVGV4dDokUGxhaW5UZXh0IC1BbGlnbiAkQWxpZ259fQ0KICAgICAgICBpZiAoISR0ZXh0IC1vciAkdGV4dCAtbm90bWF0Y2ggIl4oKD88Tk5MPngpfCg/PE5TPm5zPykpezAsMn0oPzx0Plw+KikoPzxzPlsrXC0hXCpcI1xAX10pKD88dz4uKikiKSB7cmV0dXJuICRUZXh0fQ0KICAgICAgICAkdGIgID0gIiAgICAiKiRNYXRjaGVzLnQubGVuZ3RoOw0KICAgICAgICAkQ29sID0gQHsnKyc9JzInOyctJz0nMTInOychJz0nMTQnOycqJz0kQmx1ZTsnIyc9J0RhcmtHcmF5JzsnQCc9J0dyYXknOydfJz0nd2hpdGUnfVsoJFNpZ24gPSAkTWF0Y2hlcy5TKV0NCiAgICAgICAgaWYgKCEkQ29sKSB7VGhyb3cgIkluY29ycmVjdCBTaWduIFskU2lnbl0gUGFzc2VkISJ9DQogICAgICAgICRTaWduID0gJChpZiAoJE5vU2lnbiAtb3IgJE1hdGNoZXMuTlMpIHsiIn0gZWxzZSB7IlskU2lnbl0gIn0pDQogICAgICAgIEFQLVJlcXVpcmUgImZ1bmN0aW9uOkFsaWduLVRleHQiIHtmdW5jdGlvbiBHbG9iYWw6QWxpZ24tVGV4dCgkYWxpZ24sJHRleHQpIHskdGV4dH19DQogICAgICAgICREYXRhID0gIiR0YiRTaWduJCgkTWF0Y2hlcy5XKSI7aWYgKCEkRGF0YSkge3JldHVybn0NCiAgICAgICAgJERhdGEgPSBBbGlnbi1UZXh0IC1BbGlnbiAkQWxpZ24gIiR0YiRTaWduJCgkTWF0Y2hlcy5XKSINCiAgICAgICAgaWYgKCRQbGFpblRleHQpIHtyZXR1cm4gJERhdGF9DQogICAgICAgIFdyaXRlLUhvc3QgLU5vTmV3TGluZTokKFtib29sXSRNYXRjaGVzLk5OTCkgLWYgJENvbCAkRGF0YQ0KICAgICAgICBpZiAoJFBhc3NUaHJ1KSB7JERhdGF9DQogICAgfQ0KfQoKZnVuY3Rpb24gSlMtT1Ige2ZvcmVhY2ggKCRhIGluICRhcmdzKSB7aWYgKCEkYSkge2NvbnRpbnVlfTtpZiAoJGEuR2V0VHlwZSgpLk5hbWUgLWVxICJTY3JpcHRCbG9jayIpIHskYSA9ICRhLmludm9rZSgpO2lmICghJGEpe2NvbnRpbnVlfX07cmV0dXJuICRhfX0KCmZ1bmN0aW9uIEtleVRyYW5zbGF0ZSB7cGFyYW0oW1BhcmFtZXRlcihNYW5kYXRvcnk9JFRydWUpXVtTdHJpbmddJEtleSkNCg0KICAgICRIYXNoS2V5ID0gQHsNCiAgICAgICAgIn5+U3BhY2V+fiI9MzINCiAgICAgICAgIn5+RVNDQVBFfn4iPTI3DQogICAgICAgICJ+fkVudGVyfn4iPTEzDQogICAgICAgICJ+flNoaWZ0fn4iPTE2DQogICAgICAgICJ+fkNvbnRyb2x+fiI9MTcNCiAgICAgICAgIn5+QWx0fn4iPTE4DQogICAgICAgICJ+fkJhY2tTcGFjZX5+Ij04DQogICAgICAgICJ+fkRlbGV0ZX5+Ij00Ng0KICAgICAgICAifn5mMX5+Ij0xMTINCiAgICAgICAgIn5+ZjJ+fiI9MTEzDQogICAgICAgICJ+fmYzfn4iPTExNA0KICAgICAgICAifn5mNH5+Ij0xMTUNCiAgICAgICAgIn5+ZjV+fiI9MTE2DQogICAgICAgICJ+fmY2fn4iPTExNw0KICAgICAgICAifn5mN35+Ij0xMTgNCiAgICAgICAgIn5+Zjh+fiI9MTE5DQogICAgICAgICJ+fmY5fn4iPTEyMA0KICAgICAgICAifn5mMTB+fiI9MTIxDQogICAgICAgICJ+fmYxMX5+Ij0xMjINCiAgICAgICAgIn5+ZjEyfn4iPTEyMw0KICAgICAgICAifn5NdXRlfn4iPTE3Mw0KICAgICAgICAifn5JbnNlcnR+fiI9NDUNCiAgICAgICAgIn5+UGFnZVVwfn4iPTMzDQogICAgICAgICJ+flBhZ2VEb3dufn4iPTM0DQogICAgICAgICJ+fkVORH5+Ij0zNQ0KICAgICAgICAifn5IT01Ffn4iPTM2DQogICAgICAgICJ+fnRhYn5+Ij05DQogICAgICAgICJ+fkNhcHNMb2Nrfn4iPTIwDQogICAgICAgICJ+fk51bUxvY2t+fiI9MTQ0DQogICAgICAgICJ+fldpbmRvd3N+fiI9OTENCiAgICAgICAgIn5+TGVmdH5+Ij0zNw0KICAgICAgICAifn5VcH5+Ij0zOA0KICAgICAgICAifn5SaWdodH5+Ij0zOQ0KICAgICAgICAifn5Eb3dufn4iPTQwDQogICAgICAgICJ+fktQMH5+Ij05Ng0KICAgICAgICAifn5LUDF+fiI9OTcNCiAgICAgICAgIn5+S1Ayfn4iPTk4DQogICAgICAgICJ+fktQM35+Ij05OQ0KICAgICAgICAifn5LUDR+fiI9MTAwDQogICAgICAgICJ+fktQNX5+Ij0xMDENCiAgICAgICAgIn5+S1A2fn4iPTEwMg0KICAgICAgICAifn5LUDd+fiI9MTAzDQogICAgICAgICJ+fktQOH5+Ij0xMDQNCiAgICAgICAgIn5+S1A5fn4iPTEwNQ0KICAgIH0NCiAgICBpZiAoW2ludF0kQ29udmVydCA9ICRIYXNoS2V5LiRLZXkpIHtyZXR1cm4gJENvbnZlcnR9DQogICAgVGhyb3cgIkludmFsaWQgU3BlY2lhbCBLZXkgQ29udmVyc2lvbiINCn0KCmZ1bmN0aW9uIEdldC1XaGVyZSB7cGFyYW0oW1BhcmFtZXRlcihNYW5kYXRvcnk9JHRydWUpXVtzdHJpbmddJEZpbGUsIFtTd2l0Y2hdJEFsbCkNCg0KICAgIEFQLVJlcXVpcmUgImRlcDp3aGVyZSIge3Rocm93ICJOZWVkIFN5czMyXHdoZXJlIHRvIHdvcmshIjtyZXR1cm59DQogICAgJE91dD0kbnVsbA0KICAgIGlmICgkUFNWZXJzaW9uVGFibGUuUGxhdGZvcm0gLWVxICJVbml4Iikgew0KICAgICAgICAkT3V0ID0gd2hpY2ggJGZpbGUgMj4kbnVsbA0KICAgIH0gZWxzZSB7JE91dCA9IHdoZXJlLmV4ZSAkZmlsZSAyPiRudWxsfQ0KICAgIA0KICAgIGlmICghJE91dCkge3JldHVybn0NCiAgICBpZiAoJEFsbCkge3JldHVybiAkT3V0fQ0KICAgIHJldHVybiBAKCRPdXQpWzBdDQp9CgpmdW5jdGlvbiBNYWtlLVJlYWRPbmx5IHtwYXJhbSgkbykNCg0KICAgIGlmICghJG8uR2V0RW51bWVyYXRvciAtYW5kICRvLkdldFR5cGUoKS5OYW1lIC1lcSAiSGFzaHRhYmxlIikge1dyaXRlLUFQICIhSW52YWxpZCBvYmplY3QgcGFzc2VkLCBtdXN0IGJlIGEgaGFzaHRhYmxlIjtyZXR1cm59DQogICAgJG5ldyA9IFtQc0N1c3RvbU9iamVjdF1Ae30NCiAgICAkby5HZXRFbnVtZXJhdG9yKCkgfCAlIHskdiA9ICRfLnZhbHVlOyRuZXcgfCBBZGQtTWVtYmVyICRfLmtleSAtRm9yY2UgLU1lbWJlclR5cGUgU2NyaXB0UHJvcGVydHkgeyR2fS5HZXROZXdDbG9zdXJlKCl9DQogICAgcmV0dXJuICRuZXcNCn0KCmZ1bmN0aW9uIFBhdXNlIHtwYXJhbShbU3RyaW5nXSRQYXVzZVEgPSAiUHJlc3MgYW55IGtleSB0byBjb250aW51ZSAuIC4gLiAiKQ0KDQogICAgV3JpdGUtSG9zdCAtbm9OZXdsaW5lICRQYXVzZVENCiAgICAkbnVsbCA9ICRIb3N0LlVJLlJhd1VJLlJlYWRLZXkoIk5vRWNobywgSW5jbHVkZUtleURvd24iKQ0KICAgIFdyaXRlLUhvc3QgIiINCn0KCmZ1bmN0aW9uIEFsaWduLVRleHQge3BhcmFtKFtQYXJhbWV0ZXIoTWFuZGF0b3J5PSRUcnVlKV1bU3RyaW5nW11dJFRleHQsIFtWYWxpZGF0ZVNldCgiQ2VudGVyIiwiUmlnaHQiLCJMZWZ0IildW1N0cmluZ10kQWxpZ249J0NlbnRlcicpDQoNCiAgICBpZiAoJFRleHQuY291bnQgLWd0IDEpIHsNCiAgICAgICAgJGFucyA9IEAoKQ0KICAgICAgICBmb3JlYWNoICgkbG4gaW4gJFRleHQpIHskQW5zICs9IEFsaWduLVRleHQgJGxuICRBbGlnbn0NCiAgICAgICAgcmV0dXJuICgkYW5zKQ0KICAgIH0gZWxzZSB7DQogICAgICAgICRXaW5TaXplID0gW2NvbnNvbGVdOjpCdWZmZXJXaWR0aA0KICAgICAgICBpZiAoKCIiKyRUZXh0KS5MZW5ndGggLWdlICRXaW5TaXplKSB7DQogICAgICAgICAgICAkQXBwZW5kZXIgPSBAKCIiKTsNCiAgICAgICAgICAgICRqID0gMA0KICAgICAgICAgICAgZm9yZWFjaCAoJHAgaW4gMC4uKCgiIiskVGV4dCkuTGVuZ3RoLTEpKXsNCiAgICAgICAgICAgICAgICBpZiAoKCRwKzEpJSR3aW5zaXplIC1lcSAwKSB7JGorKzskQXBwZW5kZXIgKz0gIiJ9DQojICAgICAgICAgICAgICAgICIiKyRqKyIgLSAiKyRwDQogICAgICAgICAgICAgICAgJEFwcGVuZGVyWyRqXSArPSAkVGV4dC5jaGFycygkcCkNCiAgICAgICAgICAgIH0NCiAgICAgICAgICAgIHJldHVybiAoQWxpZ24tVGV4dCAkQXBwZW5kZXIgJEFsaWduKQ0KICAgICAgICB9IGVsc2Ugew0KICAgICAgICAgICAgaWYgKCRBbGlnbiAtZXEgIkNlbnRlciIpIHsNCiAgICAgICAgICAgICAgICByZXR1cm4gKCIgIipbbWF0aF06OnRydW5jYXRlKCgkV2luU2l6ZS0oIiIrJFRleHQpLkxlbmd0aCkvMikrJFRleHQpDQogICAgICAgICAgICB9IGVsc2VpZiAoJEFsaWduIC1lcSAiUmlnaHQiKSB7DQogICAgICAgICAgICAgICAgcmV0dXJuICgiICIqKCRXaW5TaXplLSgiIiskVGV4dCkuTGVuZ3RoLTEpKyRUZXh0KQ0KICAgICAgICAgICAgfSBlbHNlIHsNCiAgICAgICAgICAgICAgICByZXR1cm4gKCRUZXh0KQ0KICAgICAgICAgICAgfQ0KICAgICAgICB9DQogICAgfQ0KfQoKZnVuY3Rpb24gS2V5UHJlc3NlZCB7cGFyYW0oW1BhcmFtZXRlcihNYW5kYXRvcnk9JFRydWUpXVtTdHJpbmdbXV0kS2V5LCAkU3RvcmU9Il5eXiIpDQoNCiAgICBpZiAoJFN0b3JlIC1lcSAiXl5eIiAtYW5kICRIb3N0LlVJLlJhd1VJLktleUF2YWlsYWJsZSkgeyRTdG9yZSA9ICRIb3N0LlVJLlJhd1VJLlJlYWRLZXkoIkluY2x1ZGVLZXlVcCxOb0VjaG8iKX0gZWxzZSB7aWYgKCRTdG9yZSAtZXEgIl5eXiIpIHtyZXR1cm4gJEZhbHNlfX0NCiAgICAkQW5zID0gJEZhbHNlDQogICAgJEtleSB8ICUgew0KICAgICAgICAkU09VUkNFID0gJF8NCiAgICAgICAgdHJ5IHsNCiAgICAgICAgICAgICRBbnMgPSAkQW5zIC1vciAoS2V5UHJlc3NlZENvZGUgJFNPVVJDRSAkU3RvcmUpDQogICAgICAgIH0gY2F0Y2ggew0KICAgICAgICAgICAgRm9yZWFjaCAoJEsgaW4gJFNPVVJDRSkgew0KICAgICAgICAgICAgICAgIFtTdHJpbmddJEsgPSAkSw0KICAgICAgICAgICAgICAgIGlmICgkSy5sZW5ndGggLWd0IDQgLWFuZCAoJEtbMCwxLC0xLC0yXSAtam9pbigiIikpIC1lcSAifn5+fiIpIHsNCiAgICAgICAgICAgICAgICAgICAgJEFucyA9ICRBTlMgLW9yIChLZXlQcmVzc2VkQ29kZSAoS2V5VHJhbnNsYXRlKCRLKSkgJFN0b3JlKQ0KICAgICAgICAgICAgICAgIH0gZWxzZSB7DQogICAgICAgICAgICAgICAgICAgICRBbnMgPSAkQU5TIC1vciAoJEsuY2hhcnMoMCkgLWluICRTdG9yZS5DaGFyYWN0ZXIpDQogICAgICAgICAgICAgICAgfQ0KICAgICAgICAgICAgfQ0KICAgICAgICB9DQogICAgfQ0KICAgIHJldHVybiAkQW5zDQp9CgpTZXQtQWxpYXMgaW52IFByb2Nlc3MtVHJhbnNwYXJlbmN5ClNldC1BbGlhcyA/OiBJbnZva2UtVGVybmFyeQ==")))
# ========================================END=OF=COMPILER===========================================================|

#= INIT =======================================================================================|
[int[]]$Win       = @(([Console]::WindowHeight-2), [Console]::WindowWidth)
$Script:TitleBkp  = [Console]::Title
$Script:BkColBkp  = [Console]::BackGroundColor
#= SETTINGS ===================================================================================|
$Script:SaveFile  = "$env:APPDATA\AP-PowerSneks\AP-PowerSneks.Map.Save"
$Script:CharMap   = Make-ReadOnly @{
    Space        = ' '
    Symbol       = Make-ReadOnly @{
        Food = "♣"
        Wall = "█"
        Space = " "
    }
    SnakeMoves   = @("<","^",">","v")
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
        PrintDelay   = 15  # Laser draw delay per block in ms
        InitialCount = 1
        AquireCost   = 3   # How many food items to eat before acquiring laser 
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
#= GLOBAL-OBJECTS =============================================================================|
enum Direction {Left;Up;Right;Down}
enum LifeState {Alive;Dead}
enum GameMode {SinglePlayer;MultiPlayer}
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
#= INTERFACES =================================================================================|
class Serializeable {
    [object] serializeState() {return @{}}
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
    incrementScore() {$this.Score += $Script:GameKnobs.ScoreIncr}
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

class Game : LiveObject {
    [int]$Score = 0
    [int]$Ticks = 0
    [int]$quits_issued = 0
    [int]$Lasers = $Script:GameKnobs.Laser.InitialCount
    [int]$Consumption = 0
    [Collections.ArrayList]$Players = @()
    [Collections.ArrayList]$LiveObjects = @()
    [char]$Tail = ' '
    [char[][]]$Grid
    [ScoreBoard]$ScoreBoard
    [GameMode]$GameMode = [GameMode]::SinglePlayer
    [Decimal]$SleepAdj = 0
    [Decimal]$SlowTime = 0
    [Bool]$Paused = $false
    [Management.Automation.Host.BufferCell[,]]$GameBkp

    Game($Map, [bool]$Trail) {
        [Console]::BackgroundColor = $Script:ColorMap.Game.Background
        [Console]::Title = "PowerSneks by AP"
        if ($Trail) {$this.Tail = '.'}
        $this.ScoreBoard = [ScoreBoard]::new($this, [Console]::Title)
        $this.loadMap($Map, $true)
    }
    run() {$this.run({})}
    run([ScriptBlock]$Code) {
        $Sleep = $Script:GameKnobs.Sleep.Tick
        $this.ticks = 0
        $i = 0
        while ($this.isAlive()) {
            if (!$this.paused) {
                $this.ticks++                
                $Code.Invoke($this.ticks)
            }
            $i = ($i + 1) % 5
            $this.tick()
            $PixRatio = $(if (!$this.isMultiPlayer() -and $this.Players[0].Direction%2) {$Script:GameKnobs.Sleep.CursorRatio} else {1})
            if ($this.SlowTime) {
                $this.SlowTime = [Math]::Max($this.SlowTime * $Script:GameKnobs.SlowTimeDeteriorate, 3)-3
            }
            $SS = [Math]::Max((($Sleep + $this.SleepAdj + $this.SlowTime) * $PixRatio), 0)
            if ($Script:Debug) {Place-BufferedContent "Sleeping for $SS$('.' * $i)$(' '*5)" 3 4}
            sleep -m $SS
        }
    }
    loadMap($Map) {$this.loadMap($Map, $false)}
    loadMap($Map, [bool]$OptimizeForFirstLoad) {
        $this.Grid = 0..($Script:Win[0]-1)
        0..($Script:Win[0]-1) | % {
            $W = $Script:SymbolMap.Wall
            $Char = $Script:SymbolMap.Space
            if ($_ -in @(0, ($Script:Win[0]-1))) {$Char = $W}
            $this.Grid[$_] = @($W)+((,$Char)*($Script:Win[1]-2))+@(,$W)
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
            if ($_%2 -eq 0) {$Wall[$_].Bottom = $Script:Win[0]-1}
            else {$Wall[$_].Left++;$Wall[$_].Right = $Script:Win[1]-2}
        }
        # -------------
        "Left","Right" | % {$Wall[2].$_   = $Script:Win[1]-1}
        "Top","Bottom" | % {$Wall[3].$_   = $Script:Win[0]-1}
        $Ch = $Script:CharMap.Wall
        0,2 | % {$WFill[$_].Character = $Ch.Vertical} #475
        $WFill[1].Character = $Ch.Top
        $WFill[3].Character = $Ch.Bottom
        # -------------
        0..3 | % {$WFill[$_].ForegroundColor = $Script:ColorMap.Wall;$WFill[$_].BackgroundColor = $Script:ColorMap.Game.Background}
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
        $H, $W = $Script:Win
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
                if ($FastLoad -and $Kt -eq $Script:SymbolMap.Space -and !($p -in 0,($H-1)) -and !($d -in 0,($W-1))) {continue}
                $this.RenderPoint($d, $p)
            }
        }
    }
    pause() {
        $this.paused = !$this.paused
        if (!$this.paused) {
            $this.ScoreBoard.write()
            $Global:Host.UI.RawUI.SetBufferContents($Script:Lib.Coord::new(0,0), $this.GameBKP)
            return
        }
        $Area = $Script:Lib.Rect::new(0, 0, $Script:Win[1]+1, $Script:Win[0]-2)
        $this.GameBKP = $Global:Host.UI.RawUI.GetBufferContents($Area)
        $Fill = $Script:Lib.Cell::new(' ', 'Black', 'Black', 0)
        $Global:Host.UI.RawUI.SetBufferContents($Area, $Fill)

        $Colm = $Script:Lib.Rect::new(0, 0, 0, $Script:Win[0]-2)
        $Fill = $Script:Lib.Cell::new($Script:CharMap.Symbol.Food, 'DarkGray', $Script:ColorMap.Game.Background, 0)
        1..[Math]::Floor($Script:Win[1]/3) | % {
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
    ShootLaser() {
        if ($this.isMultiPlayer()) {$this.ScoreBoard.write("Lasers are not permitted in multiplayer!");return}
        if ($this.Lasers -le 0 -and $this.Lasers -ne -100) {$this.ScoreBoard.write("- - - - - - - - No More Lasers - - - - - - - -");return}
        $this.Lasers--
        $P = $this.Players[0]
        $x, $y = $P.Head
        $Laser = $Script:CharMap.Laser
        if ($P.Direction -in 0,2) {
            $Set = 0..($Script:Win[1]-1)
            if ($P.Direction -eq 0) {[Array]::Reverse($Set)}
            foreach ($p in $Set){
                if ($this.Grid[$y][$p] -eq $Script:SymbolMap.Wall){
                    $this.Grid[$y][$p] = $Script:SymbolMap.Space
                    Write-ToPos $Laser -y $y -x $p -fgc $Script:ColorMap.Laser
                    sleep -m $Script:GameKnobs.Laser.PrintDelay
                    $this.RenderPoint($p, $y)
                }
            }
        } else {
            $Set = 0..($Script:Win[0]-1)
            if ($P.Direction -eq 1) {[Array]::Reverse($Set)}
            foreach ($p in $Set){
                if ($this.Grid[$p][$x] -eq $Script:SymbolMap.Wall){
                    $this.Grid[$p][$x] = $Script:SymbolMap.Space
                    Write-ToPos $Laser -y $p -x $x -fgc $Script:ColorMap.Laser
                    sleep -m $Script:GameKnobs.Laser.PrintDelay
                    $this.RenderPoint($x, $p)
                }
            }
        }
        if ($Script:LaserCnt -ne -100) {$Script:LaserCnt--}
        $this.ScoreBoard.write()
    }
    readKeys() {
        while ($Global:Host.UI.RawUI.KeyAvailable) {
            $Store = $Global:Host.UI.RawUI.ReadKey("NoEcho,IncludeKeydown,IncludeKeyUp")
            if (!$Store.KeyDown) {Continue}
            
            #Critical Hotkeys
            If (KeyPressed "q","x","~~Escape~~" $Store) {$this.ScoreBoard.write(". . . QUIT Signal . . .");$this.quit()}
            ElseIf (KeyPressed "p"  $Store) {$this.pause()}
            ElseIf (KeyPressed '`'  $Store) {
                $Script:Debug = !$Script:Debug
                if ($Script:Debug) {return}
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
            if ($this.paused) {continue}
            ElseIf (KeyPressed "~~left~~"  $Store) {$this.sendPlayer(0)}
            ElseIf (KeyPressed "~~up~~"    $Store) {$this.sendPlayer(1)}
            ElseIf (KeyPressed "~~right~~" $Store) {$this.sendPlayer(2)}
            ElseIf (KeyPressed "~~down~~"  $Store) {$this.sendPlayer(3)}
            ElseIf (KeyPressed "A" $Store) {$this.sendPlayer(0, 2)}
            ElseIf (KeyPressed "W" $Store) {$this.sendPlayer(1, 2)}
            ElseIf (KeyPressed "D" $Store) {$this.sendPlayer(2, 2)}
            ElseIf (KeyPressed "S" $Store) {$this.sendPlayer(3, 2)}
            ElseIf (KeyPressed "-"  $Store) {$this.SleepAdj += 2}
            ElseIf (KeyPressed "+"  $Store) {$this.SleepAdj -= 2}
            ElseIf (KeyPressed "~~space~~","L","Z","~~Control~~"  $Store) {$this.ShootLaser()}
            ElseIf (KeyPressed "0s" $Store) {$this.generateFood()}
            ElseIf (KeyPressed "123" $Store) {$this.ScoreBoard.write("Loading Full Screen");cmd /c start /max cmd /k "mode con cols=239 lines=84&powershell -ep bypass -noprofile $PSCommandPath";$this.quit()}
            ElseIf (KeyPressed "~~Tab~~" $Store) {$this.ScoreBoard.write(". . . Saving Game State . . .");$this.SaveMap();$this.ScoreBoard.write(". . . Saved Game State . . .")}
            ElseIf (KeyPressed "116" $Store) {$this.refreshScreen()}
        }
    }
    saveMap() {$this.saveMap($Script:SaveFile)}
    saveMap($File) {
        md (Split-Path $File) -Force | Out-Null
        attrib -h -r -s +a $File 2>&1 | Out-Null
        "This is a Save File from PowerSneks by Apoorv Verma [AP]
        Copyright 2020. All Rights Reserved
        AP|--------------------------------->
            >>Game......= $($this.serializeState() | ConvertTo-Json -Compress)
            >>Window....= $Script:Win
        AP|--------------------------------->" | % {$_.replace((" "*4),"").replace(">>",(" "*4))} | out-file -Encoding ascii $File
        $this.Grid | % {$_ -join("")} | Out-File -Append -Encoding ascii $File
        attrib +h +r +s -a $File 2>&1 | Out-Null
    }
    [object] serializeState() {
        return @{
            Score = $this.Score
            Ticks = $this.Ticks
            Consumption = $this.Consumption
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
    }
    refreshScreen() {
        $OP = $(if([console]::WindowHeight -gt 3){-1}else{1})
        [console]::WindowHeight += $OP
        [console]::WindowHeight -= $OP
    }
    [int[]] getEmptyCoord() {
        $H, $W = $Script:Win
        $TmOut = .5*$W*$H
        while ($true) {
            $y = Get-Random -min 0 -max $H
            $x = Get-Random -min 0 -max $W
            # Write-AP "*Finding $x,$y = [$($this.Grid[$y][$x])]"
            if ($tmout -le 0) {break}
            $TmOut--
            if ($this.Grid[$y][$x] -eq $Script:SymbolMap.Space) {return $x,$y}
        }
        $this.ScoreBoard.write("Game Took Too Long to Find Coords")
        $this.quit()
        return -1,-1
    }
    quit() {
        $this.quits_issued++
        [Console]::Title = $Script:TitleBkp
        [Console]::BackGroundColor = $Script:BkColBkp
        $Global:Host.UI.RawUI.FlushInputBuffer()
        [Console]::CursorTop = $Script:Win[0]+2
        $this.die()
        if ($this.quits_issued -gt 20) {
            $this.ScoreBoard.write('Game cannot quit gracefully, force quitting!')
            exit
        }
    }
    generateFood() {
        $x, $y = $this.getEmptyCoord()
        $this.Grid[$y][$x] = $Script:SymbolMap.Food
        Write-ToPos $Script:CharMap.Symbol.Food -y $y -x $x -fgc $Script:ColorMap.Food
    }
    tick() {
        $this.readKeys()
        if ($this.paused) {return}
        $ToRemove = @()
        foreach ($Ob in $this.LiveObjects) {
            if ($Script:Debug) {Place-BufferedContent ("Ticking: {0,-16} {1}" -f "LiveObject $($Ob.ID)",$This.Ticks) 3 3}
            $ob.tick()
            if ($ob.isAlive()) {$ob.draw()}
        }
        if ($Script:Debug) {
            $Dirs = $($this.Players | % {$_.Direction} | select -f 4)
            $Curs = $($this.Players | % {"{$($_.Head -join ', ')}"} | select -f 4)
            $c = "       P> Direction: $Dirs | Old Position: $Curs"
            Place-BufferedContent $c ($Script:Win[1]-2-$c.length) 3
        }
        foreach ($Player in $this.Players) {
            if ($Script:Debug) {Place-BufferedContent ("Ticking: {0,-16} {1}" -f "Player $($Player.ID)",$This.Ticks) 3 3}
            $Player.tick()
        }
        if ($Script:Debug) {
            $c = "       New Position: $($this.Players | % {"{$($_.Head -join ', ')}"} | select -f 4)"
            Place-BufferedContent $c ($Script:Win[1]-2-$c.length) 4
        }
        foreach ($Player in $this.Players) {
            if ($Script:Debug) {Place-BufferedContent ("Drawing: {0,-16} {1}" -f "Player $($Player.ID)",$This.Ticks) 3 3}
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
        if ($Script:Debug) {
            $C = "[$(if($this.isMultiPlayer()){' Multi'}else{'Single'})Player] Loaded Players: $RemainingPlayers"
            Place-BufferedContent $C -y 2 -x ($Script:Win[1]-$C.length-2)
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
        $this.Grid[$y][$x] = $Script:CharMap.Space
        $this.generateFood()
        $this.Consumption++
        $this.SleepAdj += $Script:GameKnobs.Sleep.AdjPerFood
        if (!($this.Consumption % $Script:GameKnobs.Laser.AquireCost)) {
            $this.Lasers++
        }
        $this.createObstruction()
        $this.ScoreBoard.write()
    }
    createObstruction() {
        $Coord = @()
        $H, $W = $Script:Win
        $TmOut = $H*$W
        $HDist, $WDist = $H, $W | % {[Math]::Ceiling($Script:GameKnobs.Obstruction.SnakeDistanceRatio*$_)}
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
        $xLen = get-random -min 1 -max ($W*$Script:GameKnobs.Obstruction.MaxWidth+1)
        $yLen = get-random -min 1 -max ($H*$Script:GameKnobs.Obstruction.MaxHeight+1)
        $Items2Respawn = @()
        foreach ($p in $y..($y+$yLen)) {
            foreach ($d in $x..($x+$xLen)) {
                $nx,$ny = [Game]::WarpCoords($d,$p)
                if ($this.Grid[$ny][$nx] -eq $Script:SymbolMap.Wall) {continue}
                if ($this.Grid[$ny][$nx] -eq $Script:SymbolMap.Food) {
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
                $this.Grid[$ny][$nx] = $Script:SymbolMap.Wall
                Write-ToPos $Script:CharMap.Wall.Vertical -y $ny -x $nx -fgc $Script:ColorMap.Wall -bgc $Script:ColorMap.Wall
            }
        }
        $this.SlowTime = $Script:GameKnobs.Sleep.SlowTime
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
        $Key = $Script:MapToSymbol.$Symbol
        if ($Script:Debug) {Place-BufferedContent "Current Block: $Key       " 2 2}
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
            if ($Script:Debug) {Place-BufferedContent "Distance-O: $dist     " 3 5}
            if ($dist -gt 0) {continue}
            if (!$o.checkForCollision($obj.getCollideablePoints())) {continue}
            $o.collided($obj)
        }
        if (!$this.isMultiPlayer()) {return}
        foreach ($p in $this.Players) {
            if ($p.Id -eq $Obj.Id) {continue}
            $dist = [Game]::CoordsDistance($p.head, $obj.Head) - $p.Size
            if ($Script:Debug) {Place-BufferedContent "Distance-P: $dist     " 3 5}
            if ($dist -gt 0) {continue}
            if (!$p.checkForCollision($obj.getCollideablePoints())) {continue}
            $obj.collided("Player $($Obj.ID) died by colliding into Player $($p.ID)")
        }
    }
    RenderPoint([int[]]$Coord) {$this.RenderPoint($Coord[0], $Coord[1])}
    RenderPoint([int]$x, [int]$y) {
        $Symbol = $this.Grid[$y][$x]
        $Key = JS-OR $Script:MapToSymbol.$Symbol 'Space'
        $Char = $Script:CharMap.Symbol.$Key
        if ($Key -eq 'Wall' -and $x -notin (0, $Script:Win[1])) {
            if ($y -eq 0) {$Char = $Script:CharMap.Wall.Top}
            if ($y -eq $Script:Win[0]-1) {$Char = $Script:CharMap.Wall.Bottom}
        }
        Write-ToPos $Char $x $y -fgc $Script:ColorMap.$Key
    }
    static [bool] CoordsEqual([int[]]$A,[int[]]$B) {
        return $A[0] -eq $B[0] -and $A[1] -eq $B[1]
    }
    static [int] CoordsDistance([int[]]$A,[int[]]$B) {
        return [Math]::Abs($A[0] - $B[0]) + [Math]::Abs($A[1] - $B[1])
    }
    static [int[]] WarpCoords([int[]]$c) {return [Game]::WarpCoords($c[0], $c[1])}
    static [int[]] WarpCoords($x, $y) {
        $H, $W = $Script:Win
        if ($x -lt 0) {$x += $W}
        if ($y -lt 0) {$y += $H}
        return ($x%$W), ($y%$H)
    }
}
class Snake : Player {
    [String]$Class               = 'Snake'
    [Int]$Size                   = 1
    [Int]$GrowFactor             = $Script:GameKnobs.SnakeStartSz
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
        $ch = if ($this.Game.isMultiPlayer() -and $Script:ShowPlayerLabels) {$this.ID} else {$Script:charMap.SnakeMoves[$this.Direction]}
        Write-ToPos $CH $x $y -fgc $Script:ColorMap.Snake.Head
        if ($Spawn) {
            $this.Body.GetEnumerator() | % {
                $x, $y = $_
                Write-ToPos $Script:charMap.SnakeMoves[$this.BodyDirection] $x $y -fgc $Script:ColorMap.Snake.Body
            }
        } else {
            $x, $y = @($this.Body)[-1]
            Write-ToPos $Script:charMap.SnakeMoves[$this.BodyDirection] $x $y -fgc $Script:ColorMap.Snake.Body
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
        if ($this.BodyDirection -eq (($Dir+2)%4)) {return} # Cannot move into body
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

    ScoreBoard([Game]$Game, [String]$Title) {
        $this.FallBackTitle = $Title
        $this.Game = $Game
        $this.ScoreBoard = $Script:Lib.Rect::new(1, $Script:Win[0], $Script:Win[1]-2, $Script:Win[0])
        $this.SBFiller = $Script:Lib.Cell::new(' ', $Script:ColorMap.Game.ConsoleText, $Script:ColorMap.Game.ConsoleTextBg, 0)
        $Global:Host.UI.RawUI.SetBufferContents($this.ScoreBoard,$this.SBFiller)
        $this.Write()
    }
    Write() {$this.write($this.FallBackTitle)}
    Write([String]$title) {
        $title = $title
        $Colors = $Script:ColorMap.Game
        $SB, $SF = $this.ScoreBoard, $this.SBFiller
        $Global:Host.UI.RawUI.SetBufferContents($SB, $SF)
        $LaserText = " Lasers : $(if ($this.Game.Lasers -eq -100) {'∞'} else {$this.Game.Lasers}) "
        $ScoreText = " SCORE : $($this.Game.Score) "
        $OffSetS = $ScoreText.Length
        $OffSetL = 1 + $LaserText.Length
        $OffSet  = $OffSetS+$OffsetL
        $Area = $SB.Right-$SB.Left-$Offset
        $Y = $Script:Win[0]
        if ($Title.length -gt $Area) {$Title = $Title.substring(0,$Area-3)+"..."}
        Place-BufferedContent (Align-Text $Title).substring([Math]::Floor($OffSet/2)) 1 $Y -f $Colors.ConsoleText -b $Colors.ConsoleTextBg
        # Dividers
        $X_Off = $SB.Left + $Area
        $DIV = $Script:CharMap.Wall.Vertical
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
#= MAIN-GAME ==================================================================================|

[Console]::CursorVisible = $False
cls
$Map = $null
if (($MapFile -ne '/*\') -and (Test-path -type leaf $MapFile)) {
    $Map = $MapFile
} elseif ($LoadDefaultSave) {
    $Map = $SaveFile
}
$Script:Game = [Game]::New($Map, $Trail)
if (!$Game.Players) {
    1..$Snakes | % {
        $c = @(-1, -1)
        $tmout = 100
        $H, $W = $Script:Win
        while (1) {
            $x,$y = $c = $Game.getEmptyCoord()
            if (--$tmout -gt 0 -and $x -lt (.1*$W) -or $x -gt (.9*$W) -or $y -lt (.45*$H) -or $y -gt (.95*$H)) {continue}
            break
        }
        $Game.attachPlayer([Snake]::new($c, $Game))
    }
}
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
    } catch {
        Write-Host Error ($_ | Out-String)
    }
})
