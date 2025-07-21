upower -e | grep --line-buffered BAT | head -n 1 | xargs upower -i | grep percentage | awk '{ print $2 }' | sed 's/%//g'
