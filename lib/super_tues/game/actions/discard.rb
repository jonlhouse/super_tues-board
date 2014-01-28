module SuperTues
  module Game
    module Actions

      class Discard < Action
        def initialize(card_or_cards)
          super
          # @cards = Array.wrap(card_or_cards)
        end
      end

    end
  end
end