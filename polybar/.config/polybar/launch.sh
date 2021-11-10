#!/usr/bin/env sh

# Terminate already running bar instances
killall -q polybar
killall -q dunst
dunst -conf ~/.dunstrc &

# Wait until the processes have been shut down
while pgrep -x polybar >/dev/null; do sleep 1; done
has_secondary() {
    x="$(xrandr | grep Virtual2 | grep -v disconnected | wc -l)"
    echo $x
    if test $x = "1"; then
        echo "Secondary"
        return 1
    else
        echo "No Secondary"
        return 0
    fi
}
# Launch bar1 and bar2
polybar topbar &
#polybar bottom &
has_secondary
second=$?
if [ "$second" -eq "1" ]; then
    polybar alternatetop &
    bspc monitor Virtual2 -d 1 2 3 4 5 6 7 8 9 0
fi
bspc monitor Virtual1 -d 1 2 3 4 5 6 7 8 9 0
echo "Bars launched..."
