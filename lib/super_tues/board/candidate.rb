module SuperTues
  module Board

    class Candidate

      attr_reader :name, :clout, :cash, :cards, :description, :state, :special

      def initialize(attrs)
        @name = attrs[:name]
        @cash = Cash.new(attrs[:cash])
        @clout = Clout.new(attrs[:clout])
        @cards = attrs[:cards]
        @description = attrs[:description]
        @state = attrs[:state]
        @special = attrs[:special]
      end

      def has_special?
        @special.present?
      end

      def to_s
        name
      end

    end

  end
end 