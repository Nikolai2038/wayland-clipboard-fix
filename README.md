# wayland-clipboard-fix

**EN** | [RU](README_RU.md)

2024-09-29: Archived - use [clipboard-sync](https://github.com/dnut/clipboard-sync) instead.

## 1. Description

The purpose here is to sync clipboard content when working in VirtualBox.
Wayland clipboard is not syncing, but X11 clipboard does.
So the service created by this script here watches Wayland clipboard content, and when it changes, it copies it to the X11 clipboard content and vice versa.

## 2. Requirements

- `pacman` (Arch-based) or `apt-get` (Debian-based) installed;
- `sudo` installed.

## 3. Usage

Execute inside virtual machine for usual user:

```bash
curl -s https://raw.githubusercontent.com/Nikolai2038/wayland-clipboard-fix/main/fix.sh | sh
```

## 4. Contribution

Feel free to contribute via [pull requests](https://github.com/Nikolai2038/wayland-clipboard-fix/pulls) or [issues](https://github.com/Nikolai2038/wayland-clipboard-fix/issues)!
