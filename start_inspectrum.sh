#!/bin/sh

#All of the necessary files should be within the inspectrum-centos-7 folder.
# The libraries have not been installed system wide and again are local to this folder.
# We have to tell LD where the shared (.so) files in order to link at runtime.
# At somepoint it would be very cool to staticly link this so that everything is in the executable file.

echo "export LD_LIBRARY_PATH=../lib"
export LD_LIBRARY_PATH=../lib
./inspectrum &
