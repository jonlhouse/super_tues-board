require 'spec_helper.rb'

module SuperTues
  module Game

    describe Board do
      let(:board) { Board.new }

      context "new game" do
        specify { board.should be_a Board }

        describe "candidates" do
          let(:candidates) { board.remaining_candidates }          
        end

        describe "states" do
          # new game state for the state bins
          specify { board.states.length.should == 51 }  # 50 states + DC
          specify { (board.states.map { |state| state.name } - State::NAMES.keys).should be_empty }
          specify { board.states.each { |state| state.picks.empty?.should be_true } }
          specify { board.states.each { |state| state.electoral_votes.should > 0 } }
          specify { board.states.each { |state| state.sway.should be_within(4).of(0) } }
        end

        describe "days" do
          # new game initializes the game day array
          specify { board.days.should_not be_empty }
          let(:first_day) { board.days.first }
          specify { first_day.date.should == Date.new(2016, 1, 4)}
        end

        describe "card deck and cards" do
          specify { board.cards.should_not be_empty }
        end

        describe "news deck and news" do
          specify { board.news.should_not be_empty }
        end

        describe "bills deck" do
          specify { board.bills.should_not be_empty }
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