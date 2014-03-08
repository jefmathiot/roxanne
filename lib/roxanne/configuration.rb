module Roxanne
  module Configuration
    class Base

      attr_reader :consumers, :publisher, :active_days, :timerange

      def initialize(*args)
        @consumers = []
        @publisher = nil
        @active_days = 1..5
        @timerange=8..19
      end

      def activated
        will_activate(DateTime.now)
      end

      private
      def will_activate( dt )
        @active_days.include?(dt.wday) && @timerange.cover?(dt.hour)
      end
    end
  end
end

require 'roxanne/configuration/yaml'
