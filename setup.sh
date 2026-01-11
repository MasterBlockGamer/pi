#!/bin/bash
set -e
trap 'echo -e "${RED}Error on line $LINENO. Aborting.${NC}" >&2; exit 1' ERR

# Define colors for logging
GREEN="\e[32m"
YELLOW="\e[33m"
BLUE="\e[34m"
RED="\e[31m"
NC="\e[0m"

echo -e "${BLUE}>>> Updating system packages...${NC}"
sudo apt-get update
sudo apt-get full-upgrade -y
echo -e "${GREEN}System update complete.${NC}"

echo -e "${BLUE}>>> Installing general development tools...${NC}"
sudo apt-get install -y git curl wget build-essential pkg-config cmake ninja-build
echo -e "${GREEN}General tools installed.${NC}"

echo -e "${BLUE}>>> Installing Java (OpenJDK 17) and build tools...${NC}"
sudo apt-get install -y openjdk-17-jdk maven gradle
# Attempt to install OpenJDK 11 if available in repos
if apt-cache show openjdk-11-jdk >/dev/null 2>&1; then
    sudo apt-get install -y openjdk-11-jdk
else
    echo -e "${YELLOW}Warning: OpenJDK 11 not in standard repos; skipped.${NC}"
fi
echo -e "${BLUE}>>> Installing OpenCV Java bindings...${NC}"
sudo apt-get install -y libopencv-java
echo -e "${GREEN}Java environment ready.${NC}"

echo -e "${BLUE}>>> Installing Python 3 and libraries...${NC}"
sudo apt-get install -y python3 python3-pip python3-venv python3-opencv python3-flask python3-django
echo -e "${BLUE}>>> Upgrading pip and installing Python packages...${NC}"
python3 -m pip install --upgrade pip
python3 -m pip install tensorflow fastapi uvicorn
echo -e "${BLUE}>>> Installing GPIO and camera libraries...${NC}"
sudo apt-get install -y python3-gpiozero python3-rpi.gpio python3-picamera2 libgphoto2-dev v4l-utils libcamera-dev
echo -e "${GREEN}Python environment ready.${NC}"

echo -e "${BLUE}>>> Installing Node.js, npm, and yarn...${NC}"
sudo apt-get install -y nodejs npm yarnpkg
echo -e "${BLUE}>>> Installing common Node.js frameworks (Express, Angular, React, Next)...${NC}"
sudo npm install -g express-generator @angular/cli create-react-app next
echo -e "${GREEN}Node.js environment ready.${NC}"

echo -e "${BLUE}>>> Installing VS Code and Qt Creator...${NC}"
sudo apt-get install -y code qtcreator qtbase5-dev qttools5-dev qttools5-dev-tools
echo -e "${GREEN}Editors/IDEs installed.${NC}"

echo -e "${BLUE}>>> Installing container and virtualization tools...${NC}"
sudo apt-get install -y docker.io podman qemu-system qemu-user-static
echo -e "${GREEN}Container and emulation tools installed.${NC}"

echo -e "${GREEN}>>> All done! Your Raspberry Pi OS Lite development environment is ready.${NC}"
