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

require 'yaml'
require 'roxanne/base_configuration'

module Roxanne

  module Configuration

    class YAMLConfiguration < BaseConfiguration

      attr_reader :consumers
      
      def initialize( working_dir, path = nil )
        super
        path = path || 'config/config.yml'
        path = File.join(working_dir, path)
        puts "Parsing configuration file #{path}"
        yaml = YAML::load( File.open( path ) )
        yaml['roxanne']['consumers'].each { |key, value|
          klass = resolve_class(value['class'])
          consumer = klass.new
          copy_properties(consumer, value)
          @consumers << consumer
          puts "Added consumer \"#{key}\" (#{klass})"
        }
        @timerange = yaml['roxanne']['activation']['timerange'] unless yaml['roxanne']['activation']['timerange'].nil?
        @active_days = yaml['roxanne']['activation']['days'] unless yaml['roxanne']['activation']['days'].nil?
        puts @active_days.length
        @publisher = resolve_class(yaml['roxanne']['publisher']['class']).new
        copy_properties(@publisher, yaml['roxanne']['publisher'])
        puts "Configuration ready, #{@consumers.length} consumers added to the queue."
      end
      
      private
      def copy_properties(target_object, yaml_object)
        yaml_object.keys.each{|key|
          target_object.send("#{key}=", yaml_object[key]) if key != 'class' && target_object.respond_to?("#{key}=".to_sym)
        }
      end
    end

    
  end
end
