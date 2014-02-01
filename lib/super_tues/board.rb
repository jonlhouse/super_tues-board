require "super_tues/board/version"
require "super_tues/board/game"
require "super_tues/board/player"
require "super_tues/board/candidate"
require "super_tues/board/state"
require "super_tues/board/state_bin"
require "super_tues/board/day"
require "super_tues/board/calendar"
require "super_tues/board/card"
require "super_tues/board/news"
require "super_tues/board/deck"
require "super_tues/board/bill"
require "super_tues/board/rules"
require "super_tues/board/rule_set"
require "super_tues/board/card_deck"
require "super_tues/board/news_deck"
require "super_tues/board/bill_deck"
require "super_tues/board/candidate_deck"
require "super_tues/board/cash"
require "super_tues/board/clout"
require "super_tues/board/front_runner"

require "super_tues/board/events"
require "super_tues/board/actions"

require 'active_support/core_ext/object'
require 'active_support/core_ext/hash'
require 'active_support/core_ext/string'
require 'active_support/core_ext/numeric'

require 'yaml'

module SuperTues
  module Board
    # Your code goes here...

    @config = { 
      candidates_per_player: 3,
      starting_cash: 20,
      starting_clout: 20,
      starting_cards: 3
    }

    def self.config
      @config
    end

    def self.load_candidates
      load_yaml('candidates')
    end

    def self.load_states
      load_yaml('states')
    end

    def self.load_days
      load_yaml('days')
    end

    def self.load_yaml(filename)
      yaml_filename = File.join File.dirname(__FILE__), "yaml/#{filename}.yaml"
      YAML::load(File.open(yaml_filename))      
    rescue Errno::ENOENT => e
      # log(:warning, "YAML configuration file couldn't be found. Using defaults.")
      raise e
    rescue Psych::SyntaxError => e
      # log(:warning, "YAML configuration file contains invalid syntax. Using defaults.")
      raise e
    end

  end
end
