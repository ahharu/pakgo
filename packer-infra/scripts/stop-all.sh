#!/usr/bin/env bash

set -e

function killService() {
    service=$1
    sudo systemctl stop $service
    sudo systemctl kill --kill-who=all $service

}

function disableTimers() {
    sudo systemctl disable apt-daily.timer
    sudo systemctl disable apt-daily-upgrade.timer
}

function killServices() {
    killService unattended-upgrades.service
    killService apt-daily.service
    killService apt-daily-upgrade.service
}

function main() {
    disableTimers
    killServices
}

main
sudo rm -rf /var/cache/apt/*
sudo rm -rf /var/lib/apt/lists/*
sudo apt-get clean
sudo apt-get update
