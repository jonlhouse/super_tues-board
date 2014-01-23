module SuperTues
  module Game
    module Events

      # Base class for game events both interactive and non-interactive.
      #
      # Events can be built from hash data or a string using the ::build method.
      #
      # Events will .happen
      #
      #
      class Event

        def self.build(attrs)
          case attrs
          when String
            event_klass(attrs).new
          when Hash
            if attrs.keys.length > 1 
              raise ArgumentError.new("event hash must contain only a single top-level key: #{attrs}")
            else 
              event_klass(attrs.to_a[0].first).new(attrs.to_a[0].last)
            end
          else
            raise ArgumentError.new("event cannot build #{attrs}")
          end
        end

      private
        def self.event_klass(name)
          "SuperTues::Game::Events::#{name.to_s.camelcase}".constantize
        end

      end

    end

  end
end