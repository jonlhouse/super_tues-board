module SuperTues
  module Game

    class CardDeck < Deck
      def initialize()
        super
        load_deck_from_yaml('cards', Card).shuffle!
      end
    end

  end
end