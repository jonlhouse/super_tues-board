require 'spec_helper'

module SuperTues
  module Board

    describe "SuperTues game simulation (1)" do

      let(:player0) { Player.new(name: 'player-0', color: :red) }
      let(:player1) { Player.new(name: 'player-1', color: :blue) }
      let(:player2) { Player.new(name: 'player-2', color: :green) }
      let(:player3) { Player.new(name: 'player-3', color: :yellow) }

      let(:game) { Game.new }

      # adding players to the game
      before(:each) { game.add_players player0, player1, player2, player3 }
      specify { game.players.should == [player0, player1, player2, player3] }      

      # dealing candidates
      before(:each) { game.deal_candidates }
      it "deals candidates to players" do
        game.players.each { |player| expect(player).to receive(:candidates_dealt=) }
        game.deal_candidates
      end

      # picking candidates
      before(:each) { game.players.each { |player| player.candidate = player.candidates_dealt.sample } }
      specify { game.candidates_picked?.should be }

      # start the game
      before(:each) { game.init_game }

      # colors are assigned to players
      specify { game.players.each { |player| player.color.should be_in Player::COLORS } }
      specify { game.players.map(&:color).uniq.length.should == game.players.length }

      # home states
      specify { game.players.each { |player| game.state(player.candidate.state).picks[player].should == 3 } }

      # other states should be zero'ed
      specify { game.states.inject(0) { |acc, state| acc + state.picks.total }.should == 12 }  # 3 picks x 4 players, all reset zero

      # seating players
      specify { game.seats.keys.sort.should == (0..3).to_a }

      # players should have seed funds
      specify { game.players.each { |player| expect(player.cash).to be > 0 } }
      specify { game.players.each { |player| expect(player.clout).to be > 0 } }
      specify { game.players.each { |player| expect(player.cards.length).to be > 0 } }

      # game should assign a front runner
      specify { game.front_runner.should be_in game.players }
    end

    describe "first turn" do
      let(:game) { setup_game }
      specify { game.players.should_not be_empty }
    end

  end
end