import XMonad hiding ((|||))
import XMonad.Config.Gnome
import XMonad.Config.Desktop (desktopLayoutModifiers)
import XMonad.Util.EZConfig (additionalKeys)

import XMonad.Layout.NoBorders
import XMonad.Layout.TwoPane
import XMonad.Layout.LayoutCombinators ((|||))
import XMonad.Layout.LayoutHints
import XMonad.Layout.Named

import XMonad.Actions.Promote
import XMonad.Actions.RotSlaves
import XMonad.Actions.CycleSelectedLayouts
import XMonad.Actions.SpawnOn
-- import XMonad.Util.Replace

myLayout = tall ||| full ||| twopane ||| tallm
    where
		nmaster = 1
		ratio   = 4/7
		delta   = 5/100
		tallm   = named "tallm" (smartBorders
			(layoutHintsWithPlacement (0.5, 0.5) (Mirror (Tall nmaster delta ratio))))
		tall    = named "tall" (smartBorders
			(layoutHintsWithPlacement (0.5, 0.5) (Tall nmaster delta ratio)))
		full    = named "full" (smartBorders
			(layoutHintsWithPlacement (0.5, 0.5) (Full)))
		twopane = named "twopane" (smartBorders
			(layoutHintsWithPlacement (0.5, 0.5) (TwoPane delta ratio)))

main = -- do
	-- args <- getArgs
    -- when ("--replace" `elem` args) replace
	-- sp <- mkSpawner
	xmonad $ gnomeConfig {
        terminal = "urxvt"
      , layoutHook = desktopLayoutModifiers myLayout
      , modMask = mod4Mask
      , borderWidth = 1
      , normalBorderColor  = "#666666"
      , focusedBorderColor = "#888888"
	  -- , manageHook = manageSpawn sp <+> manageHook gnomeConfig
    }
        `additionalKeys` 
    [ ((mod4Mask, xK_Tab), promote)
    -- similar to default, but swap with first slave if focused on 
    , ((mod4Mask, xK_Return), promote)
    -- cycle slaves, good for TwoPane
    , ((mod4Mask .|. controlMask, xK_k), rotSlavesUp)
    , ((mod4Mask .|. controlMask, xK_j), rotSlavesDown)
	-- "Toggle" TwoPane/Tall, e.g. showing all slaves in right column vs. just
	-- the top slave.
    , ((mod4Mask .|. controlMask, xK_space),
		cycleThroughLayouts ["tall", "twopane"])
    -- Don't include TwoPane in the default cycle.
    , ((mod4Mask, xK_space), cycleThroughLayouts ["tall", "full", "tallm"])
    ]
    
