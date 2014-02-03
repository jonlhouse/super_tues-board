require_relative "./event"

module SuperTues
  module Board
    module Events

      # Business (day) events comprise the "meat" of player turns.  Players 
      #  can play picks, play card, discard, move on the spectrum or poll on 
      #  business days.
      #
      # Business days are:
      #   notice_mode: :all_at_once -- Tell everyone it's time to take actions
      #   interaction_mode: :take_turns -- Get actions from one player at a time.
      #   update_mode: :take_turns -- Update after each players action(s)
      #
      class Business < Event

        def initialize(params)
          super(params)
          @notice_mode = :all_at_once
          @interaction_node = :take_turns
          @update_mode = :take_turns
        end

        # Define the state machine for Business day event.
        #   
        #  Notify-P1 => Interact-P1 => Update-P1 => 
        #  Notify-P2 => Interact-P2 => ....
        #  ...
        #
        # workflow do
          # state :new do
          # end
          # state :notify do
          # end
          # state :interact do
          # end
          # state :update do
          # end
        # end

        # Build the notification and pass to super to yield to players
        def notify(players)
          super(players, Notices::BusinessNotice.new)
        end

        def to_s
          'Business'
        end
        
      end
    
    end
  end
end