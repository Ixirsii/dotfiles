#!/usr/bin/env bash

function icon_map() {
    case "$1" in
    # ######################################################################## #
    #                                  Apple                                   #
    # ######################################################################## #
    "App Store")
        icon_result=":app_store:"
        ;;
    "Calendar")
        icon_result=":calendar:"
        ;;
    "FaceTime" | "FaceTime 通话")
        icon_result=":face_time:"
        ;;
    "Finder")
        icon_result=":finder:"
        ;;
    "Keynote")
        icon_result=":keynote:"
        ;;
    "Mail")
        icon_result=":mail:"
        ;;
    "Messages")
        icon_result=":messages:"
        ;;
    "Music")
        icon_result=":music:"
        ;;
    "Notes")
        icon_result=":notes:"
        ;;
    "Numbers")
        icon_result=":numbers:"
        ;;
    "Pages")
        icon_result=":pages:"
        ;;
    "Preview")
        icon_result=":preview:"
        ;;
    "Reminders")
        icon_result=":reminders:"
        ;;
    "Safari")
        icon_result=":safari:"
        ;;
    "Spotlight")
        icon_result=":spotlight:"
        ;;
    "System Preferences" | "System Settings" | "系统设置")
        icon_result=":gear:"
        ;;
    "Xcode")
        icon_result=":xcode:"
        ;;
    # ######################################################################## #
    #                                 Browser                                  #
    # ######################################################################## #
    "Chromium" | "Google Chrome" | "Google Chrome Canary")
        icon_result=":google_chrome:"
        ;;
    "Firefox")
        icon_result=":firefox:"
        ;;
    "Helium")
        icon_result=":helium:"
        ;;
    "Tor Browser")
        icon_result=":tor_browser:"
        ;;
    "Zen")
        icon_result=":zen_browser:"
        ;;
    # ######################################################################## #
    #                                  Docker                                  #
    # ######################################################################## #
    "Docker" | "Docker Desktop")
        icon_result=":docker:"
        ;;
    "Orbstack")
        icon_result=":orbstack:"
        ;;
    # ######################################################################## #
    #                                  Email                                   #
    # ######################################################################## #
    "Proton Mail")
        icon_result=":proton_mail:"
        ;;
    # ######################################################################## #
    #                                   IDE                                    #
    # ######################################################################## #
    "Android Studio")
        icon_result=":android_studio:"
        ;;
    "IntelliJ IDEA")
        icon_result=":idea:"
        ;;
    "PyCharm")
        icon_result=":pycharm:"
        ;;
    "WebStorm")
        icon_result=":web_storm:"
        ;;
    "Zed")
        icon_result=":zed:"
        ;;
    # ######################################################################## #
    #                                Microsoft                                 #
    # ######################################################################## #
    "Microsoft Excel")
        icon_result=":microsoft_excel:"
        ;;
    "Microsoft PowerPoint")
        icon_result=":microsoft_power_point:"
        ;;
    "Microsoft Word")
        icon_result=":microsoft_word:"
        ;;
    # ######################################################################## #
    #                                  Music                                   #
    # ######################################################################## #
    "Live")
        icon_result=":ableton:"
        ;;
    "Spotify")
        icon_result=":spotify:"
        ;;
    # ######################################################################## #
    #                                  Photos                                  #
    # ######################################################################## #
    "GIMP")
        icon_result=":gimp:"
        ;;
    "Inkscape")
        icon_result=":inkscape:"
        ;;
    # ######################################################################## #
    #                                  Social                                  #
    # ######################################################################## #
    "Discord" | "Discord Canary" | "Discord PTB" | "Legcord")
        icon_result=":discord:"
        ;;
    "Signal")
        icon_result=":signal:"
        ;;
    "zoom.us")
        icon_result=":zoom:"
        ;;
    # ######################################################################## #
    #                                 Terminal                                 #
    # ######################################################################## #
    "Ghostty")
        icon_result=":ghostty:"
        ;;
    "Terminal" | "iTerm2" | "kitty")
        icon_result=":terminal:"
        ;;
    "WezTerm")
        icon_result=":wezterm:"
        ;;
    # ######################################################################## #
    #                               Text editor                                #
    # ######################################################################## #
    "Obsidian")
        icon_result=":obsidian:"
        ;;
    "Sublime Text")
        icon_result=":sublime_text:"
        ;;
    # ######################################################################## #
    #                                   VPN                                    #
    # ######################################################################## #
    "Proton VPN")
        icon_result=":proton_vpn:"
        ;;
    # ######################################################################## #
    #                                 Default                                  #
    # ######################################################################## #
    "Default" | *)
        icon_result=":default:"
        ;;
    esac

    echo "$icon_result"
}
