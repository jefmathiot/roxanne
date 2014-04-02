module Roxanne
  class Loop
    def initialize(config)
      @config = config
    end

    def cycle
      if @config.activated
        status = :green
        @config.consumers.each do |consumer|
          actual = consumer.pull
          if actual == :red
            status = :red
            break
          elsif actual == :orange && @previous != :green
            status = :orange
          end
        end
        publish( @previous, status )
        @previous = status
      else
        @config.publisher.disable
      end
    end

    def reset
      @config.publisher.push(nil, nil)
    end

    private
    def publish(previous, current)
      @config.publisher.push(previous, current)
    end
  end
end
