#!/usr/bin/env bash

SCRIPTNAME=$(readlink -f ${BASH_SOURCE[0]})
pushd "$(dirname $SCRIPTNAME)" > /dev/null

export XDG_CONFIG_HOME="${XDG_CONFIG_HOME:-$HOME/.config}"

if [[ ! -d "$XDG_CONFIG_HOME/autostart" ]]; then
    mkdir "$XDG_CONFIG_HOME/autostart"
fi
read -p "Kiosk URL: " KIOSKURL

cat << __kiosk_desktop > $XDG_CONFIG_HOME/autostart/kiosk.desktop
[Desktop Entry]
Type=Application
Name=Kiosk
Exec=/usr/bin/firefox --kiosk $KIOSKURL
__kiosk_desktop

# Make a desktop shortcut for the script
if [[ ! -d "$HOME/Desktop" ]]; then
    mkdir "$HOME/Desktop"
fi
cp $XDG_CONFIG_HOME/autostart/kiosk.desktop "$HOME/Desktop"

echo ""
echo ""
echo "====================================="
echo "kiosk.desktop has been created in the"
echo "    '$XDG_CONFIG_HOME/autostart' directory to run the kiosk at startup"
echo ""
echo "$HOME/Desktop/kiosk.desktop desktop shortcut has been created for this script"
echo "====================================="
echo ""
echo "Will be starting firefox automatically first to perform account login to kiosk"

sleep 3
/usr/bin/firefox --kiosk $KIOSKURL &

popd > /dev/null

