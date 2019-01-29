import XMonad hiding (Tall(..))
import qualified XMonad.StackSet as W
import XMonad.Actions.CopyWindow
import XMonad.Layout.Tabbed
import XMonad.Layout.HintedTile
import XMonad.Layout.NoBorders
import XMonad.Layout.ThreeColumns
import XMonad.Hooks.ManageDocks
import XMonad.Hooks.ManageHelpers (isFullscreen, doFullFloat)
import XMonad.Hooks.EwmhDesktops
import XMonad.Hooks.DynamicLog
import XMonad.Prompt
import XMonad.Actions.SpawnOn
import XMonad.Util.SpawnOnce
import XMonad.Util.Run(spawnPipe)
import XMonad.Util.EZConfig(removeKeys)
import System.IO


import XMonad.Layout.LayoutScreens
import XMonad.Layout.TwoPane

import Data.List (isPrefixOf)

import qualified Data.Map as M

main = do
  xmproc <- spawnPipe "@xmobar@ ~/.config/xmobar/xmobar.conf"
  xmonad $ docks $ ewmh $ defaultConfig
    { terminal = "kitty"
    , workspaces = ["src", "web"] ++ map show [3 .. 8 :: Int] ++ ["tv"]
    , mouseBindings = \(XConfig {modMask = modm}) -> M.fromList $
            [ ((modm, button1), (\w -> focus w >> mouseMoveWindow w))
            , ((modm, button2), (\w -> focus w >> windows W.swapMaster))
            , ((modm.|. shiftMask, button1), (\w -> focus w >> mouseResizeWindow w)) ]
    , keys = \c -> mykeys c `M.union` keys defaultConfig c
    , layoutHook = modifiers layouts
    , focusedBorderColor = "#586e75"
    , normalBorderColor = "#000000"
    , startupHook = myStartupHook
    , logHook = dynamicLogWithPP sjanssenPP
         { ppOutput = hPutStrLn xmproc
         , ppLayout = const "" -- to disable the layout info on xmobar
         }
    , manageHook = manageHook defaultConfig
                <+> manageSpawn
                <+> (isFullscreen --> doFullFloat)
                <+> (className =? "Kodi" --> doShift "tv")
    } `removeKeys` [(mod1Mask, xK_space)]
 where
    tiled     = HintedTile 1 0.03 0.5 TopLeft
    layouts   = (tiled Tall ||| (tiled Wide ||| Full)) ||| ThreeColMid 1 (3/100) (3/4)
    modifiers = avoidStruts . smartBorders
    myStartupHook = spawn "@albert@"
    mykeys (XConfig {modMask = modm}) = M.fromList $
        [((modm .|. shiftMask, xK_Return), spawnHere =<< asks (terminal . config))
        ,((modm .|. shiftMask, xK_c     ), kill1)
        ,((modm .|. shiftMask .|. controlMask, xK_c     ), kill)
        ,((modm .|. shiftMask, xK_0     ), windows $ copyToAll)
        ,((modm,               xK_z     ), layoutScreens 2 $ TwoPane 0.5 0.5)
        ,((modm .|. shiftMask, xK_z     ), rescreen)
        ,((modm .|. controlMask, xK_l   ), spawn "@lockCmd@")
        ,((modm,               xK_b     ), sendMessage ToggleStruts)
        ,((modm .|. controlMask, xK_m   ), spawn "amixer -q set Master toggle")
        ,((modm .|. controlMask, xK_j   ), spawn "amixer -q set Master 5%-")
        ,((modm .|. controlMask, xK_k   ), spawn "amixer -q set Master 5%+")
        ,((modm, xK_n                   ), sendMessage NextLayout)
        ]

