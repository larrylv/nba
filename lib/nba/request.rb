require 'faraday'
require 'faraday_middleware'
require 'faraday_middleware/scrape_game'

module NBA
  # @private
  class Request
    def self.get_teams(path, options = {})
      freebase_connection.get do |request|
        request.url(path, options)
      end.body
    end

    def self.get_games(path, options = {})
      espn_connection.get do |request|
        request.url(path, options)
      end.body
    end

  private

    def self.freebase_connection
      Faraday.new(:url => 'https://www.googleapis.com', :ssl => {:verify => false}) do |builder|
        builder.request :url_encoded
        builder.use FaradayMiddleware::ParseJson
        builder.adapter Faraday.default_adapter
      end
    end

    def self.espn_connection
      Faraday.new(:url => 'http://scores.espn.go.com') do |builder|
        builder.use FaradayMiddleware::ScrapeGame
        builder.adapter Faraday.default_adapter
      end
    end
  end
end
