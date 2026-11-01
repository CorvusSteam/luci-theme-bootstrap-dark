#!/bin/sh
# Removes the "BootstrapDark" LuCI theme.
set -e

if [ "$(uci -q get luci.main.mediaurlbase)" = "/luci-static/bootstrap-dark" ]; then
	uci set luci.main.mediaurlbase=/luci-static/bootstrap
fi
uci -q delete luci.themes.BootstrapDark || true
uci commit luci

rm -rf /www/luci-static/bootstrap-dark /usr/lib/lua/luci/view/themes/bootstrap-dark
sed -i '\#/bootstrap-dark$#d' /etc/sysupgrade.conf 2>/dev/null || true
rm -rf /tmp/luci-indexcache /tmp/luci-modulecache
echo "BootstrapDark removed."
