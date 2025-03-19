#!/bin/sh

#This script fetches the S.No of connected Power Adapter. So we can use this to identify which person is using the adpater through advanced search in Jamf Pro.

# Check if the Mac is charging
charging_status=$(system_profiler SPPowerDataType | grep -i -m 1 "Charging:" | awk '{print $2}')

if [[ "$charging_status" == "Yes" ]]; then
    # Extract the charger's serial number
    charger_serial=$(system_profiler SPPowerDataType | awk '/AC Charger Information:/{flag=1} flag && /Serial Number:/{print; exit}' | awk '{print $3}')
    
    echo "<result>$charger_serial</result>"

else
    echo "<result>No charger found.</result>"
fi
