function fixwineext
    find ~/.local/share/mime -name "*wine*" -exec rm {} \;
    rm -f "~/.local/share/applications/wine*.desktop"
    update-mime-database ~/.local/share/mime
end
