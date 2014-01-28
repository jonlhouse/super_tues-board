module SuperTues
  module Game
    module Actions

      class PlayCards < Action

        # Creates a new play_card action.
        #
        # Usage:
        #   PlayCards.new(card)
        #   PlayCards.new(card1, card2)
        #   PlayCards.new([card1, card2])
        #
        def initialize(*cards, **opts)
          super opts
          @cards = Array.wrap(cards).flatten
        end

        def count
          @cards.length
        end

        def allowed?(rules)
          tests = [:can_play_cards?, :lte_max_cards?]
          tests.all? { |test| pass? test, rules }
        end

      private

        def can_play_cards?(rules)
          rules.player('action.play_cards.allowed', default: true)
        end

        def lte_max_cards?(rules)
          count <= rules.player('action.play_cards.max')
        end
      end

    end
  end
end