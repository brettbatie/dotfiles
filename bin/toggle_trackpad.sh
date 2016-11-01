#/bin/sh
id=$(xinput --list --id-only 'SynPS/2 Synaptics TouchPad')
devEnabled=$(xinput --list-props $id | awk '/Device Enabled/{print !$NF}')
xinput --set-prop $id 'Device Enabled' $devEnabled
notify-send --icon computer 'Synaptics TouchPad' "Device Enabled = $devEnabled"
