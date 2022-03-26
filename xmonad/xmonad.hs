import XMonad

import Graphics.X11.ExtraTypes.XF86
import XMonad.Util.EZConfig
import XMonad.Util.Loggers
import XMonad.Util.Ungrab
import XMonad.Hooks.EwmhDesktops
import XMonad.Hooks.StatusBar
import XMonad.Hooks.StatusBar.PP
import Data.Monoid
import System.Exit
import XMonad.Hooks.DynamicLog
import XMonad.Util.SpawnOnce
import XMonad.Util.Run
import XMonad.Util.Loggers
import XMonad.Hooks.ManageDocks
import XMonad.Layout.Spacing
import qualified DBus as D
import qualified DBus.Client as D
import qualified XMonad.StackSet as W
import qualified Data.Map        as M
import qualified Codec.Binary.UTF8.String as UTF8
-- The preferred terminal program, which is used in a binding below and by
-- certain contrib modules.
--
myTerminal      = "alacritty "
myEditor        = myTerminal ++ " -e nvim "
myBrowser       = "firefox"
-- Whether focus follows the mouse pointer.
myFocusFollowsMouse :: Bool
myFocusFollowsMouse = True

-- Whether clicking on a window to focus also passes the click to the window
myClickJustFocuses :: Bool
myClickJustFocuses = False

-- Width of the window border in pixels.
--
myBorderWidth   = 1

-- modMask lets you specify which modkey you want to use. The default
-- is mod1Mask ("left alt").  You may also consider using mod3Mask
-- ("right alt"), which does not conflict with emacs keybindings. The
-- "windows key" is usually mod4Mask.
--
myModMask       = mod4Mask

-- The default number of workspaces (virtual screens) and their names.
-- By default we use numeric strings, but any string may be used as a
-- workspace name. The number of workspaces is determined by the length
-- of this list.
--
-- A tagging example:
--
-- > workspaces = ["web", "irc", "code" ] ++ map show [4..9]
--
myWorkspaces    = ["1","2","3","4","5","6","7","8","9"]
---- Key binding to toggle the gap for the bar.
toggleStrutsKey XConfig {XMonad.modMask = modMask} = (modMask, xK_b)
-- Border colors for unfocused and focused windows, respectively.
--
myNormalBorderColor  = "#523874"
myFocusedBorderColor = "#adf182"

------------------------------------------------------------------------
-- Key bindings. Add, modify or remove key bindings here.
--
myKeys conf@(XConfig {XMonad.modMask = modm}) = M.fromList $

    -- launch a terminal
    [ ((modm .|. shiftMask, xK_Return), spawn $ XMonad.terminal conf)

    , ((modm, xK_o), spawn "maimocr &")

    -- , ("C-S-\\", spawn "dunstctl set-paused toggle")
    -- volume ctl  
    -- launch dmenu
    , ((modm,               xK_p     ), spawn "dmenu_run")

    -- launch gmrun
    , ((modm .|. shiftMask, xK_p     ), spawn "gmrun")

    -- close focused window
    , ((modm .|. shiftMask, xK_c     ), kill)

     -- Rotate through the available layout algorithms
    , ((modm,               xK_space ), sendMessage NextLayout)

    --  Reset the layouts on the current workspace to default
    , ((modm .|. shiftMask, xK_space ), setLayout $ XMonad.layoutHook conf)

    -- Resize viewed windows to the correct size
    , ((modm,               xK_n     ), refresh)

    -- Move focus to the next window
    , ((modm,               xK_Tab   ), windows W.focusDown)

    -- Move focus to the next window
    , ((modm,               xK_j     ), windows W.focusDown)

    -- Move focus to the previous window
    , ((modm,               xK_k     ), windows W.focusUp  )

    -- Move focus to the master window
    , ((modm,               xK_m     ), windows W.focusMaster  )

    -- Swap the focused window and the master window
    , ((modm,               xK_Return), windows W.swapMaster)

    -- Swap the focused window with the next window
    , ((modm .|. shiftMask, xK_j     ), windows W.swapDown  )

    -- Swap the focused window with the previous window
    , ((modm .|. shiftMask, xK_k     ), windows W.swapUp    )

    -- Shrink the master area
    , ((modm,               xK_h     ), sendMessage Shrink)

    -- Expand the master area
    , ((modm,               xK_l     ), sendMessage Expand)

    -- Push window back into tiling
    , ((modm,               xK_t     ), withFocused $ windows . W.sink)

    -- Increment the number of windows in the master area
    , ((modm              , xK_comma ), sendMessage (IncMasterN 1))

    -- Deincrement the number of windows in the master area
    , ((modm              , xK_period), sendMessage (IncMasterN (-1)))

    -- Toggle the status bar gap
    -- Use this binding with avoidStruts from Hooks.ManageDocks.
    -- See also the statusBar function from Hooks.DynamicLog.
    --
    -- , ((modm              , xK_b     ), sendMessage ToggleStruts)

    -- Quit xmonad
    , ((modm .|. shiftMask, xK_q     ), io (exitWith ExitSuccess))

    -- Restart xmonad
    , ((modm              , xK_q     ), spawn "xmonad --recompile; xmonad --restart")

    -- Run xmessage with a summary of the default keybindings (useful for beginners)
    --, ((modm .|. shiftMask, xK_slash ), spawn ("echo \"" ++ help ++ "\" | xmessage -file -"))
    ]
    ++

    --
    -- mod-[1..9], Switch to workspace N
    -- mod-shift-[1..9], Move client to workspace N
    --
    [((m .|. modm, k), windows $ f i)
        | (i, k) <- zip (XMonad.workspaces conf) [xK_1 .. xK_9]
        , (f, m) <- [(W.greedyView, 0), (W.shift, shiftMask)]]
    ++

    --g
    -- mod-{w,e,r}, Switch to physical/Xinerama screens 1, 2, or 3
    -- mod-shift-{w,e,r}, Move client to screen 1, 2, or 3
    --
    [((m .|. modm, key), screenWorkspace sc >>= flip whenJust (windows . f))
        | (key, sc) <- zip [xK_w, xK_e, xK_r] [0..]
        , (f, m) <- [(W.view, 0), (W.shift, shiftMask)]]


------------------------------------------------------------------------
-- Mouse bindings: default actions bound to mouse events
--
myMouseBindings (XConfig {XMonad.modMask = modm}) = M.fromList $

    -- mod-button1, Set the window to floating mode and move by dragging
    [ ((modm, button1), (\w -> focus w >> mouseMoveWindow w
                                       >> windows W.shiftMaster))

    -- mod-button2, Raise the window to the top of the stack
    , ((modm, button2), (\w -> focus w >> windows W.shiftMaster))

    -- mod-button3, Set the window to floating mode and resize by dragging
    , ((modm, button3), (\w -> focus w >> mouseResizeWindow w
                                       >> windows W.shiftMaster))

    -- you may also bind events to the mouse scroll wheel (button4 and button5)
    ]

------------------------------------------------------------------------
-- Layouts:

-- You can specify and transform your layouts by modifying these values.
-- If you change layout bindings be sure to use 'mod-shift-space' after
-- restarting (with 'mod-q') to reset your layout state to the new
-- defaults, as xmonad preserves your old layout settings by default.
--
-- The available layouts.  Note that each layout is separated by |||,
-- which denotes layout choice.

myLayout = avoidStruts (tiled ||| Mirror tiled ||| Full)
  where
     -- default tiling algorithm partitions the screen into two panes
     tiled   = Tall nmaster delta ratio

     -- The default number of windows in the master pane
     nmaster = 1

     -- Default proportion of screen occupied by master pane
     ratio   = 1/2

     -- Percent of screen to increment by when resizing panes
     delta   = 3/100

{-
myLayout = tiled ||| Mirror tiled ||| Full ||| threeCol
  where
    threeCol = magnifiercz' 1.3 $ ThreeColMid nmaster delta ratio
    tiled    = Tall nmaster delta ratio
    nmaster  = 1      -- Default number of windows in the master pane
    ratio    = 1/2    -- Default proportion of screen occupied by master pane
    delta    = 3/100  -- Percent of screen to increment by when resizing panes
-}
------------------------------------------------------------------------
-- Window rules:

-- Execute arbitrary actions and WindowSet manipulations when managing
-- a new window. You can use this to, for example, always float a
-- particular program, or have a client always appear on a particular
-- workspace.
--
-- To find the property name associated with a program, use
-- > xprop | grep WM_CLASS
-- and click on the client you're interested in.
--
-- To match on the WM_NAME, you can use 'title' in the same way that
-- 'className' and 'resource' are used below.
--
myManageHook = composeAll
    [ className =? "MPlayer"        --> doFloat
    , className =? "Gimp"           --> doFloat
    , resource  =? "desktop_window" --> doIgnore
    , resource  =? "kdesktop"       --> doIgnore ]

------------------------------------------------------------------------
-- Event handling

-- * EwmhDesktops users should change this to ewmhDesktopsEventHook
--
-- Defines a custom handler function for X Events. The function should
-- return (All True) if the default handler is to be run afterwards. To
-- combine event hooks use mappend or mconcat from Data.Monoid.
--
myEventHook = mempty

------------------------------------------------------------------------
-- Status bars and logging

-- Perform an arbitrary action on each internal state change or X event.
-- See the 'XMonad.Hooks.DynamicLog' extension for examples.
--
--myLogHook h = dynamicLogWithPP $ def{ ppOutput = hPutStrLn h }
-- COLORS
green     = "#adf182"
gray      = "#7F7F7F"
gray2     = "#222222"
red       = "#900000"
blue      = "#2E9AFE"
white     = "#eeeeee"


--myLogHook :: D.Client -> PP
--myLogHook dbus = def 
--        {ppOutput = dbusOutput dbus
--           , ppCurrent = wrap ("%{F" ++ green ++ "} ") " %{F-}"
--           , ppVisible = wrap ("%{F" ++ gray ++ "} ") " %{F-}"
--           , ppUrgent = wrap ("%{F" ++ red ++ "} ") " %{F-}"
--           , ppHidden = wrap ("%{F" ++ gray ++ "} ") " %{F-}"
--           , ppTitle = wrap ("%{F" ++ gray2 ++ "} ") " %{F-}"
--        }
-- Emit a DBus signal on log updates
--dbusOutput :: D.Client -> String -> IO ()
--dbusOutput dbus str = do
--    let signal = (D.signal objectPath interfaceName memberName) {
--            D.signalBody = [D.toVariant $ UTF8.decodeString str]
--        }
--    D.emit dbus signal
--  where
--    objectPath = D.objectPath_ "/org/xmonad/Log"
--   interfaceName = D.interfaceName_ "org.xmonad.Log"
--   memberName = D.memberName_ "Update"

------------------------------------------------------------------------
-- Startup hook

-- Perform an arbitrary action each time xmonad starts or is restarted
-- with mod-q.  Used by, e.g., XMonad.Layout.PerWorkspace to initialize
-- per-workspace layout choices.
--
-- By default, do nothing.
myStartupHook = do
  spawn "killall trayer"
  spawn ("sleep 2 && trayer --edge top --align right --widthtype request --padding 6 --SetDockType true --SetPartialStrut true --expand true --monitor 0 --transparent true --alpha 0 --tint 0x3e4451 --height 22")
  spawnOnce "nitrogen --restore &"
  spawnOnce "picom &"
  spawnOnce "xset r rate 300 50"
  spawnOnce "setxkbmap -model abnt -layout us -variant intl"
  spawnOnce "sct 3000"
  spawnOnce "ibus-daemon -drxR &"
  spawnOnce "xfce4-clipman -d &"
  spawnOnce "nm-applet -d &"
  spawnOnce "volumeicon"
------------------------------------------------------------------------
-- Now run xmonad with all the defaults we set up.
-- Run xmonad with the settings you specify. No need to modify this.
main :: IO ()
main = xmonad
     . ewmhFullscreen
     . ewmh
     . withEasySB (statusBarProp "xmobar" (pure myXmobarPP)) defToggleStrutsKey
     $ myConfig 

myXmobarPP :: PP
myXmobarPP = def
    { ppSep             = orange " • "
    , ppTitleSanitize   = xmobarStrip
    , ppCurrent         = green . wrap " " ""
    , ppHidden          = purple . wrap " " ""
    , ppUrgent          = red . wrap (red "!") (red "!")
    , ppOrder           = \[ws, _, wins, _] -> [ws, wins]
    , ppExtras          = [logTitles formatFocused formatUnfocused]
    }
  where
    formatFocused   = wrap (green    "[") (green    "]") . purple . ppWindow
    formatUnfocused = wrap (purple "[") (purple "]") . orange    . ppWindow

    -- | Windows should have *some* title, which should not not exceed a
    -- sane length.
    ppWindow :: String -> String
    ppWindow = xmobarRaw . (\w -> if null w then "untitled" else w) . shorten 30

    purple, green, orange, red, yellow, white :: String -> String
    purple = xmobarColor "#916cad" ""
    green  = xmobarColor "#adf182" ""
    orange = xmobarColor "#f6c026" ""
    red    = xmobarColor "#9e2224" ""
    yellow = xmobarColor "#f9cc38" ""
    white  = xmobarColor "#bbc2cf" ""

myConfig = def
     -- simple stuff
       {terminal           = myTerminal,
        focusFollowsMouse  = myFocusFollowsMouse,
        clickJustFocuses   = myClickJustFocuses,
        borderWidth        = myBorderWidth,
        modMask            = myModMask,
        workspaces         = myWorkspaces,
        normalBorderColor  = myNormalBorderColor,
        focusedBorderColor = myFocusedBorderColor,

      -- key bindings
        keys               = myKeys,
        mouseBindings      = myMouseBindings,

      -- hooks, layouts
        layoutHook         = spacingRaw False (Border 0 10 0 10) True (Border 10 0 10 0) True $ myLayout,
        manageHook         = myManageHook,
        --logHook            = dynamicLogWithPP (myLogHook dbus) {ppOrder = \(ws:_) -> [ws]},
 --       logHook = dynamicLogWithPP xmobarPP
 --                       { ppOutput = \x ->  hPutStrLn xmproc x   
 --                       , ppCurrent = wrap ("%{F" ++ green ++ "} ") " %{F-}"
 --                       , ppVisible = wrap ("%{F" ++ gray ++ "} ") " %{F-}"
 --                       , ppUrgent = wrap ("%{F" ++ red ++ "} ") " %{F-}"
 --                      , ppHidden = wrap ("%{F" ++ gray ++ "} ") " %{F-}"
 --                       , ppTitle = wrap ("%{F" ++ gray2 ++ "} ") " %{F-}"
 --                       },
        
        handleEventHook    = myEventHook,
        startupHook        = myStartupHook
       }
