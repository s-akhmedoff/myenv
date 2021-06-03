#!/bin/sh

# Install All packages
sudo dnf install $(cat pkgs.list)
