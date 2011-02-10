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

require 'roxanne/http/http_consumer'
require 'json'

module Roxanne
  module Jenkins
    class JenkinsConsumer < Roxanne::HTTP::HTTPConsumer
      def handle_response(body)
        json = JSON.parse(body)
        status = :green
        json['jobs'].each { |job|
          status  = replace_status(to_status(job['color']), status) if COLORS.keys.include?job['color']
        }
        status
      end

      private
      COLORS = {'blue'=>:green, 'yellow'=>:green, 'red'=>:red, 'blue_anime'=>:orange, 'yellow_anime'=>:orange, 'red_anime'=>:orange}
      def to_status(hudson_color)
        COLORS[hudson_color]
      end
    end
  end
end
