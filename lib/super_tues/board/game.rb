require 'forwardable'

module SuperTues
  module Board

    # Top-level SuperTues Game representation
    #
    # Game encapsulates the players, the board, the rules, the score, state-bins etc.
    #
    class Game
      extend Forwardable
      attr_reader :players, :states, :rules, :current_player, :round, :turn, :max_players

      def initialize(max_players: Board.config[:default_max_players])
        @max_players = max_players
        @players = []        
        @states = {}.with_indifferent_access
        @states_long_name = {}.with_indifferent_access
        @calendar = Calendar.new
        @candidate_deck = CandidateDeck.new
        @card_deck = CardDeck.new
        @news_deck = NewsDeck.new
        @bill_deck = BillDeck.new
        @rules = Rules.new(self)
        @front_runner = FrontRunner.new(self)

        init_states
        init_days
      end

      # delegate today, today= and tomorrow! to calendar
      def_delegators :@calendar, :today, :today=, :tomorrow!

      # delegate game.front_runner to @front_runner.is
      def_delegator :@front_runner, :is, :front_runner

      def_delegators :@candidate_deck, :candidate

      ########################################
      # Player Methods
      #
      def add_players(*new_players)
        new_players.each { |player| add_player player }
        players
      end

      def add_player(new_player)
        raise Player::TooManyPlayers if full?
        new_player.game = self
        players << new_player
      end

      # Lookup player by name
      def player(name)
        players.detect { |p| p.name == name }
      end

      # Returns whether the max number of player is reached
      def full?
        players.length >= max_players
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

      # Returns whether seat *num* is already assigned for this game.
      def seat_taken?(num)
        players.map(&:seat).include?(num)
      end

      # Returns a hash of seats => players
      def seats
        players.each_with_object({}) { |player, hash| hash[player.seat] = player }
      end


      ########################################
      # Candidate Methods
      #

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
          player.candidates_dealt = choices.shift(SuperTues::Board.config[:candidates_per_player])
        end
      end

      def deal_cards(n)
        @card_deck.pop(n)   # TODO: out of cards reshuffle
      end

      ########################################
      # State, State-bins Methods
      #
      def states
        @state_vals ||= @states.values
      end

      def state(name)
        if name.length == 2
          @states[name.to_sym.downcase]
        else
          @states_long_name[name.downcase]
        end
      end

      ########################################
      # Observers
      #
      def observe(what, &block)
        case what
        when :calendar then @calendar.add_observer(&block)
        else
        end
      end

      ########################################
      # Game State
      #

      # Reset (init) the game
      #
      def reset
        @round = 0
        @turn = 0 
        assign_player_colors
        seat_players
        seed_player_funds
        reset_state_bins
        add_home_state_picks
        pick_who_goes_first
        start_at_first_day
      end

      def ready_to_start?
        players.all? { |player| player.ready? }
      end

      def start
        tomorrow!
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

      def assign_player_colors
        colors = Player::COLORS.dup.shuffle
        players.each { |player| player.color = colors.pop }
      end

      def pick_who_goes_first
        @front_runner.random        
      end

      def seed_player_funds
        players.each { |player| player.seed_funds }
      end

      def reset_state_bins
        states.each { |state| state.picks.clear }
      end

      def add_home_state_picks
        players.each do |player|
          starting_picks = rules.rule 'candidate.home_state_picks', default: 3, player: player.name
          state(player.candidate.state).picks.add player, starting_picks
        end
      end

      def start_at_first_day
        today = 0
      end

      def init_states
        SuperTues::Board::load_states.each do |state_hash|
          state = State.new(state_hash.with_indifferent_access)
          @states[state_hash['abbr'].downcase.to_sym] = state
          @states_long_name[state_hash['name'].downcase] = state
        end
      end

      def init_days
        @calendar.days = SuperTues::Board.load_days.collect do |day_hash|
                           Day.new(day_hash.with_indifferent_access)
                         end
      end
    end

  end
end