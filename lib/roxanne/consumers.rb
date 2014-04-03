module Roxanne
  module Consumers
    module Priority

      def prioritize(current_status, former_status)
        [:red, :orange].each do |status|
          return status if status == former_status
        end
        current_status
      end

    end
  end
end

require 'roxanne/jenkins/consumer'
require 'roxanne/test/consumer'
require 'roxanne/travis/consumer'

