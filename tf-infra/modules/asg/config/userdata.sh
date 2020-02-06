#!/bin/bash
export DEBIAN_FRONTEND=noninteractive
sudo export DEBIAN_FRONTEND=noninteractive
sudo cat <<EOT > /usr/bin/${project_name}.sh
${project_sh}
EOT
sudo cat <<EOT > /lib/systemd/system/${project_name}.service
${project_service}
EOT
sudo chmod +x /usr/bin/*.sh

sudo systemctl enable ${project_name}
sudo systemctl start ${project_name}
EOF