require 'thor'

module NBA
  class CLI < Thor
    desc "games DATE", "Retrieve games' scoreboard of date"
    method_option :date, :aliases => '-d', :desc => "format: YYYYMMDD"
    def games
      if options[:date].nil? || options[:date] == 'today'
        game_date_in_et = (Time.now.utc - 5 * 60 * 60).strftime("%Y%m%d")
      elsif options[:date] == 'yesterday'
        game_date_in_et = (Time.now.utc - (5 + 24) * 60 * 60).strftime("%Y%m%d")
      else
        game_date_in_et = options[:date]
      end

      Game.all(game_date_in_et)
    end

    desc "teams", "Retrieve teams' info, with players' info if `-p` arg is passed"
    method_option :name, :type => :string, :aliases => "-n", :required => true
    method_option :players, :type => :boolean, :aliases => "-p", :default => false
    def teams
      team_results = Team.all.select { |team| team.name =~ %r|#{options[:name]}|i }

      if team_results.count == 0
        puts "No team founded with name #{options[:name]}"
      else
        team_results.each do |team|
          team.pretty_print
          puts "-" * 42
        end
      end
    end
  end
end
