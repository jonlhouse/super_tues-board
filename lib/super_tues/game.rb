require "super_tues/game/version"
require "super_tues/game/board"
require "super_tues/game/player"
require "super_tues/game/candidate"
require "super_tues/game/state"
require "super_tues/game/day"

require "super_tues/game/events/event"
require "super_tues/game/events/payday"

require 'yaml'

module SuperTues
  module Game
    # Your code goes here...

    @config = { 
      candidates_per_player: 3
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
      YAML::load File.open(yaml_filename)
    rescue Errno::ENOENT => e
      # log(:warning, "YAML configuration file couldn't be found. Using defaults.")
      raise e
    rescue Psych::SyntaxError => e
      # log(:warning, "YAML configuration file contains invalid syntax. Using defaults.")
      raise e
    end

  end
end
