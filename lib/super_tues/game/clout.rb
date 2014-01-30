module SuperTues
  module Game
    class Clout
      def initialize(_amount)
        raise ArgumentError, "#{_amount} must be an Integer" unless _amount.is_a? Integer
        @amount = _amount
      end

      def ==(other)
        cast(other) do |this, other|
          this == other
        end
      end

      def +(other)
        cast(other) { |this, other| Clout.new(this + other) }
      end
      
      def -(other)
        cast(other) { |this, other| Clout.new(this - other) }
      end

      def coerce(other)
        if other.is_a? Integer
          [other, @amount]
        else
          raise TypeError, "#{self.class} can't be coerced to #{other.class}"
        end
      end

      def to_i
        @amount
      end

      def to_s
        "#{@amount} clout"
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