#!/bin/bash

# Main list of packages
packages=(
	"i3"
    "sxhkd"
    "suckless-tools"
    "tilix"
)

# Function to read common packages from a file
read_common_packages() {
    local common_file="$1"
    if [ -f "$common_file" ]; then
        packages+=( $(< "$common_file") )
    else
        echo "Common packages file not found: $common_file"
        exit 1
    fi
}

# Read common packages from file
read_common_packages $HOME/trixie-scripts/install_scripts/common_packages.txt

# Function to install packages if they are not already installed
install_packages() {
    local pkgs=("$@")
    local missing_pkgs=()

    # Check if each package is installed
    for pkg in "${pkgs[@]}"; do
        if ! dpkg -l | grep -q " $pkg "; then
            missing_pkgs+=("$pkg")
        fi
    done

    # Install missing packages
    if [ ${#missing_pkgs[@]} -gt 0 ]; then
        echo "Installing missing packages: ${missing_pkgs[@]}"
        sudo apt update
        sudo apt install -y "${missing_pkgs[@]}"
        if [ $? -ne 0 ]; then
            echo "Failed to install some packages. Exiting."
            exit 1
        fi
    else
        echo "All required packages are already installed."
    fi
}

# Call function to install packages
install_packages "${packages[@]}"

sudo systemctl enable avahi-daemon
sudo systemctl enable acpid

xdg-user-dirs-update
mkdir ~/Screenshots/


SCRIPT_DIR=~/trixie-scripts
REPO_URL=https://github.com/arkadysmith/dot_files.git

# Check if the directory already exists
if [ -d "$SCRIPT_DIR/dot_files" ]; then
    echo "Directory $SCRIPT_DIR/dot_files already exists."
else
    # Clone the repository
    echo "Cloning jag_dots repository..."
    git clone $REPO_URL $SCRIPT_DIR/dot_files
    if [ $? -eq 0 ]; then
        echo "Repository cloned successfully."
    else
        echo "Error: Failed to clone repository."
        exit 1
    fi
fi

# moving custom config
\cp -r ~/trixie-scripts/dot_files/.config/i3/ ~/.config/
\cp -r ~/trixie-scripts/dot_files/.config/picom/ ~/.config/
\cp -r ~/trixie-scripts/dot_files/.config/rofi/ ~/.config/

# check FT-Labs picom and nerdfonts are installed
bash ~/trixie-scripts/install_scripts/picom.sh

# adding gtk theme and icon theme
bash ~/trixie-scripts/colorschemes/blue.sh


