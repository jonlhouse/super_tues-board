module SuperTues
  module Game
    class StateBin < Hash

      def add(key, picks)
        self[key.to_sym] = self[key.to_sym] + picks
      end

      def [](key)
        super(key.to_sym)
      end

      def []=(key, value)
        raise ArgumentError, "#{value} must be an Integer" unless value.respond_to?(:to_int)
        super(key.to_sym, value.to_int)
      end

    end
  end
end