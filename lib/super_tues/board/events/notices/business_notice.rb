module SuperTues
  module Board
    module Events
      class BusinessNotice < Notice
        def to_s
          "Time for business!"
        end
      end
    end
  end
end