# Improved Nano Syntax Highlighting Files

[![shellcheck](https://github.com/galenguyer/nano-syntax-highlighting/actions/workflows/shellcheck.yml/badge.svg?branch=master)](https://github.com/galenguyer/nano-syntax-highlighting/actions/workflows/shellcheck.yml)
[![installer-sync](https://github.com/galenguyer/nano-syntax-highlighting/actions/workflows/installer-sync.yml/badge.svg?branch=master)](https://github.com/galenguyer/nano-syntax-highlighting/actions/workflows/installer-sync.yml)
[![release](https://img.shields.io/github/v/release/marmitar/nano-syntax-highlighting?logo=github&logoColor=%23959DA5&labelColor=%23444D56)](https://github.com/marmitar/nano-syntax-highlighting/releases/latest)

This repository holds ``{lang}.nanorc`` files that have improved definitions of syntax highlighting for various languages.

This repository is forked from [github.com/scopatz/nanorc](https://github.com/scopatz/nanorc) after almost 2 years of no activity from the maintainer.

## Installation

There are three ways to install this repo.

### 1. Automatic installer

Copy the following code to download and run the installer script:

```sh
curl https://raw.githubusercontent.com/galenguyer/nano-syntax-highlighting/master/install.sh | bash
```

If your machine doesn't have `curl` command, use this code:

```sh
wget https://raw.githubusercontent.com/galenguyer/nano-syntax-highlighting/master/install.sh -O- | bash
```

This automatically unpacks all the `.nanorc` files to `~/.local/share/nano-syntax-highlighting`.

#### Note

Some syntax definitions which exist in Nano upstream may be preferable to the ones provided by this package.
The `install.sh` script may be run with `-l` or `--lite` to insert the included syntax definitions from this package with *lower* precedence than the ones provided by the standard package.

### 2. Package managers

The follow table lists all systems with this package published.
Feel free to add your official package manager.

> Systems that are based in others' package managers or repositories are compatible. For example: `pacman` based systems are compatible with `Arch Linux`.

| System     | Command                                  |
| ---------- | ---------------------------------------- |
| Arch Linux | `pacman -S nano-syntax-highlighting`     |

### 3. Clone repo (copy the files)

The files should be placed inside of the `~/.local/share/nano-syntax-highlighting` directory.

You may put the files to a different directory, for example to `~/.nano`.
For readability, we use `$install_path` to represent the path of your choice (in *system wide* the path is always `/usr/share/nano-syntax-highlighting/`).

For single user, run:
https://github.com/marmitar/nano-syntax-highlighting/archive/refs/tags/2025.07.13-23.tar.gz

```sh
curl -L https://github.com/galenguyer/nano-syntax-highlighting/archive/master.tar.gz |\
  tar -C  $install_path -xz --strip-components=2 nano-syntax-highlighting-master/src/
```

For system wide, run:

```sh
curl -L https://github.com/galenguyer/nano-syntax-highlighting/archive/master.tar.gz |\
  sudo tar -C  $install_path -xz --strip-components=2 nano-syntax-highlighting-master/src/
```

## Configuration

After installation, you need to inform `nano` to used the new highlight files.
The configuration file is located at `~/.config/nano/nanorc` or `~/.nanorc`, for users, and at `/etc/nanorc`, for system wide.
If this file doesn't exist, create a new one.

Again there are three ways:

### 1. Include all

Append the content of the folder in one line, with wildcard:

`echo "include $install_path/*.nanorc" >> ~/.config/nano/nanorc` or
`echo "include $install_path/*.nanorc" >> /etc/nanorc`

### 2. Include/append our `nanorc` file

Simply run:

`cat $install_path/nanorc >> ~/.config/nano/nanorc` or
`cat $install_path/nanorc >> /etc/nanorc`

### 3. One by one

Add your preferable languages one by one into the file. For example:

```
## C/C++
include "~/.local/share/nano-syntax-highlighting/c.nanorc"
```

## Tricks & Tweaks

### MacOS

`\<` and `\>` are regular character escapes on MacOS.
The bug is fixed in Nano, but this might be a problem if you are using an older version
If this is the case, replace them respectively with `[[:<:]]` and `[[:>:]]`.
This is reported in [Issue 52](https://github.com/scopatz/nanorc/issues/52).

### Why not include the original files?

Good question! It's due to the way that nano reads the files, the regex instructions should be in a _specific order_ which is evident in some nanorc files.
And if we use the `include` or `extendsyntax` commands, the colors or other things may not work as expected.
The best way to make changes is by copying and editing the original files.
Please see this [issue](https://savannah.gnu.org/bugs/index.php?5698).
But if some original nanorc file needs an update, feel free to [patch it](https://savannah.gnu.org/patch/?func=additem&group=nano)!

### My shortcut is not working!

Please see this [issue](https://savannah.gnu.org/bugs/?56994).

## Acknowledgements

Some of these files are derived from the original [Nano](https://www.nano-editor.org) editor [repo](https://git.savannah.gnu.org/cgit/nano.git)
