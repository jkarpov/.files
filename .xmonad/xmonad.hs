import System.IO
import System.Exit
import Prelude
import XMonad
import Data.Ratio
import XMonad.Hooks.DynamicLog
import XMonad.Hooks.EwmhDesktops
import XMonad.Hooks.ManageDocks
import XMonad.Hooks.ManageHelpers
import XMonad.Hooks.SetWMName
import XMonad.Layout.Fullscreen
import XMonad.Layout.NoBorders
import XMonad.Layout.SimplestFloat
import XMonad.Layout.ThreeColumns
import XMonad.Layout.SimpleFloat
import XMonad.Layout.Spiral
import XMonad.Layout.PerWorkspace(onWorkspace)
import XMonad.Layout.Tabbed
import XMonad.Actions.FloatKeys
import XMonad.Actions.SpawnOn
import XMonad.Layout.Spacing
import XMonad.Util.SpawnOnce
import XMonad.Util.Run(spawnPipe)
import Control.Monad (liftM2)
import qualified XMonad.StackSet as W
import qualified Data.Map as M


------------------------------------------------------------------------
-- Terminal
myTerminal = "kitty"
myStatusBar = "xmobar -x0 ~/.xmonad/xmobar.conf"

------------------------------------------------------------------------
-- Workspaces
-- The default number of workspaces (virtual screens) and their names.
myWorkspaces = ["web", "dev", "sh", "media", "5", "6", "7"]

myLauncher = "$(yeganesh -x -- -nb '#000000' -nf '#FFFFFF' -sb '#7C7C7C' -sf '#CEFFAC')"

------------------------------------------------------------------------
-- Window rules
-- Execute arbitrary actions and WindowSet manipulations when managing
-- a new window. You can use this to, for example, always float a
-- particular program, or have a client always appear on a particular
-- workspace.
--
-- To find the property name associated with a program, use
-- > xprop | grep WM_CLASS
-- and click on the client you're interested in.
--
-- To match on the WM_NAME, you can use 'title' in the same way that
-- 'className' and 'resource' are used below.
--
myManageHook = composeAll
    [ className =? "Chromium"       --> viewShift "web"
    , className =? "Firefox"        --> viewShift "web"
    , className =? "Media"          --> viewShift "media"
    , className =? "sh"          --> viewShift "sh"
    , className =? "Dev"            --> viewShift "dev"
    , className =? "Download"       --> doFloat
    , className =? "Progress"       --> doFloat
    --, title =? "Steam_Login"        --> doFloat
    --, className =? "steam"          --> doFloat -- bigpicture-mode
    --, className =? "Steam"          --> doFloat -- bigpicture-mode
    --, isFullscreen --> (doF W.focusDown <+> doFullFloat)
    ]
    where viewShift = doF . liftM2 (.) W.greedyView W.shift
--, isFullscreen                  --> doFullFloat ]

------------------------------------------------------------------------
-- Layouts
-- You can specify and transform your layouts by modifying these values.
-- If you change layout bindings be sure to use 'mod-shift-space' after
-- restarting (with 'mod-q') to reset your layout state to the new
-- defaults, as xmonad preserves your old layout settings by default.
--
-- The available layouts. Note that each layout is separated by |||,
-- which denotes layout choice.

defaultLayouts = avoidStruts (
    smartSpacingWithEdge 20 $
    ThreeColMid 1 (3/100) (3/4) |||
    Mirror (Tall 1 (3/100) (1/2)) |||
    spiral (6/7)) |||
    noBorders (fullscreenFull Full)


------------------------------------------------------------------------
-- Colors and borders
--
myNormalBorderColor = "#002b36"
myFocusedBorderColor = "#657b83"

-- Width of the window border in pixels.
myBorderWidth = 0


------------------------------------------------------------------------
-- Key bindings
--
-- modMask lets you specify which modkey you want to use. The default
-- is mod1Mask ("left alt"). You may also consider using mod3Mask
-- ("right alt"), which does not conflict with emacs keybindings. The
-- "windows key" is usually mod4Mask.
--
myModMask = mod1Mask

myKeys conf@(XConfig {XMonad.modMask = modMask}) = M.fromList $
  ----------------------------------------------------------------------
  -- Custom key bindings
  --

  -- Start a terminal. Terminal to start is specified by myTerminal variable.
  [ ((modMask .|. shiftMask, xK_Return),
     spawn $ XMonad.terminal conf)

 -- Takes screenshot
  , ((controlMask, xK_Print), spawn "sleep 0.2; scrot -s -e 'mv $f ~dima/Pictures/Screenshots'")
  , ((0, xK_Print), spawn "scrot -e 'mv $f ~dima/Pictures/Screenshots'")

  -- Lock the screen using slock.
  , ((modMask .|. controlMask, xK_l),
     spawn "slock")

  -- Make window larger wile keeping bottom left corner fixed
  , ((modMask, xK_s),
      withFocused (keysResizeWindow (100,100) (1,1)))

  -- Make window smaller wile keeping bottom left corner fixed
  , ((modMask, xK_d),
      withFocused (keysResizeWindow (-100,-100) (1,1)))

  -- Make window smaller wile keeping bottom left corner fixed
  , ((modMask, xK_d),
      withFocused (keysResizeWindow (-100,-100) (1,1)))

  , ((modMask, xK_a),
      withFocused (keysMoveWindowTo (1920,24) (1%2,0)))


  -- Move window to the left
  , ((modMask .|. shiftMask, xK_h),
      withFocused (keysMoveWindow (-100, 0)))

  -- Move window to the right
  , ((modMask .|. shiftMask, xK_l),
      withFocused (keysMoveWindow (100, 0)))

  -- Move window down
  , ((modMask .|. shiftMask, xK_j),
      withFocused (keysMoveWindow (0, 100)))

  -- Move window up
  , ((modMask .|. shiftMask, xK_k),
      withFocused (keysMoveWindow (0, -100)))

  -- Spawn dmenu
  , ((modMask, xK_p),
     spawn myLauncher)

  -- Mute volume.
  , ((modMask .|. controlMask, xK_m),
     spawn "amixer -q set Master toggle")

  -- Decrease volume.
  , ((modMask .|. controlMask, xK_j),
     spawn "amixer -q set Master 5%-")

  -- Increase volume.
  , ((modMask .|. controlMask, xK_k),
     spawn "amixer -q set Master 5%+")

  -- Close focused window.
  , ((modMask .|. shiftMask, xK_c),
     kill)

  -- Cycle through the available layout algorithms.
   , ((modMask, xK_n),
     sendMessage NextLayout)

  -- Reset the layouts on the current workspace to default.
  , ((modMask .|. shiftMask, xK_space),
     setLayout $ XMonad.layoutHook conf)

  -- Resize viewed windows to the correct size.
  --, ((modMask, xK_n),
  --   refresh)

  -- Move focus to the next window and shift to master
  , ((modMask, xK_Tab),
   --  windows W.focusDown )
     windows W.focusUp >> windows W.shiftMaster)

  -- Move focus to the next window.
  , ((modMask, xK_j),
     windows W.focusDown)

  -- Move focus to the previous window.
  , ((modMask, xK_k),
     windows W.focusUp )

  -- Move focus to the master window.
  , ((modMask, xK_m),
     windows W.focusMaster )

  -- Swap the focused window and the master window.
  , ((modMask, xK_Return),
     windows W.swapMaster)

  -- Shrink the master area.
  , ((modMask, xK_h),
     sendMessage Shrink)

  -- Expand the master area.
  , ((modMask, xK_l),
     sendMessage Expand)

  -- Push window back into tiling.
  , ((modMask, xK_t),
     withFocused $ windows . W.sink)

  -- Increment the number of windows in the master area.
  , ((modMask, xK_comma),
     sendMessage (IncMasterN 1))

  -- Decrement the number of windows in the master area.
  , ((modMask, xK_period),
     sendMessage (IncMasterN (-1)))

  -- Quit xmonad.
  , ((modMask .|. shiftMask, xK_q),
     io (exitWith ExitSuccess))

  -- Restart xmonad.
  , ((modMask, xK_q),
     restart "xmonad" True)

  ]

  ++

  -- mod-[1..9], Switch to workspace N
  -- mod-shift-[1..9], Move client to workspace N
  [((m .|. modMask, k), windows $ f i)
      | (i, k) <- zip (XMonad.workspaces conf) [xK_1 .. xK_9]
      , (f, m) <- [(W.greedyView, 0), (W.shift, shiftMask)]]
  ++

  -- mod-{w,e,r}, Switch to physical/Xinerama screens 1, 2, or 3
  -- mod-shift-{w,e,r}, Move client to screen 1, 2, or 3
  [((m .|. modMask, key), screenWorkspace sc >>= flip whenJust (windows . f))
      | (key, sc) <- zip [xK_w, xK_e, xK_r] [0..]
      , (f, m) <- [(W.view, 0), (W.shift, shiftMask)]]


------------------------------------------------------------------------
-- Mouse bindings
--
-- Focus rules
-- True if your focus should follow your mouse cursor.
myFocusFollowsMouse :: Bool
myFocusFollowsMouse = True

myMouseBindings (XConfig {XMonad.modMask = modMask}) = M.fromList $
  [
    -- mod-button1, Set the window to floating mode and move by dragging
    ((modMask, button1),
     (\w -> focus w >> mouseMoveWindow w))

    -- mod-button2, Raise the window to the top of the stack
    , ((modMask, button2),
       (\w -> focus w >> windows W.swapMaster))

    -- mod-button3, Set the window to floating mode and resize by dragging
    , ((modMask, button3),
       (\w -> focus w >> mouseResizeWindow w))

    -- you may also bind events to the mouse scroll wheel (button4 and button5)
  ]

------------------------------------------------------------------------
-- Startup hook
-- Perform an arbitrary action each time xmonad starts or is restarted
-- with mod-q. Used by, e.g., XMonad.Layout.PerWorkspace to initialize
-- per-workspace layout choices.
--
-- By default, do nothing.
myStartupHook = do
  spawn "feh --bg-fill -z ~/photo/wallpaper"
  spawn "albert"
  spawnOnce "firefox"


------------------------------------------------------------------------
-- Floats all windows in a certain workspace.
-- myLayouts
--myLayouts = onWorkspace "three" simplestFloat $ defaultLayouts
myLayouts = defaultLayouts

------------------------------------------------------------------------
-- Run xmonad with all the defaults we set up.
--
main = do
 xmproc <- spawnPipe "/run/current-system/sw/bin/xmobar ~/.xmonad/xmobar.conf"
 xmonad $ ewmh $ docks defaultConfig
   { manageHook = myManageHook
   , layoutHook = myLayouts
   , borderWidth = myBorderWidth
   , logHook = dynamicLogWithPP xmobarPP
         { ppOutput = hPutStrLn xmproc
         , ppLayout = const "" -- to disable the layout info on xmobar
         }
    -- simple stuff
   , terminal = myTerminal
   , focusFollowsMouse = myFocusFollowsMouse
   , modMask = myModMask
   , workspaces = myWorkspaces
   , normalBorderColor = myNormalBorderColor
   , focusedBorderColor = myFocusedBorderColor

    -- key bindings
   , keys = myKeys
   , mouseBindings = myMouseBindings

    -- hooks, layouts
   , startupHook = myStartupHook
   }

