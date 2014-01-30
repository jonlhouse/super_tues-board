module SuperTues
  module Game
    class Deck < Array
      def initialize()
      end

      def deal(n)
        pop(n)
      end

    private

      def load_deck_from_yaml(fname, klass)
        SuperTues::Game.load_yaml(fname).each do |klass_hash|
          ( klass_hash.delete('count') { 1 } ).times do
            self << klass.new(klass_hash.with_indifferent_access)
          end
        end
        self
      end

    end
  end
end