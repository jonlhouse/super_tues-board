require 'spec_helper.rb'

module SuperTues
  module Game

    describe Board do
      let(:board) { Board.new }

      context "new game" do
        specify { board.should be_a Board }

        describe "candidates" do
          let(:candidates) { board.remaining_candidates }
          specify { candidates.should_not be_empty }
          specify { candidates.each { |c| c.should be_a Candidate }}
        end
      end

      describe "setup" do
        describe "adding players" do        
          it "add players and updates player's board" do
            board.add_players('bob', 'tom')
            board.players.count.should == 2 
            board.players.each { |player| player.board.should == board }          
          end
        end

        describe "picking candidates" do
          before(:each) { board.add_players('bob', 'tom', 'jim') }
          it "deals candidates to players" do
            board.deal_candidates
            board.players.each { |player| player.candidates_dealt.count.should == SuperTues::Game.config[:candidates_per_player] }
          end 

          it "candidates are unique" do
            board.deal_candidates
            dealt = board.players.map { |player| player.candidates_dealt }.flatten
            dealt.length.should == dealt.uniq.length
          end
        end
      end
    end

  end
end