@echo off

if DEFINED DESTDIR (
  echo "Destdir.............%DESTDIR%"
  set DESTDIR_ARG="--root=%DESTDIR%"
)

cd "C:/Users/borge/MARSHA/ros_dev/pc/catkin_ws/src/ROS-TCP-Endpoint"

if NOT EXIST "C:\Users\borge\MARSHA\ros_dev\pc\catkin_ws\install\lib/site-packages\" (
  mkdir "C:\Users\borge\MARSHA\ros_dev\pc\catkin_ws\install\lib/site-packages"
)

set "PYTHONPATH=C:\Users\borge\MARSHA\ros_dev\pc\catkin_ws\install\lib/site-packages;C:/Users/borge/MARSHA/ros_dev/pc/catkin_ws/build\lib/site-packages"
set "CATKIN_BINARY_DIR=C:/Users/borge/MARSHA/ros_dev/pc/catkin_ws/build"
for /f "usebackq tokens=*" %%a in ('C:\Users\borge\MARSHA\ros_dev\pc\catkin_ws\install') do (
  set _SETUPTOOLS_INSTALL_PATH=%%~pna
  set _SETUPTOOLS_INSTALL_ROOT=%%~da
)

"C:/opt/ros/melodic/x64/python.exe" ^
    "C:/Users/borge/MARSHA/ros_dev/pc/catkin_ws/src/ROS-TCP-Endpoint\setup.py" ^
    build --build-base "C:/Users/borge/MARSHA/ros_dev/pc/catkin_ws/build/ROS-TCP-Endpoint" ^
    install %DESTDIR_ARG%  ^
    --prefix="%_SETUPTOOLS_INSTALL_PATH%" ^
    --install-scripts="%_SETUPTOOLS_INSTALL_PATH%\bin" ^
    --root=%_SETUPTOOLS_INSTALL_ROOT%\
