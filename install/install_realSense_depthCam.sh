# https://github.com/IntelRealSense/librealsense/issues/8324
wget https://github.com/IntelRealSense/librealsense/archive/refs/tags/v2.50.0.zip
unzip v2.50.0.zip
cd librealsense-2.50.0
mkdir build
cd build
cmake ../ -DFORCE_RSUSB_BACKEND=ON -DBUILD_PYTHON_BINDINGS:bool=true -DPYTHON_EXECUTABLE=/usr/bin/python3.6 -DCMAKE_BUILD_TYPE=release -DBUILD_EXAMPLES=true -DBUILD_GRAPHICAL_EXAMPLES=true -DBUILD_WITH_CUDA:bool=true
make -j4
sudo make install

echo -e "
#RealSense Depth Camera
export PATH=$PATH:~/.local/bin
export PYTHONPATH=$PYTHONPATH:/usr/local/lib
export PYTHONPATH=$PYTHONPATH:/usr/local/lib/python3.6/pyrealsense2
" >> ~/.bashrc

cd ../../
sudo rm -r librealsense-2.50.0/
rm v2.50.0.zip
