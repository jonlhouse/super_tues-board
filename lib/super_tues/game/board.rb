module SuperTues
  module Game

    class Board
      attr_reader :players, :states, :days, :cards, :news, :bills, :rules

      def initialize()
        @players = []        
        @states = []
        @days = []
        @candidate_deck = CandidateDeck.new
        @cards = CardDeck.new
        @news = NewsDeck.new
        @bills = BillDeck.new
        @rules = Rules.new(self)
        @turn = 1
        init_states
        init_days
      end

      # PLACEHOLDER
      def current_player
        'player-0'
      end

      def add_players(*new_players)
        new_players.each { |player| player.board = self }
        players.concat new_players        
        players
      end

      # Returns the candidates in play
      def candidates
        players.map(&:candidate).compact
      end

      def candidate_available?(whom)
        not candidates.include? whom
      end

      def candidates_picked?
        players.all? { |player| player.candidate }
      end

      # remaining candidates is all candidates minus player choices
      def remaining_candidates
        @candidate_deck - candidates
      end

      def deal_candidates
        choices = @candidate_deck.dup
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

      # Assigns seats randomly or by assignment
      def seat_players(assigned_seating = false)
        seating = if !assigned_seating
                    random_seats = (0...players.length).to_a.shuffle
                    players.each_with_object({}) { |player,hash| hash[random_seats.shift] = player }
                  else
                    assigned_seating
                  end
        seating.each { |seat, player| player.seat = seat }
        seats
      end

      # Returns whether seat *num* is already assigned for this board.
      def seat_taken?(num)
        players.map(&:seat).include?(num)
      end

      # Returns a hash of seats => players
      def seats
        players.each_with_object({}) { |player, hash| hash[player.seat] = player }
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