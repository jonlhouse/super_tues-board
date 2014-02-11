# RSpec Setup Steps
#
module GameSteps
  def setup_game
    player0, player1, player2, player3 = (0...4).map { |n| SuperTues::Board::Player.new name: "player-#{n}" }

    game = SuperTues::Board::Game.new
    game.add_players player0, player1, player2, player3
    game.deal_candidates
    game.players.each { |player| player.candidate = player.candidates_dealt.sample }
    game.reset

    game
  end

  def day1
    setup_game.tap do |game|
      game.start
    end
  end
end
