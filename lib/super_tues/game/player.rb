module SuperTues
  module Game

    #
    # Player represents the entity controlling a SuperTues candidate.  Players are the objects
    #  that take turns, receive paydays, and get acted upon.
    #    
    #  Players are given a name "e.g. John" that are distinct from their candidates name.
    class Player

      class IllegalName < ArgumentError ; end

      attr_accessor :name, :color, :board, :candidate, :candidates_dealt

      def initialize(attrs)
        self.name = ensure_name(attrs[:name])        
        self.color = attrs[:color]
        @board = board
        self.candidates_dealt = []
      end

      def self.name_forbidden?(test_name)
        test_name.blank? || forbidden_names.include?(test_name)
      end

      def self.name_allowed?(test_name)
        not name_forbidden?(test_name)
      end

    private

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