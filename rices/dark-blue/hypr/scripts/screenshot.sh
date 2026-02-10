export MODE=$1
export OLD_WORKSPACE=$(hyprctl activeworkspace -j | jq .id)

if [[ "$MODE" = "output" ]] then
    if [[ "$(hyprctl monitors -j | jq length)" -eq "1" ]] then
        export MODE="screen"
    fi
fi

grimblast \
    --notify --freeze copysave \
    $MODE \
    ~/Pictures/Screenshots/$(date +"Screenshot-%F-%H-%M-%S.png")

if [[ "$(hyprctl monitors -j | jq length)" -eq "1" ]] then
    hyprctl dispatch workspace $OLD_WORKSPACE
fi
