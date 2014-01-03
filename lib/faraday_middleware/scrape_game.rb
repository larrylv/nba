require 'faraday_middleware/response_middleware'
require 'nokogiri'

module FaradayMiddleware
  class ScrapeGame < ResponseMiddleware
    define_parser do |body|
      doc = Nokogiri::HTML.parse body
      doc.css('.score-row .mod-content').inject([]) do |results, game_node|
        home_team_node = game_node.css('.home').first
        home_score     = home_team_node.css('.finalScore').first.content
        home_team_name_node = home_team_node.css('p.team-name').first
        begin
          home_team = home_team_name_node.search('a').first.content
        rescue
          # some teams may change their name, so the old team has no links.
          home_team = home_team_name_node.search('span').first.content
        end

        away_team_node = game_node.css('.away').first
        away_score     = away_team_node.css('.finalScore').first.content
        away_team_name_node = away_team_node.css('p.team-name').first
        begin
          away_team = away_team_name_node.search('a').first.content
        rescue
          # some teams may change their name, so the old team has no links.
          away_team = away_team_name_node.search('span').first.content
        end

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
