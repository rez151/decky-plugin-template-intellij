#!/bin/bash

SETTINGS_FILE="$(pwd)/scripts/settings.json"

# Check for jq
if ! command -v jq >/dev/null 2>&1; then
    echo "Error: jq is required but not installed. Install it (e.g., 'sudo apt install jq' or 'brew install jq')." >&2
    exit 1
fi

# Check if file exists and is valid JSON
if [[ ! -f "$SETTINGS_FILE" ]]; then
    echo "Error: Settings file $SETTINGS_FILE not found!" >&2
    exit 1
fi
if ! jq empty "$SETTINGS_FILE" >/dev/null 2>&1; then
    echo "Error: Invalid JSON in $SETTINGS_FILE!" >&2
    exit 1
fi

deckdir=$(jq -r '.deckdir' "$SETTINGS_FILE")
pluginname=$(jq -r '.pluginname' "$SETTINGS_FILE")
deckuser=$(jq -r '.deckuser' "$SETTINGS_FILE")
deckip=$(jq -r '.deckip' "$SETTINGS_FILE")
deckport=$(jq -r '.deckport' "$SETTINGS_FILE")
deckkey=$(jq -r '.deckkey' "$SETTINGS_FILE")
deckpass=$(jq -r '.deckpass' "$SETTINGS_FILE")

# echo all variables
echo "deckdir: $deckdir"
echo "pluginname: $pluginname"
echo "deckuser: $deckuser"
echo "deckip: $deckip"
echo "deckport: $deckport"
echo "deckkey: $deckkey"
echo "deckpass: $deckpass"


#rsync -azp --chmod=D0755,F0755 --rsh="ssh -p $deckport -i $deckkey" out/ "$deckuser@$deckip:$deckdir/homebrew/plugins"

#echo '/home/bazzite/homebrew/plugins/Example Plugin.zip' && ssh bazzite@192.168.178.47 -p 22 -i /Users/reser/.ssh/id_rsa_deck 'echo bazzite | sudo -S mkdir -m 755 -p "$(echo "/home/bazzite/homebrew/plugins/Example Plugin" | sed "s| |-|g")" && echo bazzite | sudo -S chown bazzite:bazzite "$(echo "/home/bazzite/homebrew/plugins/Example Plugin" | sed "s| |-|g")" && echo bazzite | sudo -S unzip -o "/home/bazzite/homebrew/plugins/Example Plugin.zip" -d "$(echo "/home/bazzite/homebrew/plugins/" | sed "s| |-|g")"'

echo '/home/bazzite/homebrew/plugins/Example Plugin.zip' && \
ssh bazzite@192.168.178.47 -p 22 -i /Users/reser/.ssh/id_rsa_deck \
'echo bazzite | sudo -S mkdir -m 755 -p "$(echo "/home/bazzite/homebrew/plugins/Example Plugin" | sed "s| |-|g")" && \
echo bazzite | sudo -S chown bazzite:bazzite "$(echo "/home/bazzite/homebrew/plugins/Example Plugin" | sed "s| |-|g")" && \
echo bazzite | sudo -S unzip -o "/home/bazzite/homebrew/plugins/Example Plugin.zip" -d "$(echo "/home/bazzite/homebrew/plugins/" | sed "s| |-|g")"'
