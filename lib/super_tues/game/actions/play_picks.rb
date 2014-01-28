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

      end   

    end
  end
end