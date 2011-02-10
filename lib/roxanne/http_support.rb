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
