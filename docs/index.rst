Marsha Docs - Meta Artificial Intelligent Robotic Spacecraft Handy Arm
===================================

**Marsha** stands for Meta Artificial intelligent Robotic Spacecraft Handy Arm.

Embedded Platform
-------

This is the documentation for the Embedded Platform.


Device Platforms
----------------

Three device platforms are used to for marsha development and operation:

* Auxiliary Platform (Linux 18.04 Computer)

   * The Auxiliary Platform is used to manually control the robot as well as program it.

   * `Access Auxiliary Platform Wiki <https://aborger-marsha.readthedocs.io/en/auxiliary-platform/>`_

* Embedded Platform (Jetson Nano)

   * The Embedded Platform runs ros-melodic and acts as a high level controller responsible for mission management (payload control system),
     computer vision, artificial intelligence, and robotic motion planning.

   * `Access Embedded Platform Wiki <https://aborger-marsha.readthedocs.io/en/embedded-platform/>`_

*  Microcontroller Platform (Teensy 4.1)

   * The Embedded Platform gives the Microcontroller position commands for each joint in the robotic arm.
     The Microcontroller implements a closed loop controller to move stepper motors with the position commands 
     as the setpoint and encoders as the feedback.

   * `Access Microcontroller Platform Wiki <https://aborger-marsha.readthedocs.io/en/microcontroller-platform/>`_


.. note::

   This project is under active development. Marsha name subject to change.

Getting Started
--------
The following guides provide instructions to install marsha and begin with a demo of the basic functionality.

.. toctree::
   :caption: Guides

   guides/install
   guides/introduction


Robotic Control Components
--------
.. toctree::
   :caption: Component Documentation

   components/nodes
   components/programs
   components/services

Payload Control System
---------
.. toctree::
   :caption: Payload Control System
   
   payload_control_system/arducams

API Documentation
--------
.. toctree::
   :caption: API Documentation
