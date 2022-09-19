=============
Arducams
=============

.. contents:: Table of Contents


Getting Started
==============

The following items are needed to get started with the Arducams:

- Computer (Ex: Jetson Nano, Raspberry Pi, Arduino)
- Arducam

Arducam History at NNU
---------------
NNU has a history of using arducams for Rocksat-X projects:

- Rocksat-X 2020
    `This Arducam`_ was used with a Raspberry Pi and successfully recorded footage from space.
    `This is the link`_ to the python script that controlled the arducam

    Pros:
        Actually recorded footage from space
    Cons:
        Could not be activated and deactivated. It was controlled by a 'record for 100 seconds' command
        This isn't ideal because it is hard for an embedded system like a raspberry pi to properly keep track of time due to the operating system
        Used a ribbon cable, which has finnicky connections

- Rocksat-X 2022
    Multiple `Arducam IMX477`_ were connected to Jetson Nanos.
    `Here is the link`_ to the python script for the arducam IMX477. The core code is in the `run` function of the recorder class.

    Pros:
        Works with a jetson Nano
        Works well when not used with hdmi adapters and hi-vac connectors
        Can be activated and deacivated on command
        Can be used with opencv for added control and affects
    Cons:
        Did not record footage mostly due to bad connection scheme
        Ribbon cable had finnicky connections


.. _`This Arducam`: https://www.amazon.com/Arducam-Camera-Raspberry-Interchangeable-M12x0-5/dp/B013JTY8WY/ref=sr_1_17_sspa?dchild=1&keywords=Raspberry%2BPi%2BCamera%2BLens&qid=1618427601&sr=8-17-spons&spLa=ZW5jcnlwdGVkUXVhbGlmaWVyPUEyS0ExOTI0T0sxVVQ3JmVuY3J5cHRlZElkPUEwMTQ4NzIwNlY3SkxJSVE4SlVPJmVuY3J5cHRlZEFkSWQ9QTAzMDExMjcxNlJRQjJRNFUxMkg3JndpZGdldE5hbWU9c3BfbXRmJmFjdGlvbj1jbGlja1JlZGlyZWN0JmRvTm90TG9nQ2xpY2s9dHJ1ZQ&th=1
.. _`This is the link`: https://github.com/aborger/RockSatX2020-KauIda/blob/Flight/devices/arducam.py
.. _`Arducam IMX477`: https://www.amazon.com/Arducam-12-3MP-Camera-Nvidia-Jetson/dp/B08F743RGG/ref=sr_1_16?crid=2VVMAKX3BU6PG&keywords=arducam&qid=1642523706&sprefix=arduca%2Caps%2C238&sr=8-16
.. _``Here is the link`: https://github.com/aborger/Marsha/blob/flight_left/marsha_core/nodes/record_longeron


Suggestions for Arducam Usage
-----------------------

It could be a good idea to use an additional computer seperate from the main mission computers that focus solely on controlling cameras.
However, this isn't entirely necessary the rocksat-x 2020 payload did not do this and was successful, but doing this would seperate the sub-systems.

In order to record successfully the camera must stop recording and save before power is turned off. 
Rocksat 2022 experienced some issues with this. 

Solely using timing isn't a reliable way to make sure the camera stops recording and saves in time.
A signal such as a timer event should be used to tell the camera it is time to stop recording and save because power is turning off soon.
OpenCV could also be used to periodically save what has been recorded so far (This should definitely be implemented).

As far as connection scheme, we have only used arducams with ribbon cables, but electrically it is difficult to do this if the camera must be outside of some sort of dry box.
There are cameras that use SPI or I2C to communicate with the computer, but this may be slower and could lower the frame rate/image quality because there is only 1 transmission wire instead of 15.
Finally, if you use opencv on a device that has a GPU such as the Jetson Nano, make sure you have the GPU enabled.

The following python script will return 0 if it is not using the gpu:

```
import cv2
count = cv2.cuda.getCudaEnabledDeviceCount()
print(count)
```