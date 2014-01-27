module SuperTues
  module Game
    module Actions

      class Action
        def self.build(attrs)
          case attrs
          when String
            event_klass(attrs).new
          # when Hash
          #   if attrs.keys.length > 1 
          #     raise ArgumentError.new("event hash must contain only a single top-level key: #{attrs}")
          #   else 
          #     event_klass(attrs.to_a[0].first).new(attrs.to_a[0].last)
          #   end
          # else
          #   raise ArgumentError.new("event cannot build #{attrs}")
          end
        end

      private
        def self.event_klass(name)
          "SuperTues::Game::Actions::#{name.to_s.camelcase}".constantize
        end
      end

    end
  end
end