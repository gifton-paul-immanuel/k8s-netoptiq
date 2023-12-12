#!/bin/bash

# Unbound Post Install
{ echo -e "\e[30;48;5;248m⮞⮞ Unbound Post Install Steps ⮜⮜\e[0m"; } 2> /dev/null

# Add unbound User & Group
echo -e "Add unbound User & Group ..."
if ! getent passwd unbound &>/dev/null; then
	adduser --quiet --system --group --no-create-home --home /var/lib/unbound unbound
fi

# Create Dirs
echo -e "Create Dirs ..."
[ ! -d /var/lib/unbound ] && { mkdir -p /var/lib/unbound; chown unbound:unbound /var/lib/unbound; }
[ ! -d /usr/lib/unbound ] && { mkdir -p /usr/lib/unbound; }

# Copy Files
echo -e "Copy Files ..."
[ ! -f /etc/init.d/unbound ] && { cp -p -f etc/init.d/unbound /etc/init.d/; chown root:root /etc/init.d/unbound; chmod +x /etc/init.d/unbound; }
[ ! -f /usr/lib/systemd/system/unbound.service ] && { cp -p -f usr/lib/systemd/system/unbound.service /usr/lib/systemd/system/; chown root:root /usr/lib/systemd/system/unbound.service; }
[ ! -f /usr/lib/unbound/package-helper ] && { cp -p -f usr/lib/unbound/package-helper /usr/lib/unbound/; chown root:root /usr/lib/unbound/package-helper; chmod +x /usr/lib/unbound/package-helper; }
[ ! -f /var/lib/unbound/root.hints ] && { cp -p -f var/lib/unbound/root.hints /var/lib/unbound/; chown unbound:unbound /var/lib/unbound/root.hints; }

# Create unbound-control Crypto Keys In /etc/unbound/
echo -e "Create unbound-control Crypto Keys ..."
[ ! -f /etc/unbound/unbound_control.key ] && { unbound-control-setup; }
