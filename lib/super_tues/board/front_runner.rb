module SuperTues
  module Board
    
    #  Picks a front runner for the game.
    #
    #  Usage:
    #    FrontRunnerSelector.new(players).pick  #=> <player>
    #
    class FrontRunner

      def initialize(game, current = nil)
        @game = game
        @current = current
      end

      def is
        @current
      end

      def random
        @current = @game.players.sample
      end

      def select
        top_scores = @game.players.group_by { |player| player.score }.sort.reverse[0].last
        if top_scores.length > 1
          @current    # tie goes to current front runner
        else
          @current = top_scores.first
        end        
      end


    end
  end
end