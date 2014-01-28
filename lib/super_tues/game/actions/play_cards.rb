module SuperTues
  module Game
    module Actions

      class PlayCards < Action

        # Creates a new play_card action.
        #
        # Usage:
        #   PlayCard.new(card)
        #
        def initialize(card_or_cards)
          super
          @cards = Array.wrap(card_or_cards)
        end

        def allowed?(rules)
          tests = [:can_play_cards?]
          tests.all? { |test| pass? test, rules }
        end

      private

        def can_play_cards?(rules)
          rules.player('action.play_cards.allowed', default: true)
        end
      end

    end
  end
end