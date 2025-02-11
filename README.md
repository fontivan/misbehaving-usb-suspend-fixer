# misbehaving-usb-suspend-fixer

There are some usb devices which do not behave correctly when a system suspend is requested.

This script is an attempt to fix this misbehaviour by manually shutting down the offending devices at the start of suspend, and turning them back on after resume.

# configuration

An example configuration is provided in `src/etc/example.conf`.

Create your own configuration file at `/usr/lib/systemd/system-sleep/misbehaving-usb-suspend-fixer.conf` with your problematic devices.

The strings used in the configuration file should be relatively unique and from the output of `lsusb`.

# installation

The script can be installed directly from GitHub, e.g.:
```
sudo curl -sS https://raw.githubusercontent.com/fontivan/misbehaving-usb-suspend-fixer/main/src/bin/misbehaving-usb-suspend-fixer -o /usr/lib/systemd/system-sleep/misbehaving-usb-suspend-fixer
sudo chmod +x /usr/lib/systemd/system-sleep/misbehaving-usb-suspend-fixer
```

The example configuration can also be installed directly from GitHub and then modified to your own needs, e.g.:
The script can be installed directly from GitHub, e.g.:
```
sudo curl -sS https://raw.githubusercontent.com/fontivan/misbehaving-usb-suspend-fixer/main/src/etc/example.conf -o /usr/lib/systemd/system-sleep/misbehaving-usb-suspend-fixer.conf
```
