#!/bin/bash

ctx logger info "Installing pymongo 2.8.0"
sudo apt-get update
sudo apt-get -y install python-dev python-pip
sudo pip install pymongo==2.8.0
