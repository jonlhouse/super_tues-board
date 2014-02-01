module SuperTues
  module Board
    module Events
      # Base class for game events both interactive and non-interactive.
      #
      # Events have 3 stages:
      #   1) #notify is called to let all the players know this event is happening
      #     It will yield a new Notificiation object to each player.
      #   2) #
      #   3) #update is called to let all the players know the results of this event.
      #     It will yield a new Happened object to each player
      class Event

        def initialize(params)
          @complete = false
        end

        def complete?
          @complete
        end

        def complete!
          @complete = true
        end

        # Yield a notification object to each of the players
        # 
        def notify(players)
        end

        def self.build(klass, params = {})
          event_klass(klass).new params
        end

      private
        def self.event_klass(name)
          "SuperTues::Board::Events::#{name.to_s.camelcase}".constantize
        end

      end

    end

  end
end