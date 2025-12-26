#!/bin/bash
# 환경 설정 로드
source /opt/ros/jazzy/setup.bash
export RMW_IMPLEMENTATION=rmw_cyclonedds_cpp

# GSCAM 설정 및 실행
export GSCAM_CONFIG="v4l2src device=/dev/video0 ! videoconvert ! video/x-raw,format=RGB ! videoconvert"
echo "Starting Galaxy Book 4 Camera Node..."
ros2 run gscam gscam_node
