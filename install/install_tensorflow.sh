# https://docs.nvidia.com/deeplearning/frameworks/install-tf-jetson-platform/index.html
sudo apt-get update
sudo apt-get install libhdf5-serial-dev hdf5-tools libhdf5-dev zlib1g-dev zip libjpeg8-dev liblapack-dev libblas-dev gfortran

sudo apt-get install python3-pip
sudo pip3 install -U --no-deps -r tf_dependencies.txt

sudo pip3 install --extra-index-url https://developer.download.nvidia.com/compute/redist/jp/v461 tensorflow-gpu==1.15.5+nv22.1
