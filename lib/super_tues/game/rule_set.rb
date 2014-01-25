module SuperTues
  module Game

    class RuleSet

      class UnknownKey < ArgumentError
      end

      PERMANENT = 'permanent'

      attr_reader :rules
      attr_accessor :duration

      def initialize(rules_hash, duration: PERMANENT)
        raise ArgumentError.new("Empty rules hash") if rules_hash.empty?
        @rules = convert_numeric_values(rules_hash).with_indifferent_access
        self.duration = Integer(duration) rescue duration
      end

      def [](key, *default)
        raise UnknownKey.new("#{key}") if (keys = key.to_s.split('.')).empty?
        traverse_keys keys, default.pop
      end

      def []=(key, value)
        keys = key.to_s.split('.')
        last_key = keys.pop
        traverse_keys(keys)[last_key] = value
      end

      def traverse_keys(keys, default = nil)
        return rules if keys.empty?
        keys.inject(rules) do |hash, key|
          if hash.has_key? key
            hash[key]
          elsif default
            default
          else
            raise UnknownKey.new "#{key}"
          end
        end
      end

      def self.default
        @default_rules ||= load_rules_from_yaml('default_rules')
      end
      
    private

      def convert_numeric_values(hash)
        deep_transform_values hash do |value|
          Integer(value) rescue (Float(value) rescue value)
        end
      end

      def deep_transform_values(hash, &block)
        result = {}
        hash.each do |key, value|
          result[key] = value.is_a?(Hash) ? deep_transform_values(value, &block) : yield(value)
        end
        result
      end

      def initialize_copy(other)
        @rules = other.rules.deep_dup
      end

      def self.load_rules_from_yaml(fname)
        self.new SuperTues::Game.load_yaml(fname).with_indifferent_access
      end

    end

  end
end