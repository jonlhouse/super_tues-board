# RSpec Setup Steps
#
module GameSteps
  def setup_game
    player0, player1, player2, player3 = (0...4).map { |n| SuperTues::Board::Player.new name: "player-#{n}" }

    board = SuperTues::Board::Game.new
    board.add_players player0, player1, player2, player3
    board.deal_candidates
    board.players.each { |player| player.candidate = player.candidates_dealt.sample }
    board.init_game

    board
  end
end
