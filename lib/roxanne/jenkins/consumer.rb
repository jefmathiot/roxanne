require 'roxanne/http/consumer'
require 'json'

module Roxanne
  module Jenkins
    class Consumer < Roxanne::HTTP::Consumer

      def handle_response(body)
        json = JSON.parse(body)
        status = :green
        json['jobs'].each do |job|
          if COLORS.keys.include?(job['color'])
            status = prioritize(to_status(job['color']), status)
          end
        end
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

      def to_status(hudson_color)
        COLORS[hudson_color]
      end
    end
  end
end
