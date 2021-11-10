function resizedisplay
xrandr --output (xrandr | grep primary | awk '{print $1}') --auto
end
