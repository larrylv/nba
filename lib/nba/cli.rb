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
  end
end
