module SuperTues
  module Board
    module Events

      class ReadBill < Event
        def happen
        end

        def to_s
          'Read New Bill'
        end
      end

    end
  end
end