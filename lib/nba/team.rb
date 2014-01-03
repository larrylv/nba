module NBA
  class Team
    attr_reader :name, :founded, :conference, :division, :championships, :players, :head_coach, :team_stats

    alias :coach :head_coach

    # Returns an array of Team objects
    #
    # @example
    #   NBA::Team.all.first.name                    # => "Atlanta Hawks"
    #   NBA::Team.all.first.division                # => "Southeast Division"
    #   NBA::Team.all.first.founded                 # => 1946
    #   NBA::Team.all.first.players.first.name      # => "Al Horford"
    #   NBA::Team.all.first.players.first.number    # => 15
    #   NBA::Team.all.first.players.first.position  # => ["Forward-center"]
    def self.all
      # Attempt to fetch the result from the Freebase API unless there is a
      # connection error, in which case read from a fixture file
      @all ||= begin
        results_to_team(results_from_freebase)
      rescue Errno::EHOSTUNREACH, Faraday::Error::ConnectionFailed, Faraday::Error::TimeoutError
        results_to_team(results_from_cache)
      end
    end

    def self.reset
      @all = nil
    end

  private

    def initialize(attributes = {})
      attributes.each do |key, value|
        instance_variable_set("@#{key}", value) if self.respond_to?(key)
      end
    end

    def self.results_from_freebase
      options = {:query => mql_query}
      Request.get('/freebase/v1/mqlread', options)
    end

    def self.results_from_cache
      JSON.load(file_from_cache('teams.json').read)
    end

    def self.file_from_cache(file_name)
      File.new(File.expand_path('../../../cache', __FILE__) + '/' + file_name)
    end

    def self.results_to_team(results)
      results['result'].map do |result|
        players       = result['/sports/sports_team/roster']

        new(
          :name          => result['name'],
          :conference    => result['/basketball/basketball_team/conference'],
          :division      => result['/basketball/basketball_team/division'],
          :head_coach    => result['/basketball/basketball_team/head_coach'],
          :team_stats    => result['/basketball/basketball_team/team_stats'],
          :founded       => result['/sports/sports_team/founded'],
          :championships => result['/sports/sports_team/championships'],
          :players       => (players ? Player.all_from_roster(players) : [])
        )
      end
    end

    # Returns the MQL query for teams, as a Ruby hash
    def self.mql_query
      query = <<-eos
        [{
          "name":          null,
          "mid":           null,
          "/basketball/basketball_team/head_coach": null,
          "/basketball/basketball_team/conference": null,
          "/basketball/basketball_team/division": null,
          "/sports/sports_team/founded": null,
          "/sports/sports_team/championships": [],
          "/sports/sports_team/roster": [{
            "number":   null,
            "player":   null,
            "from":     null,
            "to":       null,
            "position": [],
            "sort": "player"
          }],
          "/basketball/basketball_team/team_stats": [{
            "optional": true,
            "season": null,
            "wins": null,
            "losses": null
          }],
          "sort":          "name",
          "type":          "/basketball/basketball_team",
          "/sports/sports_team/league": [{
            "league": "National Basketball Association"
          }]
        }]
        eos
      query.gsub!("\n", '')
    end
  end
end
