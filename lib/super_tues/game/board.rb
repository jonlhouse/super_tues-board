module SuperTues
  module Game

    class Board
      attr_reader :players, :candidates, :states, :days, :cards, :news, :bills, :rules

      def initialize()
        @players = []        
        @states = []
        @days = []
        @candidates = CandidateDeck.new
        @cards = CardDeck.new
        @news = NewsDeck.new
        @bills = BillDeck.new
        @rules = Rules.new(self)
        @turn = 1
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
        choices = candidates.dup
        players.each do |player|
          player.candidates_dealt = choices.shift(SuperTues::Game.config[:candidates_per_player])
        end
      end

      def to_s
        "<Game State: #{players.count} players, turn: #{@turn}>"
      end

      def inspect
        to_s
      end

      # Rules delegators
      # 
      def rule(rule_str)
        rules.rule rule_str
      end

      def allowed?(rule_str, value)
        # rules.allowed? rule_str, value
      end

    private     
      def init_states
        SuperTues::Game::load_states.each do |state_hash|
          states << State.new(state_hash.with_indifferent_access)
        end
      end

      def init_days
        SuperTues::Game.load_days.each do |day_hash|
          days << Day.new(day_hash.with_indifferent_access)
        end
      end
    end

  end
end