#!/bin/bash
upSeconds="$(cat /proc/uptime | grep -o '^[0-9]\+')"
upMinutes=$((upSeconds/60))
upHoure=$((upMinutes/60))
upDays=$((upHoure/24))

### for Houres ####
gun=$((upDays - 1))
f="$((gun * 24))"
saat="$((upHoure - f - 24))"
###for Minutes####
sa="$((((upHoure-1))*60))"
mi="$((upMinutes - sa - 60))"
#####
if [[ "$upMinutes" -ge 3 ]] && [[ "$upDays" -le 1 ]]; then
     echo  "Ok. up $saat hours,$mi minutes"
elif [[ "$upMinutes" -ge 3 ]] && [[ "$upDays" -ge 1 ]]; then
         echo "Ok. up $upDays days, $saat hours, $mi minutes "
     exit 0
elif [[ "$upMinutes" -le 3 ]]; then
    echo "CRITICAL! VM was rebooted $upMinutes minutes ago."
    exit 2
fi

