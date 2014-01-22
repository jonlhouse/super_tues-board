module SuperTues
  module Game
    class Day

      attr_reader :date, :events

      def initialize(attrs)
        attrs.each { |attr,value| instance_variable_set("@#{attr}", value) }
        @date = Date.parse(date) unless date.is_a? Date   # throws ArgumentError on invalid dates
        @events = [] if events.nil?
      end

    end
  end
end