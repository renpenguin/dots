if [ $# -eq 0 ]
  then
    echo "Following player"
    playerctl status --format '{{ playerName }}' --follow > /tmp/player-last
else
    echo "Passing arguments to playerctl"
    playerctl -p $(tail -1 /tmp/player-last) $@
fi

