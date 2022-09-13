============
Introduction
============

.. contents:: Table of Contents


What is Marsha
=============

Marsha is a project devoted to develop artificial intelligence controlled robot arms capable of assisting in the space industry from orbit.

The goal is to develop a system that can grasp and manipulate moving objects in zero gravity. Such system would be beneficial for manufacturing, assembly and servicing spacecraft in-orbit as well as space debris removal.

Large spacecraft will need to be manufactured in space to overcome the cost of launching fully manufactured spacecraft into orbit. Eventually, as lunar and asteroid mining technology is developed, the resources to manufacture spacecraft will already be in space.

Humans may be able to perform this manufacturing and assembly effort, however working in a manufacturing environment in space while wearing a cumbersome space suit is ideal for disaster to strike.

In addition, large spacecraft such as `O'Neill Cylinders`_ will be far to complex and expensive for humans to build. A larger, more expendible workforce will be needed.

.. _`O'Neill Cylinders`: https://en.wikipedia.org/wiki/O%27Neill_cylinder

Such O`Neill Cylinders are appealing for space tourism, research, exploration, and moving polluting industries off of Earth.


Why has this not been achieved already
===============

The private space industry has just begun which means regulations have not been developed to enforce standards across the industry.

NASA, Space Force and the FAA are currently using aviation industry standards to define the best practices to develop aerospace technology.

Some of these standards work, but others do not.


The standard most commonly used in aviation to govern software is `DO-178`_ which requires software developers to plan exactly how the software will act, develop the software, and then verify and proove the software will not act in any other way.

Since DO-178 has mostly been adopted by the space industry, the software for any spacecraft with a crew must follow DO-178 or similar standards.

This makes it difficult to argue for an autonomous robotic arm on-board a spacecraft. In this context, autonomous does not even mean using artificial intelligence. It simply means adapting to the environment in any way which is difficult to do while following DO-178.

In addition, there has never been a system that utilizes machine learning that has been certified for airborne applications. Several attempts are being made to certify a machine learning algorithm with DO-178. `Read more here`_

DO-178 has different levels of rigor toward which the software must be developed. Low criticality software follows DAL-D (Design Assurance Level D). A robotic arm on a crewed or uncrewed spacecraft would be considered DAL-D.

Should Marsha be deployed on an orbital spacecraft governed by NASA, Space Force and the FAA its software should be developed to DAL-D.



Historically, Marsha has used a deep reinforcement learning approach to control a robotic arm. This approach could pass the DO-178C DAL-D standard if a deterministic algorithm is fully trained in simulation before being deployed.

In addition, more critical software such as that used to avionics that controls the spacecraft or rocket engine must be developed to the DAL-B and DAL-A standards which is much more strict.

Developing a deep reinforcement learning algorithm that can be certified to the DAL-D standard would make it easier to eventually use that algorithm for avionics software that must follow more strict standards.


.. _`DO-178`: https://en.wikipedia.org/wiki/DO-178C

.. _`Read more here`: https://ntrs.nasa.gov/api/citations/20210019093/downloads/main.pdf



Previous Marsha Flights
===============

Marsha flew on a NASA Terrier-Improved Malemute sounding rocket in August 2022. The goal of this mission was to throw and catch a ball with two robotic arms.

The ball catching procedure was trained in simulation using the `TD3 algorithm`_ (Twin Delayed Deep Deterministic Policy Gradients algorithm). 

This algorithm learned what angle to catch the ball given its current position and velocity, but in a way that the arm could move there without colliding with anything.

The results of this flight were inconclusive at no fault of the artificial intelligence software, but due to complex project management problems.

- `Read more about the artificial intelligence software for the 2022 flight.`_

- `Read more about the results of the flight.`

.. _`TD3 algorithm`: https://spinningup.openai.com/en/latest/algorithms/td3.html

.. _`Read more about the artificial intelligence software for the 2022 flight.`: https://drive.google.com/file/d/16puG0EUAEeprjh0N5W_qU4mVsE8ddA2B/view?usp=sharing


Marsha 2023
=================

Throughout 2022 and 2023, a second version of Marsha will be developed and will compete for a spot on a NASA sounding rocket flight in August 2023. In addition, it will be renamed as it's acronym no longer has meaning.

The goal will be to develop a new artificial intelligence algorithm that can catch a ball as well as different shaped objects.

While NASA, Blue Origin, and Open Robotics develop `Space ROS`_ a framework that follows DO-178, Marsha 2023 will continue to use ROS Melodic which can easily be migrated to Space ROS at a later date.

The artificial intelligence software will follow DO-178C so the two software components can be combined to get a certifiable safety-critical artificial intelligence controlled robotic arm.

To do so, the artificial intelligence algorithm will be developed in C, trained in simulation, and then verified that it follows DAL-D standards.

This artificial intelligence algorithm will take a 3D-point cloud generated by the `Intel RealSense D435`__ as the input.

The Yolo-3-tiny-288 network will detect the object returning only the 3D-point cloud of the object. This Yolo algorithm will not follow DO-178, but object detection is a common problem, so Yolo will be used for now in hopes someone else developes a flight certified object detection algorithm.
This algorithm is very fast and light weight so it will be able to detect and track different shaped object well.

A `Transformer Model`_ will be trained as the TD3 actor network allowing the network to learn the dynamics of a subset of points in the 3D-point cloud. The key to the transformer is it can learn which points provide the most information and ignores the rest (This is my assumption, transformers are usually used for language processing not object tracking and predicting). The TD3 transformer model serves as the encoder in the `6-DOF GraspNet`_ `Variational Auto Encoder`_. Therefore, the output of the transformer model is the latent space for the grasp net which can then be decoded into the position and `quaternion`_ vectors representing the grasp.

I'd like to conclude with some reassurance. I have included links for any complex topics to allow myself and anyone who would like to learn more or refresh their memory. However, each one of those topics incorporates multiple years worth of AI research that I read instead of paying attention in class and doing homework. You do not need to know what those topics are unless you are working directly with the AI. If you would like to learn these topic and don't know where to start, reach out to me (Aaron Borger).


.. _`Space ROS`: https://www.openrobotics.org/blog/2022/2/2/rosinspace

.. _`Intel RealSense D435`: https://www.intelrealsense.com/depth-camera-d435/

.. _`Transformer Model`: https://en.wikipedia.org/wiki/Transformer

.. _`6-DOF GraspNet`: https://arxiv.org/pdf/1905.10520.pdf

.. _`Variational Auto Encoder`: https://towardsdatascience.com/understanding-variational-autoencoders-vaes-f70510919f73

.. _`quaternion`: https://en.wikipedia.org/wiki/Quaternion
