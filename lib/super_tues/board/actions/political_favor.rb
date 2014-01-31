module SuperTues
  module Board
    module Actions

      class PoliticalFavor < PlayPicks
        def initialize(attrs = {})
          super(attrs)
          @state_picks = attrs
        end

      private

        def all_must_pass
          ['action.play_picks.allowed', :gt_zero_picks?, :lte_max_picks?, :spread_allowed?]
        end

        def gt_zero_picks?(rules)
          total_picks > 0
        end

        def lte_max_picks?(rules)
          total_picks <= rules.player('action.political_favor.picks.max')
        end

        def spread_allowed?(rules)
          spread? ? rules.player('action.political_favor.picks.spread') : true
        end

      end

    end
  end
end