--
-- Ryan Porterfield's XMonad config
-- 
-- Taken from the default XMonad config for readability and comments,
-- and from dankGnu's files for usablility
-- <https://github.com/dankGnu/dotfiles>
--

import XMonad
import XMonad.Actions.CycleWS	
import XMonad.Actions.FloatKeys
import XMonad.Actions.GridSelect
import XMonad.Config.Gnome
import XMonad.Hooks.DynamicLog
import XMonad.Hooks.EwmhDesktops
import XMonad.Hooks.InsertPosition
import XMonad.Hooks.ManageDocks
import XMonad.Hooks.ManageHelpers
import XMonad.Hooks.SetWMName
import XMonad.Hooks.UrgencyHook
import XMonad.Layout.Circle
import XMonad.Layout.Fullscreen
import XMonad.Layout.NoBorders
import XMonad.Layout.PerWorkspace
import XMonad.Layout.ResizableTile
import XMonad.Layout.SimplestFloat
import XMonad.Layout.Spacing
import XMonad.Layout.Spiral
import XMonad.Layout.ThreeColumns
import XMonad.ManageHook
import XMonad.Util.EZConfig
import XMonad.Util.Dmenu
import XMonad.Util.Run (spawnPipe)

import Data.List		
import Data.Monoid
import Graphics.X11.ExtraTypes.XF86
import System.Directory
import System.FilePath
import System.Exit
import System.IO (hPutStrLn)

import qualified XMonad.StackSet as W
import qualified Data.Map        as M

--
myHome          = "/home/ryan/"

-- The wallpaper we want to set
--
myWallpaper		= myHome ++ "Pictures/Wallpapers/Wallpaper.jpg"

-- The preferred terminal program, which is used in a binding below and by
-- certain contrib modules.
--
myTerminal  	= "urxvtc"

-- Whether focus follows the mouse pointer.
myFocusFollowsMouse :: Bool
myFocusFollowsMouse = False

-- Whether clicking on a window to focus also passes the click to the window
myClickJustFocuses :: Bool
myClickJustFocuses = True

-- Width of the window border in pixels.
--
myBorderWidth   = 1

-- System font
myFont	    	= "-*-tamsyn-medium-*-normal-*-14-*-*-*-*-*-*-*"

myBarIconDir 	= myHome ++ ".dzen2/workspaces/"
myWMIconDir		= myHome ++ ".dzen2/wm/"

-- modMask lets you specify which modkey you want to use. The default
-- is mod1Mask ("left alt").  You may also consider using mod3Mask
-- ("right alt"), which does not conflict with emacs keybindings. The
-- "windows key" is usually mod4Mask.
--
myModMask 	= mod1Mask

-- The default number of workspaces (virtual screens) and their names.
-- By default we use numeric strings, but any string may be used as a
-- workspace name. The number of workspaces is determined by the length
-- of this list.
--
-- A tagging example:
--
-- > workspaces = ["web", "irc", "code" ] ++ map show [4..9]
myWorkspaces  = clickable  $
		["^i(" ++ myBarIconDir ++ "shell.xbm) code"
		,"^i(" ++ myBarIconDir ++ "web.xbm) web"
		,"^i(" ++ myBarIconDir ++ "docs.xbm) docs"
		,"^i(" ++ myBarIconDir ++ "tunes.xbm) media" 
		,"^i(" ++ myBarIconDir ++ "mail.xbm) mail"
		--,"^i(" ++ myBarIconDir ++ "misc.xbm) misc"
		]
      where clickable l     = [ "^ca(1,xdotool key super+" ++ show (n) ++ ")" ++ ws ++ "^ca()" |
                              (i,ws) <- zip [1..] l,
                              let n = i ]			

-- Border colors for unfocused and focused windows, respectively.
--
myNormalBorderColor  = "#343638"
myFocusedBorderColor = "#111111"

-- Colors for status bars and other things
-- 
background			 = "#000000"
foreground			 = "#ffffff"
active				 = "#1692d0"
inactive			 = "#b2b2b2"
nowindow			 = "#404040"

-- Customized dmenu command
myDmenu 	= "dmenu_run -b -fn '-*-tamsyn-medium-*-14-*-*-*-*-*-*-*' -nb '#000000' -nf '#b2b2b2' -sb '#1692d0' -sf '#000000'"
-- Start bar with Arch Linux logo and text
myStartMenu 	= myHome ++ ".xmonad/start " ++ myHome ++ ".xmonad/apps"
-- Bar displaying workspaces
myXmonadBar 	= "dzen2 -x '150' -y '0' -h '20' -w '800' -ta 'r' -fg '"++foreground++"' -bg '"++background++"' -fn "++myFont
-- Bar displaying system stuff?
myStatusBar 	= "conky -qc " ++ myHome ++ ".xmonad/.conkyrc | dzen2 -x '950' -w '650' -h '20' -ta 'r' -bg '"++background++"' -fg '"++foreground++"' -y '0' -fn "++myFont

------------------------------------------------------------------------
-- Key bindings. Add, modify or remove key bindings here.
--
myKeys conf@(XConfig {XMonad.modMask = modm}) = M.fromList $

    ------------------------ Punctuation Keys  -------------------------
    -- launch a terminal
    [ ((modm .|. shiftMask, xK_Return), spawn $ XMonad.terminal conf)

    -- Swap the focused window and the master window
    , ((modm,               xK_Return), windows W.swapMaster)

    -- close focused window
	, ((modm,               xK_BackSpace), kill)

     -- Rotate through the available layout algorithms
    , ((modm,               xK_space), sendMessage NextLayout)

    -- Move focus to the next window
    , ((modm,               xK_Tab), nextWS)

    -- Move focus to the next window
    , ((modm .|. shiftMask, xK_Tab), prevWS)

    -- Increment the number of windows in the master area
    , ((modm,               xK_comma     ), sendMessage (IncMasterN 1))

    -- shift focus to previous non-empty workspace
    , ((modm .|. shiftMask, xK_grave), moveTo Prev NonEmptyWS)

    -- shift focus to next non-empty workspace
    , ((modm,               xK_grave), moveTo Next NonEmptyWS)

    -- Deincrement the number of windows in the master area
    , ((modm,               xK_period    ), sendMessage (IncMasterN (-1)))

    ------------------------ Alphabetic Keys  --------------------------
    -- move 20 px left
    , ((modm,               xK_a), withFocused (keysMoveWindow (-20,0)))

    -- shrink 20 from width
    , ((modm .|. shiftMask, xK_a), withFocused (keysResizeWindow (-20,0) (0,0)))

    -- launch firefox
    , ((modm,               xK_b         ), spawn "firefox")

    -- shift focust to next empty workspace
    , ((modm,               xK_c), moveTo Next EmptyWS)

    -- move 20 px right
    , ((modm,               xK_d), withFocused (keysMoveWindow (20,0)))

    -- expand 20 to width
    , ((modm .|. shiftMask, xK_d), withFocused (keysResizeWindow (20,0) (0,0)))

    -- launch ranger
    , ((modm,               xK_f), spawn "urxvtc -title ranger -e ranger")

    -- Spawn htop
    , ((modm,               xK_h), spawn "urxvtc -title htop -e htop")

    -- tries to expand upward, shrinks if on top
    , ((modm .|. shiftMask, xK_h), sendMessage MirrorExpand)

    -- Spawn new Irssi instance
    , ((modm,               xK_i), spawn "urxvtc -title irssi -e torify irssi")

    -- Move focus to the next window
    , ((modm,               xK_j), windows W.focusDown)

    -- Swap the focused window with the next window
    , ((modm .|. shiftMask, xK_j), windows W.swapDown  )
 
    -- Move focus to the previous window
    , ((modm,               xK_k), windows W.focusUp  )

    -- Swap the focused window with the previous window
    , ((modm .|. shiftMask, xK_k), windows W.swapUp    )

    -- Expand the master area
    , ((modm,               xK_l), sendMessage Expand)

    -- tries to shrink upward, expands if on bottom
    , ((modm .|. shiftMask, xK_l), sendMessage MirrorShrink)

    -- launch mutt
    , ((modm,               xK_m), spawn "urxvtc -title mutt -e mutt")

    -- Move focus to the master window
    , ((modm .|. shiftMask, xK_m), windows W.focusMaster  )

    -- launch ncmpcpp
    , ((modm,               xK_n), spawn "urxvtc -title ncmpcpp -e ncmpcpp -s clock")

    -- shift focus to next workspace
    , ((modm .|. shiftMask, xK_n), nextWS)

    -- shift focus to previous workspace
    , ((modm .|. shiftMask, xK_p), prevWS)

    -- Restart xmonad
    , ((modm,               xK_q), spawn "xmonad --recompile && (killall avant-window-navigator; killall dzen2; killall conky; killall tint2; xmonad --restart)")

    -- Quit xmonad
    , ((modm .|. shiftMask, xK_q), io (exitWith ExitSuccess))

    -- Resize viewed windows to the correct size
    , ((modm,               xK_r), refresh)

    -- launch gmrun
    , ((modm .|. shiftMask, xK_r), spawn "gmrun")

    -- move 20 px down
    , ((modm,               xK_s), withFocused (keysMoveWindow (0,20)))

    -- shrink 20 from height
    , ((modm .|. shiftMask, xK_s), withFocused (keysResizeWindow (0,-20) (0,0)))

    -- toggle trayer
    , ((modm,               xK_t), spawn "trayerToggle")

    -- Push window back into tiling
    , ((modm .|. shiftMask, xK_t), withFocused $ windows . W.sink)

    -- launch gvim
    , ((modm,               xK_v), spawn "gvim")

    -- launch pavucontrol
    , ((modm .|. shiftMask, xK_v), spawn "pavucontrol")

    -- move 20 px up
    , ((modm,               xK_w), withFocused (keysMoveWindow (0,-20)))

    -- expand 20 to height
    , ((modm .|. shiftMask, xK_w), withFocused (keysResizeWindow (0,20) (0,0)))

    -- close focused window
    , ((modm .|. shiftMask, xK_x), kill)

    --------------------------- System Keys ----------------------------
    -- lower volume
    , ((0,                  xF86XK_AudioLowerVolume), spawn "vol_down")

    -- raise volume
    , ((0,                  xF86XK_AudioRaiseVolume), spawn "vol_up")

	-- lock screen
	, ((0,                  xF86XK_ScreenSaver), spawn "xscreensaver-command -lock")

    -- toggle display modes
	, ((0,                  xF86XK_Display), spawn "/usr/local/bin/screenToggle")

    -- Take a webcam picture
	, ((0,                  xF86XK_WebCam), spawn "cheese")

    -- vpn's maybe?
	, ((0,                  xF86XK_Launch1), spawn "/usr/local/bin/openvpnToggle")

    -- ncmpcpp toggle
	, ((0,                  xF86XK_AudioPlay), spawn "ncmpcpp toggle")

    -- next song
	, ((0,                  xF86XK_AudioNext), spawn "ncmpcpp next")

    -- previous song
	, ((0,                  xF86XK_AudioPrev), spawn "ncmpcpp prev")

    -- stop playback
	, ((0,                  xF86XK_AudioStop), spawn "ncmpcpp stop")

    -- apps menu
    , ((0,                  xK_Menu), spawn ("menu " ++ myHome ++ ".xmonad/apps"))

    -- take a screenshot
    , ((0,                  xK_Print), spawn "scrot '%Y-%m-%d@%H:%M.png' -e 'mv $f ~/Pictures/Screenshots'")

    -- launch dmenu
    , ((modm,               xK_F2), spawn myDmenu)

    -- bluetooth
	, ((modm,               xK_F3), spawn "gksudo /etc/acpi/actions/bluetooth.sh")

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

    --
    -- mod-{w,e,r}, Switch to physical/Xinerama screens 1, 2, or 3
    -- mod-shift-{w,e,r}, Move client to screen 1, 2, or 3
    --
    [((m .|. modm, key), screenWorkspace sc >>= flip whenJust (windows . f))
        | (key, sc) <- zip [xK_y, xK_u, xK_e] [0..]
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
--


defaultLayouts = onWorkspace (myWorkspaces !! 0) (avoidStruts (tiled20 ||| tiled5 ||| splitm ||| extreme))
			$ onWorkspace (myWorkspaces !! 1) (avoidStruts (largem ||| tiled5) ||| simplestFloat ||| fullScreen)
			$ onWorkspace (myWorkspaces !! 2) (avoidStruts (fullTile ||| Circle) ||| fullScreen)
			$ onWorkspace (myWorkspaces !! 3) (avoidStruts (Circle ||| tiled20 ) ||| borderlessTile ||| fullScreen)
			$ onWorkspace (myWorkspaces !! 4) (avoidStruts (Circle ||| tiled20 ||| tiled5))
			$ avoidStruts (tiled5  ||| tiled20 ||| threeCol ||| fullTile ||| Circle ||| splitm) ||| fullScreen
	where
		borderlessTile	= noBorders(fullTile)
		extreme		= spacing 40 $ ResizableTall nmaster delta ratio []
		fullScreen 	= noBorders(fullscreenFull Full)
		fullTile 	= ResizableTall nmaster delta ratio [] 
		largem		= spacing 5 $ ResizableTall nmaster delta large []
		splitm		= spacing 5 $ ResizableTall smaster delta ratio []
		threeCol	= spacing 5 $ ThreeCol nmaster delta third
		tiled5  	= spacing 5 $ ResizableTall nmaster delta ratio [] 
		tiled20  	= spacing 20 $ ResizableTall nmaster delta ratio [] 

		-- The default number of windows in the master pane
		nmaster = 1

		-- The number of windows in the master pane for split-master-layout
		smaster = 2

		-- Default proportion of screen occupied by master pane
		ratio 	= 1/2 
		third   = 1/3

		-- Proportion for web workspace where we want the browser to be larger
		large	= 2/3

		-- Percent of screen to increment by when resizing panes
		delta 	= 5/100

nobordersLayout = noBorders $ Full
myLayout = defaultLayouts

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
myManageHook = composeAll 	[ -- isFullscreen -?> doFullFloat
				manageHook	gnomeConfig
				, resource	=? "dmenu"		--> doFloat
	       		, resource	=? "gimp"		--> doFloat
				, resource	=? "feh"		--> doFloat
				, resource	=? "steam"		--> doFloat
				, resource	=? "Steam"		--> doFloat
				-- Programming
				, className =? "Eclipse"	--> doFloat
				, title		=? "htop"		--> doShift (myWorkspaces !! 0)
				-- Internet
				, className =? "Firefox"	--> doShift (myWorkspaces !! 1)
				, className =? "Uzbl-core"	--> doShift (myWorkspaces !! 1)
				, className =? "Uzbl-tabbed" --> doShift (myWorkspaces !! 1)
				-- Documents
				, resource	=? "lowriter"	--> doShift (myWorkspaces !! 2)
				-- Media
				, title		=? "ncmpcpp"	--> doShift (myWorkspaces !! 3)
				, title		=? "alsamixer"	--> doShift (myWorkspaces !! 3)
				-- Email & Chat
				, title		=? "mutt"		--> doShift (myWorkspaces !! 4)
				, title		=? "irssi"		--> doShift (myWorkspaces !! 4)
				]

newManageHook = myManageHook <+> manageHook defaultConfig <+> manageDocks 


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
myLogHook h = dynamicLogWithPP (defaultPP
	{
		  ppCurrent		= dzenColor active background . pad
		, ppVisible		= dzenColor inactive background . pad
		, ppHidden		= dzenColor inactive background . pad
		, ppHiddenNoWindows	= dzenColor nowindow background . pad
		, ppWsSep		= ""
		, ppSep			= "  "
		, ppLayout		=  dzenColor inactive  background .
				(\x -> case x of
					"Full"				->	"^i(" ++ myWMIconDir ++ "wm_full.xbm)"
					"Spacing 5 ResizableTall"	->	"^i(" ++ myWMIconDir ++ "wm_tall5.xbm)"
					"ResizableTall"			->	"^i(" ++ myWMIconDir ++ "wm_tall.xbm)"
					"SimplestFloat"			->	"^i(" ++ myWMIconDir ++ "wm_float.xbm)"
					"Circle"			->	"^i(" ++ myWMIconDir ++ "wm_circle.xbm)"
					_				->	"^i(" ++ myWMIconDir ++ "wm_default.xbm)"
				)
		, ppOrder	=  \(ws:l:t:_) -> [ws,l]
		, ppOutput	=   hPutStrLn h
	} )

------------------------------------------------------------------------
-- Startup hook

-- Perform an arbitrary action each time xmonad starts or is restarted
-- with mod-q.  Used by, e.g., XMonad.Layout.PerWorkspace to initialize
-- per-workspace layout choices.
--
-- By default, do nothing.
myStartupHook = return ()

------------------------------------------------------------------------
-- Now run xmonad with all the defaults we set up.

-- Run xmonad with the settings you specify. No need to modify this.
--
main = do
    wallpaper       <- spawnPipe ("feh --bg-scale " ++ myWallpaper)
    dzenStartMenu   <- spawnPipe myStartMenu
    dzenLeftBar     <- spawnPipe myXmonadBar
    dzenRightBar    <- spawnPipe myStatusBar
    xmproc          <- spawnPipe "avant-window-navigator"
    -- A structure containing your configuration settings, overriding
    -- fields in the default config. Any you don't override, will
    -- use the defaults defined in xmonad/XMonad/Config.hs
    --
    -- No need to modify this.
    --
    xmonad $ ewmh gnomeConfig {
      -- simple stuff
        terminal           = myTerminal,
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
        layoutHook         = myLayout,
        manageHook         = insertPosition Below Newer <+> myManageHook,
        handleEventHook    = myEventHook,
        logHook            = myLogHook dzenLeftBar,
        startupHook        = myStartupHook
    }
