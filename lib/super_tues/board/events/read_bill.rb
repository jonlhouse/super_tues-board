module SuperTues
  module Board
    module Events

      class ReadBill < Event
        def happen(game)
          game.active_bill = bill = game.deal_bill
          bill.to_s
        end

        def to_s
          'Read New Bill'
        end
      end

    end
  end
end