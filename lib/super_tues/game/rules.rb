module SuperTues
  module Game

    class Rules

      def initialize()
        @current = Rules.default.dup
      end

      def self.default
        @default ||= RuleSet.default
      end
    end

  end
end