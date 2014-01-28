module SuperTues
  module Game

    #
    # Player represents the entity controlling a SuperTues candidate.  Players are the objects
    #  that take turns, receive paydays, and get acted upon.
    #    
    #  Players are given a name "e.g. John" that are distinct from their candidates name.
    class Player
      attr_accessor :name, :candidate, :candidates_dealt
      attr_reader :board

      def initialize(name, board)
        self.name = name
        @board = board
        self.candidates_dealt = []
      end


      def fobidden_name
        %w(any all current current_player)
      end

    end

  end
end