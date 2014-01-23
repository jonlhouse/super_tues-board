module SuperTues
  module Game

    class Card

      attr_reader :title, :description, :effect

      def initialize(attrs)
        @title = attrs[:title]
        @description = attrs[:description]
        @effect = attrs[:effect]
      end

    end

  end
end