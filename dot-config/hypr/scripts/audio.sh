# Toggle between HDMI and built-in output

export CARD=$(pactl list cards short | grep pci | head -n 1 | awk '{print $2}')

export audioSetting=$(pactl info | grep "^Default Sink" | cut -d'.' -f4)
export monitorsLen=$(hyprctl monitors -j | jq 'length')
if [ "$audioSetting" = "analog-stereo" ] && (( monitorsLen > 1 )); then
    pactl set-card-profile $CARD output:hdmi-stereo+input:analog-stereo
else
    pactl set-card-profile $CARD output:analog-stereo+input:analog-stereo
fi

pactl set-source-volume @DEFAULT_SOURCE@ 30%
