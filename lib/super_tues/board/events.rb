require_relative "events/event"
[:business, :news, :payday, :primary, :read_bill, :vote_bill, :rent].each { |file| require_relative "events/#{file}"}