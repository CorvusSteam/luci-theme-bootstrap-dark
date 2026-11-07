# Changelog

## v3.0

The stylesheet was reorganized and cleaned. Appearance is the same as in v2.1 except for the small
fixes listed below.

- 13 documented sections (palette, base, header, tabs, cards, tables, forms, buttons, dialogs,
  status page, graphs, small leftovers, page-specific rules).
- 33.5 KB -> 24.4 KB (27% smaller): rules that never applied were removed, duplicates merged,
  the `html body` priority hack went from 181 uses to 54, unused variables and guessed selectors
  (for example `.cbi-input-user`, `form.login`) were dropped.
- The theme is always dark. The `@media (prefers-color-scheme: dark)` wrapper and the optional
  "automatic dark mode" installation method were removed: use *System -> Language and Style* to
  switch back to the stock theme.
- The installer no longer post-processes the CSS and prints the size of the installed theme.
- Fixes: the "Login" button on the login page is blue and "Reset" red; disabled buttons do not react
  to hover; submit buttons with a color class keep their color on hover; the "x" button of alerts
  is white on hover; buttons in the file browser keep their own border color.

## v2.1

A full page-by-page check against the original `bootstrap` theme. Colors and readability only.

- Buttons: Save, Add and "Update lists" are green; Apply, Edit and the other action buttons are
  blue; Stop on the Startup page is red; one subtle hover step for every button type.
  "Apply" in the pending-changes dialog stays blue.
- Text no longer looks blurry: the white `text-shadow` of the original theme is removed.
- Crisp CSS loading spinner instead of the blurry GIF (1 s turn, matches LuCI's per-second refresh).
- Zone badges and interface headers keep their zone colors and use dark text; "this device" and
  "any zone" are dark gray plates; the active interface/radio header is highlighted in blue.
- Labels (for example "not installed") and header indicators have readable text.
- Form labels, device names, SSID/Mode captions are no longer dim.
- Tables: no zebra striping; named first column no longer turns white on hover; no highlight on
  the Diagnostics page.
- Dropdowns: no blue fill on closed lists, readable focus/selected items, dark separators.
- Dynamic lists (NTP servers etc.), file browser, pending-changes list and invalid-field red
  highlight now match the dark theme.
- Login page without a lighter card; bottom action bar and the SSH keys page without light strips.
- Realtime graphs are drawn on a dark background.

## v2.0

- The hostname in the page header now opens the Status page. In the stock `bootstrap` theme it
  only appends `#` to the address. The installer patches `header.htm` of the `bootstrap-dark`
  copy only; the stock theme is not touched.
- The installer prints the theme version.

## v1.0

First release.

- Dark theme for the LuCI `bootstrap` theme on OpenWrt 19.07, installed as a separate
  **BootstrapDark** entry in *System → System → Language and Style*.
- Covers the overview page, interfaces (zone colors are kept), realtime graphs, forms,
  dynamic lists, tables, tabs, dropdowns, buttons, alerts and modal dialogs.
- Tables without zebra striping; row highlight on hover for table rows only.
- One-command installation with `wget`, installation from a copied folder, uninstaller.
- Theme files are listed in `/etc/sysupgrade.conf`, so the theme survives firmware upgrades
  when settings are kept.
- English and Russian README.
