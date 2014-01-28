module SuperTues
  module Game
    module Actions

      class Discard < Action

        # Creates a new discard action.
        #
        # Usage:
        #   Discard.new(card)
        #   Discard.new(card1, card2)
        #   Discard.new([card1, card2])
        #
        def initialize(*cards, **opts)
          super opts
          @cards = Array.wrap(cards).flatten
        end

        def allowed?(rules)
          tests = [:can_discard?, :lte_max_cards?]
          tests.all? { |test| pass? test, rules }
        end

        def count
          @cards.length
        end

      private

        def can_discard?(rules)
          rules.player('action.discard.allowed')
        end

        def lte_max_cards?(rules)
          count <= rules.player('action.discard.max')
        end
      end

    end
  end
end