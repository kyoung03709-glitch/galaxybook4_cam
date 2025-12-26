#!/bin/bash
echo "Installing ROS 2 Jazzy Camera Packages..."
sudo apt update
sudo apt install v4l-utils gstreamer1.0-tools gstreamer1.0-plugins-good gstreamer1.0-plugins-bad v4l2loopback-utils -y
sudo apt install ros-jazzy-rmw-cyclonedds-cpp ros-jazzy-gscam -y

echo "Optimizing Network Buffer for Cyclone DDS..."
sudo sysctl -w net.core.rmem_max=2147483647

echo "Restarting IPU6 Camera Driver..."
sudo systemctl restart v4l2-relayd
