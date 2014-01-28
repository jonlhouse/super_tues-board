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

        def allowed?(rules)
          raise ArgumentError, "must be a Rules" unless rules.is_a? Rules
          tests = [:can_play_picks?, :more_than_zero_picks?, :less_than_max_picks?, :spread_allowed?]
          tests.all? { |test| pass?(test, rules) }
        end
 
      private

        def more_than_zero_picks?(rules)
          total_picks > 0
        end

        def less_than_max_picks?(rules)
          total_picks <= rules['action.radio_spot.picks.max']
        end

        def spread_allowed?(rules)
          spread? ? rules['action.radio_spot.picks.spread'] : true
        end

      end

    end
  end
end