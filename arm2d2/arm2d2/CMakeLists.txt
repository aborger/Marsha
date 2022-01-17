cmake_minimum_required(VERSION 3.1.3)
project(arm2d2)

find_package(catkin REQUIRED)

catkin_package()

install(DIRECTORY launch DESTINATION ${CATKIN_PACKAGE_SHARE_DESTINATION})

catkin_install_python(PROGRAMS
    scripts/folding
    DESTINATION ${CATKIN_PACKAGE_BIN_DESTINATION}
)