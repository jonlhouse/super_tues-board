module SuperTues
  module Board
    class Cash
      include Comparable

      def initialize(value)
        raise ArgumentError, "#{value} must be an Integer" unless value.is_a? Integer
        @amount = value
      end

      def ==(other)
        cast(other) { |this, other| this == other }
      end

      def +(other)
        cast(other) { |this, other| this + other }
      end

      def -(other)
        cast(other) { |this, other| this - other }
      end

      def <=>(other)
        cast(other) { |this, other| this <=> other }
      end

      def to_i
        Integer(@amount)
      end

      def to_s
        "$#{@amount*10}k"
      end

      def coerce(other)
        [other, to_i]
      end

    private

      def cast(other)
        if other.is_a? Clout or other.is_a? Integer
          yield to_i, other.to_i
        else
          raise TypeError, "#{other} must be an Integer or Clout"
        end
      end
    end
  end
end