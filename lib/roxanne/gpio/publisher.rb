require 'taopaipai'

module Roxanne
  module GPIO
    class Publisher
      attr_accessor :green_pin, :orange_pin, :red_pin

      def disable
        [green_pin, orange_pin, red_pin].each do |num|
          Taopaipai.gpio.pin(num, direction: :out).value 0
        end
      end

      def push(previous, status)
        return disable unless status
        [:green, :orange, :red].each do |color|
          Taopaipai.gpio.pin(send("#{color}_pin"), direction: :out).
            value(color == status ? 1 : 0)
        end
      end

    end
  end
end
