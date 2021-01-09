#!/usr/bin/env bash

battery=BAT0
voltage=$(cat /sys/class/power_supply/$battery/voltage_now)
current=$(cat /sys/class/power_supply/$battery/current_now)

voltage=$(($voltage / 1000))
current=$(($current / 1000))


printf "%.2f W\n" "$(($voltage * $current))e-6"





