module SuperTues
  module Board
    class Day

      attr_reader :date, :events

      def initialize(attrs)
        # Note: throws ArgumentError on invalid dates
        @date = attrs[:date].is_a?(Date) ? attrs[:date] : Date.parse(attrs[:date]) 
        @events = attrs[:events].empty? ? {} : build_events(attrs[:events])
      end

      def to_s
        # Monday, January 3 2014
        @date.strftime "%A, %B %-e %Y"
      end

    private

      def build_events(events_ary)
        events_ary.collect do |event,params|
          if params
            Events::Event.build(event, params)
          else
            Events::Event.build(event)
          end
        end
      end

    end
  end
end