require 'spec_helper'

describe Roxanne::Configuration::YAML do

  def spec_file(variation)
    File.expand_path(File.join(File.dirname(__FILE__), '../../yaml', "#{variation}.yml"))
  end

  it 'uses activation default settings' do
    subject.new(spec_file('defaults')).tap do |config|
      config.active_days.must_equal 1..5
      config.timerange.must_equal 8..19
    end
  end

  it 'overrides activation settings' do
    subject.new(spec_file('full_blown')).tap do |config|
      config.active_days.must_equal 1..3
      config.timerange.must_equal 9..18
    end
  end

  module Roxanne::Test
    class Consumer
      attr_reader :opt

      def initialize(opts)
        @opt = opts[:consumer_opt]
      end
    end

    class Publisher
      attr_reader :opt

      def initialize(opts)
        @opt = opts[:publisher_opt]
      end
    end
  end

  it 'create consumers' do
    subject.new(spec_file('defaults')).tap do |config|
      config.consumers.size.must_equal 1
      config.consumers.first.must_be_instance_of Roxanne::Test::Consumer
      config.consumers.first.opt.must_equal "some-value"
    end
  end

  it 'create publisher' do
    subject.new(spec_file('defaults')).tap do |config|
      config.publisher.must_be_instance_of Roxanne::Test::Publisher
      config.publisher.opt.must_equal "another-value"
    end
  end

end
