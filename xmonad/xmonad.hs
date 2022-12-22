-- Based on https://xmonad.org/TUTORIAL.html#customizing-xmonad

-- See the XMonad repo for the default config:
-- https://github.com/xmonad/xmonad/blob/master/src/XMonad/Config.hs

import XMonad

import System.Exit
import XMonad.Actions.UpdatePointer
import XMonad.Hooks.DynamicLog
import XMonad.Hooks.EwmhDesktops
import XMonad.Hooks.ManageHelpers
import XMonad.Hooks.StatusBar
import XMonad.Hooks.StatusBar.PP
import XMonad.Layout.NoBorders
import XMonad.Layout.Spacing
import XMonad.Util.EZConfig
import XMonad.Util.Loggers
import XMonad.Util.Ungrab

main :: IO ()
main = xmonad
     . ewmhFullscreen
     . ewmh
     . withEasySB (statusBarProp "xmobar" (pure myXmobarPP)) defToggleStrutsKey
     $ myConfig

myXmobarPP :: PP
myXmobarPP = def
    { ppCurrent         = wrap "" "" . xmobarBorder "Top" "#8be9fd" 2  -- draculaCyan
    , ppExtras          = [logTitles formatFocused formatUnfocused]
    , ppHidden          = draculaForeground . wrap "" ""
    , ppHiddenNoWindows = draculaComment . wrap "" ""
    , ppLayout          = draculaPurple
    , ppOrder           = \[ws, l, _, wins] -> [ws, l, wins]
    , ppTitleSanitize   = xmobarStrip
    , ppUrgent          = draculaRed . wrap (draculaYellow "!") (draculaYellow "!")
    , ppSep             = draculaPink " • "
    }
  where
    formatFocused   = wrap (draculaPink    "[") (draculaPink    "]") . draculaForeground . ppWindow
    formatUnfocused = wrap (draculaComment "[") (draculaComment "]") . draculaComment    . ppWindow

    -- | Windows should have *some* title, which should not not exceed a sane length.
    ppWindow :: String -> String
    ppWindow = xmobarRaw . (\w -> if null w then "untitled" else w) . shorten 30

    draculaComment, draculaForeground, draculaPink, draculaPurple, draculaRed, draculaYellow :: String -> String
    draculaComment    = xmobarColor "#6272a4" ""
    draculaForeground = xmobarColor "#f8f8f2" ""
    draculaPink       = xmobarColor "#ff79c6" ""
    draculaPurple     = xmobarColor "#bd93f9" ""
    draculaRed        = xmobarColor "#ff5555" ""
    draculaYellow     = xmobarColor "#f1fa8c" ""

-- https://github.com/dracula/dracula-theme#color-palette
draculaBackground = "#282a36"
draculaPink       = "#ff79c6"

-- https://codeberg.org/xmobar/xmobar/src/branch/master/doc/quick-start.org#headline-24
xmobarToggleCommand :: String
xmobarToggleCommand = "dbus-send --session --dest=org.Xmobar.Control --type=method_call '/org/Xmobar/Control' org.Xmobar.Control.SendSignal 'string:Toggle 0'"

myConfig = def
    { borderWidth        = 2
    , focusedBorderColor = draculaPink
    , layoutHook         = myLayout      -- Use custom layouts
    , logHook            = updatePointer (0, 0) (0, 0)
    , manageHook         = myManageHook  -- Match on certain windows
    , modMask            = mod4Mask      -- Rebind Mod to the Super key
    , normalBorderColor  = draculaBackground
    , terminal           = "kitty"
    }
  `additionalKeysP`
    [ ("M-C-S-q", (io exitSuccess)                           )
    , ("M-C-s"  , unGrab *> spawn "scrot --select"           )
    , ("M-S-b"  , spawn (xmobarToggleCommand)                )
    , ("M-S-f"  , spawn "firefox"                            )
    , ("M-S-q"  , spawn "xmonad --restart"                   )
    , ("M-p"    , spawn "launcher_t1"                        )
    , ("M-q"    , spawn "powermenu_t1"                       )
    ]

myLayout = smartBorders
         $ smartSpacingWithEdge 10  -- Adjust this value if extra whitespace occurs at the bottom of the terminal.
         $ tiled ||| Mirror tiled ||| Full
  where
    tiled   = Tall nmaster delta ratio
    nmaster = 1      -- Default number of windows in the master pane
    ratio   = 1/2    -- Default proportion of screen occupied by master pane
    delta   = 3/100  -- Percent of screen to increment by when resizing panes

myManageHook :: ManageHook
myManageHook = composeAll
    [ isDialog --> doFloat
    ]
