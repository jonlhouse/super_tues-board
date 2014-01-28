module SuperTues
  module Game
    module Actions

      class RadioSpot < PlayPicks

        # Initialized with a hash of State name keys and pick count values.
        #
        # Usage:
        #  RadioSpot.new 'Indiana' => 2, 'Flordia' => 1
        # 
        def initialize(attrs = {})
          super(attrs)
        end
 
      private

        def all_must_pass
          [ 'action.play_picks.allowed', :gt_zero_picks?, :lte_max_picks?, :spread_allowed?]
        end

        def gt_zero_picks?(rules)
          total_picks > 0
        end

        def lte_max_picks?(rules)
          total_picks <= rules.player('action.radio_spot.picks.max')
        end

        def spread_allowed?(rules)
          spread? ? rules.player('action.radio_spot.picks.spread') : true
        end

      end

    end
  end
end