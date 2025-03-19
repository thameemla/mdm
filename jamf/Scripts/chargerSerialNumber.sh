#!/bin/bash

# Check if the Mac is charging
charging_status=$(system_profiler SPPowerDataType | grep -i -m 1 "Charging:" | awk '{print $2}')

if [[ "$charging_status" == "Yes" ]]; then
    # Extract the charger's serial number
    charger_serial=$(system_profiler SPPowerDataType | awk '/AC Charger Information:/{flag=1} flag && /Serial Number:/{print; exit}' | awk '{print $3}')
    
    if [[ -n "$charger_serial" ]]; then
        echo "<result>$charger_serial</result>"
    else
        echo "Charger connected, but serial number not found."
    fi
else
    echo "No charger found."
fi
