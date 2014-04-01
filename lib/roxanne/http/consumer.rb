require 'roxanne/http_support'

module Roxanne
  module HTTP
    class Consumer

      include Roxanne::HTTPSupport

      def pull
        response = fetch_response
        case response
        when Net::HTTPSuccess
          handle_response(response.body)
        when Net::HTTPRedirection
          puts "The request has been redirected to #{response['location']}"
          :red
        else
          puts "The request has failed #{response.error}"
          :red
        end
      rescue Exception => e
        puts "Unable to fetch data : #{e.message}"
        :red
      end

      def handle_response(body)
        puts "Does nothing, HTTP consumer should be overriden."
        :green
      end
      
    end
  end
end
