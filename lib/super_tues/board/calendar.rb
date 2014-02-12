
module SuperTues
  module Board
    class Calendar
      include Observer

      attr_accessor :days

      def initialize(days = [])
        self.days = days
        @today = nil
      end

      def days=(day_ary)
        @days = day_ary
      end

      def today
        days.fetch(@today) rescue nil
      end

      def today=(day_or_index)
        @today = if day_or_index.respond_to? :to_int
                  day_or_index.to_int
                else
                  days.index(day_or_index)          
                end
      end

      def tomorrow!
        @today = (@today.nil? ? 0 : @today + 1)
        notify_observers today
        today
      end

    end
  end
end