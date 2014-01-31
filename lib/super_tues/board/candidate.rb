module SuperTues
  module Board

    class Candidate

      attr_reader :name, :clout, :cash, :cards, :description, :state

      def initialize(attrs)
        attrs.each { |attr,value| instance_variable_set("@#{attr}", value) }
      end

    end

  end
end 