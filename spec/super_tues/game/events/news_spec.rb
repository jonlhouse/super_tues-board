require 'spec_helper'

module SuperTues
  module Game
    module Events

      describe News do
        let(:news) { News.new }
        specify { news.should respond_to :happen }
      end

    end
  end
end