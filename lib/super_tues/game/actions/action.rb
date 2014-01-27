module SuperTues
  module Game
    module Actions

      # Action encapsulates a given player business-day action.
      #
      # Actions include: RadioSpot, PoliticalFavor, Poll, Move, PlayCard, Discard.
      #
      # An instance of an Action subclass specifies the type and parameter of
      #  the action to be performed.
      #
      # Example:
      #   radio_spot = Action::RadioSpot.new {
      #     play_picks: {
      #       'Indiana': 2,
      #       'Idaho': 1,
      #       'Florida': 2
      #     }
      #   }
      #
      # Actions will be performed by the board, after the player submits the action.
      #  
      # Example:
      #   player.submit radio_spot
      #   ...
      #   board.perform radio_spot
      #
      # It is the responsibility of the Action subclasses to define:
      #   allowed?(board) -- given the current board state and rules is this action allowed?
      #   cost(board) -- given the current board state, what does this action cost?
      #   perform(board) -- update the board state depending on the result of the action
      #
      class Action
        def initialize(attrs = {})
        end

        def self.build(*attrs)
          event_klass(attrs.shift).new attrs.extract_options!
        end

        def perform(board)
          raise NotImplementedError
        end

        def cost(board)
          raise NotImplementedError
        end

        def allow?(board)
          raise NotImplementedError
        end

      private
        def self.event_klass(name)
          "SuperTues::Game::Actions::#{name.to_s.camelcase}".constantize
        end
      end

    end
  end
end