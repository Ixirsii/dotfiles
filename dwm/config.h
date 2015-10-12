/* See LICENSE file for copyright and license details. */

#include <X11/XF86keysym.h>
#include "moveresize.c"

/* appearance */
static const char font[]            = "Droid Sans Mono 10";
static const char normbordercolor[] = "#373f4c";
static const char normbgcolor[]     = "#373f4c";
static const char normfgcolor[]     = "#64626d";
static const char selbordercolor[]  = "#373f4c";
static const char selbgcolor[]      = "#373f4c";
static const char selfgcolor[]      = "#86b7df";
static const char floatnormbordercolor[] = "#ffffff";
static const char floatselbordercolor[]  = "#373f4c";
static const unsigned int borderpx  = 1;        /* border pixel of windows */
static const unsigned int gappx     = 5;        /* gap pixel between windows */
static const unsigned int snap      = 5;        /* snap pixel */
static const unsigned int systrayspacing = 3;   /* systray spacing */
static const Bool showsystray       = True;     /* False means no systray */
static const Bool showbar           = True;     /* False means no bar */
static const Bool topbar            = True;     /* False means bottom bar */
static const Bool statusmarkup      = True;     /* True means use pango markup in status message */

/* tagging */
static const char *tags[] = { "Dev", "Web", "Social", "Media" };

static const Rule rules[] = {
	/* class        instance    title       tags mask     isfloating   monitor */
	{ "Chromium",   NULL,       NULL,       1 << 1,       True,        -1 },
	{ "Gimp",       NULL,       NULL,       1 << 3,       True,        -1 },
	{ "Firefox",    NULL,       NULL,       1 << 1,       True,        -1 },
	{ "net-minecraft-bootstrap-Bootstrap", 
                    NULL,       NULL,       1 << 3,       True,        -1 },
	{ "Pwsafe",     NULL,       NULL,       0,            True,        -1 },
	{ "Transmission-gtk",  
                    NULL,       NULL,       1 << 1,       True,        -1 },
	{ "Vlc",        NULL,       NULL,       1 << 3,       True,        -1 },
};

/* layout(s) */
static const float mfact      = 0.50; /* factor of master area size [0.05..0.95] */
static const int nmaster      = 1;    /* number of clients in master area */
static const Bool resizehints = True; /* True means respect size hints in tiled resizals */

static const Layout layouts[] = {
	/* symbol     arrange function */
	{ "[]=",      tile },    /* first entry is default */
	{ "><>",      NULL },    /* no layout function means floating behavior */
	{ "[M]",      monocle },
};

/* key definitions */
#define MODKEY Mod1Mask
#define TAGKEYS(KEY,TAG) \
	{ MODKEY,                       KEY,      view,           {.ui = 1 << TAG} }, \
	{ MODKEY|ControlMask,           KEY,      toggleview,     {.ui = 1 << TAG} }, \
	{ MODKEY|ShiftMask,             KEY,      tag,            {.ui = 1 << TAG} }, \
	{ MODKEY|ControlMask|ShiftMask, KEY,      toggletag,      {.ui = 1 << TAG} },

/* helper for spawning shell commands in the pre dwm-5.0 fashion */
#define SHCMD(cmd) { .v = (const char*[]){ "/bin/sh", "-c", cmd, NULL } }

/* commands */

#define TERMCMD "st"

static const char *armcmd[] = { TERMCMD, "sudo", "-u", "tor", "arm", NULL };
static const char *chromiumcmd[] = { "chromium", NULL };
static const char *brightup[] = { "xbacklight", "-inc", "20", NULL };
static const char *brightdown[] = { "xbacklight", "-dec", "20", NULL };
static const char *dmenucmd[] = { "dmenu_run", "-fn", font, "-nb", normbgcolor, "-nf", normfgcolor, "-sb", selbgcolor, "-sf", selfgcolor, NULL };
static const char *firefoxcmd[] = { "firefox", NULL };
static const char *irssicmd[]   = { TERMCMD, "-e", "usewithtor", "irssi", NULL };
static const char *htopcmd[] = { TERMCMD, "-e", "htop", NULL };
static const char *rangercmd[] = { TERMCMD, "-e", "ranger", NULL };
static const char *rtorrentcmd[] = { TERMCMD, "-e", "tmux", "new-session", "-t", "rtorrent", NULL };
static const char *screenfetchcmd[] = { TERMCMD, "-t", "screenfetch", "-e", "/bin/bash", "-c", "screenfetch; read -s -n 1", NULL };
static const char *surfcmd[] = { "tabbed", "-c", "surf", "-e", NULL };
static const char *termcmd[]  = { TERMCMD, NULL };
static const char *volumedown[] = { "chvol", "down", NULL };
static const char *volumeup[]   = { "chvol", "up", NULL };
static const char *mute[]       = { "chvol", "toggle", NULL };

static Key keys[] = {
	/* modifier                     key         function        argument */
	{ MODKEY,                       XK_b,       togglebar,      {0} },
	{ MODKEY,                       XK_d,       incnmaster,     {.i = -1 } },
	{ MODKEY,                       XK_f,       setlayout,      {.v = &layouts[1]} },
	{ MODKEY,                       XK_h,       setmfact,       {.f = -0.05} },
	{ MODKEY,                       XK_i,       incnmaster,     {.i = +1 } },
	{ MODKEY,                       XK_j,       focusstack,     {.i = +1 } },
	{ MODKEY,                       XK_k,       focusstack,     {.i = -1 } },
	{ MODKEY,                       XK_l,       setmfact,       {.f = +0.05} },
	{ MODKEY,                       XK_m,       setlayout,      {.v = &layouts[2]} },
	{ MODKEY,                       XK_p,       spawn,          {.v = dmenucmd } },
	{ MODKEY,                       XK_t,       setlayout,      {.v = &layouts[0]} },
	{ MODKEY,                       XK_0,       view,           {.ui = ~0 } },
	{ MODKEY,                       XK_comma,   focusmon,       {.i = -1 } },
	{ MODKEY,                       XK_period,  focusmon,       {.i = +1 } },
	{ MODKEY,                       XK_Return,  zoom,           {0} },
	{ MODKEY,                       XK_space,   setlayout,      {0} },
	{ MODKEY,                       XK_Tab,     view,           {0} },
    { MODKEY,                       XK_Down,    moveresize,     {.v = (int []){ 0, 25, 0, 0 }}},
    { MODKEY,                       XK_Up,      moveresize,     {.v = (int []){ 0, -25, 0, 0 }}},
    { MODKEY,                       XK_Right,   moveresize,     {.v = (int []){ 25, 0, 0, 0 }}},
    { MODKEY,                       XK_Left,    moveresize,     {.v = (int []){ -25, 0, 0, 0 }}},
	{ MODKEY|ShiftMask,             XK_a,       spawn,          {.v = armcmd } },
	{ MODKEY|ShiftMask,             XK_g,       spawn,          {.v = screenfetchcmd } },
	{ MODKEY|ShiftMask,             XK_h,       spawn,          {.v = htopcmd } },
	{ MODKEY|ShiftMask,             XK_i,       spawn,          {.v = irssicmd } },
	{ MODKEY|ShiftMask,             XK_r,       spawn,          {.v = rangercmd } },
	{ MODKEY|ShiftMask,             XK_s,       spawn,          {.v = surfcmd } },
	{ MODKEY|ShiftMask,             XK_t,       spawn,          {.v = rtorrentcmd } },
    { MODKEY|ShiftMask,             XK_Down,    moveresize,     {.v = (int []){ 0, 0, 0, 25 }}},
    { MODKEY|ShiftMask,             XK_Up,      moveresize,     {.v = (int []){ 0, 0, 0, -25 }}},
    { MODKEY|ShiftMask,             XK_Right,   moveresize,     {.v = (int []){ 0, 0, 25, 0 }}},
    { MODKEY|ShiftMask,             XK_Left,    moveresize,     {.v = (int []){ 0, 0, -25, 0 }}},
	{ MODKEY|ShiftMask,             XK_c,       killclient,     {0} },
	{ MODKEY|ShiftMask,             XK_0,       tag,            {.ui = ~0 } },
	{ MODKEY|ShiftMask,             XK_comma,   tagmon,         {.i = -1 } },
	{ MODKEY|ShiftMask,             XK_period,  tagmon,         {.i = +1 } },
	{ MODKEY|ShiftMask,             XK_space,   togglefloating, {0} },
	{ MODKEY|ShiftMask,             XK_Return,  spawn,          {.v = termcmd } },
    { MODKEY|ControlMask,           XK_j,       pushdown,       {0} },
    { MODKEY|ControlMask,           XK_k,       pushup,         {0} },
    { 0, XF86XK_AudioLowerVolume,               spawn,          { .v = volumedown } },
    { 0, XF86XK_AudioRaiseVolume,               spawn,          { .v = volumeup } }, 
    { 0, XF86XK_AudioMute,                      spawn,          { .v = mute } },
    { 0, XF86XK_MonBrightnessUp,                spawn,          { .v = brightup } },
    { 0, XF86XK_MonBrightnessDown,              spawn,          { .v = brightdown } },
	TAGKEYS(                        XK_1,                      0)
	TAGKEYS(                        XK_2,                      1)
	TAGKEYS(                        XK_3,                      2)
	TAGKEYS(                        XK_4,                      3)
	TAGKEYS(                        XK_5,                      4)
	TAGKEYS(                        XK_6,                      5)
	TAGKEYS(                        XK_7,                      6)
	TAGKEYS(                        XK_8,                      7)
	TAGKEYS(                        XK_9,                      8)
	{ MODKEY|ShiftMask,             XK_q,      quit,           {0} },
};

/* button definitions */
/* click can be ClkLtSymbol, ClkStatusText, ClkWinTitle, ClkClientWin, or ClkRootWin */
static Button buttons[] = {
	/* click                event mask      button          function        argument */
	{ ClkLtSymbol,          0,              Button1,        setlayout,      {0} },
	{ ClkLtSymbol,          0,              Button3,        setlayout,      {.v = &layouts[2]} },
	{ ClkWinTitle,          0,              Button2,        zoom,           {0} },
	{ ClkStatusText,        0,              Button2,        spawn,          {.v = termcmd } },
	{ ClkClientWin,         MODKEY,         Button1,        movemouse,      {0} },
	{ ClkClientWin,         MODKEY,         Button2,        togglefloating, {0} },
	{ ClkClientWin,         MODKEY,         Button3,        resizemouse,    {0} },
	{ ClkTagBar,            0,              Button1,        view,           {0} },
	{ ClkTagBar,            0,              Button3,        toggleview,     {0} },
	{ ClkTagBar,            MODKEY,         Button1,        tag,            {0} },
	{ ClkTagBar,            MODKEY,         Button3,        toggletag,      {0} },
};

