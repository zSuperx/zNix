BATTERY_DATA=$(upower -e | grep --line-buffered BAT | xargs upower -i)

STATUS=$(echo "$BATTERY_DATA" | grep state | awk '{ print $2 }')

PERCENTAGE_STRING=$(echo "$BATTERY_DATA" | grep percentage | awk '{ print $2 }')
PERCENTAGE="${PERCENTAGE_STRING%\%}"

if [ $STATUS = "charging" ]; then
    ICON="󰂄"
elif [[ $PERCENTAGE -ge 99 ]]; then
    ICON="󰁹"
elif [[ $PERCENTAGE -ge 80 ]]; then
    ICON="󰂁"
elif [[ $PERCENTAGE -ge 50 ]]; then
    ICON="󰁿"
elif [[ $PERCENTAGE -ge 20 ]]; then
    ICON="󰁼"
else
    ICON="󰁺"
fi

echo $ICON $PERCENTAGE%


