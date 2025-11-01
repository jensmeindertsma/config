#!/usr/bin/env python3

# Path to battery info
BATTERY_PATH = "/sys/class/power_supply/BATT/"

# Read the battery percentage
with open(BATTERY_PATH + "capacity", "r") as f:
    percent = f.read().strip()

# Read the charging state and convert it to lowercase
with open(BATTERY_PATH + "status", "r") as f:
    state = f.read().strip().lower()

# Output the data in JSON format for Waybar
print(f'{{"text": "{percent}% ({state})", }}')
