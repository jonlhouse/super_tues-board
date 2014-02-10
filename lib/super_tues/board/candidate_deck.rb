module SuperTues
  module Board

    class CandidateDeck < Deck

      def initialize()
        load_deck_from_yaml('candidates', Candidate).shuffle!
      end

      def candidate(name)
        detect { |c| c.name == c.name }
      end

    end

  end
end