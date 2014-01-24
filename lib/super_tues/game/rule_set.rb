module SuperTues
  module Game

    class RuleSet

      attr_reader :rules

      def initialize(rules_hash)
        @rules = rules_hash
      end

      def self.default
        @default_rules ||= load_rules_from_yaml('default_rules')
      end

    private

      def self.load_rules_from_yaml(fname)
        self.new SuperTues::Game.load_yaml(fname).with_indifferent_access
      end

    end

  end
end