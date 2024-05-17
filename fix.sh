#!/bin/sh

# Exit on any error
set -e

# Install CLI utils to work with clipboard: "wl-clipboard" for Wayland and "xclip" for X11
# inotify-tools - for watching changes in variable
sudo apt-get update && sudo apt-get install -y wl-clipboard xclip inotify-tools

# ========================================
# Create script for the service.
# The purpose here is to sync clipboard content when working in VirtualBox.
# Wayland clipboard is not syncing, but X11 clipboard does.
# So the script here watches Wayland clipboard content, and when it changes, it copies it to the X11 clipboard content.
# ========================================
# shellcheck disable=SC2016
echo '#!/bin/sh

# Set initial clipboard value
previous_clipboard_xclip="$(xclip -selection clipboard -o)"
previous_clipboard_wayland="$(wl-paste)"

while true; do
    # Get current clipboard value
    current_clipboard_xclip="$(xclip -selection clipboard -o)"

    # If X11 clipboard value has changed, copy it to Wayland clipboard
    if [ "${current_clipboard_xclip}" != "${previous_clipboard_xclip}" ]; then
        echo -n "${current_clipboard_xclip}" | wl-copy
        previous_clipboard_xclip="${current_clipboard_xclip}"
        previous_clipboard_wayland="${previous_clipboard_xclip}"
    fi

    current_clipboard_wayland="$(wl-paste)"
    # If Wayland clipboard value has changed, copy it to X11 clipboard
    if [ "${current_clipboard_wayland}" != "${previous_clipboard_wayland}" ]; then
        echo -n "${current_clipboard_wayland}" | xclip -selection clipboard
        previous_clipboard_wayland="${current_clipboard_wayland}"
        previous_clipboard_xclip="${previous_clipboard_wayland}"
    fi

    # Wait before checking again
    sleep 0.2
done' | sudo tee /usr/local/bin/clipboard-watcher.sh

# Make the script executable
sudo chmod +x /usr/local/bin/clipboard-watcher.sh
# ========================================

# ========================================
# Create service file
# ========================================
mkdir --parents "${HOME}/.config/systemd/user"

echo '[Unit]
Description=Clipboard Watcher Service
After=graphical-session.target

[Service]
Type=simple
ExecStart=/usr/local/bin/clipboard-watcher.sh
Restart=on-failure

[Install]
WantedBy=default.target' > "${HOME}/.config/systemd/user/clipboard-watcher.service"
# ========================================

# Reload systemd manager configuration
systemctl --user daemon-reload

# Enable and start the service
systemctl --user enable --now clipboard-watcher.service
