#!/bin/bash
function undo_changes(){
  rm -rf "/tmp/compile_sispmctl" >/dev/null 2>&1
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
  exit 1
}
if [ -f "/usr/local/src/sispmctl/sispmctl.zip" ]; then
  echo "Extract source(s) ..."
  rm -rf "/tmp/compile_sispmctl" >/dev/null 2>&1
  mkdir -p "/tmp/compile_sispmctl" >/dev/null 2>&1
  unzip "/usr/local/src/sispmctl/sispmctl.zip" -d "/tmp/compile_sispmctl" >/dev/null 2>&1
  [ $? -ne 0 ] && undo_changes
  echo "add user and group \"sispmctl\" and rules ..."
  if ! id "sispmctl" >/dev/null 2>&1; then
    adduser sispmctl --system --group --disabled-login --no-create-home >/dev/null 2>&1
    [ $? -ne 0 ] && undo_changes
  fi
  cp -af "/tmp/compile_sispmctl/examples/60-sispmctl.rules" "/lib/udev/rules.d/60-sispmctl.rules"
  [ $? -ne 0 ] && undo_changes
  udevadm control --reload-rules >/dev/null 2>&1
  [ $? -ne 0 ] && undo_changes
  udevadm trigger >/dev/null 2>&1
  [ $? -ne 0 ] && undo_changes
  echo "Compile and install from source(s) ..."
  cd "/tmp/compile_sispmctl"
  chmod +x ./autogen.sh >/dev/null 2>&1
  [ $? -ne 0 ] && undo_changes
  ./autogen.sh >/dev/null 2>&1
  [ $? -ne 0 ] && undo_changes
  ./configure >/dev/null 2>&1
  [ $? -ne 0 ] && undo_changes
  make >/dev/null 2>&1
  [ $? -ne 0 ] && undo_changes
  make install >/dev/null 2>&1
  [ $? -ne 0 ] && undo_changes
  ldconfig >/dev/null 2>&1
  [ $? -ne 0 ] && undo_changes
  echo "Install sispmctl service ..."
  cp -af "/tmp/compile_sispmctl/examples/sispmctl.service" "/lib/systemd/system/sispmctl.service" >/dev/null 2>&1
  [ $? -ne 0 ] && undo_changes
  sed -i "s/ExecStart=\/usr\/local\/bin\/sispmctl -p 2638 -l*$/ExecStart=\/usr\/local\/bin\/sispmctl -p 9091 -l/" /lib/systemd/system/sispmctl.service >/dev/null 2>&1
  [ $? -ne 0 ] && undo_changes
  chmod +x "/lib/systemd/system/sispmctl.service" >/dev/null 2>&1
  [ $? -ne 0 ] && undo_changes
  systemctl daemon-reload >/dev/null 2>&1
  [ $? -ne 0 ] && undo_changes
  rm -rf "/tmp/compile_clicklock" >/dev/null 2>&1
else
  undo_changes
fi
exit 0