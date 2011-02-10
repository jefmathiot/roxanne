#            DO WHAT THE FUCK YOU WANT TO PUBLIC LICENSE
#                    Version 2, December 2004
#
# Copyright (C) 2011 ServeBox / http://www.servebox.org
#
# Everyone is permitted to copy and distribute verbatim or modified
# copies of this license document, and changing it is allowed as long
# as the name is changed.
#
#            DO WHAT THE FUCK YOU WANT TO PUBLIC LICENSE
#   TERMS AND CONDITIONS FOR COPYING, DISTRIBUTION AND MODIFICATION
#
#  0. You just DO WHAT THE FUCK YOU WANT TO.
#
# This program is free software. It comes without any warranty, to
# the extent permitted by applicable law. You can redistribute it
# and/or modify it under the terms of the Do What The Fuck You Want
# To Public License, Version 2, as published by Sam Hocevar. See
# http://sam.zoy.org/wtfpl/COPYING for more details.

module Roxanne
  class BaseConfiguration

    attr_reader :consumers
    attr_reader :publisher
    attr_accessor :active_days
    attr_accessor :timerange

    def initialize(*args)
      @consumers = []
      @publisher = nil
      @active_days = 0..6
      @timerange=0..23
    end

    def resolve_class( classname )
      require underscore(classname)
      o = Object
      classname.split(/::/).each { |chunk|
        o = o.const_get( chunk )
      }
      o
    end

    def activated
      will_activate(DateTime.now)
    end

    def will_activate( dt )
      @active_days.include?(dt.wday) && @timerange.cover?(dt.hour)
    end

    private
    def underscore(camel_cased_word)
      word = camel_cased_word.to_s.dup
      word.gsub!(/::/, '/')
      word.gsub!(/([A-Z]+)([A-Z][a-z])/,'\1_\2')
      word.gsub!(/([a-z\d])([A-Z])/,'\1_\2')
      word.tr!("-", "_")
      word.downcase!
      word
    end
  end
end
