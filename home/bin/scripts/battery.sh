# TEMPORARY. FIX TO USE A BETTER SCRIPT METHOD
BATTERY=$(upower -e | head -n 1)
STATUS=$(upower -i $BATTERY)
PERCENTAGE=$(printf "%s" "$STATUS" | grep percentage | awk '{ print $2 }')
IS_CHARGING=$(printf "%s" "$STATUS" | grep -Pq 'state:\s+charging' && echo '')
echo $IS_CHARGING $PERCENTAGE
