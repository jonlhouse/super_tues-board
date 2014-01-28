# require the following Action::ACTION_CLASS file
['action', 'play_picks', 'radio_spot', 'political_favor', 'move', 
 'poll', 'play_cards', 'discard', 'pass'].each { |file| require_relative "actions/#{file}" }