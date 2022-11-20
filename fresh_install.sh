#!/usr/bin/env bash

function print_info() {
    printf "%b %s" "$1" "$2"
    printf '\n'
}

blue="\033[0;34m"
green="\033[0;32m"
red="\033[0;31m"
yellow="\033[0;33m"
reset="\033[0m"

info="[${blue}INFO${reset}]"
warn="[${yellow}WARN${reset}]"
error="[${red}ERROR${reset}]"
success="[${green}SUCCESS${reset}]"



# install and configuration of novnc server
install_novnc() {
    print_info ${info} "Installing novnc server..."
    # install novnc server
    sudo apt install novnc -y > /dev/null 2>&1
    sudo touch /etc/novnc/config
    sudo echo "vncserver -geometry 1920x1080 -depth 24" > /etc/novnc/config
    sudo touch /etc/systemd/system/novnc.service
    sudo echo "[Unit]" > /etc/systemd/system/novnc.service
    sudo echo "Description=NoVNC server" >> /etc/systemd/system/novnc.service
    sudo echo "After=network.target" >> /etc/systemd/system/novnc.service
    sudo echo "" >> /etc/systemd/system/novnc.service
    sudo echo "[Service]" >> /etc/systemd/system/novnc.service
    sudo echo "Type=simple" >> /etc/systemd/system/novnc.service
    sudo echo "ExecStart=/usr/bin/novnc" >> /etc/systemd/system/novnc.service
    sudo echo "Restart=always" >> /etc/systemd/system/novnc.service
    sudo echo "" >> /etc/systemd/system/novnc.service
    sudo echo "[Install]" >> /etc/systemd/system/novnc.service
    sudo echo "WantedBy=multi-user.target" >> /etc/systemd/system/novnc.service
    sudo systemctl enable novnc.service
    sudo systemctl start novnc.service
    print_info ${success} "Novnc server installed!"
}

# install and configuration of xrdp server and xorg server
install_xrdp() {
    print_info ${info} "Installing xrdp server..."
    # install xrdp server
    sudo apt install xrdp -y > /dev/null 2>&1
    # create xrdp systemd service
    sudo touch /etc/systemd/system/xrdp.service
    # add xrdp systemd service
    sudo echo "[Unit]" > /etc/systemd/system/xrdp.service
    sudo echo "Description=XRDP server" >> /etc/systemd/system/xrdp.service
    sudo echo "After=network.target" >> /etc/systemd/system/xrdp.service
    sudo echo "" >> /etc/systemd/system/xrdp.service
    sudo echo "[Service]" >> /etc/systemd/system/xrdp.service
    sudo echo "Type=simple" >> /etc/systemd/system/xrdp.service
    sudo echo "ExecStart=/usr/sbin/xrdp" >> /etc/systemd/system/xrdp.service
    sudo echo "Restart=always" >> /etc/systemd/system/xrdp.service
    sudo echo "" >> /etc/systemd/system/xrdp.service
    sudo echo "[Install]" >> /etc/systemd/system/xrdp.service
    sudo echo "WantedBy=multi-user.target" >> /etc/systemd/system/xrdp.service
    # enable xrdp systemd service
    sudo systemctl enable xrdp.service
    # start xrdp systemd service
    sudo systemctl start xrdp.service
    # sudo service xrdp start
    print_info ${success} "Xrdp server installed!"
}

# install gui and desktop environment (xfce4)
install_gui() {
    print_info ${info} "Installing xfce4 desktop environment..."
    sudo apt update  > /dev/null 2>&1
    # install xfce4 desktop environment
    sudo apt install xfce4 -y > /dev/null 2>&1
    # install xorg server
    sudo apt install xorg -y > /dev/null 2>&1
    print_info ${success} "Xfce4 desktop environment installed!"
}