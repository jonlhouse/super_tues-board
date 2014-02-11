module SuperTues
  module Board
    module Observer

      def observers
        @observers ||= {}
      end

      def observer_id
        @observer_id = if @observer_id
                         @observer_id += 1
                       else
                         0 
                       end
      end

      def add_observer(&block)
        id = observer_id
        observers[id] = Proc.new # implicit block conversion
        id
      end

      def remove_observer(id)
        observers.delete(id)
      end

    private

      def notify_observers
        observers.values.each { |proc| proc.call }
      end
    end
  end
end