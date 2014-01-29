module SuperTues
  module Game

    #
    # Player represents the entity controlling a SuperTues candidate.  Players are the objects
    #  that take turns, receive paydays, and get acted upon.
    #    
    #  Players are given a name "e.g. John" that are distinct from their candidates name.
    class Player

      class IllegalName < ArgumentError ; end
      class NotAtGame < StandardError ; end
      class IllegalSeat < ArgumentError ; end
      class IllegalCandidate < ArgumentError ; end

      attr_accessor :name, :color, :board, :seat, :candidates_dealt
      attr_reader :candidate

      def initialize(attrs)
        self.name = ensure_name(attrs[:name])     
        self.color = attrs[:color]
        @board = board
        self.candidates_dealt = []
      end

      def candidate=(picked)
        raise IllegalCandidate, "#{picked} not in #{candidates_dealt}" unless candidate_dealt?(picked)
        raise IllegalCandidate, "#{picked} already picked" unless board.candidate_available?(picked)
        @candidate = picked
      end

      def seat=(index)
        raise NotAtGame unless board.present?
        raise IllegalSeat, "#{index} out of range" unless (0...(board.players.length)).cover?(index)
        raise IllegalSeat, "seat #{index} taken" if board.seat_taken?(index)
        @seat = index
      end

      def seed_funds
        raise IllegalCandidate, "must select a candidate" unless candidate
        puts SuperTues::Game.config
      end

      def to_s
        name
      end

      def inspect
        "#<Player #{name}: color: #{color}, seat: #{seat}>"
      end

      def self.name_forbidden?(test_name)
        test_name.blank? || forbidden_names.include?(test_name)
      end

      def self.name_allowed?(test_name)
        not name_forbidden?(test_name)
      end

    private

      def candidate_dealt?(which)
        candidates_dealt.include? which
      end

      def self.forbidden_names
        %w(any all current current_player other others)
      end

      def ensure_name(name)
        raise IllegalName, "name: #{name}" unless Player.name_allowed?(name)
        name.to_s
      end

    end

  end
end