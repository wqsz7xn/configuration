import           Graphics.X11.ExtraTypes.XF86
import           System.Exit
import           System.IO
import           XMonad
import           XMonad.Hooks.DynamicLog
import           XMonad.Hooks.ManageDocks
import           XMonad.Hooks.Script
import           XMonad.Prompt
import           XMonad.Prompt.Shell
import           XMonad.Prompt.XMonad
import           XMonad.Util.Dmenu
import           XMonad.Util.EZConfig         (additionalKeys)
import           XMonad.Util.Run              (spawnPipe)

main = do
    xmproc <- spawnPipe "xmobar"
    xmonad $ docks defaultConfig
        { layoutHook = avoidStruts $ layoutHook defaultConfig
        , logHook = dynamicLogWithPP xmobarPP
                        { ppOutput = hPutStrLn xmproc
                        , ppTitle = xmobarColor "red" "" . shorten 20
                        }
        , modMask = mod4Mask
        , borderWidth = 1
        } `additionalKeys`
        [ ((mod4Mask, xK_s ), spawn "sleep 0.2; scrot ~/Pictures/Screenshots/%b%d::%H%M%S.png -s")
        , ((mod4Mask, xK_e ), spawn "emacs")
        , ((mod4Mask, xK_f ), spawn "chromium")
        , ((mod4Mask, xK_b ), spawn "blueman-manager")
        , ((mod4Mask, xK_m ), spawn "thunderbird")
        , ((mod4Mask, xK_z),
            xmonadPromptC systemPromptCmds defaultXPConfig)
        ]

systemPromptCmds = [
        ("shutdown", spawn "shutdown now"),
        ("reboot", spawn "reboot"),
        ("exit", io $ exitWith ExitSuccess),
        ("suspend", io $ spawn "systemctl suspend"),
        ("lock", spawn "sleep 1; xset dpms force off; slock"),
        ("restart (xmonad)", restart "xmonad" True)
    ]

