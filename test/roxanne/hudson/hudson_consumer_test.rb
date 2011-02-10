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
require 'roxanne/jenkins/jenkins_consumer'

class JenkinsConsumerTest < Test::Unit::TestCase

  def test_green
    json = '{"jobs":[{"name":"job1","color":"disabled"},{"name":"job2","color":"blue"}]}'
    consumer = Roxanne::Jenkins::JenkinsConsumer.new
    assert_equal :green, consumer.handle_response(json)
  end

  def test_orange
    json = '{"jobs":[{"name":"job1","color":"disabled"},{"name":"job2","color":"blue"},{"name":"job3","color":"yellow"},{"name":"job4","color":"blue_anime"}]}'
    consumer = Roxanne::Jenkins::JenkinsConsumer.new
    assert_equal :orange, consumer.handle_response(json)
  end

  def test_red
    json = '{"jobs":[{"name":"job1","color":"disabled"},{"name":"job2","color":"red"},{"name":"job2","color":"orange"},{"name":"job2","color":"blue"}]}'
    consumer = Roxanne::Jenkins::JenkinsConsumer.new
    assert_equal :red, consumer.handle_response(json)
  end
end
