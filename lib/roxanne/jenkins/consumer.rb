require 'roxanne/http/http_consumer'
require 'json'

module Roxanne
  module Jenkins
    class Consumer < Roxanne::HTTP::HTTPConsumer
      def handle_response(body)
        json = JSON.parse(body)
        status = :green
        json['jobs'].each { |job|
          status  = replace_status(to_status(job['color']), status) if COLORS.keys.include?job['color']
        }
        status
      end

      private
      COLORS = {
        'blue'=>:green,
        'yellow'=>:green,
        'red'=>:red,
        'blue_anime'=>:orange,
        'yellow_anime'=>:orange,
        'red_anime'=>:orange
      }

      def replace_status(current, former)
        return :red if former==:red
        return :orange if former==:orange
        current
      end

      def to_status(hudson_color)
        COLORS[hudson_color]
      end
    end
  end
end
