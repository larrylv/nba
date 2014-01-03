require 'faraday_middleware/response_middleware'
require 'nokogiri'

module FaradayMiddleware
  class ScrapeGame < ResponseMiddleware
    define_parser do |body|
      doc = Nokogiri::HTML.parse body
      doc.css('.score-row .mod-content').inject([]) do |results, game_node|
        home_team_node = game_node.css('.home').first
        home_team      = home_team_node.css('p.team-name').first.search('a').first.content
        home_score     = home_team_node.css('.finalScore').first.content

        away_team_node = game_node.css('.away').first
        away_team      = away_team_node.css('p.team-name').first.search('a').first.content
        away_score     = away_team_node.css('.finalScore').first.content

        status = game_node.css('.game-status').first.search('p').first.content

        results << {
          :home_team  => home_team,
          :home_score => (home_score.strip rescue ''),
          :away_team  => away_team,
          :away_score => (away_score.strip rescue ''),
          :status     => status
        }
      end
    end
  end
end
