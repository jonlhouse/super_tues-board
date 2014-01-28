module SuperTues
  module Game
    module Actions

      class PoliticalFavor < PlayPicks
        def initialize(attrs = {})
          super(attrs)
          @state_picks = attrs
        end

        def allowed?(rules)
          tests = [:can_play_picks?, :more_than_zero_picks?, :less_than_max_picks?, :spread_allowed?]
          tests.all? { |test| pass? test, rules}
        end

      private

        def more_than_zero_picks?(rules)
          total_picks > 0
        end

        def less_than_max_picks?(rules)
          total_picks <= rules['action.political_favor.picks.max']
        end

        def spread_allowed?(rules)
          spread? ? rules['action.political_favor.picks.spread'] : true
        end

      end

    end
  end
end