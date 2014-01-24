module SuperTues
  module Game

    class CandidateDeck < Deck

      def initialize()
        load_deck_from_yaml('candidates', Candidate).shuffle!
      end

    end

  end
end