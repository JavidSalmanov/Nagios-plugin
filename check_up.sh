#!/usr/local/bin/bash
#
if uptime |grep -q 'day' && ! uptime |grep -q 'min'; then
day="$(uptime | grep -ohe 'up .*' | sed 's/,//g' | awk '{ print $2}')"
hour="$(uptime | grep -ohe 'up .*' | sed 's/,//g' | awk '{ print $4 }'|cut -d":" -f1)"
minute="$(uptime | grep -ohe 'up .*' | sed 's/,//g' | awk '{ print $4 }'|cut -d":" -f2)"
echo "Ok. up $day days, $hour houres, $minute minutes "
#
elif uptime |grep -q 'day' && uptime |grep -q 'min'; then
day1="$(uptime | grep -ohe 'up .*' | sed 's/,//g' | awk '{ print $2}')"
minute1="$(uptime | grep -ohe 'up .*' | sed 's/,//g' | awk '{ print $4 }')"
echo "Ok. up $day1 days, $minute1 minutes "
#
elif uptime |grep -q 'min'; then
m="$(uptime | cut -d " " -f4)"
if [[ "$m" -ge 3 ]] ; then
echo "OK. up $m minutes"
exit 0
else
echo "CRITICAL! VM was rebooted $m minutes ago."
exit 2
fi
#
else
h="$(uptime | cut -d " " -f5 | cut -d "," -f1 |cut -d ":" -f1)"
mi="$(uptime | cut -d " " -f5 | cut -d "," -f1 |cut -d ":" -f2)"
echo "OK. up $h hour, $mi minutes"
exit 0
fi
