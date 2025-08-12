#!/bin/bash

# Check if git is installed
if ! command -v git &> /dev/null; then
    echo "Git is not installed. Attempting to install Git..."
    
    # Use apt to install git
    if command -v apt &> /dev/null; then
        sudo apt update
        sudo apt install git -y
    else
        echo "Cannot install Git automatically using apt. Please install Git manually and run this script again."
        exit 1
    fi
    
    # Check again if git is installed after attempting to install
    if ! command -v git &> /dev/null; then
        echo "Git installation failed. Please install Git manually and run this script again."
        exit 1
    fi
fi

echo "Git is installed. Continuing with the script..."
# Add further commands here after ensuring Git is installed



# Clone the repository into the home directory
git clone https://github.com/arkadysmith/trixie-scripts ~/trixie-scripts
git clone https://github.com/arkadysmith/dot_files ~/trixie-scripts/dot_files


clear
echo "
 -ok-"

# Make setup.sh executable (if needed, though it's typically already executable)
# chmod +x setup.sh packages.sh

# Run the setup script
bash ~/trixie-scripts/install_scripts/setup.sh

clear

# Run the extra packages
bash ~/trixie-scripts/install_scripts/packages.sh

clear 

bash ~/trixie-scripts/install_scripts/printers.sh

clear 

bash ~/trixie-scripts/install_scripts/bluetooth.sh
sudo apt autoremove

clear

printf "\e[1;32mYou can now reboot! Thanks you.\e[0m\n"
