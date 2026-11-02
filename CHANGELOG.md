# Changelog

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
