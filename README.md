# Hash-it

[![License: GPL-3.0-or-later](https://img.shields.io/badge/License-GPL%203.0--or--later-green.svg)](https://opensource.org/licenses/GPL-3.0)
[![Build Status](https://github.com/libredeb/hash-it/workflows/CI/badge.svg)](https://github.com/libredeb/hash-it/actions)
[![Code Style](https://img.shields.io/badge/code%20style-Vala-purple.svg)](https://wiki.gnome.org/Projects/Vala)

![icon](./data/icons/128/hashit.svg)

**The most intuitive and simple hash tool checker**

Hash-it is a fast and beautiful hash check tool. Writen in Vala and GTK+ 4.0 with the purpose to get the hash of file and compare it with other provided hash.

[![Get it on AppCenter](https://appcenter.elementary.io/badge.svg)](https://appcenter.elementary.io/io.github.libredeb.hashit)

![screenshot](./data/screenshot.png)

## Compilation

   1. Install dependencies:
   * For Ubuntu:
      ```sh
      sudo apt-get install cmake meson ninja-build valac libvala-*-dev libglib2.0-dev libgtk-4-dev libgranite-7-dev libadwaita-1-dev python3 python3-wheel python3-setuptools
      ```
   * For Fedora:
      ```sh
      sudo dnf install cmake meson ninja-build vala libvala-devel glib-devel gtk4-devel granite-7-devel libadwaita-devel python3 python3-wheel python3-setuptools gnome-menus
      ```
   * For Arch Linux:
      ```sh
      sudo pacman -Sy meson ninja vala glib2 gdk-pixbuf2 gtk4 granite7 libadwaita-1 python python-wheel python-setuptools
      ```
   2. Clone this repository into your machine
      ```sh
      git clone https://github.com/libredeb/hash-it.git
      cd hash-it/
      ```
   3. Create a build folder:
      ```sh
      meson setup build --prefix=/usr
      ```
   4. Compile hash-it:
      ```sh
      cd build
      ninja
      ```
   5. Install hash-it in the system:
      ```sh
      sudo ninja install
      ```
   6. (OPTIONAL) Uninstall hash-it:
      ```sh
      sudo ninja uninstall
      ```

## Developer Section

### Flatpak

Run `flatpak-builder` to configure the build environment, download dependencies, build, and install

```bash
flatpak-builder build io.github.libredeb.hashit.yml --user --install --force-clean --install-deps-from=appcenter
```

Then execute with

```bash
flatpak run io.github.libredeb.hashit
```

### Linting

To lint Vala code, you can use [vala-lint](https://github.com/vala-lang/vala-lint), a tool designed to detect potential issues and enforce coding style in Vala projects.

Read the instructions to install it on your local machine.

**Usage**

Run `io.elementary.vala-lint` command in your project source code directory:

```sh
io.elementary.vala-lint src/
```

### Validating AppStream Syntax

To ensure your [AppStream XML file](data/io.github.libredeb.hashit.appdata.xml.in) is correctly structured, use the `appstream-util` tool from the [AppStream project](https://www.freedesktop.org/software/appstream/docs/).

#### Installation

```sh
sudo apt install appstream
```

**Usage**

Run the following command to validate the syntax of your AppStream XML file:

```sh
appstreamcli validate --pedantic data/io.github.libredeb.hashit.appdata.xml.in
```

### Translations

To add more supported languages, please, edit [LINGUAS](./po/LINGUAS) file and update the translation template file (a.k.a. `pot`) running next command:
```sh
cd build
ninja io.github.libredeb.hashit-pot
```

And for generate each LINGUA `po` file, run next command:
```sh
ninja io.github.libredeb.hashit-update-po
```

## License

This project is licensed under the GNU General Public License v3.0 or later - see the [COPYING](COPYING) file for details.

⭐ If you like Hash-it, leave me a star on GitHub!
