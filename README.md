# UPCaddy

UPCaddy is a shell script tool designed to streamline the management of Caddy configurations. It simplifies the creation and updating of `.caddy` files, making it easier to set up reverse proxies and other configurations through an interactive, menu-driven interface.

## Pre-requisites

- Caddy must be installed in a Docker container named `caddy`.
- For private subdomains to function, you need a [custom Caddy build with Cloudflare DNS challenge support](https://github.com/deuts/caddy). Additionally, ensure your DNS is managed through Cloudflare.

## Table of Contents

- [Installation](#installation)
- [Usage](#usage)
- [Configuration](#configuration)
- [Scripts Overview](#scripts-overview)
- [Contributing](#contributing)
- [License](#license)

## Installation

To install UPCaddy:

```bash
git clone https://github.com/deuts/upcaddy.git
cd upcaddy
chmod +x install.sh
sudo ./install.sh
```

This script will:

1. Create necessary directories and configuration files.
2. Load configuration variables from `config.cfg`.
3. Provide an option to back up your existing Caddyfile.
4. Copy all required scripts to their respective locations.

## Usage

To launch UPCaddy, run the main script from the terminal:

```bash
upcaddy
```

You will see a menu with the following options:

1. **Create a new .caddy file**
2. **Consolidate .caddy files and update Caddy**
3. **Exit**

### Creating a New .caddy File

Selecting option 1 allows you to choose from the following configuration types:

1. Public subdomain
2. Private subdomain
3. Send relay of a subdomain
4. Receive relay of a subdomain

The script will prompt you for necessary details, such as the subdomain, address, and port. The `$subdomain.caddy` file will be created in the directory that you run the `upcaddy` command, so make sure to execute this within the `SEARCH_DIRECTORY` so it will be consolidated into the Caddyfile in the next step.

### Consolidating .caddy Files

Choosing option 2 will gather all existing `.caddy` files in the specified directory and update the Caddyfile accordingly. You can also opt to restart the Caddy Docker container.

## Configuration

During the execution of `install.sh`, you'll be prompted for the following configuration variables:

- `SEARCH_DIRECTORY`: The directory to search for `.caddy` files.
- `CADDYFILE_LOCATION`: The location of the Caddyfile on the host.
- `DOMAIN`: Your main domain name.
- `PRIVATE_SUBDOMAIN`: The subdomain for private access, which should have its `A` record pointing to a private IP address.

This configuration will be saved at `/usr/local/bin/upcaddy_files/config.cfg`, and you can edit it for further customization.

## Scripts Overview

- `install.sh`: Main installation script for UPCaddy.
- `upcaddy`: The main menu-driven interface for user interactions.
- `upcaddy_files/update`: Consolidates `.caddy` files into the main Caddyfile.
- `upcaddy_files/new1_public_subdomain`: Creates a new public subdomain configuration.
- `upcaddy_files/new2_private_subdomain`: Creates a new private subdomain configuration.
- `upcaddy_files/new3_send_subdomain`: Sets up a send relay for a subdomain.
- `upcaddy_files/new4_receive_subdomain`: Sets up a receive relay for a subdomain.

## Contributing

Contributions are welcome! Please submit a pull request or open an issue for any bugs or suggestions.

## License

This project is licensed under the GNU General Public License v3.0. See the [LICENSE](LICENSE) file for more details.
