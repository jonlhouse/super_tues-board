module SuperTues
  module Game

    class RuleSet

      PERMANENT = 'permanent'

      attr_reader :rules
      attr_accessor :duration

      def initialize(rules_hash, duration: PERMANENT)
        @rules = rules_hash unless rules_hash.empty? and raise ArgumentError.new("Empty rules hash")
        self.duration = Integer(duration) rescue duration
      end

      def [](key)
        rules[key]
      end

      def []=(key, value)
        rules[key] = value
      end

      def self.default
        @default_rules ||= load_rules_from_yaml('default_rules')
      end
      
    private

      def initialize_copy(other)
        @rules = other.rules.deep_dup
      end

      def self.load_rules_from_yaml(fname)
        self.new SuperTues::Game.load_yaml(fname).with_indifferent_access
      end

    end

  end
end