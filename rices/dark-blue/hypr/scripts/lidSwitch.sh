if [[ "$1" = "close" ]] then
    # Lock if no monitors connected
    if [[ "$(hyprctl monitors -j | jq length)" -eq "1" ]] then
        systemctl suspend
        hyprlock
    else
        hyprctl keyword monitor "eDP-1, disable"
    fi
else
    # Undo monitor disable
    if [[ "$(hyprctl monitors -j | jq length)" -ne "1" ]]; then
        hyprctl reload
    fi
fi
