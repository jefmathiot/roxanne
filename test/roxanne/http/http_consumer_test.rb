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

$:.unshift File.join(Dir.getwd,'lib')

require 'test/unit'
require 'roxanne/http/http_consumer'

class HTTPConsumerTest < Test::Unit::TestCase

  def test_http_refresh
    consumer = Roxanne::HTTP::HTTPConsumer.new
    consumer.host = 'deadlock.netbeans.org'
    consumer.port = 80
    consumer.use_ssl = false
    consumer.disable_certificate_verification = false
    consumer.path = '/hudson/api/json'
    assert_equal :green, consumer.refresh
  end
  
end
