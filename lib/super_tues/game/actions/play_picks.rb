module SuperTues
  module Game
    module Actions

      class PlayPicks < Action
        def initialize(attrs = {})
          super
          @state_picks = attrs || {}
        end

        def spread?
          states.length > 1
        end

        def states
          @state_picks.keys
        end

        def total_picks
          @state_picks.values.inject(0, :+)
        end

      private

        def can_play_picks?(rules)
          rules.player('player.can_play_picks')
        end

      end   

    end
  end
end