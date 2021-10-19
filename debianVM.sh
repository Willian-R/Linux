#!/bin/bash
apt update
apt install build-essential linux-headers-$(uname -r) -y
