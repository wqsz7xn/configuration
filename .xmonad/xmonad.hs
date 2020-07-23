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
                        , ppTitle = xmobarColor "green" "" . shorten 20
                        }
        , modMask = mod4Mask
        , focusedBorderColor = "#FFFF00"
	, borderWidth = 1
        } `additionalKeys`
        [ ((mod4Mask, xK_a ), spawn "scrot -s")
        , ((mod4Mask, xK_r ), spawn "autorandr --change")
        , ((mod4Mask, xK_e ), spawn "emacs")
        , ((mod4Mask, xK_f ), spawn "firefox")
        , ((mod4Mask, xK_m ), spawn "thunderbird")
        , ((0, xF86XK_AudioLowerVolume   ), spawn "amixer set Master 2-")
        , ((0, xF86XK_AudioRaiseVolume   ), spawn "amixer set Master 2+")
        , ((0, xF86XK_AudioMute          ), spawn "amixer -D pulse set Master Playback Switch toggle")
        , ((0, xF86XK_AudioMicMute), spawn "amixer set Capture toggle")
        , ((mod4Mask, xK_z),
            xmonadPromptC systemPromptCmds defaultXPConfig)
        ]

systemPromptCmds = [
        ("shutdown", spawn "shutdown now"),
        ("reboot", spawn "reboot"),
        ("exit", io $ exitWith ExitSuccess),
        ("lock", spawn "sleep 1; xset dpms force off; slock"),
        ("restart", restart "xmonad" True)
    ]
