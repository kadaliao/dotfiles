#!/bin/bash

############################### FOLDER ICONS ###################################

folder="$(pwd)"

# Construct the path for the folder icon
FOLDER_ICON_PATH="$folder/.icon"

if [ -f $FOLDER_ICON_PATH ]; then
    folder_icon="$(cat $FOLDER_ICON_PATH)"
else
    echo "Could not find an .icon file in $folder, using the default icon 📁"
    folder_icon="📁"
fi

# Strip the path and leave the folder name
folder_name="$(basename $folder)"

# Construct the session name
SESSION="$folder_icon  $folder_name"

# Attach to Tmux

if [ -z "$TMUX" ]; then
    # We're not inside Tmux
    echo "Attaching to $SESSION"
    tmux attach-session -d -t "$SESSION" || tmux new-session -s "$SESSION"
else
    # We're inside Tmux
    # if [ -z "$(tmux list-sessions | grep $folder_name -s)" ]; then
    if ! tmux has-session -t "$SESSION" 2>/dev/null; then
        # Create a new dettached session
        echo "Create $SESSION"
        tmux new -ds "$SESSION" 
    fi

    # Switch to the session
    echo "Switch client to $SESSION"
    tmux switch-client -t "$SESSION"
fi
