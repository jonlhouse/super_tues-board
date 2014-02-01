module SuperTues
  module Board
    module Events

      class Primary < Event
        attr_reader :state
        
        def initialize(attrs)
          super
          @state = attrs[:state]
        end

        def happen
        end

        def to_s
          "#{state} State Primary"
        end
      end

    end
  end
end