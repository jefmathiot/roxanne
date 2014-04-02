require 'spec_helper'

describe Roxanne::Loop do
  before do
    @publisher = mock
    @config = Roxanne::Configuration::Base.new
    @config.stubs(:publisher).returns @publisher
  end

  it 'disables publishers unless active' do
    @config.expects(:activated).returns false
    @publisher.expects(:disable)
    subject.new(@config).cycle
  end

  describe 'activated' do

    before do
      @config.expects(:activated).at_least(1).returns true
      @publisher.expects(:disable).never

      3.times do
        @config.consumers << mock
      end
    end

    it 'publishes green if all of consumers answer green' do
      @config.consumers.each do |consumer|
        consumer.expects(:pull).returns :green
      end
      @publisher.expects(:push).with(nil, :green)
      subject.new(@config).cycle
    end

    it 'publishes red if one of the consumers answers red' do
      @config.consumers.first.expects(:pull).returns :red
      @publisher.expects(:push).with(nil, :red)
      subject.new(@config).cycle
    end

    def expects_pulls(*statuses)
      @config.consumers.each_with_index do |consumer, i|
        consumer.expects(:pull).returns statuses[i] if statuses[i]
      end
    end

    it 'publishes orange if a consumer answers orange and the previous status wasnt green' do
      loop = subject.new(@config)
      # First cycle to turn it red
      expects_pulls(:red)
      @publisher.expects(:push).with(nil, :red)
      loop.cycle

      # Second cycle to orange
      expects_pulls(:green, :orange, :green)
      @publisher.expects(:push).with(:red, :orange)
      loop.cycle
    end

    it 'publishes green if orange and previous state wasnt red' do
      loop = subject.new(@config)

      expects_pulls(:green, :green, :green)
      @publisher.expects(:push).with(nil, :green)
      loop.cycle

      expects_pulls(:orange, :green, :green)
      @publisher.expects(:push).with(:green, :green)
      loop.cycle
    end

  end

  it 'publishes nil on reset' do
    loop = subject.new(@config)
    @publisher.expects(:push).with(nil, nil)
    loop.reset
  end

end
