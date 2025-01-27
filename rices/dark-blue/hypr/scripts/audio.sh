# Toggle between HDMI and built-in output

export SINKS=$(wpctl status -k | rg Sinks: -A 2 -m 1 | tail -n +2 | cut -c 7-)
echo "Available Sinks"
echo "$SINKS"

export NEW_SINK_ID=$(echo "$SINKS" | rg -v "\*" | cut -c 4-6)
echo "Switching to sink $NEW_SINK_ID"

wpctl set-default "$NEW_SINK_ID"

wpctl set-volume @DEFAULT_SOURCE@ 30%
