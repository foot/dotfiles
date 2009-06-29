
import XMonad hiding ((|||))
-- import qualified XMonad.StackSet as W 

import XMonad.Hooks.DynamicLog
import XMonad.Hooks.ManageDocks
import XMonad.Util.Run (spawnPipe)
import XMonad.Util.EZConfig (additionalKeys)
import System.IO

import XMonad.Layout.Accordion
import XMonad.Layout.Circle
import XMonad.Layout.Dishes
import XMonad.Layout.DragPane
import XMonad.Layout.Grid
import XMonad.Layout.Tabbed
import XMonad.Layout.TabBarDecoration
import XMonad.Layout.Combo
import XMonad.Layout.TwoPane
import XMonad.Layout.LayoutCombinators ((|||))
import XMonad.Actions.CycleSelectedLayouts

import XMonad.Actions.RotSlaves
import XMonad.Actions.Promote
-- import XMonad.Actions.SpawnOn

import XMonad.Prompt
import XMonad.Prompt.Man
import XMonad.Prompt.Ssh
import XMonad.Prompt.Window

-- import XMonad.Config.Gnome

myLayout = tiled ||| Mirror tiled ||| Full ||| (TwoPane delta ratio)
    where
        tiled   = Tall nmaster delta ratio
        nmaster = 1
        ratio   = 4/7
        delta   = 5/100

main = do
    xmproc <- spawnPipe "$HOME/.cabal/bin/xmobar $HOME/.xmonad/xmobar"

    xmonad $ defaultConfig {
        manageHook = manageHook defaultConfig,
        layoutHook = avoidStruts $ myLayout,
        logHook = dynamicLogWithPP $ xmobarPP {
                      ppOutput = hPutStrLn xmproc
                    , ppTitle = xmobarColor "green" "" . shorten 50
                    },
        borderWidth        = 2,
        terminal           = "/usr/bin/urxvt",
        normalBorderColor  = "#cccccc",
        focusedBorderColor = "#cd8b00",
        modMask = mod4Mask

    } `additionalKeys`
        [ ((mod4Mask .|. shiftMask, xK_z), spawn "xscreensaver-command -lock")

        , ((controlMask, xK_Print), spawn "scrot -s")
        , ((mod4Mask, xK_Print), spawn "scrot")

        , ((mod4Mask, xK_F1), manPrompt defaultXPConfig)
        , ((mod4Mask .|. shiftMask, xK_s), sshPrompt defaultXPConfig)
        , ((mod4Mask .|. controlMask, xK_s), windowPromptGoto  defaultXPConfig)

        -- similar to default, but swap with first slave if focused on master.
        , ((mod4Mask, xK_Tab), promote)
        , ((mod4Mask, xK_Return), promote)

        -- cycle slaves, good for TwoPane
        , ((mod4Mask .|. controlMask, xK_k), rotSlavesUp)
        , ((mod4Mask .|. controlMask, xK_j), rotSlavesDown)

        -- "Toggle" TwoPane/Tall, e.g. showing all slaves in right column vs. just the top slave.
        , ((mod4Mask .|. controlMask, xK_space), cycleThroughLayouts ["Tall", "TwoPane"])

        -- Don't include TwoPane in the default cycle.
        , ((mod4Mask, xK_space), cycleThroughLayouts ["Tall", "Mirror Tall", "Full"])
        ]

--        ++

        --
        -- mod-{w,e,r}, Switch to physical/Xinerama screens 1, 2, or 3
        -- mod-shift-{w,e,r}, Move client to screen 1, 2, or 3
        --
--        [((m .|. modMask, key), screenWorkspace sc >>= flip whenJust (windows . f))
--            | (key, sc) <- zip [xK_e, xK_w, xK_r] [0..]
--            , (f, m) <- [(XMonad.StackSet.view, 0), (XMonad.StackSet.shift, shiftMask)]]


