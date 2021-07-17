#!/bin/sh

if [ -n "$DESTDIR" ] ; then
    case $DESTDIR in
        /*) # ok
            ;;
        *)
            /bin/echo "DESTDIR argument must be absolute... "
            /bin/echo "otherwise python's distutils will bork things."
            exit 1
    esac
fi

echo_and_run() { echo "+ $@" ; "$@" ; }

echo_and_run cd "/home/aaron/MARSHA/ros_dev/nano/catkin_ws/src/rosbridge_suite-release"

# ensure that Python install destination exists
echo_and_run mkdir -p "$DESTDIR/home/aaron/MARSHA/ros_dev/nano/catkin_ws/install/lib/python2.7/dist-packages"

# Note that PYTHONPATH is pulled from the environment to support installing
# into one location when some dependencies were installed in another
# location, #123.
echo_and_run /usr/bin/env \
    PYTHONPATH="/home/aaron/MARSHA/ros_dev/nano/catkin_ws/install/lib/python2.7/dist-packages:/home/aaron/MARSHA/ros_dev/nano/catkin_ws/build/lib/python2.7/dist-packages:$PYTHONPATH" \
    CATKIN_BINARY_DIR="/home/aaron/MARSHA/ros_dev/nano/catkin_ws/build" \
    "/usr/bin/python2" \
    "/home/aaron/MARSHA/ros_dev/nano/catkin_ws/src/rosbridge_suite-release/setup.py" \
     \
    build --build-base "/home/aaron/MARSHA/ros_dev/nano/catkin_ws/build/rosbridge_suite-release" \
    install \
    --root="${DESTDIR-/}" \
    --install-layout=deb --prefix="/home/aaron/MARSHA/ros_dev/nano/catkin_ws/install" --install-scripts="/home/aaron/MARSHA/ros_dev/nano/catkin_ws/install/bin"
