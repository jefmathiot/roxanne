#            DO WHAT THE FUCK YOU WANT TO PUBLIC LICENSE
#                    Version 2, December 2004
#
# Copyright (C) 2011 ServeBox / http://www.servebox.org
#
# Everyone is permitted to copy and distribute verbatim or modified
# copies of this license document, and changing it is allowed as long
# as the name is changed.
#
#            DO WHAT THE FUCK YOU WANT TO PUBLIC LICENSE
#   TERMS AND CONDITIONS FOR COPYING, DISTRIBUTION AND MODIFICATION
#
#  0. You just DO WHAT THE FUCK YOU WANT TO.
#
# This program is free software. It comes without any warranty, to
# the extent permitted by applicable law. You can redistribute it
# and/or modify it under the terms of the Do What The Fuck You Want
# To Public License, Version 2, as published by Sam Hocevar. See
# http://sam.zoy.org/wtfpl/COPYING for more details.

$:.unshift File.join(File.dirname(__FILE__),'..','lib')

require 'roxanne/configuration/yaml_configuration'
require 'roxanne/status_helper'
require 'daemon_spawn'

class RoxanneServer < DaemonSpawn::Base

  include Roxanne::StatusHelper

  def start(args)
    sleeping = false
    puts "Roxanne starting in #{self.working_dir}"
    @configuration = Roxanne::Configuration::YAMLconfiguration.new(self.working_dir, get_config)
    puts 'Starting loop'
    while true
      if @configuration.activated
        sleeping = false
        status = :green
        begin
          @configuration.consumers.each { |consumer|
            status = replace_status(consumer.refresh, status)
            break if status == :red
          }
          @configuration.publisher.publish(status)
        rescue Exception => e
          puts "An error has been raised : #{e.message}"
        end
      else
        @configuration.publisher.publish(nil) if !sleeping
        sleeping = true
      end
      sleep 30
    end
  end

  def stop
    @configuration.publisher.publish(nil)
  end

  def get_config(args)
    return args[0] || 'config.yml'
  end

end

RoxanneServer.spawn!(
  :log_file => File.join(File.dirname(__FILE__),'..','roxanne.log'),
  :pid_file => File.join(File.dirname(__FILE__),'..','roxanne.pid'),
  :sync_log => true,
  :working_dir =>  File.join(File.dirname(__FILE__),'..'))