module Roxanne
  module Test
    class Publisher
      def disable
        puts "Publisher is now disabled"
      end

      def push(previous, status)
        puts "Publisher switching from status #{default(previous)} to #{default(status)}"
      end

      private
      def default(status)
        status.nil? ? 'none' : status
      end
    end
  end
end