#!/usr/bin/env zsh

# Source .zshrc if exists
[[ -f ~/.zshrc ]] && source ~/.zshrc

############################### FOLDER ICONS ###################################

# Disable logging for now
#exec 1>/dev/null
#exec 2>&1

folder="$(pwd)"
FOLDER_ICON_PATH="$folder/.icon"

# Read folder icon from .icon file, or use default icon
if [[ -f "$FOLDER_ICON_PATH" ]]; then
    folder_icon="$(cat "$FOLDER_ICON_PATH")"
else
    echo "Could not find an .icon file in '$folder', using the default icon 📁"
    folder_icon="📁"
fi

# Get the folder name and construct the session name
folder_name="$(basename "$folder")"
SESSION="$folder_icon  $folder_name"

# Attach to Tmux
if [[ -z "$TMUX" ]]; then
    # We're not inside Tmux
    echo "Attach to $SESSION"
    tmux attach-session -d -t "$SESSION" || tmux new-session -s "$SESSION"
else
    # We're inside Tmux
    if ! tmux has-session -t "$SESSION" &>/dev/null; then
        # Create a new detached session
        echo "Create $SESSION"
        tmux new -ds "$SESSION"
    fi

    # Switch to the session
    if tmux switch-client -t "$SESSION"; then
        echo "Switch client to $SESSION"
    else
        echo "Switch client to $SESSION failed"
        echo "Then Attach session to $SESSION"
        tmux attach-session -t "$SESSION"
    fi
fi

