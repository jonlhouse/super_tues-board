module SuperTues
  module Game

    # Rules define the constraints of the SuperTues game.
    #
    # Rules need to be mutable since many cards, bills and news events modify
    #  the game rules.
    #
    # Rule are defined as nested key/pair values (deep hashs).  Rules are queried
    #  using a 'each.key.dotted' syntax.  Where only he end "scalar" rules can be 
    #  accessed.
    # 
    # The game starts with a set of default rules.  These rules are all permanent.
    #  However, news rules can be ammended either permanently or for a fixed duration.
    #  Each game turn, the rules will decrement the duration of ammended rules.  When
    #  a new rule's duration reached zero it is removed from the game rules (i.e. expires).
    #
    # By default, newer rules take priority over older rules.
    #
    # Some rules are "player-specific".  When creating rules you can specify certain 
    #  player(s) it applies to.  When rules are queried these player-specific rules are
    #  higher-priority.
    #
    class Rules

      def initialize(board)
        @board = board
        @default_rules = Rules.default.dup
        @rule_heirarchy = []
        @rule_heirarchy.push @default_rules
      end

      # Returns the current value for the rule-string given.
      #
      # This function is heirarchy aware so only the most current rule_set
      #  value is computed and returned.
      def rule(rule_str)
        # allows_current_player_rules(rule_str) do |str|
          @rule_heirarchy.each do |rule_set|
            return rule_set[str] rescue next
          end
          raise UnknownKey, str
        end        
      # end
      alias_method :[], :rule

      # Ammends a rule set to the rule_heirarchy.
      #      
      # It creates a new rule_set with an optional duration and prepends
      #  the rule to the heirarchy.
      #
      def ammend(*args)
        @rule_heirarchy.unshift RuleSet.new(*args)
        self
      end

      # Returns the remaining time on the active rule accessed via the rule_str.
      #  Note: returns 'permanent' in the case where the duration is indefinite.
      def duration(rule_str)
        active(rule_str).duration # note raises when key not found in any rule_set
      end

      def self.default
        @default ||= RuleSet.default
      end
    
    private

      # Usage:
      #  override = RuleSet.new('action.radio_spot.picks.max', 42)
      #  rules Rules.new.ammend(override)
      #  rules.where('action.radio_spot.picks.max') #=> override
      def active(str)
        # Maybe have a NullRuleSet
        @rule_heirarchy.find { |rule_set| rule_set.has?(str) }
      end

      # Performs rule manipulation with 'current_player' substitution.
      #
      def allows_current_player_rules(rule_str)
      end

      def current_player_rule?(str)
        str.starts_with?('current_player')
      end

    end

  end
end