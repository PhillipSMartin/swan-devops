#!/usr/bin/env bash
echo "### Performing final clean-up tasks ###"
sudo systemctl stop ecs
sudo docker system prune -f -a
sudo systemctl disable --now docker.service docker.socket
sudo rm -rf /var/log/docker /var/log/ecs/*