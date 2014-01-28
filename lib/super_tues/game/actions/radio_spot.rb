module SuperTues
  module Game
    module Actions

      class RadioSpot < Action

        # Initialized with a hash of State name keys and pick count values.
        #
        # Usage:
        #  RadioSpot.new 'Indiana' => 2, 'Flordia' => 1
        # 
        def initialize(attrs = {})
          super
          @state_picks = attrs || {}
        end

        def allowed?(rules)
          more_than_zero_picks &&
          less_than_max_picks(rules) &&
          (spread? ? spread_allowed?(rules) : true)  # check only if spread
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

        def more_than_zero_picks
          total_picks > 0
        end

        def less_than_max_picks(rules)
          total_picks <= rules['action.radio_spot.picks.max']
        end

        def spread_allowed?(rules)
          rules['action.radio_spot.picks.spread']
        end

      end

    end
  end
end