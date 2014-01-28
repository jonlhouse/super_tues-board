module SuperTues
  module Game
    module Actions

      class Poll < Action
        def initialize(*states, **opts)
          super opts
          @states = Array.wrap(states).flatten
        end

        def all_must_pass
          ['action.poll.allowed', :lte_max_polls?]
        end

      private

        def lte_max_polls?(rules)
          @states.length <= rules.player('action.poll.max')
        end
      end

    end
  end
end