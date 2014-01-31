require_relative "./event"

module SuperTues
  module Board
    module Events

      class Business < Event

        def happen
        end

        def to_s
          'Business'
        end
        
      end
    
    end
  end
end