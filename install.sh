#!/bin/bash
set -e

# Set up USER_BIN
USER_BIN="$HOME/.local/bin"

# Function to check if a command exists
command_exists() {
    command -v "$1" >/dev/null 2>&1
}

# Function to get the latest release version
get_latest_release() {
    curl --silent "https://api.github.com/repos/MesserLab/SLiM/releases/latest" |
    grep '"tag_name":' |
    sed -E 's/.*"([^"]+)".*/\1/'
}

# Function to set up USER_BIN
setup_user_bin() {
    if [ ! -d "$USER_BIN" ]; then
        mkdir -p "$USER_BIN"
        echo "Created $USER_BIN directory."
    fi
    if [[ ":$PATH:" != *":$USER_BIN:"* ]]; then
        echo "Adding $USER_BIN to PATH for this session."
        export PATH="$USER_BIN:$PATH"
        echo "To add it permanently, add the following line to your .bashrc or .bash_profile:"
        echo "export PATH=\"$USER_BIN:\$PATH\""
    fi
}

# Main installation function
install_slim() {
    echo "Starting SLiM installation..."

    # Set up USER_BIN
    setup_user_bin

    # Check for required tools
    for cmd in curl tar make cmake g++; do
        if ! command_exists $cmd; then
            echo "Error: $cmd is not installed. Please install it and try again."
            exit 1
        fi
    done

    # Create a temporary directory
    TEMP_DIR=$(mktemp -d)
    echo "Working in temporary directory: $TEMP_DIR"

    # Change to the temporary directory
    cd "$TEMP_DIR"

    # Get the latest release version
    SLIM_VERSION=$(get_latest_release)
    echo "Latest SLiM version: $SLIM_VERSION"

    # Download the latest release
    DOWNLOAD_URL="https://github.com/MesserLab/SLiM/archive/refs/tags/$SLIM_VERSION.tar.gz"
    echo "Downloading SLiM $SLIM_VERSION..."
    curl -L -o slim.tar.gz $DOWNLOAD_URL

    # Extract the archive
    echo "Extracting SLiM..."
    tar xzf slim.tar.gz

    # Build SLiM
    echo "Building SLiM..."
    cd "SLiM-${SLIM_VERSION#v}"
    mkdir build
    cd build
    cmake ..
    make slim

    # Copy SLiM executable to USER_BIN
    echo "Installing SLiM..."
    if cp slim "$USER_BIN/"; then
        echo "SLiM installed successfully to $USER_BIN/slim"
        chmod +x "$USER_BIN/slim"
    else
        echo "Failed to copy SLiM to $USER_BIN. You may need to copy it manually."
    fi

    # Clean up
    echo "Cleaning up temporary files..."
    cd
    rm -rf "$TEMP_DIR"

    echo "SLiM installation completed successfully!"
    echo "You can now use 'slim' command to run SLiM."
    echo "Make sure $USER_BIN is in your PATH."
}

# Run the installation
install_slim
