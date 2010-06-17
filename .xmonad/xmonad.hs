import XMonad hiding ((|||))
import XMonad.Config.Gnome
import XMonad.Config.Desktop (desktopLayoutModifiers)
import XMonad.Util.EZConfig (additionalKeys)

import XMonad.Layout.NoBorders
import XMonad.Layout.TwoPane
import XMonad.Layout.LayoutCombinators ((|||))

import XMonad.Actions.Promote
import XMonad.Actions.RotSlaves
import XMonad.Actions.CycleSelectedLayouts

myLayout = smartBorders tiled ||| smartBorders (Mirror tiled) ||| smartBorders Full ||| (TwoPane delta ratio)
    where
        tiled   = Tall nmaster delta ratio
        nmaster = 1
        ratio   = 553/1000 -- gives 80 cols on terminal in main pane.
        delta   = 5/100

main = xmonad $ gnomeConfig {
        terminal = "urxvt"
      , layoutHook = desktopLayoutModifiers myLayout
      , modMask = mod4Mask
      , borderWidth = 1
      , normalBorderColor  = "#666666"
      , focusedBorderColor = "#888888"
    }
        `additionalKeys` 
    [ ((mod4Mask, xK_Tab), promote)
    -- similar to default, but swap with first slave if focused on 
    , ((mod4Mask, xK_Return), promote)
    -- cycle slaves, good for TwoPane
    , ((mod4Mask .|. controlMask, xK_k), rotSlavesUp)
    , ((mod4Mask .|. controlMask, xK_j), rotSlavesDown)
    -- "Toggle" TwoPane/Tall, e.g. showing all slaves in right column vs. just the top slave.
    , ((mod4Mask .|. controlMask, xK_space), cycleThroughLayouts ["Tall", "TwoPane"])
    -- Don't include TwoPane in the default cycle.
    , ((mod4Mask, xK_space), cycleThroughLayouts ["Tall", "Mirror Tall", "Full"])
    ]
    
