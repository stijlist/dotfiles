-- My second haskell program: A window manager.
--
-- With a little help from my personal gods, the xmonad dev team:
import XMonad
import XMonad.Hooks.ManageDocks -- (avoidStruts)
import XMonad.Util.EZConfig (additionalKeys)
import XMonad.Config.Xfce
import XMonad.Config.Desktop
import XMonad.Hooks.EwmhDesktops
import XMonad.Actions.CycleWS
import XMonad.Layout.NoBorders
import XMonad.Layout.SimpleDecoration
import XMonad.Layout.NoFrillsDecoration
import XMonad.Layout.Grid
import XMonad.Layout.FixedColumn
import XMonad.Layout.Magnifier
import XMonad.Layout.IM
import XMonad.Layout.Reflect
import XMonad.Layout.PerWorkspace
import XMonad.Layout.ResizableTile
import XMonad.Layout.Dishes
import XMonad.Layout.PerWorkspace
import XMonad.Layout.ThreeColumns
import XMonad.Layout.ToggleLayouts
import XMonad.Layout.LimitWindows
import XMonad.Layout.NoBorders
import XMonad.Util.Themes
import XMonad.Prompt
import XMonad.Prompt.Shell
import XMonad.Actions.RotSlaves
import XMonad.Actions.PerWorkspaceKeys
import qualified XMonad.Actions.FlexibleResize as Flex
import XMonad.Util.Scratchpad
import XMonad.Hooks.ManageHelpers
import qualified XMonad.StackSet as W
import qualified Data.Map as M
import Control.Monad
import Data.Ratio ((%))
import Data.Maybe
import Data.List
-- dzen2 integration
import XMonad.Hooks.DynamicLog

myMod = mod1Mask -- windows key
myTerminal = "urxvtc"
myNormalBorderColor  = "#dddddd"
myFocusedBorderColor = "#ff0000"

myWorkSpaces = ["main", "web", "book", "chat", "misc", "logs", "7", "8", "9"]

myTheme = defaultTheme
	{ activeColor         = blue
	, inactiveColor       = grey
	, activeBorderColor   = myFocusedBorderColor
	, inactiveBorderColor = myNormalBorderColor
	, activeTextColor     = "white"
	, inactiveTextColor   = "black"
	, decoHeight          = 0
	}
	where
		blue = "#4a708b" -- same color used by pager
		grey = "#cccccc"

myXPConfig = defaultXPConfig
	{ fgColor  = "white"
	, bgColor  = "black"
	, promptBorderWidth = 0
	, position = Bottom
	, height   = 25
	}

myLayout = smartBorders $ toggleLayouts Full perWS
	where
		-- Per workspace layout selection.
		perWS =
			onWorkspace "logs" (withTitles $ myLogs dishFirst) $
			onWorkspace "web"  (noTitles   $ noBorders $ (mySplit ||| myWide)) $
			onWorkspace "chat" (noTitles   $ myChat gridFirst) $
			onWorkspace "book" (noTitles   $ myBook) $
			                   (noTitles $ codeFirst)

		-- Modifies a layout to be desktop friendly with title bars
		-- and avoid the panel.
		withTitles l = noFrillsDeco shrinkText myTheme $ desktopLayoutModifiers l
		--withTitles l = desktopLayoutModifiers l

		-- Modifies a layout to be desktop friendly, but with no title bars
		-- and avoid the panel.
		noTitles l = desktopLayoutModifiers l

		-- Each of these allows toggling through a set of layouts
		-- in the same logical order, but from a different starting
		-- point.
		codeFirst = myCode ||| myWide ||| myGrid ||| myDish
		dishFirst = myDish ||| myCode ||| myWide ||| myGrid
		gridFirst = myGrid ||| myDish ||| myCode ||| myWide

		-- This is a tall-like layout with magnification.
		-- The master window is fixed at 80 columns wide, making
		-- this good for coding. Limited to 3 visible windows at
		-- a time to ensure all are a good size.
		myCode = limitWindows 3 $ magnifiercz' 1.4 $
			FixedColumn 1 1 80 10

		-- Stack with one large master window.
		-- It's easy to overflow a stack to the point that windows
		-- are too small, so only show first 5.
		myDish = limitWindows 5 $ Dishes nmaster ratio
			where
				-- default number of windows in the master pane
				nmaster = 1
				-- proportion of screen occupied by other panes
				ratio = 1/5

		-- Wide layout with subwindows at the bottom.
		myWide = Mirror $ Tall nmaster delta ratio
			where
				-- default number of windows in the master pane
				nmaster = 1
				-- Percent of screen to increment by when resizing panes
				delta   = 3/100
				-- proportion of screen occupied by master pane
				ratio   = 80/100

		-- Split screen, optimized for web browsing.
		mySplit = magnifiercz' 1.4 $ Tall nmaster delta ratio
			where
				-- default number of windows in the master pane
				nmaster = 1
				-- Percent of screen to increment by when resizing panes
				delta   = 3/100
				-- proportion of screen occupied by master pane
				ratio   = 60/100

		-- Standard grid.
		myGrid = Grid

		-- The chat workspace has a roster on the right.
		myChat base = mirror base $ withIM size roster
			where
				-- Ratio of screen roster will occupy
				size = 1%5
				-- Match roster window
				roster = Title "Buddy List"

		-- The logs workspace has space for procmeter.
		myLogs base = mirror base $ withIM procmeterSize procmeter
			where
				-- Ratio of screen procmeter will occupy
				procmeterSize = 1%7
				-- Match procmeter
				procmeter = ClassName "ProcMeter3"

		-- For reading books, I typically want borders on 
		-- the margin of the screen.
		myBook = ThreeColMid nmaster delta ratio
			where
				-- default number of windows in the master pane
				nmaster = 1
				-- Percent of screen to increment by when resizing panes
				delta   = 3/100
				-- proportion of screen occupied by master pane
				ratio   = 2/3

		-- Applies a layout mirrored.
		mirror base a = reflectHoriz $ a $ reflectHoriz base

myKeys =
    -- launch a terminal
    [ ((myMod .|. shiftMask, xK_Return), spawn myTerminal)

    -- close focused window
    , ((myMod .|. shiftMask, xK_c     ), kill)

    -- launch dmenu
    , ((myMod,               xK_p     ), spawn "dmenu_run")

    -- launch chromium
    , ((myMod .|. shiftMask, xK_i     ), spawn "chromium")

    --  Reset the layouts on the current workspace to default
    --  , ((myMod .|. shiftMask, xK_space ), setLayout $ XMonad.layoutHook conf)

    -- Resize viewed windows to the correct size
    , ((myMod,               xK_n     ), refresh)

    -- Move focus to the next window
    , ((myMod,               xK_Tab   ), windows W.focusDown)

    -- Move focus to the next window
    , ((myMod,               xK_j     ), windows W.focusDown)

    -- Move focus to the previous window
    , ((myMod,               xK_k     ), windows W.focusUp  )

    -- Move focus to the master window
    , ((myMod,               xK_m     ), windows W.focusMaster  )

    -- Swap the focused window and the master window
    , ((myMod,               xK_Return), windows W.swapMaster)

    -- Swap the focused window with the next window
    , ((myMod .|. shiftMask, xK_j     ), windows W.swapDown  )

    -- Swap the focused window with the previous window
    , ((myMod .|. shiftMask, xK_k     ), windows W.swapUp    )

    -- Shrink the master area
    , ((myMod,               xK_h     ), sendMessage Shrink)

    -- Expand the master area
    , ((myMod,               xK_l     ), sendMessage Expand)

    -- Push window back into tiling
    , ((myMod,               xK_t     ), withFocused $ windows . W.sink)

    -- Increment the number of windows in the master area
    , ((myMod              , xK_comma ), sendMessage (IncMasterN 1))

    -- Deincrement the number of windows in the master area
    , ((myMod              , xK_period), sendMessage (IncMasterN (-1)))

    -- Toggle the status bar gap
    -- Use this binding with avoidStruts from Hooks.ManageDocks.
    -- See also the statusBar function from Hooks.DynamicLog.
    --
    , ((myMod              , xK_b     ), sendMessage ToggleStruts)

    -- Quit xmonad
    -- TODO: figure out why exitWith and ExitSuccess are not in scope
    -- , ((myMod .|. shiftMask, xK_q     ), io (exitWith ExitSuccess))

    -- Restart xmonad
    , ((myMod              , xK_q     ), spawn "xmonad --recompile; xmonad --restart")
    -- Bind skippy-xd, an expose-like app switcher/overview, to mod-x
    , ((myMod              , xK_x     ), spawn "skippy-xd")

	-- the rest of Joey Hess's config starts here
	, ((myMod, xK_a), myToggle)
	, ((myMod, xK_z), shellPrompt myXPConfig)
	-- xfce terminal does not support params the scratchpad needs
	, ((myMod, xK_s), scratchpadSpawnAction myConfig { terminal = "xterm" })
	, ((myMod, xK_Tab), bindOn [("chat", rotSlavesDown), ("", rotAllDown)])
	, ((myMod .|. shiftMask, xK_Tab), bindOn [("chat", rotSlavesUp), ("", rotAllUp)])
	, ((myMod, xK_d), sendMessage $ NextLayout)
	, ((myMod, xK_space), sendMessage $ ToggleLayout)
	]

myManageHook = composeAll
	-- comes first to partially override default gimp floating behavior
	[ gimp "toolbox" --> nofloat
	, gimp "image-window" --> nofloat
	, manageHook xfceConfig
	, doF avoidMaster
	, scratchpadManageHook (W.RationalRect 0.25 0.25 0.5 0.5)
	, resource =? "floatterm" --> doFloat
	-- workaround for <http://code.google.com/p/xmonad/issues/detail?id=228>
	, composeOne [ isFullscreen -?> doFullFloat ]
	]
	where
		gimp win = className =? "Gimp" <&&> fmap (win `isSuffixOf`) role
		role = stringProperty "WM_WINDOW_ROLE"
		nofloat = ask >>= doF . W.sink

-- TODO: de-uglify this log hook; make it look like dwm's
myLogHook = dynamicLog

-- Modified to only operate on floating windows, since I seem to do this by
-- accident to non-floating.
myMouseBindings (XConfig {XMonad.modMask = modMask}) = M.fromList
	-- mod-button1, Move by dragging
	[ ((modMask, button1), (\w -> focus w >> ifFloating w mouseMoveWindow))
	-- mod-button2, Raise the window to the top of the stack
	, ((modMask, button2), (\w -> focus w >> windows W.swapMaster))
	-- mod-button3, Resize by dragging
	, ((modMask, button3), (\w -> focus w >> ifFloating w mouseResizeWindow))
	]
	where
		ifFloating w f = withWindowSet $ \ws ->
			when (M.member w $ W.floating ws) (f w)

myConfig = xfceConfig
	{ manageHook = myManageHook
	, layoutHook = myLayout
	, modMask = myMod
--  TODO: de-uglify this log hook
    , logHook = myLogHook
	, workspaces = myWorkSpaces
	, mouseBindings = myMouseBindings
	, terminal = myTerminal
	, borderWidth = 1
	, normalBorderColor  = inactiveBorderColor myTheme
	, focusedBorderColor = activeBorderColor myTheme
	} `additionalKeys` myKeys

-- main = xmonad myConfig
main = xmonad =<< dzen myConfig

-- Avoid the master window, but otherwise manage new windows normally.
avoidMaster :: W.StackSet i l a s sd -> W.StackSet i l a s sd
avoidMaster = W.modify' $ \c ->
	case c of
		W.Stack t [] (r:rs) -> W.Stack t [r] rs
		_ -> c

-- A version of toggleWS that ignores the scratchPad workspaces.
myToggle = windows $ W.view =<< W.tag . head . filter (notSP . W.tag) . W.hidden
	where
		notSP x = x /= "NSP" && x /= "SP"
