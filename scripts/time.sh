#!/usr/bin/env bash

set -e

# Configure host to use timezone
# http://docs.aws.amazon.com/AWSEC2/latest/UserGuide/set-time.html
sudo timedatectl set-timezone $TIMEZONE