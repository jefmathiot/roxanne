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

$:.unshift File.join(pwd,'lib')

require 'test/unit'
require 'roxanne/configuration/yaml_configuration'

module Roxanne
  class YAMLConfigurationTest < Test::Unit::TestCase

    # TODO Use a test configuration file
    def test_initialize
      config = Roxanne::Configuration::YAMLConfiguration.new(pwd, 'config/test.yml')
      assert_equal 1, config.consumers.length, 'Configuration should contain a consumer'
      assert_equal Roxanne::Hudson::HudsonConsumer, config.consumers[0].class, 'First consumer should be an hudson consumer'
      assert_equal 'deadlock.netbeans.org', config.consumers[0].host, 'Consumer configuration should point to deadlock.netbeans.org'
      assert_equal '/hudson/api/json', config.consumers[0].path, 'Consumer configuration should point to /hudson/api/json'
      assert_equal false, config.consumers[0].disable_certificate_verification, 'Consumer configuration should not disable SSL cert. verification'
      assert_equal false, config.consumers[0].use_ssl, 'Consumer configuration should not use SSL'
      assert_equal 80, config.consumers[0].port, 'Consumer configuration should point to the 80 TCP port'
      assert_equal Roxanne::IPX::IPXPublisher, config.publisher.class, 'Publisher should be an hudson consumer'
      assert_equal 'relayboard', config.publisher.host, 'Publisher configuration should point to relayboard'
      assert_equal '/preset.htm?led1=${1}&led2=${2}&led3=${3}&led4=0&led5=0&led6=0&led7=0&led8=0', config.publisher.path, 'Publisher configuration should point to /preset.htm?led1=${1}&led2=${2}&led3=${3}&led4=0&led5=0&led6=0&led7=0&led8=0'
      assert_equal false, config.publisher.use_ssl, 'Publisher configuration should not use SSL'
      assert_equal false, config.publisher.disable_certificate_verification, 'Publisher configuration should not disable SSL cert. verification'
      assert_equal 80, config.publisher.port, 'Publisher configuration should point to the 80 TCP port'
    end
  end
end
