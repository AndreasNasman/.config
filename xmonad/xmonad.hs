-- Based on https://xmonad.org/TUTORIAL.html#customizing-xmonad

import XMonad

import XMonad.Hooks.DynamicLog
import XMonad.Hooks.EwmhDesktops
import XMonad.Hooks.StatusBar
import XMonad.Hooks.StatusBar.PP
import XMonad.Util.EZConfig
import XMonad.Util.Ungrab

main :: IO ()
main = xmonad $ ewmhFullscreen $ ewmh $ xmobarProp $ myConfig

myConfig = def
    { modMask  = mod4Mask     -- Rebind Mod to the Super key
    , terminal = "alacritty"
    }
  `additionalKeysP`
    -- [ ("M-S-z", spawn "xscreensaver-command -lock")
    [ ("M-C-s", unGrab *> spawn "scrot -s"        )
    , ("M-f"  , spawn "firefox"                   )
    ]
