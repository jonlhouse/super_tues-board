module SuperTues
  module Game

    class RuleSet

      class UnknownRule < ArgumentError ; end

      PERMANENT = 'permanent'

      attr_reader :rules
      attr_accessor :duration

      def initialize(*args, duration: PERMANENT, **opts)
        args = [opts] if args.empty?
        rule_attr = args.shift
        @rules =  case rule_attr
                  when String
                    build_from_string rule_attr, args.shift
                  when Hash
                    raise ArgumentError, "Empty rules hash" if rule_attr.empty?
                    convert_values(rule_attr).with_indifferent_access
                  when RuleSet
                    rules_attrs.deep_dup
                  end
        self.duration = Integer(duration) rescue duration
      end

      def permanent?
        duration == PERMANENT
      end

      def [](key, *default)
        raise ArgumentError, "#{key}" if (keys = key.to_s.split('.')).empty?

        # raise exception unless rule lookup returns a string/bool/numeric/symbol
        traverse_keys(keys, default.pop).tap do |value|
          raise UnknownRule, "#{key} => #{value.inspect} not valid rule" if value.is_a? Enumerable
        end
      end

      def []=(key, value)
        keys = key.to_s.split('.')
        last_key = keys.pop
        last_hash = traverse_keys(keys) do |rule_hash, key_not_found|
          # build the new key hash and return it
          rule_hash[key_not_found] = {}
          rule_hash[key_not_found]
        end
        last_hash[last_key] = try_convert value
      end

      def traverse_keys(keys, default = nil, &block)
        return rules if keys.empty?
        keys.inject(rules) do |hash, key|
          if hash.has_key? key
            hash[key]
          elsif default
            default
          else
            if block_given?
              yield hash, key
            else
              raise UnknownRule.new "#{key}"
            end
          end
        end
      end

      def self.default
        @default_rules ||= load_rules_from_yaml('default_rules')
      end
      
    private

      def convert_values(hash)
        deep_transform_values hash do |value|
          try_convert value
        end
      end

      def try_convert(value)
        Integer(value) rescue (Float(value) rescue string_or_bool(value))
      end

      def string_or_bool(value)
        return true if ['true', 'TRUE', 'yes', 'YES', :true].include? value
        return false if ['false', 'FALSE', 'no', 'NO', :false].include? value
        value
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

      def build_from_string(rule_str, value)
        raise ArgumentError, "value (#{value}) must be present" unless value.present?
        keys = rule_str.split('.')
        last = nil
        @rules = {}.with_indifferent_access

        keys.inject(rules) do |hash,key|
          last = hash
          hash[key] = {}
          hash[key]
        end
        last[keys.last] = value
        @rules
      end

      def self.load_rules_from_yaml(fname)
        self.new SuperTues::Game.load_yaml(fname).with_indifferent_access
      end

    end

  end
end