#!/bin/bash

echo "=== Raspberry Pi Cross-Distro Setup ==="

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m'

print_status() { echo -e "${GREEN}[+]${NC} $1"; }
print_warning() { echo -e "${YELLOW}[!]${NC} $1"; }
print_error() { echo -e "${RED}[!]${NC} $1"; }

# Detect package manager
if command -v apt &> /dev/null; then
    PM="apt"
    INSTALL="sudo apt install -y"
    UPDATE="sudo apt update && sudo apt upgrade -y"
elif command -v pacman &> /dev/null; then
    PM="pacman"
    INSTALL="sudo pacman -S --noconfirm"
    UPDATE="sudo pacman -Syu --noconfirm"
else
    print_error "Unknown package manager"
    exit 1
fi

print_status "Using package manager: $PM"

# Update system
print_status "Updating system..."
eval $UPDATE

# Install basic tools
print_status "Installing basic tools..."
$INSTALL git curl wget nano vim htop tree

# Install Python and OpenCV
print_status "Installing Python and OpenCV..."
if [ "$PM" = "apt" ]; then
    $INSTALL python3 python3-pip python3-venv python3-opencv
elif [ "$PM" = "pacman" ]; then
    $INSTALL python python-pip python-virtualenv opencv
fi

# Install virtualenv wrapper
print_status "Installing virtualenv..."
pip3 install virtualenv virtualenvwrapper

# Install Java
print_status "Installing Java..."
if [ "$PM" = "apt" ]; then
    $INSTALL default-jdk
elif [ "$PM" = "pacman" ]; then
    $INSTALL jdk-openjdk
fi

# Install Node.js (JavaScript)
print_status "Installing Node.js..."
if [ "$PM" = "apt" ]; then
    $INSTALL nodejs npm
elif [ "$PM" = "pacman" ]; then
    $INSTALL nodejs npm
fi

# Install Qt
print_status "Installing Qt..."
if [ "$PM" = "apt" ]; then
    $INSTALL qt5-default qtcreator
elif [ "$PM" = "pacman" ]; then
    $INSTALL qt5-base qt5-tools qtcreator
fi

# Install additional libraries
print_status "Installing development libraries..."
if [ "$PM" = "apt" ]; then
    $INSTALL build-essential cmake libatlas-base-dev libhdf5-dev
elif [ "$PM" = "pacman" ]; then
    $INSTALL base-devel cmake
fi

# Setup virtualenvwrapper
print_status "Setting up virtualenvwrapper..."
echo "export WORKON_HOME=$HOME/.virtualenvs" >> ~/.bashrc
echo "export VIRTUALENVWRAPPER_PYTHON=/usr/bin/python3" >> ~/.bashrc
echo "source /usr/local/bin/virtualenvwrapper.sh" >> ~/.bashrc

# Run SSH setup
print_status "Setting up SSH..."
chmod +x CheckSSH
./CheckSSH

print_status "=== Setup Complete ==="
echo "Installed: Python, OpenCV, Java, Node.js, Qt, virtualenv"
print_warning "Please restart your terminal or run: source ~/.bashrc"
