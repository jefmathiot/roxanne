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

require 'roxanne/http_support'
require 'roxanne/base_publisher'

module Roxanne
  module IPX
    class IPXPublisher < Roxanne::BasePublisher
      
      include Roxanne::HTTPSupport

      def publish(previous, status)
        @previous = previous
        @status = status
        response = fetch_response
        case response
        when Net::HTTPSuccess
          puts "IPX status refreshed successfully"
        when Net::HTTPRedirection
          puts "The request has been redirected to #{response['location']}"
        else
          puts "The request has failed #{response.error}"
        end
      end

      def complete_path
        if @status == :red
          color_path(0, 0, 1)
	elsif @previous == :red && @status == :orange
          color_path(0, 1, 0)
        else
          color_path(1, 0, 0)
        end 
      end

      def color_path(g, o, r)
        @path.gsub(/\$\{1\}/, g.to_s).gsub(/\$\{2\}/, o.to_s).gsub(/\$\{3\}/, r.to_s)
      end

    end
  end
end
