#!/bin/sh
# Installs the "BootstrapDark" LuCI theme (OpenWrt 19.07).
#
# Usage:
#   sh install.sh [--activate]
#   wget -O - https://raw.githubusercontent.com/<USER>/luci-theme-bootstrap-dark/main/install.sh | sh
#   wget -O - https://raw.githubusercontent.com/<USER>/luci-theme-bootstrap-dark/main/install.sh | sh -s -- --activate
#
# If bootstrap-dark.css is not found next to this script, it is downloaded from RAW_BASE.
set -e

VERSION="2.0"
RAW_BASE="https://raw.githubusercontent.com/<USER>/luci-theme-bootstrap-dark/main"

STATIC_SRC=/www/luci-static/bootstrap
STATIC_DST=/www/luci-static/bootstrap-dark
VIEW_SRC=/usr/lib/lua/luci/view/themes/bootstrap
VIEW_DST=/usr/lib/lua/luci/view/themes/bootstrap-dark

[ -d "$STATIC_SRC" ] && [ -d "$VIEW_SRC" ] || {
	echo "Standard bootstrap theme not found (luci-theme-bootstrap is required)."; exit 1; }

if grep -q "Dark mode for LuCI bootstrap" "$STATIC_SRC/cascade.css"; then
	echo "The original bootstrap theme was modified by an earlier dark CSS."
	echo "Restore its original cascade.css (or reinstall luci-theme-bootstrap) and run again."
	exit 1
fi

# Find the CSS next to the script, otherwise download it.
DIR="$(cd "$(dirname "$0")" 2>/dev/null && pwd)" || DIR=""
CSS="$DIR/bootstrap-dark.css"
TMP_CSS=""
if [ ! -f "$CSS" ]; then
	case "$RAW_BASE" in
		*"<"USER">"*) echo "bootstrap-dark.css not found, and RAW_BASE in install.sh still has the USER placeholder."; exit 1 ;;
	esac
	TMP_CSS="/tmp/bootstrap-dark.css.$$"
	echo "Downloading bootstrap-dark.css..."
	wget -q -O "$TMP_CSS" "$RAW_BASE/bootstrap-dark.css" || {
		rm -f "$TMP_CSS"; echo "Download failed. Check internet access and the system time (date)."; exit 1; }
	CSS="$TMP_CSS"
fi
grep -q "Dark mode for LuCI bootstrap" "$CSS" || {
	[ -z "$TMP_CSS" ] || rm -f "$TMP_CSS"
	echo "bootstrap-dark.css looks invalid."; exit 1; }

echo "BootstrapDark v$VERSION"
echo "Copying theme files..."
rm -rf "$STATIC_DST" "$VIEW_DST"
cp -r "$STATIC_SRC" "$STATIC_DST"
cp -r "$VIEW_SRC" "$VIEW_DST"

# The stock header links the hostname to "#". Make it open the Status page instead.
# (No-op if the header uses a different markup.)
sed -i -e 's|\(class="brand"[^>]*href="\)#"|\1<%=controller%>/admin/status/overview"|' \
       -e 's|\(href="\)#"\([^>]*class="brand"\)|\1<%=controller%>/admin/status/overview"\2|' \
       "$VIEW_DST/header.htm" 2>/dev/null || true

echo "Appending dark CSS (always dark when this theme is selected)..."
sed '/^@media (prefers-color-scheme: dark) {$/d; /^} \/\* end @media/d' "$CSS" >> "$STATIC_DST/cascade.css"
[ -z "$TMP_CSS" ] || rm -f "$TMP_CSS"

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
