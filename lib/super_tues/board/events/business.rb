require_relative "./event"

module SuperTues
  module Board
    module Events

      class Business < Event

        # Build the notification and pass to super to yield to players
        def notify(game)
          super(game.players, BusinessNotice.new)
        end

        def to_s
          'Business'
        end
        
      end
    
    end
  end
end