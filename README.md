# AutoHotkey v2 Productivity Script

A personal AutoHotkey v2 script for boosting productivity and adding handy shortcuts

## Features

- **CapsLock as a Modifier Key**: 
  - Acts as **Esc** when active in Neovim, VS Code, Obsidian, Cursor, or Zed
  - Double-tap **CapsLock** to toggle standard CapsLock state
- **VIM like line navigation**: Holding CapsLock makes hjkl act like Vim navigation keys (`h`/`j`/`k`/`l` for arrows, word jumps, and line selections)
- **MacOS like Line Editing**: 
  - `Alt + Backspace`: Delete to the start of the line
  - `Alt + Delete`: Delete to the end of the line
- **Window & Media Controls**:
  - `Win + Q`: Close active window (safely ignores desktop and taskbar)
  - `Win + W`: Minimize active window
  - `Alt + C`: Center current window on the screen
  - `CapsLock + A`: Play / Pause
  - `Pause`: key (re-mapped mouse forward button) held down with mouse buttons/wheel adjusts volume, and left and right click switch to left and right desktops respectively
- **Background Process Manager**: Automatically throttles `blender.exe` process priority to Low every 10 seconds

## Requirements

- AutoHotkey v2.0+
