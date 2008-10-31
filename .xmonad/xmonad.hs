
import XMonad
-- import qualified XMonad.StackSet as W 

import XMonad.Hooks.DynamicLog
import XMonad.Hooks.ManageDocks
import XMonad.Util.Run(spawnPipe)
import XMonad.Util.EZConfig(additionalKeys)
import System.IO

import XMonad.Layout.Accordion
import XMonad.Layout.Circle
import XMonad.Layout.Dishes
import XMonad.Layout.DragPane
import XMonad.Layout.Grid
import XMonad.Layout.Tabbed


import XMonad.Prompt
import XMonad.Prompt.Man
import XMonad.Prompt.Ssh

import XMonad.Config.Gnome

main = do
    xmproc <- spawnPipe "/home/simonhowe/.cabal/bin/xmobar /home/simonhowe/.xmonad/xmobar"
    xmonad $ defaultConfig {
    -- xmonad $ gnomeConfig {
        -- modMask = mod4Mask
    -- }
        manageHook = manageDocks <+> manageHook defaultConfig,
        layoutHook = avoidStruts  $  (layoutHook defaultConfig) ||| simpleTabbed,
        logHook = dynamicLogWithPP $ xmobarPP {
                        ppOutput = hPutStrLn xmproc
                    , ppTitle = xmobarColor "green" "" . shorten 50
                    },
        borderWidth        = 2,
        terminal           = "/usr/bin/gnome-terminal --hide-menubar",
        normalBorderColor  = "#cccccc",
        focusedBorderColor = "#cd8b00",
        modMask = mod4Mask
    } `additionalKeys`
        [ ((mod4Mask .|. shiftMask, xK_z), spawn "xscreensaver-command -lock")
            , ((controlMask, xK_Print), spawn "scrot -s")
            , ((0, xK_Print), spawn "scrot")
            , ((0, xK_F1), manPrompt defaultXPConfig)
            , ((mod4Mask .|. shiftMask, xK_s), sshPrompt defaultXPConfig)
        ]

