module SuperTues
  module Game
    module Actions

      class RadioSpot < Action

        # Initialized with a hash of State name keys and pick count values.
        #
        # Usage:
        #  RadioSpot.new 'Indiana' => 2, 'Flordia' => 1
        # 
        def initialize(attrs = {})
          super
          @picks = attrs || {}
        end

        def allowed?(rules)

        end

      end

    end
  end
end