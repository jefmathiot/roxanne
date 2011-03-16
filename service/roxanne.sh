#!/bin/bash
cd $HOME/roxanne
source $HOME/.bashrc
rvm 1.9.2@roxanne
ruby lib/roxanne_server.rb $1 config/golgotha.yml
