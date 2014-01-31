module SuperTues
  module Game
    
    #  Picks a front runner for the board.
    #
    #  Usage:
    #    FrontRunnerSelector.new(players).pick  #=> <player>
    #
    class FrontRunner

      def initialize(board, current = nil)
        @board = board
        @current = current
      end

      def is
        @current
      end

      def random
        @current = @board.players.sample
      end

      def select
        top_scores = @board.players.group_by { |player| player.score }.sort.reverse[0].last
        if top_scores.length > 1
          @current    # tie goes to current front runner
        else
          @current = top_scores.first
        end        
      end


    end
  end
end