module SuperTues
  module Board

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

      def to_h
        { title: title, description: description, showing: up? }
      end

    end

  end
end