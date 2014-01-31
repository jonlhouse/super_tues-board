# SuperTues::Board

SuperTues is a board game created by Peder Lindberg (rights reserved and used here with permission).  This gem contains the "game logic" as a series of plain-old ruby objects. 

## Installation

Add this line to your application's Gemfile:

    gem 'super_tues-board'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install super_tues-board

## Usage

Create a new SuperTues game with the following:

```ruby
	game = Game.new
```

An "in-progress" game can be started by passing a GameState object during initialization:

```ruby
	game = Game.new(GameState.load(...))
```

Players can be added to the game using:

```ruby
	player = game.add_player('player_name', Candidate.new("Sen. Barnes"))
```

Advance the game when a player takes a turn:

```ruby
	player_updates = game.player_turn(player.actions)
```

## Contributing

1. Fork it ( http://github.com/<my-github-username>/super_tues-board/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
