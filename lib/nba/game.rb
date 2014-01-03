module NBA
  class Game
    attr_reader :home_team, :home_score, :away_team, :away_score, :status

    # Returns an array of Team objects
    #
    # @example
    #   NBA::Game.all.first.name                    # => "Atlanta Hawks"
    def self.all(date = (Time.now.utc - 5 * 60 * 60).strftime("%Y%m%d"))
      games = results_to_game(results_from_espn(date))
      print(games)
    end

    def pretty_format(options = {})
      self.status.center(options[:status_length].to_i + 1) + " - " + \
        self.home_team.center(options[:home_length].to_i + 1) + " " + \
        (self.home_score =~ /\d/ ? self.home_score.center(4) : "") + " : " + \
        (self.away_score =~ /\d/ ? self.away_score.center(4) : "") + " " + \
        self.away_team.center(options[:away_length].to_i + 1)
    end

    private
      def initialize(attributes = {})
        attributes.each do |key, value|
          instance_variable_set("@#{key}", value) if self.respond_to?(key)
        end
      end

      def self.length_options_of(games)
        {
          :status_length => games.map(&:status).map(&:length).max,
          :home_length   => games.map(&:home_team).map(&:length).max,
          :away_length   => games.map(&:away_team).map(&:length).max,
        }
      end

      def self.print(games)
        length_options = length_options_of(games)
        puts games.map { |game| game.pretty_format(length_options) }.join("\n")
      end

      def self.results_to_game(results)
        results.map { |result| new result }
      end

      def self.results_from_espn(date)
        options = {:date => date}
        Request.get_games('/nba/scoreboard', options)
      end
  end
end
