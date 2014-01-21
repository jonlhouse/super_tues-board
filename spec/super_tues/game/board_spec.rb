require 'spec_helper.rb'

module SuperTues
	module Game
		
		describe Board do

			context "new game" do
				let(:new_board) { Board.new }
				specify { new_board.should be_a Board }
			end
				
		end
	end

end