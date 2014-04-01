require 'daemon_spawn'

module Roxanne
  class Server < DaemonSpawn::Base

    def start(args)
      @configuration = Configuration::YAML.new(args.first || 'config.yml')
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