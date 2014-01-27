module SuperTues
  module Game
    module Actions

      class Action
        def initialize(attrs)
        end

        def self.build(*attrs)
          event_klass(attrs.shift).new attrs.extract_options!
        end

      private
        def self.event_klass(name)
          "SuperTues::Game::Actions::#{name.to_s.camelcase}".constantize
        end
      end

    end
  end
end