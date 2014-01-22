module SuperTues
  module Game
    class Day

      attr_reader :date

      def initialize(attrs)
        attrs.each { |attr,value| instance_variable_set("@#{attr}", value) }
        @date = Date.parse(date) unless date.is_a? Date   # throws ArgumentError on invalid dates
      end

    end
  end
end