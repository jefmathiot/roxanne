$:.unshift File.join(File.dirname(__FILE__),'..','lib')

require 'daemon_spawn'

module Roxanne
  class Server < DaemonSpawn::Base

    def initialize(configuration, opts={})
      super(opts)
      @configuration = configuration
    end

    def start(args)
      puts "Roxanne starting in #{self.working_dir}"
      @controller = Loop.new(@configuration)
      loop do
        @controller.cycle
        sleep 5
      end
    end

    def stop
      @controller.reset
    end

    def get_config(args)
      args.first
    end

  end
end

#RoxanneServer.spawn!(
#  :log_file => File.join(File.dirname(__FILE__),'..','roxanne.log'),
#  :pid_file => File.join(File.dirname(__FILE__),'..','roxanne.pid'),
#  :sync_log => true,
#  :working_dir =>  File.join(File.dirname(__FILE__),'..'))
