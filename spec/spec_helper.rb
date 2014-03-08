#require 'simplecov'
#require 'coveralls'
#
#SimpleCov.formatter = SimpleCov::Formatter::MultiFormatter[
#  SimpleCov::Formatter::HTMLFormatter,
#  Coveralls::SimpleCov::Formatter
#]
#
#SimpleCov.start do
#    add_filter '/spec/'
#end

require 'roxanne'
require 'minitest'
require 'minitest/spec'
require 'minitest/autorun'
require 'minitest/pride'
require 'minitest-implicit-subject'
require 'timecop'
require 'mocha/setup'