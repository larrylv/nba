require 'faraday'
require 'json'

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

    ADJUST_WIDTH = 16
    def pretty_print
      puts "%#{ADJUST_WIDTH}s: #{self.name}" % "Name"
      puts "%#{ADJUST_WIDTH}s: #{self.founded}" % "Founded"
      puts "%#{ADJUST_WIDTH}s: #{self.conference}" % "Conference"
      puts "%#{ADJUST_WIDTH}s: #{self.division}" % "Division"
      puts "%#{ADJUST_WIDTH}s: #{self.coach}" % "Coach"
      puts "%#{ADJUST_WIDTH}s: #{pretty_print_championships}" % "Championships"
      puts "%#{ADJUST_WIDTH}s: #{pretty_print_players}" % "Players"
    end

    private

      def initialize(attributes = {})
        attributes.each do |key, value|
          instance_variable_set("@#{key}", value) if self.respond_to?(key)
        end
      end

      def pretty_print_championships
        idx = 0

        self.championships.sort.reverse.each_slice(2).inject("") do |string, chams|
          string << "\n" +  (" " * (ADJUST_WIDTH + 2)) if (idx += 1) != 1
          string << chams.join(", ")
        end
      end

      def pretty_print_players
        idx = 0

        self.players.sort_by{|p| -p.number}.reverse.inject("") do |string, player|
          string << "\n" +  (" " * (ADJUST_WIDTH + 2)) if (idx += 1) != 1
          string << player.pretty_print
        end
      end

      def self.results_from_freebase
        options = {:query => mql_query}
        Request.get_teams('/freebase/v1/mqlread', options)
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
            :founded       => result['/sports/sports_team/founded'].to_i,
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
