# -*- coding: utf-8 -*-
import os
import re
import socket
import subprocess
from libqtile import qtile
from libqtile.config import Click, Drag, Group, KeyChord, Key, Match, Screen
from libqtile.command import lazy
from libqtile import layout, bar, widget, hook
from libqtile.lazy import lazy
from typing import List  # noqa: F401

mod = "mod4"                             # Sets mod key to SUPER/WINDOWS
myTerm = "alacritty"                     # My terminal of choice

FONTSIZE = 15
SCREEN_SIZE = 25

keys = [
    # The essentials
    Key([mod], "Return", lazy.spawn(myTerm), desc='Launches My Terminal'),
    Key([mod], "space",
        # lazy.spawn("dmenu_run -p 'Run: '"),
        lazy.spawn("rofi -combi-modi window,drun,ssh -theme solarized -font 'hack 15' -show combi -icon-theme 'Papirus' -show-icons"),
        desc='Run Launcher'
        ),
    Key([mod], "Tab", lazy.next_layout(), desc='Toggle through layouts'),
    Key([mod], "q", lazy.window.kill(), desc='Kill active window'),
    Key([mod, "shift"], "r", lazy.restart(), desc='Restart Qtile'),
    Key([mod, "shift"], "Escape", lazy.shutdown(), desc='Shutdown Qtile'),
    # Switch focus to specific monitor (out of three)
    Key([mod], "w", lazy.to_screen(0), desc='Keyboard focus to monitor 1'),
    Key([mod], "e", lazy.to_screen(1), desc='Keyboard focus to monitor 2'),
    # Switch focus of monitors
    Key([mod], "period", lazy.next_screen(), desc='Move focus to next monitor'),
    Key([mod], "comma", lazy.prev_screen(), desc='Move focus to prev monitor'),
    # Switch between windows
    Key([mod], "h", lazy.layout.left(), desc="Move focus to left"),
    Key([mod], "l", lazy.layout.right(), desc="Move focus to right"),
    Key([mod], "j", lazy.layout.down(), desc="Move focus down"),
    Key([mod], "k", lazy.layout.up(), desc="Move focus up"),

    # Move windows between left/right columns or move up/down in current stack.
    # Moving out of range in Columns layout will create new column.
    Key([mod, "shift"], "h", lazy.layout.shuffle_left(),
        desc="Move window to the left"),
    Key([mod, "shift"], "l", lazy.layout.shuffle_right(),
        desc="Move window to the right"),
    Key([mod, "shift"], "j", lazy.layout.shuffle_down(),
        desc="Move window down"),
    Key([mod, "shift"], "k", lazy.layout.shuffle_up(), desc="Move window up"),

    # Grow windows. If current window is on the edge of screen and direction
    # will be to screen edge - window would shrink.
    Key([mod, "control"], "h", lazy.layout.grow_left(),
        desc="Grow window to the left"),
    Key([mod, "control"], "l", lazy.layout.grow_right(),
        desc="Grow window to the right"),
    Key([mod, "control"], "j", lazy.layout.grow_down(),
        desc="Grow window down"),
    Key([mod, "control"], "k", lazy.layout.grow_up(), desc="Grow window up"),
    Key([mod, "mod1"], "h", lazy.layout.shrink(),
        lazy.layout.decrease_nmaster(),
        desc='Shrink window (MonadTall), decrease number in master pane (Tile)'
        ),
    Key([mod, "mod1"], "l",
        lazy.layout.grow(),
        lazy.layout.increase_nmaster(),
        desc='Expand window (MonadTall), increase number in master pane (Tile)'
        ),
    Key([mod], "n", lazy.layout.normalize(), desc="Reset all window sizes"),
    Key([mod], "m", lazy.layout.maximize(),
        desc='toggle window between minimum and maximum sizes'),
    Key([mod, "shift"], "f", lazy.window.toggle_floating(),
        desc='toggle floating'),
    Key([mod], "f", lazy.window.toggle_fullscreen(),
        desc='toggle fullscreen'),
    # Stack controls
    Key([mod, "shift"], "Tab", lazy.layout.rotate(), lazy.layout.flip(),
        desc='Switch which side main pane occupies (XmonadTall)'),
    Key([mod, "shift"], "space", lazy.layout.toggle_split(),
        desc='Toggle between split and unsplit sides of stack'),

    # volume control with PulseAudio
    Key([], "XF86AudioRaiseVolume",
        lazy.spawn("pactl set-sink-volume @DEFAULT_SINK@ +5%"),
        desc='raise volume'),
    Key([], "XF86AudioLowerVolume",
        lazy.spawn("pactl set-sink-volume @DEFAULT_SINK@ -5%"),
        desc='lower volume'),
    Key([], "XF86AudioMute",
        lazy.spawn("pactl set-sink-mute @DEFAULT_SINK@ toggle"),
        desc='toggle mute'),
    Key([], "XF86AudioMicMute",
        lazy.spawn("pactl set-source-mute @DEFAULT_SOURCE@ toggle"),
        desc='toggle mic mute'),

    # Media player controls
    Key([], "XF86AudioPlay",
        lazy.spawn("playerctl -p 'spotify,%any' play-pause"),
        desc='play-pause'),
    Key([], "XF86AudioNext",
        lazy.spawn("playerctl next"),
        desc='play next'),
    Key([], "XF86AudioPrev",
        lazy.spawn("playerctl previous"),
        desc='play previous'),

    # brightness control
    Key([], "XF86MonBrightnessUp",
        lazy.spawn("xbacklight -inc 5"),
        desc='increase brightness'),
    Key([], "XF86MonBrightnessDown",
        lazy.spawn("xbacklight -dec 5"),
        desc='decrease brightness'),

    # calculator
    Key([], "XF86Calculator",
        lazy.spawn("qalculate-gtk"),
        desc='calculator'),

    # screenshot control with scrot
    Key([], "Print",
        lazy.spawn("scrot /home/yueting/screenshots/%Y-%m-%d_%T.png"),
        desc='take screenshot of the whole window'),
    Key([mod], "Print",
        lazy.spawn("scrot -s /home/yueting/screenshots/%Y-%m-%d_%T.png"),
        desc='take screenshot of selected rectangle'),
    Key([mod, 'shift'], "Print",
        lazy.spawn("scrot -u /home/yueting/screenshots/%Y-%m-%d_%T.png"),
        desc='take screenshot of currently focused window'),
    # Emacs programs launched using the key chord CTRL+e followed by 'key'
        # KeyChord(["control"],"e", [
        #     Key([], "e",
        #         lazy.spawn("emacsclient -c -a 'emacs'"),
        #         desc='Launch Emacs'
        #         ),
        #     Key([], "v",
        #         lazy.spawn("emacsclient -c -a 'emacs' --eval '(+vterm/here nil)'"),
        #         desc='Launch vterm inside Emacs'
        #         )
        # ]),
]

group_names = [("DEV", {'layout': 'monadtall'}),
               ("WWW", {'layout': 'monadtall'}),
               ("DOC", {'layout': 'monadtall'}),
               ("4", {'layout': 'monadtall'}),
               ("5", {'layout': 'monadtall'}),
               ("6", {'layout': 'monadtall'}),
               ("7", {'layout': 'monadtall'}),
               ("8", {'layout': 'monadtall'}),
               ("9", {'layout': 'monadtall'}),
               ("0", {'layout': 'monadtall'})]

groups = [Group(name, **kwargs) for name, kwargs in group_names]

for i, (name, kwargs) in enumerate(group_names, 1):
    i %= 10
    keys.append(Key([mod], str(i), lazy.group[name].toscreen()))        # Switch to another group
    keys.append(Key([mod, "shift"], str(i), lazy.window.togroup(name))) # Send current window to another group

layout_theme = {"border_width": 2,
                "margin": 8,
                "border_focus": "e1acff",
                "border_normal": "1D2330"
                }

layouts = [
    # layout.MonadWide(**layout_theme),
    layout.Bsp(**layout_theme),
    # layout.Stack(stacks=2, **layout_theme),
    # layout.Columns(**layout_theme),
    # layout.RatioTile(**layout_theme),
    # layout.Tile(shift_windows=True, **layout_theme),
    # layout.VerticalTile(**layout_theme),
    # layout.Matrix(**layout_theme),
    # layout.Zoomy(**layout_theme),
    layout.MonadTall(**layout_theme),
    layout.Max(**layout_theme),
   # layout.Stack(num_stacks=2),
   # layout.RatioTile(**layout_theme),
   # layout.TreeTab(
   #      font = "Ubuntu",
   #      fontsize = 10,
   #      sections = ["FIRST", "SECOND", "THIRD", "FOURTH"],
   #      section_fontsize = 10,
   #      border_width = 2,
   #      bg_color = "1c1f24",
   #      active_bg = "c678dd",
   #      active_fg = "000000",
   #      inactive_bg = "a9a1e1",
   #      inactive_fg = "1c1f24",
   #      padding_left = 0,
   #      padding_x = 0,
   #      padding_y = 5,
   #      section_top = 10,
   #      section_bottom = 20,
   #      level_shift = 8,
   #      vspace = 3,
   #      panel_width = 200
   #      ),
   # layout.Floating(**layout_theme)
]

colors = [["#282c34", "#282c34"],  # panel background
          ["#3d3f4b", "#434758"],  # background for current screen tab
          ["#ffffff", "#ffffff"],  # font color for group names
          ["#ff5555", "#ff5555"],  # border line color for current tab
          ["#74438f", "#74438f"],  # border line color for 'other tabs' and color for 'odd widgets'
          ["#4f76c7", "#4f76c7"],  # color for the 'even widgets'
          ["#e1acff", "#e1acff"],  # window name
          ["#ecbbfb", "#ecbbfb"]]  # backbround for inactive screens

prompt = "{0}@{1}: ".format(os.environ["USER"], socket.gethostname())

# DEFAULT WIDGET SETTINGS #####
widget_defaults = dict(
    font="Ubuntu Mono",
    fontsize=FONTSIZE,
    padding=2,
    background=colors[2]
)
extension_defaults = widget_defaults.copy()


def init_widgets_list(fontsize=None):
    fontsize = fontsize or FONTSIZE
    widgets_list = [
        # widget.Sep(
        #          linewidth=0,
        #          padding=6,
        #          foreground=colors[2],
        #          background=colors[0]
        #          ),
        widget.Image(
                 filename="~/.config/qtile/icons/arch_icon.svg",
                 background=colors[0],
                 scale=True,
                 mouse_callbacks={'Button1': lambda: qtile.cmd_spawn(myTerm)}
                 ),
        # widget.Sep(
        #          linewidth=1,
        #          padding=6,
        #          foreground=colors[2],
        #          background=colors[0]
        #          ),
        widget.GroupBox(
                 font="Ubuntu Bold",
                 fontsize=fontsize,
                 margin_y=3,
                 margin_x=0,
                 padding_y=5,
                 padding_x=3,
                 borderwidth=3,
                 active=colors[2],
                 inactive=colors[7],
                 rounded=False,
                 highlight_color=colors[1],
                 highlight_method="line",
                 this_current_screen_border=colors[6],
                 this_screen_border=colors[4],
                 other_current_screen_border=colors[6],
                 other_screen_border=colors[4],
                 foreground=colors[2],
                 background=colors[0]
                 ),
        # widget.Prompt(
        #          prompt=prompt,
        #          font="Ubuntu Mono",
        #          padding=3,
        #          foreground=colors[4],
        #          background=colors[0]
        #          ),
        widget.Sep(
                 linewidth=1,
                 padding=10,
                 foreground=colors[2],
                 background=colors[0]
                 ),
        widget.CurrentLayoutIcon(
                 custom_icon_paths=[os.path.expanduser("~/.config/qtile/icons")],
                 foreground=colors[0],
                 background=colors[4],
                 padding=0,
                 scale=0.7
                 ),
        widget.CurrentLayout(
                 foreground=colors[2],
                 background=colors[4],
                 padding=5
                 ),
        widget.Sep(
                 linewidth=1,
                 padding=10,
                 foreground=colors[2],
                 background=colors[0]
                 ),
        widget.WindowName(
                 foreground=colors[6],
                 background=colors[0],
                 fontsize=int(fontsize*1.2),
                 padding=0
                 ),
        # widget.Sep(
        #          linewidth=1,
        #          padding=10,
        #          foreground=colors[2],
        #          background=colors[0]
        #          ),
        #  widget.TextBox(
        #           text = '',
        #           foreground = colors[4],
        #           background = colors[0],
        #           padding = 0,
        #           fontsize = 37
        #           ),
        widget.Net(
                  interface=None,
                  format='{down} ↓↑ {up}',
                  foreground=colors[2],
                  background=colors[0],
                  padding=5
                  ),
        widget.Sep(
                 linewidth=1,
                 padding=10,
                 foreground=colors[2],
                 background=colors[0]
                 ),
        #widget.TextBox(
        #         text='',
        #         foreground=colors[4],
        #         background=colors[0],
        #         padding=0,
        #         fontsize=fontsize
        #         ),
        widget.DF(
                 padding=2,
                 visible_on_warn=False,
                 warn_space=20,
                 foreground=colors[2],
                 background=colors[0],
                 fontsize=fontsize
                 ),
        widget.Sep(
                 linewidth=1,
                 padding=10,
                 foreground=colors[2],
                 background=colors[0]
                 ),
        #widget.TextBox(
        #         text='',
        #         foreground=colors[5],
        #         background=colors[4],
        #         padding=0,
        #         fontsize=fontsize
        #         ),
        widget.Battery(
                 padding=2,
                 foreground=colors[2],
                 background=colors[0],
                 fontsize=fontsize
                 ),
        widget.Sep(
                 linewidth=1,
                 padding=10,
                 foreground=colors[2],
                 background=colors[0]
                 ),
        widget.ThermalSensor(
                 foreground=colors[2],
                 background=colors[0],
                 threshold=90,
                 tag_sensor='Package id 0',
                 padding=5
                 ),
        # widget.TextBox(
        #          text='',
        #          background=colors[5],
        #          foreground=colors[4],
        #          padding=0,
        #          fontsize=fontsize
        #          ),
        widget.Sep(
                 linewidth=1,
                 padding=10,
                 foreground=colors[2],
                 background=colors[0]
                 ),
        widget.TextBox(
                 text=" ⟳",
                 padding=2,
                 foreground=colors[5],
                 background=colors[0],
                 fontsize=fontsize
                 ),
        widget.CheckUpdates(
                 update_interval=60,
                 distro="Arch_checkupdates",
                 display_format="{updates} Updates",
                 foreground=colors[2],
                 mouse_callbacks={'Button1': lambda: qtile.cmd_spawn(myTerm + ' -e sudo pacman -Syu')},
                 background=colors[0]
                 ),
        widget.Sep(
                 linewidth=1,
                 padding=10,
                 foreground=colors[2],
                 background=colors[0]
                 ),
        # widget.TextBox(
        #          text='',
        #          background=colors[4],
        #          foreground=colors[5],
        #          padding=0,
        #          fontsize=fontsize
        #          ),
        widget.TextBox(
                 text=" 🖬",
                 foreground=colors[6],
                 background=colors[0],
                 padding=0,
                 fontsize=fontsize
                 ),
        widget.Memory(
                 foreground=colors[2],
                 background=colors[0],
                 mouse_callbacks={'Button1': lambda: qtile.cmd_spawn(myTerm + '-e htop')},
                 padding=5
                 ),
        widget.Sep(
                 linewidth=1,
                 padding=10,
                 foreground=colors[2],
                 background=colors[0]
                 ),
        # widget.TextBox(
        #          text='',
        #          background=colors[5],
        #          foreground=colors[4],
        #          padding=0,
        #          fontsize=fontsize
        #          ),
        widget.TextBox(
                 text=" ₿",
                 padding=0,
                 foreground=colors[2],
                 background=colors[0],
                 fontsize=fontsize
                 ),
        widget.CPUGraph(
                 foreground=colors[2],
                 background=colors[0]
                 ),
        widget.Sep(
                 linewidth=1,
                 padding=10,
                 foreground=colors[2],
                 background=colors[0]
                 ),
        # widget.TextBox(
        #          text='',
        #          background=colors[4],
        #          foreground=colors[5],
        #          padding=0,
        #          fontsize=fontsize
        #          ),
        widget.TextBox(
                text=" Vol:",
                foreground=colors[2],
                background=colors[0],
                padding=0
                ),
        widget.Volume(
                 foreground=colors[2],
                 background=colors[0],
                 padding=5
                 ),
        widget.Sep(
                 linewidth=1,
                 padding=10,
                 foreground=colors[2],
                 background=colors[0]
                 ),
        # widget.TextBox(
        #          text='',
        #          background=colors[5],
        #          foreground=colors[4],
        #          padding=0,
        #          fontsize=fontsize
        #          ),
        # widget.TextBox(
        #          text='',
        #          background=colors[4],
        #          foreground=colors[5],
        #          padding=0,
        #          fontsize=fontsize
        #          ),
        widget.Clock(
                 foreground=colors[2],
                 background=colors[0],
                 format="%A, %B %d - %H:%M:%S"
                 ),
        widget.Sep(
                 linewidth=1,
                 padding=10,
                 foreground=colors[2],
                 background=colors[0]
                 ),
        widget.Systray(
                 # foreground=colors[2],
                 background=colors[0],
                 padding=5
                 ),
        ]
    return widgets_list


def check_num_monitors():
    connected_monitors = subprocess.run(
        "xrandr | grep -w 'connected' | wc -l",
        shell=True,
        stdout=subprocess.PIPE
    ).stdout.decode("UTF-8").split("\n")[0]
    return int(connected_monitors)


def init_screens():
    screen_with_systray = Screen(
        top=bar.Bar(widgets=init_widgets_list(), opacity=1.0, size=SCREEN_SIZE)
    )
    screen_without_systray = Screen(
        top=bar.Bar(widgets=init_widgets_list()[:-1], opacity=1.0, size=SCREEN_SIZE)
    )
    screens = [screen_with_systray]
    num_monitors = check_num_monitors()
    if num_monitors == 2:
        screens = [screen_without_systray, screen_with_systray]
    elif num_monitors > 2:
        for _ in range(num_monitors-1):
            screens.append(screen_without_systray)
    return screens


#if __name__ in ["config", "__main__"]:
screens = init_screens()
#    widgets_list = init_widgets_list()
#    widgets_screen1 = init_widgets_screen1()
#    widgets_screen2 = init_widgets_screen2()


def window_to_prev_group(qtile):
    if qtile.currentWindow is not None:
        i = qtile.groups.index(qtile.currentGroup)
        qtile.currentWindow.togroup(qtile.groups[i - 1].name)

def window_to_next_group(qtile):
    if qtile.currentWindow is not None:
        i = qtile.groups.index(qtile.currentGroup)
        qtile.currentWindow.togroup(qtile.groups[i + 1].name)

def window_to_previous_screen(qtile):
    i = qtile.screens.index(qtile.current_screen)
    if i != 0:
        group = qtile.screens[i - 1].group.name
        qtile.current_window.togroup(group)

def window_to_next_screen(qtile):
    i = qtile.screens.index(qtile.current_screen)
    if i + 1 != len(qtile.screens):
        group = qtile.screens[i + 1].group.name
        qtile.current_window.togroup(group)

def switch_screens(qtile):
    i = qtile.screens.index(qtile.current_screen)
    group = qtile.screens[i - 1].group
    qtile.current_screen.set_group(group)

mouse = [
    Drag([mod], "Button1", lazy.window.set_position_floating(),
         start=lazy.window.get_position()),
    Drag([mod], "Button3", lazy.window.set_size_floating(),
         start=lazy.window.get_size()),
    Click([mod], "Button2", lazy.window.bring_to_front())
]

dgroups_key_binder = None
dgroups_app_rules = []  # type: List
main = None
follow_mouse_focus = True
bring_front_click = False
cursor_warp = False

floating_layout = layout.Floating(float_rules=[
    # Run the utility of `xprop` to see the wm class and name of an X client.
    # default_float_rules include: utility, notification, toolbar, splash, dialog,
    # file_progress, confirm, download and error.
    *layout.Floating.default_float_rules,
    Match(title='Confirmation'),      # tastyworks exit box
    Match(title='Qalculate!'),        # qalculate-gtk
    Match(wm_class='kdenlive'),       # kdenlive
    Match(wm_class='pinentry-gtk-2'), # GPG key password entry
])
auto_fullscreen = True
focus_on_window_activation = "smart"

#@hook.subscribe.startup_once
#def start_once():
#    home = os.path.expanduser('~')
#    subprocess.call([home + '/.config/autostart.sh'])

# XXX: Gasp! We're lying here. In fact, nobody really uses or cares about this
# string besides java UI toolkits; you can see several discussions on the
# mailing lists, GitHub issues, and other WM documentation that suggest setting
# this string if your java app doesn't work correctly. We may as well just lie
# and say that we're a working one by default.
#
# We choose LG3D to maximize irony: it is a 3D non-reparenting WM written in
# java that happens to be on java's whitelist.
wmname = "LG3D"
