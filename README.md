**English** | [Русский](README.ru.md)

# luci-theme-bootstrap-dark

A dark theme for LuCI on **OpenWrt 19.07**, visually close to the stock `bootstrap` theme and
modelled on the dark mode that ships with newer OpenWrt releases (22.03 / 23.05).

<!-- Add screenshots to the screenshots/ folder and uncomment: -->
<!-- ![Status](screenshots/status.png) -->
<!-- ![Interfaces](screenshots/interfaces.png) -->

## Features

- Does not replace the stock theme. It installs as a separate **BootstrapDark** entry under
  *System → System → Language and Style → Theme*.
- CSS only: no packages to build, no compilation.
- Covers the overview page, interfaces, realtime graphs, forms, dynamic lists, tables,
  tabs, dropdowns, buttons, alerts and modal dialogs.

## Requirements

- OpenWrt 19.07 (tested on 19.07.10)
- `luci-theme-bootstrap` installed and **unmodified** (it is installed by default)

## Installation

### Option 1: copy from your computer (recommended)

1. Download this repository as a ZIP (**Code → Download ZIP**) and extract it.
2. Copy the folder to the router and run the installer:

```sh
scp -O -r luci-theme-bootstrap-dark root@192.168.1.1:/tmp/
ssh root@192.168.1.1
sh /tmp/luci-theme-bootstrap-dark/install.sh
```

> The `-O` flag makes `scp` use the legacy protocol, which OpenWrt 19.07 (Dropbear) requires
> with recent OpenSSH clients. On Windows 10/11 `scp` and `ssh` are available in PowerShell.

### Option 2: clone on the router

```sh
opkg update && opkg install git git-http
git clone https://github.com/CorvusSteam/luci-theme-bootstrap-dark.git
cd luci-theme-bootstrap-dark
sh install.sh
```

### Activate

Hard-refresh the browser (Ctrl+F5), open *System → System → Language and Style*,
choose **BootstrapDark** and click *Save & Apply*.

To make the theme active immediately, run the installer with `--activate`:

```sh
sh install.sh --activate
```

### What the installer does

- copies the `bootstrap` theme to `bootstrap-dark` and appends the dark CSS;
- registers the theme in UCI (`luci.themes.BootstrapDark`);
- adds the theme paths to `/etc/sysupgrade.conf`;
- clears the LuCI cache.

The installer refuses to run if the stock `bootstrap` theme already contains a dark CSS
(for example, one appended manually). Restore the original `cascade.css` or reinstall
`luci-theme-bootstrap` first.

## Uninstallation

```sh
sh uninstall.sh
```

This switches the active theme back to `bootstrap` if needed, removes the theme files and the
UCI entry, and deletes the lines from `/etc/sysupgrade.conf`.

## Alternative: automatic dark mode

If you prefer a single theme that turns dark only when your OS/browser prefers dark mode,
append `bootstrap-dark.css` as is to `/www/luci-static/bootstrap/cascade.css`:

```sh
cp /www/luci-static/bootstrap/cascade.css /root/cascade.css.bak
cat bootstrap-dark.css >> /www/luci-static/bootstrap/cascade.css
```

The file is wrapped in `@media (prefers-color-scheme: dark)`, so it has no effect in light mode.
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

Edit them and run `install.sh` again to apply your palette.

## Known limitations

- The realtime graphs are recolored by inverting the whole chart, so shades may differ slightly
  from the original.
- Designed for OpenWrt 19.07. Later releases (21.02+) use a different `bootstrap` layout and
  include their own dark mode.
- Third-party `luci-app-*` packages that ship their own CSS may still show light elements.

## Contributing

Found a light element or unreadable text? Please open an issue with:

- a screenshot of the page;
- ideally the element's HTML (right-click the element → *Inspect*, then copy the tag with its
  `class` attribute).

Pull requests are welcome.

## License

MIT, see [LICENSE](LICENSE).
