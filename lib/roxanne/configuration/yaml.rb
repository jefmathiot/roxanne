require 'yaml'
require 'active_support/core_ext'

module Roxanne

  module Configuration

    class YAML < Base

      def initialize(path)
        super
        yaml = ::YAML.load( File.open( path ) ).with_indifferent_access[:roxanne]
        override_activation(yaml[:activation])
        build_consumers(yaml[:consumers])
        build_publisher(yaml[:publisher])
      end

      private
      def override_activation(settings)
        if settings
          @active_days = settings[:days] if settings.has_key?(:days)
          @timerange = settings[:timerange] if settings.has_key?(:timerange)
        end
      end

      def build_consumers(hash)
        (hash||{}).each do |id, hash|
          @consumers << assign_properties( hash.delete(:class).constantize.new, hash )
        end
      end

      def build_publisher(hash)
          @publisher = assign_properties( hash.delete(:class).constantize.new, hash)
      end

      def assign_properties(object, hash)
        hash.each do |prop, value|
          object.send "#{prop}=", value
        end
        object
      end
      
    end

  end
end
