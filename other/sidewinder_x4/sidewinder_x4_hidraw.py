#!/usr/bin/env python3
import os
import binascii
import select
import subprocess

# Sidewinder X4 USB vendor and product id
VENDOR_ID='045e'
PRODUCT_ID='0768'

# path created by udev rule (if applied)
UDEV_DEV_PATH = '/dev/hidraw_swx4_media'

# default buffer length (Sidewinder sends commands 5-8 bytes)
BUFFER_LENGTH = 16

# List of HID events and commands to execute
# for now, just emulate keypresses that can be furter 
# reacted to by awesome
command_table = {
    '0801000000': ['xdotool', 'key', 'XF86Launch1'],
    '0802000000': ['xdotool', 'key', 'XF86Launch2'],
    '0804000000': ['xdotool', 'key', 'XF86Launch3'],
    '0808000000': ['xdotool', 'key', 'XF86Launch4'],
    '0810000000': ['xdotool', 'key', 'XF86Launch5'],
    '0820000000': ['xdotool', 'key', 'XF86Launch6'],
}

def discover_devices():
    import pyudev
    devices = []
    
    context = pyudev.Context()
    for device in context.list_devices(subsystem='hidraw'):
        parent_interface_attr = device.find_parent('usb', 'usb_interface').attributes
        parent_device_attr = device.find_parent("usb", "usb_device").attributes

        # check if it is a Sidewinder device and correct interfaace
        if parent_device_attr.asstring('idVendor') == VENDOR_ID \
            and parent_device_attr.asstring('idProduct') == PRODUCT_ID \
            and parent_interface_attr.asint('bInterfaceNumber') == 1:  

            devices.append(device.device_node)
    
    return devices


# check if the udev device path exists before trying to locate the devices via pyudev
if os.path.exists(UDEV_DEV_PATH):
    devices = [UDEV_DEV_PATH]
else:
    devices = discover_devices()


if len(devices) == 0:
    print("No Sidewinder X4 device(s) found!")    
    exit(1)


print("Found matching device(s):", devices)

# open all files
files = []
try:
    print("Opening devices for reading...")
    files = [open(device, "rb") for device in devices]
    
    while True:
        # wait for data to be available in any of the files
        ready, _, _ = select.select(files, [], [])

        # read from the ready ones
        for f in ready:
            event = f.read1(BUFFER_LENGTH)
            text_string = binascii.hexlify(event).decode('utf-8')

            if text_string in command_table:
                command = command_table[text_string]
                # print("Executing: ", command)
                subprocess.Popen(command)

except KeyboardInterrupt as ki:
    print("Interrupted")
except Exception as e:
    print("Unknown error: ", e)
finally:
    if files:
        print("Closing opened files...")
        [f.close() for f in files]

print("Done")