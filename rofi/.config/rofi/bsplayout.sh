#!/usr/bin/env bash

if [ $# -eq 0 ]; then
    mapfile -t choices < <(bsp-layout layouts)
    choices+=( "clear" )
    printf '%s\n' "${choices[@]}"
else
    $desktop=$(bspc query -D -d focused --names)
    case $1 in
        clear)
            bsp-layout remove
        ;;
        tall|rtall)
            bsp-layout set $1 $desktop --master-size 0.7
        ;;
        *)
            bsp-layout set $1 $desktop
        ;;
    esac
    killall rofi
fi
exit
