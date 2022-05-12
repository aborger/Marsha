# https://github.com/IntelRealSense/librealsense/issues/6980#issuecomment-666858977
echo "Updating Cmake..."
wget http://www.cmake.org/files/v3.13/cmake-3.13.0.tar.gz
tar xpvf cmake-3.13.0.tar.gz cmake-3.13.0/
cd cmake-3.13.0/
./bootstrap --system-curl
make -j6
echo 'export PATH=/home/nvidia/cmake-3.13.0/bin/:$PATH' >> ~/.bashrc
source ~/.bashrc
cd ..
rm -r cmake-3.13.0
rm cmake-3.13.0.tar.gz 
