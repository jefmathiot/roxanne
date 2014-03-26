require 'net/http'

module Roxanne
  module HTTPSupport
    attr_accessor :host
    attr_accessor :use_ssl
    attr_accessor :disable_certificate_verification
    attr_accessor :path
    attr_accessor :port
    attr_accessor :username
    attr_accessor :password

    private
    def fetch_response
      connection = ::Net::HTTP.new(@host, @port)
      connection.use_ssl=@use_ssl
      if @disable_certificate_verification
        # TODO retrieve the certificate from the remote system, see http://redcorundum.blogspot.com/2008/03/ssl-certificates-and-nethttps.html
        # Avoid issues with autosigned certificates
        connection.verify_mode = OpenSSL::SSL::VERIFY_NONE
      end
      request = Net::HTTP::Get.new(complete_path, {'Accept'=>accept})

      # TODO Authentication
      unless (username.nil? && password.nil?)
        request.basic_auth username, password
      else
      end
      connection.request(request)
    end

    def complete_path
      @path
    end

    # Override if needed to force a particular format : application/json, text/xml, etc
    protected
    def accept
      '*'
    end

  end
end
