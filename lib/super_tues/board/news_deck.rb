module SuperTues
  module Board

    class NewsDeck < Deck
      def initialize()
        super
        load_deck_from_yaml('news', News).shuffle!
      end
    end

  end
end