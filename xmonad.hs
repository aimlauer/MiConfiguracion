import XMonad
import XMonad.Actions.CycleWindows -- classic alt-tab
import XMonad.Actions.CycleWS      -- cycle thru WS', toggle last WS
import XMonad.Actions.DwmPromote   -- swap master like dwm
import XMonad.Hooks.DynamicLog     -- statusbar 
import XMonad.Hooks.EwmhDesktops   -- fullscreenEventHook fixes chrome fullscreen
import XMonad.Hooks.ManageDocks    -- dock/tray mgmt
import XMonad.Hooks.ManageHelpers    -- dock/tray mgmt
import XMonad.Hooks.UrgencyHook    -- window alert bells 
import XMonad.Layout.Named         -- custom layout names
import XMonad.Layout.NoBorders     -- smart borders on solo clients
import XMonad.Util.Run(spawnPipe)  -- spawnPipe and hPutStrLn
import XMonad.Layout.Grid (Grid(..))
import XMonad.Layout.CenteredMaster
import System.IO                   -- hPutStrLn scope
import XMonad.Layout.SimplestFloat

import XMonad.Hooks.Place
import XMonad.Util.EZConfig
import qualified XMonad.StackSet as W   -- manageHook rules

main = do
        status <- spawnPipe myDzenStatus    -- xmonad status on the left
        conky  <- spawnPipe myDzenConky     -- conky stats on the right
        xmonad $ withUrgencyHook NoUrgencyHook $ defaultConfig 
            { modMask            = mod4Mask
            , terminal           = "terminator"
            , borderWidth        = 4
            , normalBorderColor  = "#dddddd"
            , focusedBorderColor = "#0023ff"
            , workspaces = myWorkspaces
            , layoutHook = myLayoutHook
            , manageHook = manageDocks <+> doCenterFloat <+> myManageHook
            , logHook    = myLogHook status
            } 
            `additionalKeysP` myKeys

-- Tags/Workspaces
-- clickable workspaces via dzen/xdotool
myWorkspaces            :: [String]
myWorkspaces            = clickable . (map dzenEscape) $ ["1","2","3","4","5"]
 
  where clickable l     = [ "^ca(1,xdotool key super+" ++ show (n) ++ ")" ++ ws ++ "^ca()" |
                            (i,ws) <- zip [1..] l,
                            let n = i ]

spawnMyApps :: IO()
spawnMyApps = do
  spawn "thunderbird"

-- Layouts
-- the default layout is fullscreen with smartborders applied to all
--- myLayoutHook = simplestFloat
myLayoutHook = simplestFloat

-- Window management
--
myManageHook = composeAll
    [
      className =? "MPlayer"        --> doFloat
    , className =? "Vlc"            --> doFloat
    , className =? "Gimp"           --> doFloat
    , className =? "Firefox"         --> doFloat 
    , className =? "Thunderbird"    --> doF (W.shift (myWorkspaces !! 2))
    , className =? "XCalc"          --> doFloat
    , className =? "Chromium"       --> doF (W.shift (myWorkspaces !! 1)) -- send to ws 2
    , className =? "Thunar"         --> doFloat 
    , className =? "Gimp"           --> doF (W.shift (myWorkspaces !! 3)) -- send to ws 4
    ]

-- Statusbar 
--
myLogHook h = dynamicLogWithPP $ myDzenPP { ppOutput = hPutStrLn h }

myDzenStatus = "dzen2 -w '320' -ta 'l'" ++ myDzenStyle
myDzenConky  = "conky -c ~/.xmonad/conkyrc | dzen2 -x '320' -ta 'r'" ++ myDzenStyle
myDzenStyle  = " -h '20' -fg '#777777' -bg '#222222' -fn 'arial:bold:size=9'"

myDzenPP  = dzenPP
    { ppCurrent = dzenColor "#3399ff" "" . wrap " " " "
    , ppHidden  = dzenColor "#dddddd" "" . wrap " " " "
    , ppHiddenNoWindows = dzenColor "#777777" "" . wrap " " " "
    , ppUrgent  = dzenColor "#ff0000" "" . wrap " " " "
    , ppSep     = "     "
    , ppLayout  = dzenColor "#aaaaaa" "" . wrap "^ca(1,xdotool key super+space)· " " ·^ca()"
    , ppTitle   = dzenColor "#ffffff" "" 
                    . wrap "^ca(1,xdotool key super+k)^ca(2,xdotool key super+shift+c)"
                           "                          ^ca()^ca()" . shorten 20 . dzenEscape
    }

-- Key bindings
--
myKeys = [ ("M-b"        , sendMessage ToggleStruts              ) -- toggle the status bar gap
         , ("M1-<Tab>"   , cycleRecentWindows [xK_Alt_L] xK_Tab xK_Tab ) -- classic alt-tab behaviour
         , ("M-<Return>" , dwmpromote                            ) -- swap the focused window and the master window
         , ("M-<Tab>"    , toggleWS                              ) -- toggle last workspace (super-tab)
         , ("M-<Right>"  , nextWS                                ) -- go to next workspace
         , ("M-<Left>"   , prevWS                                ) -- go to prev workspace
         , ("M-S-<Right>", shiftToNext                           ) -- move client to next workspace
         , ("M-S-<Left>" , shiftToPrev                           ) -- move client to prev workspace
         , ("M-c"        , spawn "xcalc"                         ) -- calc
         , ("M-p"        , spawn "gmrun"                         ) -- app launcher
         , ("M-n"        , spawn "wicd-client -n"                ) -- network manager
         , ("M-r"        , spawn "xmonad --restart"              ) -- restart xmonad w/o recompiling
         , ("M-w"        , spawn "chromium"                      ) -- launch browser
         , ("M-S-w"      , spawn "chromium --incognito"          ) -- launch private browser
         , ("M-e"        , spawn "nautilus"                      ) -- launch file manager
         , ("C-M1-l"     , spawn "gnome-screensaver-command --lock"              ) -- lock screen
         , ("M-s"        , spawn "urxvtcd -e bash -c 'screen -dRR -S $HOSTNAME'" ) -- launch screen session
         , ("M-<Up>"     , spawn "amixer -q set -q Master 1%+") -- Volume control Up
         , ("M-<Down>"   , spawn "amixer -q set -q Master 1%-") -- Down
         , ("C-M1-<Delete>" , spawn "sudo shutdown -r now"       ) -- reboot
         , ("C-M1-<Insert>" , spawn "sudo shutdown -h now"       ) -- poweroff
         ]

