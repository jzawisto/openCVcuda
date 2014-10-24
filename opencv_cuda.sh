#! /bin/bash

cores='grep -c ^processor /proc/cpuinfo'
ver='3.8.1'

green='\e[1;32m' # '\e[1;32m' is too bright for white bg.
blue='\e[1;34m'
endColor='\e[0m'

echo -e "${blue}#######################################################################"
echo -e "Installation script for OpenCV with CUDA supptort \n
        by jzawisto "
echo -e "# CUDA   version 6.0.37 (64-bit)"
echo -e "# OpenCV version 2.4.9 "
echo -e "#######################################################################${endColor}"

echo "Installing dependencies (mostly development tools)..."
sudo apt-get -y upgrade
sudo apt-get -y install autoconf2.13 autoconf-archive 
sudo apt-get -y install build-essential gcc g++ 
sudo apt-get -y install libcoin80-dev libcoin80 libtool graphviz \
					    libgmp10 libgmp-dev libatlas-base-dev
sudo apt-get -y install python-dev python-pip python-numpy python-gevent python-levenshtein
sudo apt-get -y install git cmake cmake-gui 
sudo apt-get -y install checkinstall pkg-config yasm
echo "Installing dependencies (mostly development tools)...${green}[OK]${endColor}"

echo "Installing dependencies (algebra packs)..."
sudo apt-get -y install libeigen3-dev libblas3 libblas-dev liblapack3 liblapack-dev \
					    liblapacke libmpfr4 libmpfr-dev
echo "Installing dependencies (algebra packs)...${green}[OK]${endColor}"

echo "Removing ffmpeg, x264..."
sudo apt-get -y remove ffmpeg x264 libx264-dev
echo -e "Removing ffmpeg, x264...${green}[OK]${endColor}"

echo "Installing additional dependencies (TBB, TIFF, JPEG, JASPER, GSTREAMER)..."
sudo apt-get -y install libtbb-dev liborc-dev
sudo apt-get -y install libtiff4-dev libjpeg-dev libjasper-dev libjasper-runtime libjasper1
sudo apt-get -y install libavcodec-dev libavformat-dev libswscale-dev libdc1394-22-dev libgstreamer0.10-dev \
						libgstreamer-plugins-base0.10-dev libv4l-dev libgtk2.0-dev
echo "Installing additional dependencies (TBB, TIFF, JPEG, JASPER, GSTREAMER)...${green}[OK]${endColor}"

echo "Installing additional dependencies (OpenEXR is a high dynamic-range (HDR) library )..."
sudo apt-get -y install libilmbase-dev openexr exrtools libopenexr-dev

echo "Installing additional dependencies (faac, mp3lame, theora, vorbis )..."
sudo apt-get -y install libfaac-dev libmp3lame-dev libtheora-dev libvorbis-dev

echo "Installing additional dependencies (xvid, v4l, v4l-utils, ffmpeg )..."
sudo apt-get -y install x264 libxvidcore-dev libv4l-dev v4l-utils ffmpeg

echo "Installing additional dependencies (freeglut3, g++-4.4 (for CUDA compilation )..."
sudo apt-get -y install freeglut3 freeglut3-dev build-essential \libx11-dev libxmu-dev libxi-dev libgl1-mesa-glx \libglu1-mesa libglu1-mesa-dev gcc g++ gcc-4.4 g++-4.4

echo "Installing additional dependencies (libgstreamer*, gstreamer*, xine, xine2 )..."
sudo apt-get -y install libgstreamer*  gstreamer*
sudo apt-get -y install libxine-dev libxine2-dev

sudo ln -s /usr/lib/x86_64-linux-gnu/libglut.so.3 /usr/lib/libglut.so

echo -e "Installing ALL dependencies...${green}[OK]${endColor}"

########################## start CUDA ########################################
echo "Downloading CUDA installation..."
echo "This operation may take a while (~1GB to download)."
cd 
mkdir opencv_cuda
cd opencv_cuda
sudo apt-get -y install bumblebee bumblebee-nvidia primus nvidia-331
sudo apt-get -y install python-appindicator
sudo apt-get -y install git
mkdir git && cd git
git clone https://github.com/Bumblebee-Project/bumblebee-ui.git
cd bumblebee-ui
sudo ./INSTALL
bumblebee-indicator& # to startup applications

#wget http://developer.download.nvidia.com/compute/cuda/6_0/rel/installers/cuda_6.0.37_linux_64.run
#wget http://developer.download.nvidia.com/compute/cuda/repos/ubuntu1404/x86_64/cuda-repo-ubuntu1404_6.5-14_amd64.deb

echo -e "Downloading CUDA installation directory...${green}[OK]${endColor}"

echo "Downloading CUDA installation..."
#sudo chmod +x cuda_6.0.37_linux_64.run
#sh cuda_6.0.37_linux_64.run

#sudo dpkg -i cuda-repo-ubuntu1404_6.5-14_amd64.deb
#sudo apt-get update
#sudo apt-get -y install cuda

sudo apt-get -y install nvidia-cuda-toolkit #5.5 in default repository 14.04

#export PATH=/usr/local/cuda-6.0/bin:$PATH
#echo 'export PATH=/usr/local/cuda-6.0/bin:$PATH' > ~/.bash_rc
#export LD_LIBRARY_PATH=/usr/local/cuda-6.0/lib64:$LD_LIBRARY_PATH
#echo 'export LD_LIBRARY_PATH=/usr/local/cuda-6.0/lib64:$LD_LIBRARY_PATH' > ~/.bash_rc

# probably no need in CUDA 6.0
#sudo update-alternatives --remove-all gcc
#sudo update-alternatives --install /usr/bin/gcc gcc /usr/bin/gcc-4.4 20
#sudo update-alternatives --install /usr/bin/gcc gcc /usr/bin/gcc-4.7 50
#sudo update-alternatives --install /usr/bin/gcc gcc /usr/bin/gcc-4.8 60
#sudo update-alternatives --config gcc # choose 4.4, 4.7.x or 4.8 for CUDA 5.5/6.0 compilation

echo "Downloading CUDA installation...${green}[OK]${endColor}"


echo "Downloading and extracting OpenCV library..."
wget -O opencv-2.4.9 http://downloads.sourceforge.net/project/opencvlibrary/opencv-unix/2.4.9/opencv-2.4.9.zip?r=http%3A%2F%2Fsourceforge.net%2Fprojects%2Fopencvlibrary%2Ffiles%2Fopencv-unix%2F2.4.9%2F&ts=1408353813&use_mirror=cznic 

unzip opencv-2.4.9  
cd opencv

echo "Installing OpenCV library..."
mkdir build
cd build
cmake ..
make -j$cores

sudo -s 
make install
echo '/usr/local/lib' > /etc/ld.so.conf.d/opencv.conf
ldconfig
exit

echo -e "Downloading, extracting and installing OpenCV library...${green}[OK]${endColor}"

echo "#######################################################################"
echo "#######################################################################"

echo "Installing OpenCV with CUDA...${green}[OK]${endColor}"



