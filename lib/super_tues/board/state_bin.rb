module SuperTues
  module Board
    class StateBin < Hash

      def add(key, picks)
        self[key.to_sym] = self[key.to_sym] + picks.to_int
      end

      def subtract(key, picks)
        self[key.to_sym] = [(self[key.to_sym] - picks.to_int), 0]   #floor of zero
      end

      def [](key)
        super(key.to_sym)
      end

      def []=(key, value)
        super(key.to_sym, value.to_int)
      end

      def total
        self.values.inject(0, :+)
      end

    end
  end
end