
# sispmctl

Packaged clone of the upstream `xypron/sispmctl` (release-4.12) prepared as a
Debian `.deb` installer for Debian/Raspbian systems. The upstream `sispmctl`
utility controls USB-connected SiSPM power strips (power-on/power-off per
outlet, status queries, discovery).

## 📌 Features

- Control individual outlets on supported SiSPM power strips (on/off)
- Query device and outlet status
- Device discovery over serial/USB
- Packaged as a `.deb` for easy install/uninstall

---

## 📂 Installation

### Install via `.deb`

Download the release package and install on the device:

```bash
wget https://github.com/aragon25/sispmctl/releases/download/v4.12-1/sispmctl_4.12-1_all.deb
sudo apt install ./sispmctl_4.12-1_all.deb
```

This places the executable in your `PATH` and installs any packaging-provided
helpers.

---

## ⚙️ Usage

Run `sispmctl --help` after installation to see all options. Common commands:

```bash
# list attached SiSPM devices
sispmctl --list

# switch outlet 1 on (example device path)
sispmctl -d /dev/ttyUSB0 -o 1 on

# switch outlet 2 off
sispmctl -d /dev/ttyUSB0 -o 2 off

# get device status
sispmctl -d /dev/ttyUSB0 status
```

If your system uses different device nodes adjust `-d /dev/ttyUSB*` accordingly.

---

## ⚠️ Safety

- This utility controls power outlets. Test only on non-critical hardware and
  ensure devices attached to the power strip can be safely power-cycled.
- For automated tests, mock or stub the serial device nodes instead of using
  real hardware.
