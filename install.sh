#!/bin/bash

# Define directories for installation
BIN_DIR="/usr/local/bin"
FILES_DIR="/usr/local/bin/upcaddy_files"
UPCADDY_CFG="upcaddy_files/config.cfg"

# Create the FILES_DIR if it doesn't exist
mkdir -p "$FILES_DIR"

# Load variables from UPCADDY_CFG if it exists
declare -A config_vars  # Array to store config variables from UPCADDY_CFG

if [[ -f "$UPCADDY_CFG" ]]; then
  echo "Loading variables from $UPCADDY_CFG..."
  while IFS="=" read -r key value; do
    [[ -z "$key" || "$key" == \#* ]] && continue  # Skip empty lines and comments
    config_vars[$key]="${value//\"/}"  # Strip quotes if present
  done < "$UPCADDY_CFG"
fi

# Load FILES_DIR/config.cfg if it exists for comparison
if [[ -f "$FILES_DIR/config.cfg" ]]; then
  echo "Loading existing values from $FILES_DIR/config.cfg..."
  source "$FILES_DIR/config.cfg"
fi

# Prompt only if variables from UPCADDY_CFG are missing in FILES_DIR/config.cfg
for key in "${!config_vars[@]}"; do
  value="${!key}"  # Dynamically get the value of each key (if already set in FILES_DIR/config.cfg)
  if [[ -z "$value" ]]; then
    read -p "Enter value for $key (e.g., ${config_vars[$key]}): " value
    eval "$key=\"$value\""  # Set variable in the current environment
  fi
done

# Write all variables to FILES_DIR/config.cfg
{
  echo "# Configuration file for upcaddy scripts"
  for key in "${!config_vars[@]}"; do
    echo "$key=\"${!key}\""
  done
} > "$FILES_DIR/config.cfg"

echo "Configuration file updated at $FILES_DIR/config.cfg"

# Backup Caddyfile if it exists
if [[ -f "$CADDYFILE_LOCATION" ]]; then
  read -p "Do you want to backup the Caddyfile before making changes? (y/n): " backup_choice
  backup_choice=$(echo "$backup_choice" | tr '[:upper:]' '[:lower:]')

  if [[ "$backup_choice" == "y" || "$backup_choice" == "yes" ]]; then
    cp "$CADDYFILE_LOCATION" "${CADDYFILE_LOCATION}_Backup"
    echo "Backup created as ${CADDYFILE_LOCATION}_Backup"
  else
    echo "Backup skipped."
  fi
else
  echo "Caddyfile not found at $CADDYFILE_LOCATION. No backup created."
fi

# Copy pertinent files to FILES_DIR, excluding config.cfg
find upcaddy_files -type f ! -name "config.cfg" -exec cp {} "$FILES_DIR/" \;

# Copy the main script to BIN_DIR
cp ./upcaddy "$BIN_DIR/"

# Make scripts executable in BIN_DIR and FILES_DIR, except for 'head' and 'config.cfg'
chmod +x "$BIN_DIR/upcaddy"
find "$FILES_DIR" -type f ! -name "head" ! -name "config.cfg" -exec chmod +x {} \;

echo "Scripts and configuration files copied to $BIN_DIR and $FILES_DIR."

# Additional installation steps can be added here

echo "Installation completed successfully."
