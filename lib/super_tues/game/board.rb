module SuperTues
  module Game

    class Board
      attr_reader :players, :candidates, :states, :days

      def initialize()
        @players = []
        @candidates = []
        @states = []
        @days = []
        init_candidates
        init_states
        init_days
      end

      def add_players(*player_names)
        players.concat player_names.map{ |name| Player.new(name, self) }
      end

      # remaining candidates is all candidates minus player choices
      def remaining_candidates
        candidates - players.map(&:candidate)
      end

      def deal_candidates
        ary = candidates.shuffle
        players.each do |player|
          player.candidates_dealt = ary.shift(SuperTues::Game.config[:candidates_per_player])
        end
      end

    private     

      def init_candidates
        SuperTues::Game::load_candidates.each do |candidate_hash|
          candidates << Candidate.new(candidate_hash)
        end
      end

      def init_states
        SuperTues::Game::load_states.each do |state_hash|
          states << State.new(state_hash)
        end
      end

      def init_days
        SuperTues::Game.load_days.each do |day_hash|
          days << Day.new(day_hash)
        end
      end
    end

  end
end