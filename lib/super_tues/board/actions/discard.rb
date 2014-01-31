module SuperTues
  module Board
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

        def count
          @cards.length
        end

      private

        def all_must_pass
          ['action.discard.allowed', :lte_max_cards?]
        end

        def lte_max_cards?(rules)
          count <= rules.player('action.discard.max')
        end
      end

    end
  end
end