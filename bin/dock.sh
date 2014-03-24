# If an external monitor is connected, place it with xrandr
# External output may be "VGA" or "VGA-0" or "DVI-0" or "TMDS-1"
EXTERNAL_OUTPUT="HDMI2"
INTERNAL_OUTPUT="LVDS1"
# EXTERNAL_LOCATION may be one of: left, right, above, or below
EXTERNAL_LOCATION="right"

case "$EXTERNAL_LOCATION" in
    left|LEFT)
        EXTERNAL_LOCATION="--left-of $INTERNAL_OUTPUT"
        ;;
    right|RIGHT)
        EXTERNAL_LOCATION="--right-of $INTERNAL_OUTPUT"
        ;;
    top|TOP|above|ABOVE)
        EXTERNAL_LOCATION="--above $INTERNAL_OUTPUT"
        ;;
    bottom|BOTTOM|below|BELOW)
        EXTERNAL_LOCATION="--below $INTERNAL_OUTPUT"
        ;;
    *)
        EXTERNAL_LOCATION="--left-of $INTERNAL_OUTPUT"
        ;;
esac
#sleep 10;
while true; do
export DISPLAY=:0
/usr/bin/xrandr |/bin/grep $EXTERNAL_OUTPUT | /bin/grep " connected "
if [ $? -eq 0 ]; then
    echo "main"
#    xrandr --output $INTERNAL_OUTPUT --auto --output $EXTERNAL_OUTPUT --auto $EXTERNAL_LOCATION 2>&1 | logger -t $0
    # Alternative command in case of trouble:
    # (sleep 2; xrandr --output $INTERNAL_OUTPUT --auto --output $EXTERNAL_OUTPUT --auto $EXTERNAL_LOCATION) &
    /usr/bin/xrandr --output DP3 --off --output DP2 --off --output DP1 --off --output HDMI3 --mode 1920x1080 --pos 1920x0 --rotate normal --output HDMI2 --primary --mode 1920x1080 --pos 0x0 --rotate normal --output HDMI1 --off --output LVDS1 --off --output VGA1 --off
else
    echo "else"
#    xrandr --output $INTERNAL_OUTPUT --auto --output $EXTERNAL_OUTPUT --off 2>&1 | logger -t $0
    /usr/bin/xrandr --output DP3 --off --output DP2 --off --output DP1 --off --output HDMI3 --off --output HDMI2 --off --output HDMI1 --off --output LVDS1 --primary --mode 1600x900 --pos     0x0 --rotate normal --output VGA1 --off
fi
sleep 5;
done
