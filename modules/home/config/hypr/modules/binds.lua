local vars = require("modules.variables")
local kvars = require("modules.keybinds_variables")


-- Modifiers
local MM = kvars.MM
local QM = kvars.QM
local TM = kvars.TM

-- Keys and Programs
local BrowserKey = kvars.BrowserKey
local Browser = vars.Browser
local TermKey = kvars.TermKey
local Term = vars.Term
local EditorKey = kvars.EditorKey
local Editor = vars.Editor
local SysInfo = vars.SysInfo
local WallSwitch = kvars.WallSwitch
local CloseKey = kvars.CloseKey
local FloatKey = kvars.FloatKey
local FullscreenKey = kvars.FullscreenKey
local CenterWindowKey = kvars.CenterWindowKey
local PinKey = kvars.PinKey
local PipKey = kvars.PipKey
local GroupToggleKey = kvars.GroupToggleKey
local GroupTabKey = kvars.GroupTabKey
local MusicWorkspaceKey = kvars.MusicWorkspaceKey
local ScratchboardKey = kvars.ScratchboardKey
local SysInfoWorkspaceKey = kvars.SysInfoWorkspaceKey
local ColorPickerKey = kvars.ColorPickerKey
local ScreenshotKey = kvars.ScreenshotKey
local ShellRestartKey = kvars.ShellRestartKey
local SuspendKey = kvars.SuspendKey
local ZoomResetKey = kvars.ZoomResetKey
local MediaPlayPauseKey = kvars.MediaPlayPauseKey
local MediaNextKey = kvars.MediaNextKey
local MediaPrevKey = kvars.MediaPrevKey
local VolumeMuteKey = kvars.VolumeMuteKey

----------------------------------
--- Used for directional inputs ---
----------------------------------

local left = kvars.left 
local right = kvars.right
local up = kvars.up
local down = kvars.down

-- Helper variables to track state
local current_zoom = 1.0
local step = 0.25
local max_zoom = 3.0
local min_zoom = 1.0

--------------------------------------------------------------------------------
-- ## Script Logic (Embedded in Lua for Manual Adjustments Later)
--------------------------------------------------------------------------------
local function workspace_action(action_type, target_ws, is_group)
    -- This handles the old wsaction.fish logic locally in pure Lua
    local prefix = is_group and "group:" or ""
    if action_type == "workspace" then
        hl.dispatch(hl.dsp.focus({ workspace = prefix .. target_ws }))
    elseif action_type == "movetoworkspace" then
        hl.dispatch(hl.dsp.window.move({ workspace = prefix .. target_ws }))
    end
end

--------------------------------------------------------------------------------
-- ## Hexecute Setting gestures
--------------------------------------------------------------------------------

-- 1. Triggers when long pressing the combination
-- hl.bind(QM .. " + Alt_L", hl.dsp.exec_cmd("hexecute"), { long_press = true })

--------------------------------------------------------------------------------
-- ## Shell keybinds
--------------------------------------------------------------------------------

hl.bind("SUPER + T", hl.dsp.exec_cmd("quickshell ipc -p ~/.config/quickshell/k4/shell.qml call k4 toggleLauncher"))
hl.bind("SUPER + comma", hl.dsp.exec_cmd("quickshell ipc -p ~/.config/quickshell/k4/shell.qml call k4.panel toggle"))
hl.bind("SUPER + SHIFT + S", hl.dsp.exec_cmd("quickshell ipc -p ~/.config/quickshell/k4/shell.qml call k4.captura region"))
hl.bind("SUPER + O", hl.dsp.exec_cmd("quickshell ipc -p ~/.config/quickshell/k4/shell.qml call k4 windows"))
hl.bind("SUPER + P", hl.dsp.exec_cmd("quickshell ipc -p ~/.config/quickshell/k4/shell.qml call k4 session"))
hl.bind("SUPER + V", hl.dsp.exec_cmd("quickshell ipc -p ~/.config/quickshell/k4/shell.qml call k4 clipboard"))
-- Directional Window Moving (Vim Keys)
for i = 1, 4 do
    local vimkey = { "h", "j", "k", "l" }
    local movedir = { "l", "d", "u", "r" }

    hl.bind(
        "SUPER" .. " + " .. "SHIFT" .. " + " .. vimkey[i],
        hl.dsp.window.move({ direction = movedir[i] })
    )
end

-- Directional Focus Navigation (Vim Keys)
for i = 1, 4 do
    local vimkey = { "h", "j", "k", "l" }
    local focusdir = { "l", "d", "u", "r" }

    hl.bind(
        "SUPER" .. " + " .. vimkey[i],
        hl.dsp.focus({ direction = focusdir[i] })
    )
end

hl.bind("SUPER + SHIFT + TAB", function()
    local layouts = {
        "scrolling",
        "dwindle",
        "master",
        "monocle",
    }

    local workspace = hl.get_active_special_workspace()
        or hl.get_active_workspace()

    if not workspace then
        return
    end

    local current = workspace.tiled_layout
    local next_layout = layouts[1]

    for i, layout in ipairs(layouts) do
        if layout == current then
            next_layout = layouts[(i % #layouts) + 1]
            break
        end
    end

    if workspace.special then
        hl.workspace_rule({
            workspace = tostring(workspace.name),
            layout = next_layout,
        })
    else
        hl.workspace_rule({
            workspace = tostring(workspace.id),
            layout = next_layout,
        })
    end
end)




--------------------------------------------------------------------------------
-- ## Workspaces Loops (Programmatic & Scriptless)
--------------------------------------------------------------------------------

for i = 0, 9 do
    local key = tostring(i)
    local ws = (i == 0) and 10 or i
    
    -- Go to workspace #
    hl.bind(MM .. " + " .. key, function() workspace_action("workspace", ws, false) end)
    
    -- Go to workspace group #
    hl.bind(QM .. " + " .. MM .. " + " .. key, function() workspace_action("workspace", ws, true) end)
    
    -- Move window to workspace #
    hl.bind(MM .. " + " .. QM .. " + " .. key, function() workspace_action("movetoworkspace", ws, false) end)
    
    -- Move window to workspace group #
    hl.bind(QM .. " + " .. MM .. " + " .. QM .. " + " .. key, function() workspace_action("movetoworkspace", ws, true) end)
end

-- Go to workspace -1/+1 directional navigation (Swapped to monitor-relative 'm' to stop boundary errors)
hl.bind(MM .. " + mouse_down", hl.dsp.focus({ workspace = "m-1" }))
hl.bind(MM .. " + mouse_up", hl.dsp.focus({ workspace = "m+1" }))
hl.bind(MM .. " + Page_Up", hl.dsp.focus({ workspace = "m-1" }))
hl.bind(MM .. " + Page_Down", hl.dsp.focus({ workspace = "m+1" }))

hl.bind(MM .. " + Prior", hl.dsp.focus({ workspace = "m-1" }))
hl.bind(MM .. " + Next", hl.dsp.focus({ workspace = "m+1" }))

-- Go to workspace group -1/+1
hl.bind(QM .. " + " .. MM .. " + mouse_down", hl.dsp.focus({ workspace = "r-10" }))
hl.bind(QM .. " + " .. MM .. " + mouse_up", hl.dsp.focus({ workspace = "r+10" }))

--------------------------------------------------------------------------------
-- ## Move Window Utilities
--------------------------------------------------------------------------------

hl.bind(MM .. " + " .. QM .. " + Page_Up", hl.dsp.window.move({ workspace = "m-1" }))
hl.bind(MM .. " + " .. QM .. " + Page_Down", hl.dsp.window.move({ workspace = "m+1" }))
hl.bind(MM .. " + " .. QM .. " + mouse_down", hl.dsp.window.move({ workspace = "m-1" }))
hl.bind(MM .. " + " .. QM .. " + mouse_up", hl.dsp.window.move({ workspace = "m+1" }))
hl.bind(QM .. " + " .. MM .. " + " .. TM .. " + right", hl.dsp.window.move({ workspace = "m+1" }))
hl.bind(QM .. " + " .. MM .. " + " .. TM .. " + left", hl.dsp.window.move({ workspace = "m-1" }))

-- Move window to/from special workspace
hl.bind(QM .. " + " .. MM .. " + " .. TM .. " + up", hl.dsp.window.move({ workspace = "special:scratchboard" }))
hl.bind(QM .. " + " .. MM .. " + " .. TM .. " + down", hl.dsp.window.move({ workspace = "+0" }))

-- Move the active window out of its current group
hl.bind(MM .. " + " .. TM .. " + " .. GroupToggleKey, hl.dsp.window.move({ out_of_group = true, window = "active" }))

--------------------------------------------------------------------------------
-- ## Window Groups
--------------------------------------------------------------------------------

for i = 0, 5 do
    local key = tostring(i)
    -- Maps 0 to tab 5, otherwise matches the index number
    local ws = (i == 0) and 5 or i
    
    -- Switch to a specific window inside the group by its index (1-based)
    hl.bind(QM .. " + " .. key, hl.dsp.group.active({ index = ws }), { desc = "Jump to group tab " .. ws })
end

-- Replaced hyprctl string with native dispatch

hl.bind(MM .. " + " .. GroupToggleKey, hl.dsp.group.toggle())

-- Move the active window out of its current group
hl.bind(MM .. " + " .. TM .. " + " .. GroupToggleKey, hl.dsp.window.move({ out_of_group = true, window = "active" }))

--------------------------------------------------------------------------------
-- ## Window Actions (Focus, Resize, Management)
--------------------------------------------------------------------------------

-- Mouse drag & window sizing gestures
hl.bind(MM .. " + mouse:272", hl.dsp.window.drag(), { mouse = true })
hl.bind(MM .. " + mouse:273", hl.dsp.window.resize(), { mouse = true })

-- Alignment and Toggles
hl.bind(QM .." + " .. MM .. " + " .. CenterWindowKey, hl.dsp.window.center())

-- Replaced hyprctl strings with native dispatch logic
hl.bind(QM .. " + " .. MM .. " + " .. QM .. " + " .. CenterWindowKey, function()
    hl.dispatch("resizeactive", "exact 55% 70%")
    hl.dispatch("centerwindow", "1")
end)

hl.bind(MM .. " + " .. PinKey, hl.dsp.window.pin())
hl.bind(MM .. " + " .. TM .. " + " .. FullscreenKey, hl.dsp.window.fullscreen({mode = "fullscreen"}))
hl.bind(MM .. " + " .. FullscreenKey, hl.dsp.window.fullscreen({mode = "maximized"}))
hl.bind(MM .. " + " .. CloseKey, hl.dsp.window.close("active"))

--------------------------------------------------------------------------------
-- ## Special System Workspace Targets
--------------------------------------------------------------------------------


-- Toggle SysInfo workspace and launch the dynamic app via app2unit
-- Removed hyprctl client check. Singleton logic should be handled by app2unit script.
hl.bind(QM .. " + " .. TM .. " + " .. SysInfoWorkspaceKey, function()
    hl.dispatch(hl.dsp.workspace.toggle_special("sysinfo"))
    hl.dispatch(hl.dsp.exec_cmd("app2unit -- " .. Term .. " -e " .. SysInfo))
end)

--------------------------------------------------------------------------------
-- ## Core Applications (Mapped dynamically to variables.lua options)
--------------------------------------------------------------------------------

hl.bind(MM .. " + " .. TermKey, hl.dsp.exec_cmd("app2unit -- " .. Term))
hl.bind(MM .. " + " .. BrowserKey, hl.dsp.exec_cmd("app2unit -- " .. Browser))

--------------------------------------------------------------------------------
-- ## Utilities
--------------------------------------------------------------------------------

hl.bind("Print", hl.dsp.exec_cmd("grim - | satty --filename -"))
-- hl.bind(MM .. " + " .. TM .. " + " .. ScreenshotKey, hl.dsp.exec_cmd("bash -c 'geom=$(slurp) && sleep 0.1 && grim -g \"$geom\" - | satty --filename -'"))
hl.bind(MM .. " + " .. TM .. " + " .. QM .. " + " .. ScreenshotKey, hl.dsp.exec_cmd("bash -c 'geom=$(slurp) && sleep 0.1 && grim -g \"$geom\" - | satty --filename -'"))
--[[ hl.bind(MM .. " + " .. QM .. " + R", hl.dsp.exec_cmd("caelestia record -s"))
hl.bind(QM .. " + " .. TM .. " + R", hl.dsp.exec_cmd("caelestia record"))
hl.bind(MM .. " + " .. TM .. " + " .. QM .. " + R", hl.dsp.exec_cmd("caelestia record -r")) ]]
hl.bind(MM .. " + " .. TM .. " + " .. ColorPickerKey, hl.dsp.exec_cmd("hyprpicker -a"))

-- OmniAction Context Menu (Triggers on currently copied file)
hl.bind(MM .. " + O", hl.dsp.exec_cmd("'/run/media/boing/Games/pc backup/SideProjects/OmniMenu/omniaction_clip.sh'"))
--------------------------------------------------------------------------------
-- ## System Volume Inputs
--------------------------------------------------------------------------------

hl.bind("XF86AudioMicMute", hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle"))
hl.bind("XF86AudioMute", hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"))
hl.bind(MM .. " + " .. TM .. " + " .. VolumeMuteKey, hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"))
hl.bind("XF86AudioRaiseVolume", hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SINK@ 0; wpctl set-volume -l 1 @DEFAULT_AUDIO_SINK@ 5%+"))
hl.bind("XF86AudioLowerVolume", hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SINK@ 0; wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-"))

--------------------------------------------------------------------------------
-- ## Display Brightness Inputs (DDC/CI)
--------------------------------------------------------------------------------

hl.bind(QM .. " + " .. "XF86AudioRaiseVolume", hl.dsp.exec_cmd("ddcutil setvcp 10 + 5"))
hl.bind(QM .. " + " .. "XF86AudioLowerVolume", hl.dsp.exec_cmd("ddcutil setvcp 10 - 5"))
hl.bind(QM .. " + mouse_up", hl.dsp.exec_cmd("ddcutil setvcp 10 + 5"))
hl.bind(QM .. " + mouse_down", hl.dsp.exec_cmd("ddcutil setvcp 10 - 5"))

--------------------------------------------------------------------------------
-- ## Power Management
--------------------------------------------------------------------------------


--------------------------------------------------------------------------------
--- ## Misc 
-------------------------------------------------------------------------------

-- Function to update the zoom globally
local function set_zoom(value)
    current_zoom = math.max(min_zoom, math.min(max_zoom, value))
    hl.config({
        cursor = {
            zoom_factor = current_zoom
        }
    })
end

--------------------------------------------------------------------------------
-- ## Zoom Key Bindings
--------------------------------------------------------------------------------

-- FIXED: Combined modifiers and key into a single string format
hl.bind(MM .. " + " .. TM .. " + " .. ZoomResetKey, function()
    set_zoom(1.0)
end)

-- FIXED: Combined modifier and mouse actions into single strings
hl.bind(MM .. " + " .. TM .. " + mouse_down", function()
    set_zoom(current_zoom + step)
end)

hl.bind(MM .. " + " .. TM .. " + mouse_up", function()
    set_zoom(current_zoom - step)
end)
