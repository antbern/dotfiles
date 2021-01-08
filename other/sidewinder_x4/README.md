# Sidewinder X4 hidraw interface

This is a simple way to have commands executed when you press any of the extra shortcut buttons on your SideWinder X4 keyboard. It consists of a simple python script that opens and reads the exported `hidraw` interface of the keyboard. To configure what commands to execute, simply edit the file directly. I have it setup to use `xdotool` to press the keys `XF86Launch1-6`, and then further configuration is handled by the window manager (awesomewm).

To avoid having to run the script as root, the provided udev rule can be copied into `/etc/udev/rules.d/`. The rule sets the group to `plugdev` and permissions `0664` so that everyone has read access and any member of the `plugdev` group will additionaly have write access. The udev rule also sets up a symlink to `/dev/hidraw_swx4_media`, which, when existing, causes the script not to enumerate connected devices via udev to find the keyboard. Otherwise, the python library `pyudev` is a required dependency.

## Resources
Some useful resources if you want to learn more or modify. 

Similar projects:
* [tolga9009/sidewinderd](https://github.com/tolga9009/sidewinderd)
* [s-leroux/hid_mapper](https://github.com/s-leroux/hid_mapper)
* [Claudio-Sjo/HID_linux_xbmc_driver](https://github.com/Claudio-Sjo/HID_linux_xbmc_driver)


About udev rules:
* [This](https://unix.stackexchange.com/questions/204829/attributes-from-various-parent-devices-in-a-udev-rule) stackexchange question, especially the thrid answer, linking to [this](https://stackoverflow.com/questions/27017203/udev-rule-with-few-parent-device-attributes/27222804#27222804) stackoverflow answer about how to match attributes from multiple parent devices.
* [Writing udev rules](http://www.reactivated.net/writing_udev_rules.html) by Daniel Drake