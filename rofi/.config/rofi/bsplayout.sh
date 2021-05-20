#!/usr/bin/env bash

if [ $# -eq 0 ]; then
    mapfile -t choices < <(bsp-layout layouts)
    choices+=( "clear" )
    printf '%s\n' "${choices[@]}"
else
    case $1 in
        clear)
            bsp-layout remove
        ;;
        tall|rtall)
            bsp-layout set $1 -- --master-size 0.7
        ;;
        *)
            bsp-layout set $1 --
        ;;
    esac
    killall rofi
fi
exit
