**English** | [Русский](README.ru.md)

# luci-theme-bootstrap-dark

A dark theme for LuCI on **OpenWrt 19.07**, visually close to the stock `bootstrap` theme and
modelled on the dark mode of newer OpenWrt releases (22.03 / 23.05).

<!-- Add screenshots to the screenshots/ folder and uncomment: -->
<!-- ![Status](screenshots/status.png) -->
<!-- ![Interfaces](screenshots/interfaces.png) -->

## Features

- Does not replace the stock theme. It is installed as a separate **BootstrapDark** entry under
  *System → System → Language and Style → Theme*.
- CSS only: nothing to build or compile, no extra packages on the router.
- Covers the overview page, interfaces, realtime graphs, forms, dynamic lists, tables, tabs,
  dropdowns, buttons, alerts and modal dialogs.
- Survives firmware upgrades (`sysupgrade`) when settings are kept, thanks to entries in
  `/etc/sysupgrade.conf`.

## Requirements

- OpenWrt 19.07 (tested on 19.07.10)
- `luci-theme-bootstrap` installed and **unmodified** (it is installed by default)

## Installation

### Option 1: one command on the router (recommended)

The router needs internet access and a correct system time. On a clean OpenWrt 19.07 the packages
for HTTPS downloads are usually not installed, so install them first (this only needs to be
done once). Then run the installer, both over SSH:

```sh
opkg update && opkg install ca-bundle libustream-mbedtls
wget -O - https://raw.githubusercontent.com/CorvusSteam/luci-theme-bootstrap-dark/main/install.sh | sh
```

The script downloads `bootstrap-dark.css` by itself. It needs nothing but `wget`, which is part of
OpenWrt, and everything goes through `/tmp` (RAM), so no flash space is used. You can read the
script first by opening the same URL in a browser.

If `wget` still reports a certificate error, check the time with `date`: with a wrong clock the
certificate check fails.

If the repository's default branch is not `main` (for example `master`), change it in the URL.

### Option 2: copy from your computer

Use this if the router has no internet access.

1. Download the repository as a ZIP (**Code → Download ZIP**) and extract it.
2. Copy the folder to the router and run the installer:

```sh
scp -O -r luci-theme-bootstrap-dark root@192.168.1.1:/tmp/
ssh root@192.168.1.1
sh /tmp/luci-theme-bootstrap-dark/install.sh
```

> The `-O` flag makes `scp` use the legacy protocol. OpenWrt 19.07 (Dropbear) has no SFTP server,
> and OpenSSH 9.0+ uses SFTP by default. On Windows 10/11, `scp` and `ssh` are available in PowerShell.

### Activate

Hard-refresh the browser (Ctrl+F5), open *System → System → Language and Style*,
choose **BootstrapDark** and click *Save & Apply*.

To make the theme active right after installation, add the `--activate` option
(the first command is for Option 1, the second for Option 2):

```sh
wget -O - https://raw.githubusercontent.com/CorvusSteam/luci-theme-bootstrap-dark/main/install.sh | sh -s -- --activate
sh /tmp/luci-theme-bootstrap-dark/install.sh --activate
```

### What the installer does

- copies the `bootstrap` theme to `bootstrap-dark` and appends the dark CSS;
- registers the theme in UCI (`luci.themes.BootstrapDark`);
- adds the theme paths to `/etc/sysupgrade.conf`;
- makes the hostname in the page header a link to the Status page (in the stock theme it only
  adds `#` to the address);
- clears the LuCI cache.

The installer refuses to run if the stock `bootstrap` theme already contains a dark CSS
(for example, one appended manually). Restore the original `cascade.css` or reinstall
`luci-theme-bootstrap` first.

## Uninstallation

```sh
wget -O - https://raw.githubusercontent.com/CorvusSteam/luci-theme-bootstrap-dark/main/uninstall.sh | sh
```

If you still have the downloaded folder, you can run `sh uninstall.sh` from it instead.

The script switches the active theme back to `bootstrap` if needed, removes the theme files and
the UCI entry, and deletes the lines from `/etc/sysupgrade.conf`.

## Alternative: automatic dark mode

If you prefer a single theme that turns dark only when your OS or browser uses dark mode,
append `bootstrap-dark.css` as is to the stock theme:

```sh
cp /www/luci-static/bootstrap/cascade.css /root/cascade.css.bak
wget -O - https://raw.githubusercontent.com/CorvusSteam/luci-theme-bootstrap-dark/main/bootstrap-dark.css >> /www/luci-static/bootstrap/cascade.css
```

The file is wrapped in `@media (prefers-color-scheme: dark)`, so it has no effect in light mode.
To undo, restore the backup: `cp /root/cascade.css.bak /www/luci-static/bootstrap/cascade.css`.
Do not combine this with `install.sh` (see the note above).

## Customization

All colors are defined as CSS variables at the top of `bootstrap-dark.css`:

```css
--bg: #1b1b1b;        /* page */
--bg-card: #242424;   /* sections, tables */
--bg-alt: #2b2b2b;    /* alternate rows, table headers */
--bg-input: #181818;  /* form inputs */
--text: #e4e4e4;
--accent: #5ea1f0;
```

To change them, edit `bootstrap-dark.css` before running `install.sh` (Option 2 is the most
convenient for this), or edit `/www/luci-static/bootstrap-dark/cascade.css` on the router
after installation. Reload the page with Ctrl+F5 to see the result.

## Known limitations

- The realtime graphs are recolored by inverting the whole chart, so shades may differ slightly
  from the original.
- Designed for OpenWrt 19.07. Releases 22.03 and later have a different `bootstrap` layout and
  ship their own dark mode, so this theme is not intended for them.
- Third-party `luci-app-*` packages that ship their own CSS may still show light elements.
- On narrow screens (phones) the layout is the same as in the stock `bootstrap` theme of 19.07,
  which is not responsive. The theme changes only colors, not the layout.
- A few rules use the CSS `:has()` selector (login page, "Apply" in the changes dialog). It needs
  Chrome/Edge 105+, Firefox 121+ or Safari 15.4+; in older browsers these elements just keep
  the default look.

## Versions

See [CHANGELOG.md](CHANGELOG.md) and the Releases page of this repository.

- **v2.1**: many color and readability fixes found during a full page-by-page check.
- **v2.0**: the hostname in the page header opens the Status page.
- **v1.0**: first release.

The `main` branch always contains the latest version.

## Contributing

Found a light element or unreadable text? Please open an issue with:

- a screenshot of the page;
- ideally the element's HTML (right-click the element → *Inspect*, then copy the tag with its
  `class` attribute).

Pull requests are welcome.

## License

MIT, see [LICENSE](LICENSE).
