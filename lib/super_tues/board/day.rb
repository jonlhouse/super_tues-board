module SuperTues
  module Board
    class Day

      attr_reader :date, :events

      def initialize(attrs)
        # Note: throws ArgumentError on invalid dates
        @date = attrs[:date].is_a?(Date) ? attrs[:date] : Date.parse(attrs[:date]) 
        @events = attrs[:events].empty? ? [] : build_events(attrs[:events])
      end

    private

      def build_events(events_ary)
        events_ary.collect do |event|
          if event.is_a?(Events::Event)
            event
          else
            Events::Event.build(event)
          end
        end
      end

    end
  end
end