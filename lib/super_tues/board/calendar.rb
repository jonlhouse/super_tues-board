module SuperTues
  module Board
    class Calendar

      attr_accessor :days

      def initialize(days = [])
        self.days = days
      end

      def today
        days[@today]
      end

      def today=(day_or_index)
        if day_or_index.respond_to? :to_int
          @today = day_or_index.to_int
        else
          @today = days.index(day_or_index)          
        end
        today
      end

      def tomorrow!
        @today = @today + 1
        today
      end

    end
  end
end