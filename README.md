# inspectrum-centos7-x86_64-build

Install centos-7 2009

Setup developer enviroment
[user@localhost ~]$ sudo yum groupinstall "development tools"
[user@localhost ~]$ sudo yum install git
[user@localhost ~]$ git clone https://github.com/miek/inspectrum.git
[user@localhost ~]$ git clone https://github.com/jgaeddert/liquid-dsp.git
[user@localhost ~]$ mkdir my-root

[user@localhost ~]$ sudo yum install -y epel-release
[user@localhost ~]$ sudo yum repolist
[user@localhost ~]$ sudo yum install cmake3
[user@localhost ~]$ sudo yum install fftw
[user@localhost ~]$ sudo yum install qt5-qtbase-static.x86_64
[user@localhost ~]$ cmake3 --version

Building liquid DSP
[user@localhost ~]$ cd liquid-dsp/
[user@localhost liquid-dsp]$ ./bootstrap.sh 
[user@localhost liquid-dsp]$ ./configure 
[user@localhost liquid-dsp]$ sudo yum install fftw-static.x86_64
[user@localhost liquid-dsp]$ ./configure
[user@localhost liquid-dsp]$ ./configure --prefix=/home/user/my-root
[user@localhost liquid-dsp]$ make
[user@localhost liquid-dsp]$ make install
mkdir -p /home/user/my-root/include
mkdir -p /home/user/my-root/include/liquid
mkdir -p /home/user/my-root/lib
install -m 644 -p libliquid.a libliquid.so /home/user/my-root/lib
install -m 644 -p include/liquid.h /home/user/my-root/include/liquid
  directory /home/user/my-root
[user@localhost liquid-dsp]$ sudo ldconfig


Update gcc and build inspectrum

[user@localhost ~]$ cd inspectrum/
[user@localhost inspectrum]$ mkdir build
[user@localhost inspectrum]$ cd build
[user@localhost build]$ sudo yum install centos-release-scl
[user@localhost build]$ sudo yum install devtoolset-8
[user@localhost build]$ sudo yum install devtoolset-8-gcc*
[user@localhost build]$ scl enable devtoolset-8 bash
[user@localhost build]$ export C_INCLUDE_PATH=$HOME/my-root/include
[user@localhost build]$ export CPLUS_INCLUDE_PATH=$HOME/my-root/include
[user@localhost build]$ export LIBRARY_PATH=$HOME/my-root/lib
[user@localhost build]$ cmake3 -DCMAKE_INSTALL_PREFIX=/home/user/my-root ..
[user@localhost build]$ make
[user@localhost build]$ make install
-- Installing: /home/user/my-root/bin/inspectrum


--------------------------------------------------------------------
--------------------------------------------------------------------

TO USE: simply point bash to the libraries it needs to find:

[user@localhost bin]$ ./inspectrum 
./inspectrum: error while loading shared libraries: libliquid.so: cannot open shared object file: No such file or directory
[user@localhost bin]$ echo $LD_LIBRARY_PATH

[user@localhost bin]$ export LD_LIBRARY_PATH=/$HOME/my-root/lib
[user@localhost bin]$ ./inspectrum 

--------------------------------------------------------------------
----------------------------------------------------------------------

TO MOVE TO Another computer:
copy all files in my-root to another machine
point LD_LIBRARY_PATH to this folder
execute inspectrum

