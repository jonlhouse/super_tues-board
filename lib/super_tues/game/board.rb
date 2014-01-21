module SuperTues
  module Game

    class Board
      attr_accessor :players

      def initialize()
        self.players = []
      end

      def add_players(*player_names)
        players.concat player_names.map{ |name| Player.new(name, self) }
      end
    end

  end
end