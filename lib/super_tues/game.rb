require "super_tues/game/version"
require "super_tues/game/board"
require "super_tues/game/player"
require "super_tues/game/candidate"
require "super_tues/game/state"
require "super_tues/game/day"

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

    def self.load_candidates_yaml
      yaml_filename = File.join File.dirname(__FILE__), "yaml/candidates.yaml"
      YAML::load File.open(yaml_filename)
    rescue Errno::ENOENT => e
      # log(:warning, "YAML configuration file couldn't be found. Using defaults.")
      raise e
    rescue Psych::SyntaxError => e
      # log(:warning, "YAML configuration file contains invalid syntax. Using defaults.")
      raise e      
    end

    def self.load_states_yaml
      yaml_filename = File.join File.dirname(__FILE__), "yaml/states.yaml"
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
