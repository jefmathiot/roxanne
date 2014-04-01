require 'spec_helper'

describe Roxanne::Server do

  describe 'with a test double' do
    class ServerDouble < Roxanne::Server
      attr_reader :slept_for, :looped

      def initialize(configuration, opts)
        @config = configuration
        super(opts)
      end

      def loop(&block)
        @looped = true
        yield
      end

      def sleep(time)
        @slept_for = time
      end

      def config(args)
        @config
      end
    end

    before do
      @configuration = Roxanne::Configuration::Base.new
      @server = ServerDouble.new(
        @configuration,
        working_dir: @working_dir = File.join(File.dirname(__FILE__), '../..')
      )
    end
    
    it 'logs, cycle and sleep' do
      STDOUT.expects(:puts).with("Roxanne starting in #{@working_dir}")
      controller = Roxanne::Loop.new(@configuration)
      Roxanne::Loop.expects(:new).with(@configuration).returns(controller)
      controller.expects(:cycle)
      @server.start([])
      @server.looped.must_equal true
      @server.slept_for.must_equal 5
    end

    it 'stops' do
      @server.instance_variable_set(:@controller, controller = mock)
      controller.expects(:reset)
      @server.stop
    end
  end

  it 'creates a YAML configuration using the default path' do
    Roxanne::Configuration::YAML.expects(:new).with('config/config.yml').returns(config = mock)
    subject.new({working_dir: ''}).config([]).must_equal config
  end

  it 'creates a YAML configuration using the provided path' do
    Roxanne::Configuration::YAML.expects(:new).with('specific-config.yml').returns(config = mock)
    subject.new({working_dir: ''}).config(['specific-config.yml']).must_equal config
  end
end
