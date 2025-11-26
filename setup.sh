#!/bin/bash

echo "===================================================================="
echo "🧠 SMART RASPBERRY PI SETUP - UNIVERSAL INSTALLER"
echo "===================================================================="

# ==================== CONFIGURATION ====================
# Colors for beautiful output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m'

# Output functions
print_status() { echo -e "${GREEN}[✓]${NC} $1"; }
print_warning() { echo -e "${YELLOW}[!]${NC} $1"; }
print_error() { echo -e "${RED}[✗]${NC} $1"; }
print_info() { echo -e "${BLUE}[i]${NC} $1"; }

# ==================== SYSTEM DETECTION ====================
detect_system() {
    print_info "Detecting system configuration..."
    
    # Package manager detection
    if command -v apt &> /dev/null; then
        PM="apt"
        INSTALL="sudo apt install -y"
        UPDATE="sudo apt update && sudo apt upgrade -y"
        print_status "Detected: Debian/Ubuntu (apt)"
    elif command -v pacman &> /dev/null; then
        PM="pacman"
        INSTALL="sudo pacman -S --noconfirm --needed"
        UPDATE="sudo pacman -Syu --noconfirm"
        print_status "Detected: Arch Linux (pacman)"
    elif command -v dnf &> /dev/null; then
        PM="dnf"
        INSTALL="sudo dnf install -y"
        UPDATE="sudo dnf update -y"
        print_status "Detected: Fedora/RHEL (dnf)"
    else
        print_error "Unsupported package manager"
        exit 1
    fi

    # Architecture detection
    ARCH=$(uname -m)
    print_status "Architecture: $ARCH"
}

# ==================== CORE INSTALLATION FUNCTIONS ====================
update_system() {
    print_info "Updating system packages..."
    eval $UPDATE
    print_status "System updated"
}

install_essentials() {
    print_info "Installing essential system tools..."
    
    if [ "$PM" = "apt" ]; then
        $INSTALL \
            git curl wget nano vim htop tree \
            net-tools openssh-client openssh-server \
            unzip zip tar gzip bzip2 xz-utils \
            neofetch inxi lsb-release ca-certificates \
            software-properties-common apt-transport-https \
            gnupg2 dirmngr
    elif [ "$PM" = "pacman" ]; then
        $INSTALL \
            git curl wget nano vim htop tree \
            net-tools openssh unzip zip tar gzip bzip2 xz \
            neofetch inxi lsb-release ca-certificates \
            gnupg
    fi
    print_status "Essential tools installed"
}

install_compilers() {
    print_info "Installing compilers and build tools..."
    
    if [ "$PM" = "apt" ]; then
        $INSTALL \
            build-essential gcc g++ gdb make cmake \
            automake autoconf clang llvm llvm-dev \
            gcc-arm-linux-gnueabihf binutils binutils-arm-linux-gnueabihf \
            pkg-config libtool ninja-build cmake-curses-gui \
            checkinstall devscripts debhelper
    elif [ "$PM" = "pacman" ]; then
        $INSTALL \
            base-devel gcc gdb make cmake \
            automake autoconf clang llvm \
            arm-linux-gnueabihf-gcc binutils \
            pkg-config libtool ninja cmake-gui
    fi
    print_status "Compilers and build tools installed"
}

install_python_stack() {
    print_info "Installing Python development stack..."
    
    if [ "$PM" = "apt" ]; then
        $INSTALL \
            python3 python3-pip python3-venv python3-dev \
            python3-opencv python3-numpy python3-scipy \
            python3-matplotlib python3-pandas python3-jupyter
    elif [ "$PM" = "pacman" ]; then
        $INSTALL \
            python python-pip python-virtualenv \
            opencv python-numpy python-scipy \
            python-matplotlib python-pandas jupyter
    fi
    
    # Python packages via pip
    print_info "Installing Python packages..."
    pip3 install --upgrade pip
    pip3 install \
        virtualenv virtualenvwrapper \
        requests flask django fastapi \
        pillow scikit-learn tensorflow keras \
        opencv-python-headless \
        jupyterlab ipykernel
    
    print_status "Python stack installed"
}

install_java_stack() {
    print_info "Installing Java development stack..."
    
    if [ "$PM" = "apt" ]; then
        $INSTALL \
            default-jdk default-jre maven gradle \
            openjdk-11-jdk openjdk-17-jdk
    elif [ "$PM" = "pacman" ]; then
        $INSTALL \
            jdk-openjdk jre-openjdk maven gradle
    fi
    
    # Set JAVA_HOME
    if command -v java &> /dev/null; then
        JAVA_PATH=$(readlink -f $(which java) | sed 's|/bin/java||')
        echo "export JAVA_HOME=$JAVA_PATH" >> ~/.bashrc
        echo "export PATH=\$JAVA_HOME/bin:\$PATH" >> ~/.bashrc
    fi
    print_status "Java stack installed"
}

install_nodejs_stack() {
    print_info "Installing Node.js/JavaScript stack..."
    
    if [ "$PM" = "apt" ]; then
        # Add NodeSource repository for latest Node.js
        curl -fsSL https://deb.nodesource.com/setup_lts.x | sudo -E bash -
        $INSTALL nodejs
        $INSTALL node-gyp
    elif [ "$PM" = "pacman" ]; then
        $INSTALL nodejs npm node-gyp
    fi
    
    # Global npm packages
    print_info "Installing global npm packages..."
    sudo npm install -g \
        npm@latest \
        typescript \
        yarn \
        nodemon \
        pm2 \
        express-generator \
        @angular/cli \
        react-native-cli
    
    print_status "Node.js stack installed"
}

install_qt_stack() {
    print_info "Installing Qt development stack..."
    
    if [ "$PM" = "apt" ]; then
        $INSTALL \
            qt5-default qtcreator \
            qml-module-qtquick-controls2 \
            qml-module-qtquick-layouts \
            qml-module-qtquick-window2 \
            qtdeclarative5-dev \
            qt5-doc \
            qt5-doc-html
    elif [ "$PM" = "pacman" ]; then
        $INSTALL \
            qt5-base qt5-tools qtcreator \
            qt5-quickcontrols2 \
            qt5-doc
    fi
    print_status "Qt stack installed"
}

install_libraries() {
    print_info "Installing development libraries..."
    
    if [ "$PM" = "apt" ]; then
        $INSTALL \
            libatlas-base-dev libhdf5-dev libhdf5-serial-dev \
            libjasper-dev libqtgui4 libqt4-test \
            libopenblas-dev libblas-dev liblapack-dev \
            libgstreamer1.0-dev libgstreamer-plugins-base1.0-dev \
            libgtk-3-dev libcanberra-gtk-module libcanberra-gtk3-module \
            libavcodec-dev libavformat-dev libswscale-dev \
            libtiff5-dev libjpeg-dev libpng-dev \
            libfreetype6-dev libharfbuzz-dev \
            libssl-dev libffi-dev libxml2-dev libxslt1-dev \
            zlib1g-dev libbz2-dev libreadline-dev libsqlite3-dev
    elif [ "$PM" = "pacman" ]; then
        $INSTALL \
            openblas lapack blas \
            gstreamer gst-plugins-base gst-plugins-good \
            gtk3 libcanberra \
            ffmpeg \
            libtiff libjpeg-turbo libpng \
            freetype2 harfbuzz \
            openssl libffi libxml2 libxslt \
            zlib bzip2 readline sqlite
    fi
    print_status "Development libraries installed"
}

setup_ssh() {
    print_info "Setting up SSH..."
    
    # Make CheckSSH executable and run it
    if [ -f "CheckSSH" ]; then
        chmod +x CheckSSH
        ./CheckSSH
    else
        print_warning "CheckSSH script not found, setting up SSH manually..."
        if [ "$PM" = "apt" ]; then
            $INSTALL openssh-server
        fi
        sudo systemctl enable ssh
        sudo systemctl start ssh
        print_status "SSH setup completed"
    fi
}

setup_environment() {
    print_info "Setting up development environment..."
    
    # Virtualenvwrapper setup
    echo "export WORKON_HOME=\$HOME/.virtualenvs" >> ~/.bashrc
    echo "export VIRTUALENVWRAPPER_PYTHON=/usr/bin/python3" >> ~/.bashrc
    echo "source /usr/local/bin/virtualenvwrapper.sh" >> ~/.bashrc
    
    # Custom aliases
    echo "alias ll='ls -la'" >> ~/.bashrc
    echo "alias py='python3'" >> ~/.bashrc
    echo "alias pip-upgrade='pip3 list --outdated --format=freeze | grep -v \"^\\-e\" | cut -d = -f 1 | xargs -n1 pip3 install -U'" >> ~/.bashrc
    echo "alias jupyter-lab='jupyter lab --ip=0.0.0.0 --no-browser'" >> ~/.bashrc
    echo "alias system-info='neofetch'" >> ~/.bashrc
    
    # Create project directories
    mkdir -p ~/projects/{python,java,web,scripts,testing,qt}
    mkdir -p ~/venvs/{cv,web,ml,general}
    
    # Git configuration
    git config --global pull.rebase false
    git config --global init.defaultBranch main
    
    print_status "Environment setup completed"
}

# ==================== MAIN EXECUTION ====================
main() {
    detect_system
    
    # Execute installation steps
    update_system
    install_essentials
    install_compilers
    install_python_stack
    install_java_stack
    install_nodejs_stack
    install_qt_stack
    install_libraries
    setup_ssh
    setup_environment
    
    echo ""
    echo "===================================================================="
    print_status "🎉 SETUP COMPLETED SUCCESSFULLY!"
    echo "===================================================================="
    print_info "Installed: Python, OpenCV, Java, Node.js, Qt, Compilers"
    print_info "Created: Project directories, Virtual environments, Aliases"
    print_warning "Please restart your terminal or run: source ~/.bashrc"
    print_info "Project directories created in: ~/projects/"
    print_info "Virtual environments in: ~/venvs/"
    echo "===================================================================="
}

# ==================== MASTERBLOCK FINAL ANIMATION ====================
show_masterblock_animation() {
    print_status "Initializing MasterBlock system..."
    
    # Check if masterblock.sh exists, if not create it
    if [ ! -f "masterblock.sh" ]; then
        print_warning "MasterBlock animation not found, creating it..."
        create_masterblock_script
    fi
    
    chmod +x masterblock.sh
    ./masterblock.sh
}

# Function to create masterblock.sh if missing
create_masterblock_script() {
    cat > masterblock.sh << 'EOF'
#!/bin/bash
# MasterBlock Mathematical Animation - Auto-generated
# Colors and animation code would be here...
# [INSERT THE ENTIRE MASTERBLOCK SCRIPT CONTENT]
EOF
    print_status "MasterBlock animation script created"
}

# At the very end of setup.sh, after main() function:
main "$@"

# Show MasterBlock animation after setup completes
show_masterblock_animation
