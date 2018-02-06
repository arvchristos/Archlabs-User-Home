#!/usr/bin/env bash

BAR_ICON=""
ICON=/usr/share/icons/gnome/32x32/apps/system-software-update.png

while true; do
    updates=$(wc -l <<< "$(checkupdates)")
    if hash notify-send &>/dev/null; then
        if [[ $updates -gt 50 ]]; then
            notify-send -u critical -i $ICON \
                        "You really need to update soon!!" "$updates New package updates"
        elif [[ $updates -gt 25 ]]; then
            notify-send -u normal -i $ICON \
                        "You should update soon" "$updates New package updates"
        elif [[ $updates -gt 2 ]]; then
            notify-send -u low -i $ICON \
                        "$updates New package updates"
        fi
    fi

    while [[ $updates -gt 0 ]]; do
        if [[ $updates -eq 1 ]]; then
            echo "$count Update"
        elif [[ $updates -gt 1 ]]; then
            echo "$updates Updates"
        fi
        sleep 8
        count=$(wc -l <<< "$(checkupdates)")
    done

    while [[ $count -eq 0 ]]; do
        echo $BAR_ICON
        sleep 1200
        count=$(wc -l <<< "$(checkupdates)")
    done
done
