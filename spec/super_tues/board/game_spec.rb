require 'spec_helper.rb'

module SuperTues
  module Board

    describe Game do
      let(:game) { Game.new }

      context "new game" do
        specify { game.should be_a Game }

        describe "candidates" do
          let(:candidates) { game.remaining_candidates }          
        end

        describe "#states" do
          # new game state for the state bins
          specify { game.states.length.should == 51 }  # 50 states + DC
          specify { (game.states.map { |state| state.name } - State::NAMES.keys).should be_empty }
          specify { game.states.each { |state| state.picks.empty?.should be_true } }
          specify { game.states.each { |state| state.electoral_votes.should > 0 } }
          specify { game.states.each { |state| state.sway.should be_within(4).of(0) } }
        end

        describe "#state(name)" do
          specify { game.state(:in).name.should == 'Indiana' }
          # we have two hash -- make sure they point to exactly the same object
          specify { game.state(:in).should equal game.state('Indiana') }
        end

        describe "days" do
          # new game initializes the game day array
          specify { game.days.should_not be_empty }
          let(:first_day) { game.days.first }
          specify { first_day.date.should == Date.new(2016, 1, 4)}
        end

        describe "card deck and cards" do
          specify { game.instance_variable_get(:@card_deck).should be_present }
        end

        describe "news deck and news" do
          specify { game.instance_variable_get(:@news_deck).should be_present }
        end

        describe "bills deck" do
          specify { game.instance_variable_get(:@bill_deck).should be_present }
        end
      end

      describe "seats" do
        describe "#seat_taken?(seat_num)" do
          it "looks into players' seats" do
            player = double(seat: 1)
            game.stub(:players) { [player] }
            game.seat_taken?(1).should be_true
            game.seat_taken?(0).should be_false
          end
        end
        describe "#seats" do
          it "returns a hash mapping seats to players" do
            p1 = double(seat: 0).tap { |p| p.should_receive(:game=) }
            p2 = double(seat: 1).tap { |p| p.should_receive(:game=) }
            game.add_players p1, p2
            game.seats.should == { 0 => p1, 1 => p2 }
          end
        end
        describe "#seat_players" do
          it "seats players" do
            p1 = Player.new(name: 'p1')
            p2 = Player.new(name: 'p2')
            game.add_players p1, p2
            seats = game.seat_players
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
            it "add players and updates player's game" do
              game.add_players(bob, tom)
              game.players.count.should == 2 
              game.players.each { |player| player.game.should == game }          
            end
          end
        end

        describe "once players added" do
          before(:each) { game.add_players(bob, tom, jim) }

          describe "picking candidates" do
            describe "#deal_candidates" do          
              it "deals candidates to players" do
                game.deal_candidates
                game.players.each { |player| player.candidates_dealt.count.should == SuperTues::Board.config[:candidates_per_player] }
              end 

              it "candidates are unique" do
                game.deal_candidates
                dealt = game.players.map { |player| player.candidates_dealt }.flatten
                dealt.length.should == dealt.uniq.length
              end
            end

            describe "#candidate_available?" do
              let(:a) { double }
              it "true when" do
                game.stub(:candidates) { [] }
                game.candidate_available?(a).should be
              end
              it "false when" do
                game.stub(:candidates) { [a] }
                game.candidate_available?(a).should_not be
              end
            end

            describe "#candidates_picked?" do
              before(:each) { game.deal_candidates }

              specify { game.candidates_picked?.should_not be }
              it "true when all players have picked a candidate" do
                game.players.each { |p| p.candidate = p.candidates_dealt.sample }
                game.candidates_picked?.should be
              end
            end
          end

          describe "#seed_player_funds" do
            it "calls #seed_funds for each player" do
              game.players.each { |player| player.should_receive :seed_funds }
              game.send(:seed_player_funds)
            end
          end

          describe "#reset_state_bins" do
            it "sets each states picks to zero" do
              game.states.first.picks[:red] = 10
              game.send(:reset_state_bins)
              game.states.each do |state|
                expect(state.picks.total).to be == 0
              end
            end
          end

          describe "#add_home_state_picks" do
            let(:p1) { double('player', candidate: double(state: :in), to_sym: :red, name: 'p1') }
            let(:p2) { double('player', candidate: double(state: :ny), to_sym: :blue, name: 'p2') }
            before(:each) { game.stub(players: [p1, p2]) }
            it "should give in and ny 3 picks each" do
              game.send(:add_home_state_picks)
              game.state(:in).picks[:red].should == 3
              game.state(:ny).picks[:blue].should == 3
            end
          end

          describe "#start_game" do
            before(:each) do
              game.deal_candidates
              game.players.each { |player| player.candidate = player.candidates_dealt.first }
            end
            it "assigns colors to players" do
              game.start_game
              game.players.each { |player| expect(player.to_sym).to be_in(Player::COLORS) }
            end
            it "seeds players funds" do
              game.start_game
              game.players.each do |player|
                expect(player.cash).to be > 0
                expect(player.clout).to be > 0
                expect(player.cards.count).to be > 0
              end
            end
            it "seats players" do
              game.start_game
              game.players.each { |player| expect(player.seat).to be_in(0...game.players.count) }
              expect(game.players.map(&:seat).uniq.count).to be == game.players.count
            end
            it "reset state bins" do
              expect(game).to receive(:reset_state_bins)
              game.start_game              
            end
            it "adds home state bins" do
              game.start_game
              game.players.each do |player|
                game.state(player.candidate.state).picks[player].should be > 0
              end
            end
            it "randomly picks a front runner" do
              game.start_game
              expect(game.front_runner).to be_in(game.players)
            end
            it "sets today to the first calendar day" do
              game.start_game
              expect(game.today).to be == game.days.first
            end
          end

        end  # once players added
      end   # setup

      describe "rules" do
        describe "querying rules" do          
          describe "#rule('rule.str.ing')" do
            # check a default rule
            specify { game.rule('action.radio_spot.picks.max').should == 5 }
          end
          # describe "rule(rule_str)" do
          #   specify { game.rule('action.radio_spot.max_picks').should == 5 }
          # end

          # describe "allowed?(rule_str)" do
          #   specify { game.allowed?('action.play_card.max_cards', 1).should be_true }
          #   specify { game.allowed?('action.play_card.max_cards', 2).should be_false }
          # end
        end
      end

    end

  end
end