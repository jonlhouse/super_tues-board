module SuperTues
  module Game
    module Actions

      class PlayCard < Action

        # Creates a new play_card action.
        #
        # Usage:
        #   PlayCard.new(card)
        #
        def initialize(card)
          super
          @card = card
        end

        def allowed?(rules)
          tests = [:can_play_cards?]
          tests.all? { |test| pass? test, rules }
        end

      private

        def can_play_cards?(rules)
          rules['player.can_play_card', true, player: :current]
        end
      end

    end
  end
end