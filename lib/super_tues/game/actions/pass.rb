module SuperTues
  module Game
    module Actions

      class Pass < Action
        def initialize(attrs = {})
          super
        end

      private

        def all_must_pass
          []  # pass 
        end
      end

    end
  end
end