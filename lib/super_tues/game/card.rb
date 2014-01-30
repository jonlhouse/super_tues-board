module SuperTues
  module Game

    class Card

      attr_reader :title, :description, :effect

      def initialize(attrs)
        @showing = false
        @title = attrs[:title]
        @description = attrs[:description]
        @effect = attrs[:effect]
      end

      def up?
        @showing
      end

      def down?
        not up?
      end

      def show
        @showing = true
      end

    end

  end
end