#Requires AutoHotkey v2.0
#SingleInstance Force

A_MaxHotkeysPerInterval := 200
A_HotkeyInterval := 2000

; ========================================
; CapsLock to Esc (for Vim) | double-tap for CapsLock | CapsLock as 5th modifier key

CapsLock:: {
    winTitle := WinGetTitle("A")
    if InStr(winTitle, "nvim")
    or InStr(winTitle, "neovim")
    or InStr(winTitle, "Obsidian")
    or InStr(winTitle, "Visual Studio Code")
    or InStr(winTitle, "Cursor")
    or WinActive("ahk_exe Zed.exe") {
        Send("{Esc}")
        return
    }
    KeyWait("CapsLock")
    if (A_TimeSinceThisHotkey < 200)
    and KeyWait("CapsLock", "D T0.2")
    and (A_PriorKey = "CapsLock")
        SetCapsLockState !GetKeyState("CapsLock", "T")
}
*CapsLock:: Send "{Blind}{vk07}"

; ========================================
; MacOS like line select stuff

#HotIf GetKeyState("CapsLock", "P")

alt::  return
rwin:: return

; arrow keys
h:: Send("{Left}")
j:: Send("{Down}")
k:: Send("{Up}")
l:: Send("{Right}")

; Ctrl + Arrows
^h:: Send("^{Left}")
^j:: Send("^{Down}")
^k:: Send("^{Up}")
^l:: Send("^{Right}")

; Shift + Arrows
+h:: Send("+{Left}")
+j:: Send("+{Down}")
+k:: Send("+{Up}")
+l:: Send("+{Right}")

; Alt — Home/End/PgUp/PgDn
!h:: Send("{Home}")
!j:: Send("{PgDn}")
!k:: Send("{PgUp}")
!l:: Send("{End}")

; Ctrl + Shift + Arrows
^+h:: Send("^+{Left}")
^+j:: Send("^+{Down}")
^+k:: Send("^+{Up}")
^+l:: Send("^+{Right}")

; Alt + Shift — selection to line start/end
!+h:: Send("+{Home}")
!+j:: Send("!+{Down}")
!+k:: Send("!+{Up}")
!+l:: Send("+{End}")

; Play / Pause
a:: Send("{Media_Play_Pause}")

; Toggle CapsLock
Enter:: CapsLock

#HotIf

; ========================================
; CapsLock stuff ends here
; ========================================


; ========================================
; Line Delete

!Backspace:: {
    Send("+{Home}")
    Sleep(3)
    Send("{Del}")
}

!Del:: {
    Send("+{End}")
    Sleep(3)
    Send("{Del}")
}

; ========================================
; Open File Pilot (Not being used rn)

!e:: Run '"C:\Users\Garzon\Documents\AutoHotkey\Open_Stuff\File Pilot.lnk"'

; ========================================
; Volume / Virtual Desktop stuff with Pause Key | mouse's forward button remapped as Pause

*Pause:: Send "{Blind}{vk07}"

#HotIf GetKeyState("Pause", "P")

LButton:: Send("#^{Left}")
RButton:: Send("#^{Right}")

WheelUp:: Send("{Volume_Up 1}")
WheelDown:: Send("{Volume_Down 1}")

#HotIf

; ========================================
; Set Blender priority to Low (runs every 10 seconds)

SetBlenderPriorityLow() {
    try {
        for process in ComObjGet("winmgmts:").ExecQuery("SELECT * FROM Win32_Process WHERE Name = 'blender.exe'") {
            ProcessID := process.ProcessId
            hProcess := DllCall("OpenProcess", "UInt", 0x0600, "Int", false, "UInt", ProcessID, "Ptr")
            if (hProcess) {
                if (DllCall("GetPriorityClass", "Ptr", hProcess, "UInt") != 0x00000040)
                    DllCall("SetPriorityClass", "Ptr", hProcess, "UInt", 0x00000040)
                DllCall("CloseHandle", "Ptr", hProcess)
            }
        }
    }
}

SetTimer(SetBlenderPriorityLow, 10000)

; ========================================
; center window

!c:: {
    hwnd := WinGetID("A")
    WinGetPos(&x, &y, &w, &h, "ahk_id " hwnd)

    monitor := MonitorGetWorkArea(MonitorGetPrimary(), &left, &top, &right, &bottom)

    newX := left + ((right - left - w) // 2)
    newY := top + ((bottom - top - h) // 2)

    WinMove(newX, newY, w, h, "ahk_id " hwnd)
}

; ========================================
; Close / Minimize windows

#HotIf WinExist("A")
LWin & q::
{
    hwnd := WinExist("A")
    class := WinGetClass("ahk_id " hwnd)

    if (class != "Progman"
        && class != "WorkerW"
        && class != "Shell_TrayWnd")
        Send("!{F4}")
}
#HotIf

LWin & w:: WinMinimize("A")
