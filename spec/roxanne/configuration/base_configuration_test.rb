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

require 'date'
require 'test/unit'
require 'roxanne/base_configuration'

module Roxanne
  class BaseConfigurationTest < Test::Unit::TestCase

    def test_active_days
      config = Roxanne::BaseConfiguration.new
      config.active_days=[0]
      config.timerange=0..11
      assert_equal true, config.will_activate(DateTime.new(2011, 1, 2, 0, 0, 0)), 'Should activate'
      assert_equal true, config.will_activate(DateTime.new(2011, 1, 2, 11, 59, 59)), 'Should activate'
      assert_equal false, config.will_activate(DateTime.new(2011, 1, 2, 12, 0, 0)), 'Should not activate'
      assert_equal false, config.will_activate(DateTime.new(2011, 1, 3, 0, 0, 0)), 'Should not activate'
    end
    
  end
end
