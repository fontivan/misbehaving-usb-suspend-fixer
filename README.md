# misbehaving-usb-suspend-fixer

There are some usb devices which do not behave correctly when a system suspend or resume is performed.

This script is an attempt to fix this misbehaviour by manually disconnecting the offending devices at the start of suspend, and resetting them after resume.

# configuration

An example configuration is provided in `src/etc/example.conf`.

Create your own configuration file at `/usr/lib/systemd/system-sleep/misbehaving-usb-suspend-fixer.conf` with your problematic devices.

The strings used in the configuration file should be the vendor and device id pairs found in the output of `lsusb`.

# identification

Misbehaving usb devices can often be found in `dmesg` output. Both example devices below have their IDs included in `src/etc/example.conf`.

## HyperX QuadCast S Example

For example, my misbehaving microphone reports errors like these:
```
[31116.552164] usb 3-5.1.2.1: PM: dpm_run_callback(): usb_dev_resume returns -107
[31116.552175] usb 3-5.1.2.1: PM: failed to resume async: error -107
[31119.401244] usb 3-5.1.2.1: can't set config #1, error -32
```

And we can correlate this to the device using lshw:
```
$> sudo lshw -C input -businfo | grep '3:5.1.2.1'
usb@3:5.1.2.1     input27         input          Kingston HyperX QuadCast S
```

And finally we can identify the vendor and device id using lsusb:
```
$> sudo lsusb | grep 'QuadCast'
Bus 003 Device 014: ID 0951:171d Kingston Technology HyperX QuadCast S
Bus 003 Device 017: ID 0951:171f Kingston Technology HyperX QuadCast S
```

## Onboard Bluetooth Example

For example, my Bluetooth device reports errors like these:
```
[ 2883.430481] Bluetooth: hci0: Execution of wmt command timed out
[ 2883.430486] Bluetooth: hci0: Failed to send wmt patch dwnld (-110)
[ 2883.430488] Bluetooth: hci0: Failed to set up firmware (-110)
```

And we can correlate this to the device by checking the product:
```
$> cat /sys/class/bluetooth/hci0/device/uevent | grep PRODUCT
PRODUCT=e8d/717/100
```

Finally we can verify the vendor and device id using lsusb:
```
$> sudo lsusb | grep e8d | grep 717
Bus 003 Device 005: ID 0e8d:0717 MediaTek Inc. Wireless_Device
```

# Installation

## Github
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

## Make
The script can also be installed from source using `make install`.
