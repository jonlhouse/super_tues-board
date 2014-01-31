# RSpec Setup Steps
#
module GameSteps
  def setup_game
    player0, player1, player2, player3 = (0...4).map { |n| SuperTues::Game::Player.new name: "player-#{n}" }

    board = SuperTues::Game::Board.new
    board.add_players player0, player1, player2, player3
    board.deal_candidates
    board.players.each { |player| player.candidate = player.candidates_dealt.sample }
    board.start_game

    board
  end
end
