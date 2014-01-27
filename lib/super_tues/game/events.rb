# require the following Events::EVENT_CLASS file
['event', 'business', 'news', 'payday', 'primary', 'read_bill', 
 'vote_bill', 'rent'].each { |file| require_relative "events/#{file}" }