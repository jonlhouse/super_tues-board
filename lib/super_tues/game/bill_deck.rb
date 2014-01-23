module SuperTues
  module Game

    class BillDeck < Deck

      def initialize()
        load_deck_from_yaml('bills', Bill).shuffle!
      end
    end

  end
end