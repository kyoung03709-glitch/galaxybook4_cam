📸 Galaxy Book 4 Camera Integration for ROS 2 Jazzy

This repository provides a comprehensive guide and automation scripts to enable the Intel IPU6 Internal Camera on the Samsung Galaxy Book 4 (Intel Meteor Lake architecture) for use within the ROS 2 Jazzy Jalisco environment.
💡 Background

Modern Intel laptops, including the Galaxy Book 4, utilize the IPU6 (Image Processing Unit) interface instead of the traditional V4L2 driver standard. Consequently, standard ROS 2 camera nodes (like v4l2_camera) cannot detect the device natively. This project bridges that gap by using v4l2-relayd and GStreamer pipelines to create a virtual V4L2 device compatible with ROS 2.
📋 System Requirements

    Hardware: Samsung Galaxy Book 4 (Intel Arc GPU / IPU6 Camera)

    OS: Ubuntu 24.04 LTS (Noble Numbat)

    ROS 2 Distribution: Jazzy Jalisco

    Essential Tools: GStreamer, v4l2loopback, v4l2-relayd

🚀 Installation & Setup
1. IPU6 Driver and Environment Setup

The provided setup.sh script automates the installation of IPU6 firmware, configures v4l2loopback, and initializes the virtual video device.
Bash

# Clone the repository
git clone https://github.com/kyoung03709-glitch/galaxybook4_cam.git
cd galaxybook4_cam

# Grant execution permissions and run the script
chmod +x scripts/setup.sh
./scripts/setup.sh

2. Verify Virtual Video Device

Once the installation is complete, verify that the virtual device (usually /dev/video0) has been created to receive the IPU6 signal.
Bash

v4l2-ctl --list-devices
# You should see a 'v4l2 loopback' device in the output list.

🎥 ROS 2 Camera Integration (Execution)

To broadcast the Galaxy Book 4 camera data as a ROS 2 topic, we utilize the gscam node.
1. Set Environment Variables (GStreamer Pipeline)

Configure the pipeline to read from the virtual device and convert it to the RGB format required by ROS 2.
Bash

export GSCAM_CONFIG="v4l2src device=/dev/video0 ! videoconvert ! video/x-raw,format=RGB ! videoconvert"

2. Run the gscam Node
Bash

ros2 run gscam gscam_node

3. Verify Video Data

Open a new terminal and run rqt_image_view to confirm the /image_raw topic is streaming correctly.
Bash

ros2 run rqt_image_view rqt_image_view
