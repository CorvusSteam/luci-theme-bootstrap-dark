#!/bin/sh
# Installs the "BootstrapDark" LuCI theme (OpenWrt 19.07).
# Usage:  sh install.sh [--activate]
set -e

DIR="$(cd "$(dirname "$0")" && pwd)"
CSS="$DIR/bootstrap-dark.css"
STATIC_SRC=/www/luci-static/bootstrap
STATIC_DST=/www/luci-static/bootstrap-dark
VIEW_SRC=/usr/lib/lua/luci/view/themes/bootstrap
VIEW_DST=/usr/lib/lua/luci/view/themes/bootstrap-dark

[ -f "$CSS" ] || { echo "bootstrap-dark.css not found next to install.sh"; exit 1; }
[ -d "$STATIC_SRC" ] && [ -d "$VIEW_SRC" ] || {
	echo "Standard bootstrap theme not found (luci-theme-bootstrap is required)."; exit 1; }

if grep -q "Dark mode for LuCI bootstrap" "$STATIC_SRC/cascade.css"; then
	echo "The original bootstrap theme was modified by an earlier dark CSS."
	echo "Restore its original cascade.css (or reinstall luci-theme-bootstrap) and run again."
	exit 1
fi

echo "Copying theme files..."
rm -rf "$STATIC_DST" "$VIEW_DST"
cp -r "$STATIC_SRC" "$STATIC_DST"
cp -r "$VIEW_SRC" "$VIEW_DST"

echo "Appending dark CSS (always dark when this theme is selected)..."
sed '/^@media (prefers-color-scheme: dark) {$/d; /^} \/\* end @media/d' "$CSS" >> "$STATIC_DST/cascade.css"

echo "Registering theme..."
uci set luci.themes.BootstrapDark=/luci-static/bootstrap-dark
if [ "$1" = "--activate" ]; then
	uci set luci.main.mediaurlbase=/luci-static/bootstrap-dark
fi
uci commit luci

echo "Keeping the theme across sysupgrade..."
for p in "$STATIC_DST" "$VIEW_DST"; do
	grep -qx "$p" /etc/sysupgrade.conf 2>/dev/null || echo "$p" >> /etc/sysupgrade.conf
done

rm -rf /tmp/luci-indexcache /tmp/luci-modulecache
echo "Done. Hard-refresh the browser (Ctrl+F5) and pick BootstrapDark in"
echo "System -> System -> Language and Style."
