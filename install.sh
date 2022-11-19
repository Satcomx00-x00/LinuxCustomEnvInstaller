#!bash -> #!/usr/bin/env bash

function print_info() {
    printf "%b %s" "$1" "$2"
    printf '\n'
;}



dep="git curl wget"
fonts_url="https://github.com/ryanoasis/nerd-fonts/releases/download/v2.2.2/3270.zip"
starship_config_url="https://raw.githubusercontent.com/ryanoasis/nerd-fonts/master/patched-fonts/3270/Regular/complete/starship.toml"


blue="\033[0;34m"
green="\033[0;32m"
red="\033[0;31m"
yellow="\033[0;33m"
reset="\033[0m"

info="[${blue}INFO${reset}]"
warn="[${yellow}WARN${reset}]"
error="[${red}ERROR${reset}]"
success="[${green}SUCCESS${reset}]"



install_fonts() {
    print_info ${info} "Installing fonts..."^
    wget -O 3270.zip $fonts_url && unzip 3270.zip -d ~/.local/share/fonts && rm 3270.zip
    fc-cache -f -v
    print_info ${success} "Fonts installed!"
}

# testing multiple dependencies at the same time and installing them if not present
test_dependencies() {
    print_info ${info} "Testing dependencies..."
    for i in $dep; do
        if ! command -v $i &> /dev/null; then
            print_info ${warn} "$i is not installed, installing..."
            sudo apt install $i -y
        fi
    done
    print_info ${success} "Dependencies installed!"
}

install_starship() {
    # install starship.rs
    print_info ${info} "Installing starship.rs..."
    # catch exception if download fails
    if ! curl -fsSL https://starship.rs/install.sh | bash; then
        print_info ${error} "Starship.rs installation failed!"
        exit 1
    fi
    print_info ${success} "Starship.rs installed!"
}


# download starship.toml from github
install_starship_config() {
    print_info ${info} "Installing starship.toml..."
    if ! wget -O ~/.config/starship.toml $starship_config_url; then
        print_info ${error} "Starship.toml installation failed!"
        exit 1
    fi
    print_info ${success} "Starship.toml installed!"
}


# test dependencies and install fonts^
# call functions
test_dependencies();
install_fonts();
install_starship();
install_starship_config();



