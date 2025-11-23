#!/bin/bash
userdel -f -r sispmctl >/dev/null 2>&1
deluser --group sispmctl >/dev/null 2>&1
rm -f "/lib/udev/rules.d/60-sispmctl.rules" >/dev/null 2>&1
udevadm control --reload-rules >/dev/null 2>&1
udevadm trigger >/dev/null 2>&1
systemctl stop sispmctl.service >/dev/null 2>&1
systemctl disable sispmctl.service >/dev/null 2>&1
rm -f "/lib/systemd/system/sispmctl.service" >/dev/null 2>&1
systemctl daemon-reload >/dev/null 2>&1
rm -f "/usr/local/bin/sispmctl" >/dev/null 2>&1
rm -rf "/usr/local/share/doc/sispmctl" >/dev/null 2>&1
exit 0