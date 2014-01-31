module SuperTues
  module Board
    module Events
    
      class Rent < Event
        attr_reader :cost

        def initialize(attrs)
          @cost = attrs[:cost]
        end

        def happen
        end
      end
    
    end
  end
end