import XMonad.Layout.SimplestFloat
import XMonad

myTerminal    = "lxterminal"
myModMask     = mod4Mask -- Win key or Super_L
myBorderWidth = 3

myLayout = simplestFloat

main = do
  xmonad $ defaultConfig
    { terminal    = myTerminal
    , modMask     = myModMask
    , borderWidth = myBorderWidth
    , layoutHook = myLayout
    }

