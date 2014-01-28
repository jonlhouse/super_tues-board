module SuperTues
  module Game

    class Rules

      def initialize()
        @default_rules = Rules.default.dup
        @rule_heirarchy = []
        @rule_heirarchy.push @default_rules
      end

      # Returns the current value for the rule-string given.
      #
      # This function is heirarchy aware so only the most current rule_set
      #  value is computed and returned.
      def rule(str)
        @rule_heirarchy.each do |rule_set|
          return rule_set[str] rescue next
        end
        raise UnknownKey, str
      end
      alias_method :[], :rule

      # Ammends a rule set to the rule_heirarchy.
      #      
      # It creates a new rule_set with an optional duration and prepends
      #  the rule to the heirarchy.
      #
      def ammend(*args)
        @rule_heirarchy.unshift RuleSet.new(args)
      end

      def self.default
        @default ||= RuleSet.default
      end

    end

  end
end