module SuperTues
  module Board
    module Events
      # Base class for game events both interactive and non-interactive.
      #
      # Events can be built from hash data or a string using the ::build method.
      #
      # Events will .happen
      #
      #
      class Event
        def initialize(params)
        end

        def self.build(klass, params = {})
          event_klass(klass).new params
        end

      private
        def self.event_klass(name)
          "SuperTues::Board::Events::#{name.to_s.camelcase}".constantize
        end

      end

    end

  end
end