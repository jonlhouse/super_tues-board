require_relative "events/event"
require_relative "events/notices/notice"
events = [:business, :news, :payday, :primary, :read_bill, :vote_bill, :rent]
events.each { |event| require_relative "events/#{event}" }
events.each { |event| require_relative "events/notices/#{event}_notice" }