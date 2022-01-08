cmake_minimum_required(VERSION 3.1.3)
project(ar_mini)

find_package(catkin REQUIRED)

catkin_package()

install(DIRECTORY launch DESTINATION ${CATKIN_PACKAGE_SHARE_DESTINATION})