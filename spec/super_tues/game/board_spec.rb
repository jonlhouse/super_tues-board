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

      describe "seats" do
        describe "#seat_taken?(seat_num)" do
          it "looks into players' seats" do
            player = double(seat: 1)
            board.stub(:players) { [player] }
            board.seat_taken?(1).should be_true
            board.seat_taken?(0).should be_false
          end
        end
        describe "#seats" do
          it "returns a hash mapping seats to players" do
            p1 = double(seat: 0).tap { |p| p.should_receive(:board=) }
            p2 = double(seat: 1).tap { |p| p.should_receive(:board=) }
            board.add_players p1, p2
            board.seats.should == { 0 => p1, 1 => p2 }
          end
        end
        describe "#seat_players" do
          it "seats players" do
            p1 = Player.new(name: 'p1')
            p2 = Player.new(name: 'p2')
            board.add_players p1, p2
            seats = board.seat_players
            seats.keys.sort.should == (0...2).to_a
          end
          
        end
      end

      describe "setup" do
        let(:bob) { Player.new(name: 'bob') }
        let(:tom) { Player.new(name: 'tom') }
        let(:jim) { Player.new(name: 'jim') }

        describe "adding players" do          
          describe "adding players" do        
            it "add players and updates player's board" do
              board.add_players(bob, tom)
              board.players.count.should == 2 
              board.players.each { |player| player.board.should == board }          
            end
          end
        end

        describe "once players added" do
          before(:each) { board.add_players(bob, tom, jim) }

          describe "picking candidates" do
            describe "#deal_candidates" do          
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

            describe "#candidate_available?" do
              let(:a) { double }
              it "true when" do
                board.stub(:candidates) { [] }
                board.candidate_available?(a).should be
              end
              it "false when" do
                board.stub(:candidates) { [a] }
                board.candidate_available?(a).should_not be
              end
            end

            describe "#candidates_picked?" do
              before(:each) { board.deal_candidates }

              specify { board.candidates_picked?.should_not be }
              it "true when all players have picked a candidate" do
                board.players.each { |p| p.candidate = p.candidates_dealt.sample }
                board.candidates_picked?.should be
              end
            end
          end

          describe "#seed_player_funds" do
            it "calls #seed_funds for each player" do
              board.players.each { |player| player.should_receive :seed_funds }
              board.send('seed_player_funds')
            end
          end

          describe "#start_game" do
            it "following initializing methods are called" do
              board.should_receive :seat_players
              board.should_receive :seed_player_funds
              board.should_receive :reset_state_bins
              board.should_receive :add_home_state_picks
              board.start_game
            end
          end

        end  # once players added
      end   # setup

      describe "rules" do
        describe "querying rules" do          
          describe "#rule('rule.str.ing')" do
            # check a default rule
            specify { board.rule('action.radio_spot.picks.max').should == 5 }
          end
          # describe "rule(rule_str)" do
          #   specify { board.rule('action.radio_spot.max_picks').should == 5 }
          # end

          # describe "allowed?(rule_str)" do
          #   specify { board.allowed?('action.play_card.max_cards', 1).should be_true }
          #   specify { board.allowed?('action.play_card.max_cards', 2).should be_false }
          # end
        end
      end

    end

  end
end