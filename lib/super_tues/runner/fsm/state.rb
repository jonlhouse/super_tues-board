module SuperTues
  module Runner
    module FSM

      class State
        attr_reader :name

        def initialize(name)
          @name = name
        end
      end

    end
  end
end
