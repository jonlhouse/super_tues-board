# require the following Action::ACTION_CLASS file
['action', 'radio_spot', 'political_favor', 'move', 
 'poll', 'play_card', 'discard'].each { |file| require_relative "actions/#{file}" }