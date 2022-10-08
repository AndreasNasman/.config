import XMonad

import XMonad.Hooks.EwmhDesktops
import XMonad.Util.EZConfig
import XMonad.Util.Ungrab

main :: IO ()
main = xmonad $ ewmhFullscreen $ ewmh $ myConfig

myConfig = def
    { modMask  = mod4Mask     -- Rebind Mod to the Super key
    , terminal = "alacritty"
    }
  `additionalKeysP`
    -- [ ("M-S-z", spawn "xscreensaver-command -lock")
    [ ("M-C-s", unGrab *> spawn "scrot -s"        )
    , ("M-f"  , spawn "firefox"                   )
    ]
