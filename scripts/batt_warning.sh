TOO_LOW=35

battery_level=`acpi -b | grep -P -o '[0-9]+(?=%)'`
if [ $battery_level -le $TOO_LOW -a $(cat "/sys/class/power_supply/AC/online") = 0 ]
then
    notify-send -u critical "Battery low" "Battery level is ${battery_level}%!"
fi

exit 0
