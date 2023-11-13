#!/usr/bin/env bash

# Inspired by dotfiles from olimorris
# https://github.com/olimorris/dotfiles

main() {
    ####
    # COLOR PALETTE
    # Based on Snazzy: https://github.com/sindresorhus/hyper-snazzy
    local color_green="#5af78e"
    local color_yellow="#f3f99d"
    local color_red="#ff5c57"
    local color_blue="#57c7ff"
    local color_cyan="#9aedfe"
    local color_magenta="#ff6ac1"
    local color_gray="#5c6370"
    local color_white="#f1f1f0"

    local color_fg="#eff0eb"
    local color_bg="#282a36"
    local color_buffer="#939aa3"
    local color_border="#222430"
    local color_cursor="#97979b"
    local color_selection="#97979b"


    ####
    # PLUGINS
    tmux set -g @mode_indicator_prefix_prompt " PREFIX "
    tmux set -g @mode_indicator_prefix_mode_style bg="$color_yellow,fg=$color_bg",bold
    tmux set -g @mode_indicator_copy_prompt "  COPY  "
    tmux set -g @mode_indicator_copy_mode_style bg="$color_magenta,fg=$color_bg",bold
    tmux set -g @mode_indicator_sync_prompt "  SYNC  "
    tmux set -g @mode_indicator_sync_mode_style bg="$color_red,fg=$color_bg",bold
    tmux set -g @mode_indicator_empty_prompt "  TMUX  "
    tmux set -g @mode_indicator_empty_mode_style bg="$color_blue,fg=$color_bg",bold

    ## tmux cpu
    tmux set -g @cpu_percentage_format "CPU: %2.0f%%"
    tmux set -g @cpu_low_fg_color "#[fg=$color_green]"
    tmux set -g @cpu_medium_fg_color "#[fg=$color_yellow]"
    tmux set -g @cpu_high_fg_color "#[fg=$color_red]"

    tmux set -g @ram_percentage_format "MEM: %2.0f%%"
    tmux set -g @ram_low_fg_color "#[fg=$color_green]"
    tmux set -g @ram_medium_fg_color "#[fg=$color_yellow]"
    tmux set -g @ram_high_fg_color "#[fg=$color_red]"

    tmux set -g @cpu_medium_thresh "30"
    tmux set -g @cpu_high_thresh "80"

    tmux set -g @ram_medium_thresh "30"
    tmux set -g @ram_high_thresh "80"

    ## tmux-pomodoro
    #tmux set -g @pomodoro_on " #[fg=$color_gray] "
    #tmux set -g @pomodoro_complete " #[fg=$color_green] "
    #tmux set -g @pomodoro_ask_break " #[fg=$color_gray] break?"

    ###
    # OPTIONS
    tmux set -g status on
    tmux set -g status-justify left
    tmux set -g status-position bottom
    tmux set -g status-left-length 100
    tmux set -g status-right-length 100
    tmux set -g status-style "bg=$color_bg,fg=$color_fg"

    tmux set -g pane-active-border fg="$color_selection"
    tmux set -g pane-border-style fg="$color_border"

    tmux set -g message-style "bg=$color_blue,fg=$color_bg"
    tmux setw -g window-status-separator "  "
    tmux set-window-option -g mode-style bg="$color_magenta,fg=$color_bg"

    ###
    # FORMAT
    tmux set -g status-left "#{tmux_mode_indicator}#[bg=$color_bg] #S #[bg=$color_cyan,fg=$color_bg]#{simple_git_status}#[default]#[fg=$color_gray]#{pomodoro_status} "
    tmux set -g status-right "#[fg=$color_gray]#{ram_percentage} | #{cpu_percentage} | Session interval: #{continuum_status} "
    tmux setw -g window-status-format "#[fg=$color_gray]#I: #[noitalics]#W"
    tmux setw -g window-status-current-format "#[fg=$color_magenta]#I: #[fg=$color_buffer,noitalics,bold]#W"
}

main
