#!/usr/bin/env bash
source <(curl -fsSL https://raw.githubusercontent.com/community-scripts/ProxmoxVE/main/misc/build.func)
# Copyright (c) 2021-2025 tteck
# Author: tteck (tteckster)
# License: MIT | https://github.com/community-scripts/ProxmoxVE/raw/main/LICENSE
# Source: https://github.com/retronas/retronas

APP="retronas"
var_tags="nas;retro"
var_cpu="2"
var_ram="2048"
var_disk="10"
var_os="debian"
var_version="12"
var_unprivileged="1"

header_info "$APP"
variables
color
catch_errors

function update_script() {
    header_info
    check_container_storage
    check_container_resources
    if [[ ! -d /opt/retronas ]]; then
        msg_error "No ${APP} Installation Found!"
        exit
    fi
    echo "Updating RetroNAS..."
    cd /opt/retronas || exit
    git pull
    exit
}

start
build_container
description

msg_ok "Container created successfully!"
echo -e "${CREATING}${GN}${APP} setup has been successfully initialized!${CL}"
echo -e "${INFO}${YW} Installing RetroNAS...${CL}"

# Install RetroNAS
git clone https://github.com/retronas/retronas /opt/retronas
cd /opt/retronas || exit
bash install.sh

msg_ok "RetroNAS installation completed!"
echo -e "${INFO}${YW} Access RetroNAS setup using:${CL}"
echo -e "${TAB}${GATEWAY}${BGN}ssh root@${IP} -t 'cd /opt/retronas && ./retronas.sh'${CL}"
