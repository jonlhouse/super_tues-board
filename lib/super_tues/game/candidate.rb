module SuperTues
  module Game

    class Candidate

      attr_reader :name, :clout, :cash, :cards, :description

      def initialize(attrs)
        attrs.each { |attr,value| instance_variable_set("@#{attr}", value) }
      end

    end

  end
end 