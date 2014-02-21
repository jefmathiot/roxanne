#!/bin/bash
source $HOME/.bash_profile
eval "$(rbenv init -)"
cd /var/lib/roxanne/roxanne
bundle exec ruby lib/roxanne_server.rb $1 config/golgotha.yml
