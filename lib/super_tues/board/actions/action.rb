module SuperTues
  module Board
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
      # Actions will be performed by the game, after the player submits the action.
      #  
      # Example:
      #   * current_player.submit action
      #   * game.perform action
      #     * game.rules.allow? action
      #       * action.allowed? rules
      #     * action.allow?(game.rules) or fail
      #     * game.current_player.can_afford? action.cost or fail
      #     * game.current_player.deduct action.cost
      #     * action.perform(game)
      #
      # It is the responsibility of the Action subclasses to define:
      #   allowed?(game) -- given the current game state and rules is this action allowed?
      #   cost(game) -- given the current game state, what does this action cost?
      #   perform(game) -- update the game state depending on the result of the action
      #
      class Action
        def initialize(attrs = {})
        end

        def self.build(*attrs)
          event_klass(attrs.shift).new attrs.extract_options!
        end

        def allowed?(rules)
          all_must_pass.all? { |test| pass? test, rules }
        end

        def cost(game)
          raise NotImplementedError
        end

        def perform(game)
          raise NotImplementedError
        end       

      private

        # Subclasses override these
        def all_must_pass
          []
        end

        def self.event_klass(name)
          "SuperTues::Board::Actions::#{name.to_s.camelcase}".constantize
        end

        def pass?(method, rules)
          if method =~ /^\w+(\.\w+)*$/
            rules.player(method).tap do |res|
              raise "#{method} and did not return boolean" unless res == true || res == false
            end
          else
            send method, rules
          end
        end

      end

    end
  end
end