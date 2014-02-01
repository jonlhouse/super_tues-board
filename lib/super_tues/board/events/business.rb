require_relative "./event"

module SuperTues
  module Board
    module Events

      class Business < Event

        # Build the notification and pass to super to yield to players
        def notify(game)
          notice = Notification.new
          super(game.players, notice)
        end

        def to_s
          'Business'
        end
        
      end
    
    end
  end
end