module SuperTues
  module Board

    class CandidateDeck < Deck

      def initialize()
        load_deck_from_yaml('candidates', Candidate).shuffle!
      end

    end

  end
end