require 'daemon_spawn'

module Roxanne
  class Server < DaemonSpawn::Base

    def start(args)
      puts "Roxanne starting in #{self.working_dir}"
      @controller = Loop.new(config(args))
      loop do
        @controller.cycle
        sleep 5
      end
    end

    def stop
      @controller.reset
    end

    def config(args)
      @config ||= Configuration::YAML.new(args.first || 'config/config.yml')
    end

  end
end