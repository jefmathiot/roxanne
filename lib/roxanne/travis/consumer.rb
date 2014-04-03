require 'travis'

module Roxanne
  module Travis
    class Consumer
      include Consumers::Priority
      
      attr_accessor :organization_or_user

      def pull
        repos = ::Travis::Repository.find_all(owner_name: organization_or_user)
        status = :green
        repos.select{|repo| repo.active? }.each do |repo|
          status = prioritize(to_status(repo.last_build_state), status)
        end
        status
      end

      private
      STATES = {
        'failed' => :red,
        'started' => :orange,
        'passed' => :green
      }
      
      def to_status(travis_build_state)
        STATES[travis_build_state]
      end

    end
  end
end
