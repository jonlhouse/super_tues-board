require 'workflow'

module SuperTues
  module Board
    module Events
      # Base class for game events both interactive and non-interactive.
      #
      # Events have 3 stages:
      #   1) #notify is called to let all the players know this event is happening
      #     It will yield a new Notificiation object to each player.
      #   2) #interact
      #   3) #update is called to let all the players know the results of this event.
      #     It will yield a new Happened object to each player
      #
      # Events have 3 modes describing how notices, interaction and updates are 
      #  sequenced. The Modes are:
      #    :all_at_once -- stages occur simultaneously
      #    :take_turns -- stage occurs one after the other
      #    :none -- stage is skipped
      #  
      # Note: 
      #   If the interaction is :take_turns and update is :all_at_once, then all 
      #     interactions are completed before updateing everyone at once (e.g. Voting on
      #     a Bill).
      #   If the interaction is :take_turns and update is :take_turn, then updates are 
      #     fired off after each turn (e.g. Business Day actions).
      #
      class Event
        include Workflow

        MODES = [:take_turns, :all_at_once, :none]

        def initialize(params)
          @complete = false
          @notice_order = :all_at_once
          @interact_order = :all_at_once
          @update_order = :all_at_once    
        end

        def complete?
          @complete
        end

        def complete!
          @complete = true
        end

        # Returns symbol of event class name (e.g. :business, :read_bill)
        def type
          klass = self.class.name
          if sep = klass.rindex('::')
            klass[(sep+2)..-1]
          else
            klass
          end.underscore.to_sym
        end

        # Yield a notice object to each of the players
        # 
        def notify(players, notice = Notices::Notice.new)
          send @notice_order, players, notice do |player, notice|
            yield player, notice
          end
        end

        def interact(players, interaction = nil, &block)
          send @interact_order, players, interaction, &block
        end

        # Yield an update object to each of the players
        def update(players, update = nil)
        end

        def self.build(klass, params = {})
          event_klass(klass).new params
        end

      private
        def self.event_klass(name)
          "SuperTues::Board::Events::#{name.to_s.camelcase}".constantize
        end

        def all_at_once(players, payload)
          players.each do |player|
            yield player, payload
          end
        end

        def take_turns(players, payload, &block)
          players.each do |player|
            yield player, payload
          end
        end

        def none(players, payload, &block)
        end

      end

    end

  end
end