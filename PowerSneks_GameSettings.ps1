# =======================================START=OF=COMPILER==========================================================|
#    The Following Code was added by AP-Compiler Version [1.2] To Make this program independent of AP-Core Engine
#    GitHub: https://github.com/avdaredevil/AP-Compiler
# ==================================================================================================================|
$Script:PSHell=$(if($PSHell){$PSHell}elseif($PSScriptRoot){$PSScriptRoot}else{"."});
iex ([System.Text.Encoding]::UTF8.GetString([System.Convert]::FromBase64String("ZnVuY3Rpb24gUHJvY2Vzcy1UcmFuc3BhcmVuY3kge3BhcmFtKFtBbGlhcygiVHJhbnNwYXJlbmN5IiwiSW52aXNpYmlsaXR5IiwiaSIsInQiKV1bVmFsaWRhdGVSYW5nZSgwLDEwMCldW2ludF0kVHJhbnM9MCwgW1BhcmFtZXRlcihNYW5kYXRvcnk9JFRydWUpXSRQcm9jZXNzKQ0KDQogICAgaWYgKCRQcm9jZXNzIC1tYXRjaCAiXC5leGUkIikgeyRQcm9jZXNzID0gJFByb2Nlc3MucmVwbGFjZSgiLmV4ZSIsIiIpfQ0KICAgIFRyeSB7DQogICAgICAgIGlmICgkUHJvY2Vzcy5uYW1lKSB7JFByb2MgPSAkUHJvY2Vzcy5uYW1lfSBlbHNlIHskUHJvYyA9IChHZXQtUHJvY2VzcyAkUHJvY2VzcyAtRXJyb3JBY3Rpb24gU3RvcClbMF0ubmFtZX0NCiAgICB9IGNhdGNoIHsNCiAgICAgICAgaWYgKFtJbnRdOjpUcnlQYXJzZSgkUHJvY2VzcywgW3JlZl0zKSkgeyRQcm9jID0gKChHZXQtUHJvY2VzcyB8ID8geyRfLklEIC1lcSAkUHJvY2Vzc30pWzBdKS5uYW1lfQ0KICAgIH0NCiAgICBpZiAoJFByb2MgLW5vdE1hdGNoICJcLmV4ZSQiKSB7JFByb2MgPSAiJFByb2MuZXhlIn0NCiAgICBuaXJjbWQgd2luIHRyYW5zIHByb2Nlc3MgIiRQcm9jIiAoKDEwMC0kVHJhbnMpKjI1NS8xMDApIHwgT3V0LU51bGwNCn0KCmZ1bmN0aW9uIEtleVByZXNzZWRDb2RlIHtwYXJhbShbUGFyYW1ldGVyKE1hbmRhdG9yeT0kVHJ1ZSldW0ludF0kS2V5LCAkU3RvcmU9Il5eXiIpDQoNCiAgICBpZiAoISRIb3N0LlVJLlJhd1VJLktleUF2YWlsYWJsZSAtYW5kICRTdG9yZSAtZXEgIl5eXiIpIHtSZXR1cm4gJEZhbHNlfQ0KICAgIGlmICgkU3RvcmUgLWVxICJeXl4iKSB7JFN0b3JlID0gJEhvc3QuVUkuUmF3VUkuUmVhZEtleSgiSW5jbHVkZUtleVVwLE5vRWNobyIpfQ0KICAgIHJldHVybiAoJEtleSAtaW4gJFN0b3JlLlZpcnR1YWxLZXlDb2RlKQ0KfQoKZnVuY3Rpb24gUHJpbnQtTGlzdCB7cGFyYW0oJHgsIFtTd2l0Y2hdJEluUmVjdXJzZSkNCg0KICAgIGlmICgkeC5jb3VudCAtbGUgMSkge3JldHVybiA/OigkSW5SZWN1cnNlKXskeH17IlskeF0ifX0gZWxzZSB7DQogICAgICAgIHJldHVybiAiWyQoKCR4IHwgJSB7UHJpbnQtTGlzdCAkXyAtSW5SZWN1cnNlfSkgLWpvaW4gJywgJyldIg0KICAgIH0NCn0KCmZ1bmN0aW9uIEludm9rZS1UZXJuYXJ5IHtwYXJhbShbYm9vbF0kZGVjaWRlciwgW3NjcmlwdGJsb2NrXSRpZnRydWUsIFtzY3JpcHRibG9ja10kaWZmYWxzZSkNCg0KICAgIGlmICgkZGVjaWRlcikgeyAmJGlmdHJ1ZX0gZWxzZSB7ICYkaWZmYWxzZSB9DQp9CgpmdW5jdGlvbiBBUC1SZXF1aXJlIHtwYXJhbShbUGFyYW1ldGVyKE1hbmRhdG9yeT0kVHJ1ZSldW0FsaWFzKCJGdW5jdGlvbmFsaXR5IiwiTGlicmFyeSIpXVtTdHJpbmddJExpYiwgW1NjcmlwdEJsb2NrXSRPbkZhaWw9e30sIFtTd2l0Y2hdJFBhc3NUaHJ1KQ0KDQogICAgJExvYWRNb2R1bGUgPSB7DQogICAgICAgIHBhcmFtKCRGaWxlLFtib29sXSRJbXBvcnQpDQogICAgICAgIHRyeSB7SW1wb3J0LU1vZHVsZSAkRmlsZSAtZWEgc3RvcDtyZXR1cm4gMX0gY2F0Y2gge30NCiAgICAgICAgJExpYj1BUC1Db252ZXJ0UGF0aCAiPExJQj4iOyRMRiA9ICIkTGliXCRGaWxlIg0KICAgICAgICBbc3RyaW5nXSRmID0gaWYodGVzdC1wYXRoIC10IGxlYWYgJExGKXskTEZ9ZWxzZWlmKHRlc3QtcGF0aCAtdCBsZWFmICIkTEYuZGxsIil7IiRMRi5kbGwifQ0KICAgICAgICBpZiAoJGYgLWFuZCAkSW1wb3J0KSB7SW1wb3J0LU1vZHVsZSAkZn0NCiAgICAgICAgcmV0dXJuICRmDQogICAgfQ0KICAgICRTdGF0ID0gJChzd2l0Y2ggLXJlZ2V4ICgkTGliLnRyaW0oKSkgew0KICAgICAgICAiXkludGVybmV0IiAgICAgICAgICAgICAgIHt0ZXN0LWNvbm5lY3Rpb24gZ29vZ2xlLmNvbSAtQ291bnQgMSAtUXVpZXR9DQogICAgICAgICJeZGVwOiguKikiICAgICAgICAgICAgICAge2lmICgkTWF0Y2hlc1sxXSAtbmUgIndoZXJlIil7QVAtUmVxdWlyZSAiZGVwOndoZXJlIiB7JE1PREU9Mn19ZWxzZXskTU9ERT0yfTtpZiAoJE1PREUtMil7R2V0LVdoZXJlICRNYXRjaGVzWzFdfWVsc2V7dHJ5eyYgJE1hdGNoZXNbMV0gIi9mamZkamZkcyAtLWRzamFoZGhzIC1kc2phZGoiIDI+JG51bGw7InN1Y2MifWNhdGNoe319fQ0KICAgICAgICAiXihsaWJ8bW9kdWxlKTooLiopIiAgICAgIHskTG9hZE1vZHVsZS5pbnZva2UoJE1hdGNoZXNbMl0sICR0cnVlKX0NCiAgICAgICAgIl4obGlifG1vZHVsZSlfdGVzdDooLiopIiB7JExvYWRNb2R1bGUuaW52b2tlKCRNYXRjaGVzWzJdKX0NCiAgICAgICAgIl5mdW5jdGlvbjooLiopIiAgICAgICAgICB7Z2NtICRNYXRjaGVzWzFdIC1lYSBTaWxlbnRseUNvbnRpbnVlfQ0KICAgICAgICAiXnN0cmljdF9mdW5jdGlvbjooLiopIiAgIHtUZXN0LVBhdGggIkZ1bmN0aW9uOlwkKCRNYXRjaGVzWzFdKSJ9DQogICAgICAgIGRlZmF1bHQge1dyaXRlLUFQICIhSW52YWxpZCBzZWxlY3RvciBwcm92aWRlZCBbJCgiJExpYiIuc3BsaXQoJzonKVswXSldIjt0aHJvdyAnQkFEX1NFTEVDVE9SJ30NCiAgICB9KQ0KICAgIGlmICghJFN0YXQpIHskT25GYWlsLkludm9rZSgpfQ0KICAgIGlmICgkUGFzc1RocnUpIHtyZXR1cm4gJFN0YXR9DQp9CgpmdW5jdGlvbiBXcml0ZS1BUCB7DQogICAgW0NtZGxldEJpbmRpbmcoKV0NCiAgICBwYXJhbShbUGFyYW1ldGVyKFZhbHVlRnJvbVBpcGVsaW5lPSR0cnVlLCBNYW5kYXRvcnk9JFRydWUpXSRUZXh0LFtTd2l0Y2hdJE5vU2lnbixbU3dpdGNoXSRQbGFpblRleHQsW1ZhbGlkYXRlU2V0KCJDZW50ZXIiLCJSaWdodCIsIkxlZnQiKV1bU3RyaW5nXSRBbGlnbj0nTGVmdCcsW1N3aXRjaF0kUGFzc1RocnUpDQogICAgYmVnaW4geyRUVCA9IEAoKX0NCiAgICBQcm9jZXNzIHskVFQgKz0gLCRUZXh0fQ0KICAgIEVORCB7DQogICAgICAgICRCbHVlID0gJChpZiAoJFdSSVRFX0FQX0xFR0FDWV9DT0xPUlMpezN9ZWxzZXsnQmx1ZSd9KQ0KICAgICAgICBpZiAoJFRULmNvdW50IC1lcSAxKSB7JFRUID0gJFRUWzBdfTskVGV4dCA9ICRUVA0KICAgICAgICBpZiAoJHRleHQuY291bnQgLWd0IDEgLW9yICR0ZXh0LkdldFR5cGUoKS5OYW1lIC1tYXRjaCAiXFtcXSQiKSB7cmV0dXJuICRUZXh0IHw/eyIkXyJ9fCAlIHtXcml0ZS1BUCAkXyAtTm9TaWduOiROb1NpZ24gLVBsYWluVGV4dDokUGxhaW5UZXh0IC1BbGlnbiAkQWxpZ259fQ0KICAgICAgICBpZiAoISR0ZXh0IC1vciAkdGV4dCAtbm90bWF0Y2ggIl4oKD88Tk5MPngpfCg/PE5TPm5zPykpezAsMn0oPzx0Plw+KikoPzxzPlsrXC0hXCpcI1xAX10pKD88dz4uKikiKSB7cmV0dXJuICRUZXh0fQ0KICAgICAgICAkdGIgID0gIiAgICAiKiRNYXRjaGVzLnQubGVuZ3RoOw0KICAgICAgICAkQ29sID0gQHsnKyc9JzInOyctJz0nMTInOychJz0nMTQnOycqJz0kQmx1ZTsnIyc9J0RhcmtHcmF5JzsnQCc9J0dyYXknOydfJz0nd2hpdGUnfVsoJFNpZ24gPSAkTWF0Y2hlcy5TKV0NCiAgICAgICAgaWYgKCEkQ29sKSB7VGhyb3cgIkluY29ycmVjdCBTaWduIFskU2lnbl0gUGFzc2VkISJ9DQogICAgICAgICRTaWduID0gJChpZiAoJE5vU2lnbiAtb3IgJE1hdGNoZXMuTlMpIHsiIn0gZWxzZSB7IlskU2lnbl0gIn0pDQogICAgICAgIEFQLVJlcXVpcmUgImZ1bmN0aW9uOkFsaWduLVRleHQiIHtmdW5jdGlvbiBHbG9iYWw6QWxpZ24tVGV4dCgkYWxpZ24sJHRleHQpIHskdGV4dH19DQogICAgICAgICREYXRhID0gIiR0YiRTaWduJCgkTWF0Y2hlcy5XKSI7aWYgKCEkRGF0YSkge3JldHVybn0NCiAgICAgICAgJERhdGEgPSBBbGlnbi1UZXh0IC1BbGlnbiAkQWxpZ24gIiR0YiRTaWduJCgkTWF0Y2hlcy5XKSINCiAgICAgICAgaWYgKCRQbGFpblRleHQpIHtyZXR1cm4gJERhdGF9DQogICAgICAgIFdyaXRlLUhvc3QgLU5vTmV3TGluZTokKFtib29sXSRNYXRjaGVzLk5OTCkgLWYgJENvbCAkRGF0YQ0KICAgICAgICBpZiAoJFBhc3NUaHJ1KSB7JERhdGF9DQogICAgfQ0KfQoKZnVuY3Rpb24gSlMtT1Ige2ZvcmVhY2ggKCRhIGluICRhcmdzKSB7aWYgKCEkYSkge2NvbnRpbnVlfTtpZiAoJGEuR2V0VHlwZSgpLk5hbWUgLWVxICJTY3JpcHRCbG9jayIpIHskYSA9ICRhLmludm9rZSgpO2lmICghJGEpe2NvbnRpbnVlfX07cmV0dXJuICRhfX0KCmZ1bmN0aW9uIEtleVRyYW5zbGF0ZSB7cGFyYW0oW1BhcmFtZXRlcihNYW5kYXRvcnk9JFRydWUpXVtTdHJpbmddJEtleSkNCg0KICAgICRIYXNoS2V5ID0gQHsNCiAgICAgICAgIn5+U3BhY2V+fiI9MzINCiAgICAgICAgIn5+RVNDQVBFfn4iPTI3DQogICAgICAgICJ+fkVudGVyfn4iPTEzDQogICAgICAgICJ+flNoaWZ0fn4iPTE2DQogICAgICAgICJ+fkNvbnRyb2x+fiI9MTcNCiAgICAgICAgIn5+QWx0fn4iPTE4DQogICAgICAgICJ+fkJhY2tTcGFjZX5+Ij04DQogICAgICAgICJ+fkRlbGV0ZX5+Ij00Ng0KICAgICAgICAifn5mMX5+Ij0xMTINCiAgICAgICAgIn5+ZjJ+fiI9MTEzDQogICAgICAgICJ+fmYzfn4iPTExNA0KICAgICAgICAifn5mNH5+Ij0xMTUNCiAgICAgICAgIn5+ZjV+fiI9MTE2DQogICAgICAgICJ+fmY2fn4iPTExNw0KICAgICAgICAifn5mN35+Ij0xMTgNCiAgICAgICAgIn5+Zjh+fiI9MTE5DQogICAgICAgICJ+fmY5fn4iPTEyMA0KICAgICAgICAifn5mMTB+fiI9MTIxDQogICAgICAgICJ+fmYxMX5+Ij0xMjINCiAgICAgICAgIn5+ZjEyfn4iPTEyMw0KICAgICAgICAifn5NdXRlfn4iPTE3Mw0KICAgICAgICAifn5JbnNlcnR+fiI9NDUNCiAgICAgICAgIn5+UGFnZVVwfn4iPTMzDQogICAgICAgICJ+flBhZ2VEb3dufn4iPTM0DQogICAgICAgICJ+fkVORH5+Ij0zNQ0KICAgICAgICAifn5IT01Ffn4iPTM2DQogICAgICAgICJ+fnRhYn5+Ij05DQogICAgICAgICJ+fkNhcHNMb2Nrfn4iPTIwDQogICAgICAgICJ+fk51bUxvY2t+fiI9MTQ0DQogICAgICAgICJ+fldpbmRvd3N+fiI9OTENCiAgICAgICAgIn5+TGVmdH5+Ij0zNw0KICAgICAgICAifn5VcH5+Ij0zOA0KICAgICAgICAifn5SaWdodH5+Ij0zOQ0KICAgICAgICAifn5Eb3dufn4iPTQwDQogICAgICAgICJ+fktQMH5+Ij05Ng0KICAgICAgICAifn5LUDF+fiI9OTcNCiAgICAgICAgIn5+S1Ayfn4iPTk4DQogICAgICAgICJ+fktQM35+Ij05OQ0KICAgICAgICAifn5LUDR+fiI9MTAwDQogICAgICAgICJ+fktQNX5+Ij0xMDENCiAgICAgICAgIn5+S1A2fn4iPTEwMg0KICAgICAgICAifn5LUDd+fiI9MTAzDQogICAgICAgICJ+fktQOH5+Ij0xMDQNCiAgICAgICAgIn5+S1A5fn4iPTEwNQ0KICAgIH0NCiAgICBpZiAoW2ludF0kQ29udmVydCA9ICRIYXNoS2V5LiRLZXkpIHtyZXR1cm4gJENvbnZlcnR9DQogICAgVGhyb3cgIkludmFsaWQgU3BlY2lhbCBLZXkgQ29udmVyc2lvbiINCn0KCmZ1bmN0aW9uIEdldC1XaGVyZSB7cGFyYW0oW1BhcmFtZXRlcihNYW5kYXRvcnk9JHRydWUpXVtzdHJpbmddJEZpbGUsIFtTd2l0Y2hdJEFsbCkNCg0KICAgIEFQLVJlcXVpcmUgImRlcDp3aGVyZSIge3Rocm93ICJOZWVkIFN5czMyXHdoZXJlIHRvIHdvcmshIjtyZXR1cm59DQogICAgJE91dD0kbnVsbA0KICAgIGlmICgkUFNWZXJzaW9uVGFibGUuUGxhdGZvcm0gLWVxICJVbml4Iikgew0KICAgICAgICAkT3V0ID0gd2hpY2ggJGZpbGUgMj4kbnVsbA0KICAgIH0gZWxzZSB7JE91dCA9IHdoZXJlLmV4ZSAkZmlsZSAyPiRudWxsfQ0KICAgIA0KICAgIGlmICghJE91dCkge3JldHVybn0NCiAgICBpZiAoJEFsbCkge3JldHVybiAkT3V0fQ0KICAgIHJldHVybiBAKCRPdXQpWzBdDQp9CgpmdW5jdGlvbiBNYWtlLVJlYWRPbmx5IHtwYXJhbSgkbykNCg0KICAgIGlmICghJG8uR2V0RW51bWVyYXRvciAtYW5kICRvLkdldFR5cGUoKS5OYW1lIC1lcSAiSGFzaHRhYmxlIikge1dyaXRlLUFQICIhSW52YWxpZCBvYmplY3QgcGFzc2VkLCBtdXN0IGJlIGEgaGFzaHRhYmxlIjtyZXR1cm59DQogICAgJG5ldyA9IFtQc0N1c3RvbU9iamVjdF1Ae30NCiAgICAkby5HZXRFbnVtZXJhdG9yKCkgfCAlIHskdiA9ICRfLnZhbHVlOyRuZXcgfCBBZGQtTWVtYmVyICRfLmtleSAtRm9yY2UgLU1lbWJlclR5cGUgU2NyaXB0UHJvcGVydHkgeyR2fS5HZXROZXdDbG9zdXJlKCl9DQogICAgcmV0dXJuICRuZXcNCn0KCmZ1bmN0aW9uIFBhdXNlIHtwYXJhbShbU3RyaW5nXSRQYXVzZVEgPSAiUHJlc3MgYW55IGtleSB0byBjb250aW51ZSAuIC4gLiAiKQ0KDQogICAgV3JpdGUtSG9zdCAtbm9OZXdsaW5lICRQYXVzZVENCiAgICAkbnVsbCA9ICRIb3N0LlVJLlJhd1VJLlJlYWRLZXkoIk5vRWNobywgSW5jbHVkZUtleURvd24iKQ0KICAgIFdyaXRlLUhvc3QgIiINCn0KCmZ1bmN0aW9uIEFsaWduLVRleHQge3BhcmFtKFtQYXJhbWV0ZXIoTWFuZGF0b3J5PSRUcnVlKV1bU3RyaW5nW11dJFRleHQsIFtWYWxpZGF0ZVNldCgiQ2VudGVyIiwiUmlnaHQiLCJMZWZ0IildW1N0cmluZ10kQWxpZ249J0NlbnRlcicpDQoNCiAgICBpZiAoJFRleHQuY291bnQgLWd0IDEpIHsNCiAgICAgICAgJGFucyA9IEAoKQ0KICAgICAgICBmb3JlYWNoICgkbG4gaW4gJFRleHQpIHskQW5zICs9IEFsaWduLVRleHQgJGxuICRBbGlnbn0NCiAgICAgICAgcmV0dXJuICgkYW5zKQ0KICAgIH0gZWxzZSB7DQogICAgICAgICRXaW5TaXplID0gW2NvbnNvbGVdOjpCdWZmZXJXaWR0aA0KICAgICAgICBpZiAoKCIiKyRUZXh0KS5MZW5ndGggLWdlICRXaW5TaXplKSB7DQogICAgICAgICAgICAkQXBwZW5kZXIgPSBAKCIiKTsNCiAgICAgICAgICAgICRqID0gMA0KICAgICAgICAgICAgZm9yZWFjaCAoJHAgaW4gMC4uKCgiIiskVGV4dCkuTGVuZ3RoLTEpKXsNCiAgICAgICAgICAgICAgICBpZiAoKCRwKzEpJSR3aW5zaXplIC1lcSAwKSB7JGorKzskQXBwZW5kZXIgKz0gIiJ9DQojICAgICAgICAgICAgICAgICIiKyRqKyIgLSAiKyRwDQogICAgICAgICAgICAgICAgJEFwcGVuZGVyWyRqXSArPSAkVGV4dC5jaGFycygkcCkNCiAgICAgICAgICAgIH0NCiAgICAgICAgICAgIHJldHVybiAoQWxpZ24tVGV4dCAkQXBwZW5kZXIgJEFsaWduKQ0KICAgICAgICB9IGVsc2Ugew0KICAgICAgICAgICAgaWYgKCRBbGlnbiAtZXEgIkNlbnRlciIpIHsNCiAgICAgICAgICAgICAgICByZXR1cm4gKCIgIipbbWF0aF06OnRydW5jYXRlKCgkV2luU2l6ZS0oIiIrJFRleHQpLkxlbmd0aCkvMikrJFRleHQpDQogICAgICAgICAgICB9IGVsc2VpZiAoJEFsaWduIC1lcSAiUmlnaHQiKSB7DQogICAgICAgICAgICAgICAgcmV0dXJuICgiICIqKCRXaW5TaXplLSgiIiskVGV4dCkuTGVuZ3RoLTEpKyRUZXh0KQ0KICAgICAgICAgICAgfSBlbHNlIHsNCiAgICAgICAgICAgICAgICByZXR1cm4gKCRUZXh0KQ0KICAgICAgICAgICAgfQ0KICAgICAgICB9DQogICAgfQ0KfQoKZnVuY3Rpb24gS2V5UHJlc3NlZCB7cGFyYW0oW1BhcmFtZXRlcihNYW5kYXRvcnk9JFRydWUpXVtTdHJpbmdbXV0kS2V5LCAkU3RvcmU9Il5eXiIpDQoNCiAgICBpZiAoJFN0b3JlIC1lcSAiXl5eIiAtYW5kICRIb3N0LlVJLlJhd1VJLktleUF2YWlsYWJsZSkgeyRTdG9yZSA9ICRIb3N0LlVJLlJhd1VJLlJlYWRLZXkoIkluY2x1ZGVLZXlVcCxOb0VjaG8iKX0gZWxzZSB7aWYgKCRTdG9yZSAtZXEgIl5eXiIpIHtyZXR1cm4gJEZhbHNlfX0NCiAgICAkQW5zID0gJEZhbHNlDQogICAgJEtleSB8ICUgew0KICAgICAgICAkU09VUkNFID0gJF8NCiAgICAgICAgdHJ5IHsNCiAgICAgICAgICAgICRBbnMgPSAkQW5zIC1vciAoS2V5UHJlc3NlZENvZGUgJFNPVVJDRSAkU3RvcmUpDQogICAgICAgIH0gY2F0Y2ggew0KICAgICAgICAgICAgRm9yZWFjaCAoJEsgaW4gJFNPVVJDRSkgew0KICAgICAgICAgICAgICAgIFtTdHJpbmddJEsgPSAkSw0KICAgICAgICAgICAgICAgIGlmICgkSy5sZW5ndGggLWd0IDQgLWFuZCAoJEtbMCwxLC0xLC0yXSAtam9pbigiIikpIC1lcSAifn5+fiIpIHsNCiAgICAgICAgICAgICAgICAgICAgJEFucyA9ICRBTlMgLW9yIChLZXlQcmVzc2VkQ29kZSAoS2V5VHJhbnNsYXRlKCRLKSkgJFN0b3JlKQ0KICAgICAgICAgICAgICAgIH0gZWxzZSB7DQogICAgICAgICAgICAgICAgICAgICRBbnMgPSAkQU5TIC1vciAoJEsuY2hhcnMoMCkgLWluICRTdG9yZS5DaGFyYWN0ZXIpDQogICAgICAgICAgICAgICAgfQ0KICAgICAgICAgICAgfQ0KICAgICAgICB9DQogICAgfQ0KICAgIHJldHVybiAkQW5zDQp9CgpTZXQtQWxpYXMgaW52IFByb2Nlc3MtVHJhbnNwYXJlbmN5ClNldC1BbGlhcyA/OiBJbnZva2UtVGVybmFyeQ==")))
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