#!/usr/bin/env bash

# Setup error trapping.

set -e
trap 'echo "Error occured on line $LINENO." && exit 1' ERR

# Download the latest confd executable and build the docker image.

url=$(curl --header "Authorization: token ${GITHUB_TOKEN}" --silent https://api.github.com/repos/kelseyhightower/confd/releases | grep browser_download_url | grep linux-amd64 | head --lines 1 | cut --delimiter '"' --fields 4)
curl --output './src/confd' --location "$url"
chmod +x './src/confd'

docker build --tag "ianbytchek/confd" "./src"