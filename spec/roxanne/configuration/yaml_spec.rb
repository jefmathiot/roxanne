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

  module Roxanne::Spec
    class Consumer
      attr_accessor :consumer_opt
    end

    class Publisher
      attr_accessor :publisher_opt
    end
  end

  it 'create consumers' do
    subject.new(spec_file('defaults')).tap do |config|
      config.consumers.size.must_equal 1
      config.consumers.first.must_be_instance_of Roxanne::Spec::Consumer
      config.consumers.first.consumer_opt.must_equal "some-value"
    end
  end

  it 'create publisher' do
    subject.new(spec_file('defaults')).tap do |config|
      config.publisher.must_be_instance_of Roxanne::Spec::Publisher
      config.publisher.publisher_opt.must_equal "another-value"
    end
  end

end
