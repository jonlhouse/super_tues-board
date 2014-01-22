module SuperTues
  module Game

    class Board
      attr_reader :players, :candidates

      def initialize()
        @players = []
        @candidates = []
        add_candidates
      end

      def add_players(*player_names)
        players.concat player_names.map{ |name| Player.new(name, self) }
      end

      # remaining candidates is all candidates minus player choices
      def remaining_candidates
        candidates - players.map(&:candidate)
      end

    private     

      def add_candidates
        SuperTues::Game::load_candidates_yaml.each do |candidate_hash|
          candidates << Candidate.new(candidate_hash)
        end
      end
    end

  end
end