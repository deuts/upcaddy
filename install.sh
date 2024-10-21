#!/bin/bash

# Define directories for installation
BIN_DIR="/usr/local/bin"
FILES_DIR="/usr/local/bin/upcaddy_files"

# Create the FILES_DIR if it doesn't exist
mkdir -p "$FILES_DIR"

# Prompt for user input to populate config.cfg
echo "Please provide the following information to set up your config.cfg:"

# Prompt for the SEARCH_DIR (e.g., "/home/deuts/apps")
read -p "Enter SEARCH_DIR (e.g., /home/deuts/apps): " SEARCH_DIR

# Prompt for the CADDYFILE path (e.g., "/home/deuts/apps/caddy/Caddyfile")
read -p "Enter CADDYFILE path (e.g., /home/deuts/apps/caddy/Caddyfile): " CADDYFILE

# Prompt for the DOMAIN (e.g., "deuts.org")
read -p "Enter DOMAIN (e.g., deuts.org): " DOMAIN

# Prompt for the PRIVATE_SUBDOMAIN (e.g., "green")
read -p "Enter PRIVATE_SUBDOMAIN (e.g., green): " PRIVATE_SUBDOMAIN

# Create or overwrite the config.cfg file
cat <<EOF > "$FILES_DIR/config.cfg"
# Configuration file for upcaddy scripts

# Directory to search for .caddy files
SEARCH_DIRECTORY="$SEARCH_DIR"

# Location of the Caddyfile on the host
CADDYFILE_LOCATION="$CADDYFILE"

# Other variables
DOMAIN="$DOMAIN"
PRIVATE_SUBDOMAIN="$PRIVATE_SUBDOMAIN"
EOF

echo "Configuration file created at $FILES_DIR/config.cfg"

# Backup Caddyfile if it exists
if [[ -f "$CADDYFILE" ]]; then
  read -p "Do you want to backup the Caddyfile before making changes? (y/n): " backup_choice
  backup_choice=$(echo "$backup_choice" | tr '[:upper:]' '[:lower:]')

  if [[ "$backup_choice" == "y" || "$backup_choice" == "yes" ]]; then
    cp "$CADDYFILE" "${CADDYFILE}_Backup"
    echo "Backup created as ${CADDYFILE}_Backup"
  else
    echo "Backup skipped."
  fi
else
  echo "Caddyfile not found at $CADDYFILE. No backup created."
fi

# Copying pertinent files to BIN_DIR and FILES_DIR
# Ensure that your scripts (upcaddy, new1_subdomain, new2_subdomain_forward, new3_sub-subdomain, update) are in the current directory
cp ./upcaddy "$BIN_DIR/"
cp ./new1_subdomain "$FILES_DIR/"
cp ./new2_subdomain_forward "$FILES_DIR/"
cp ./new3_sub-subdomain "$FILES_DIR/"
cp ./update "$FILES_DIR/"
cp ./head "$FILES_DIR/"  # Copy the head file

# Make the scripts executable in the BIN_DIR
chmod +x "$BIN_DIR/upcaddy"
chmod +x "$FILES_DIR/new1_subdomain"
chmod +x "$FILES_DIR/new2_subdomain_forward"
chmod +x "$FILES_DIR/new3_sub-subdomain"
chmod +x "$FILES_DIR/update"

echo "Scripts and configuration files copied to $BIN_DIR and $FILES_DIR."

# Optionally, you can add additional installation steps here

echo "Installation completed successfully."
