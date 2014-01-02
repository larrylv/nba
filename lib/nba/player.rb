module NBA
  class Player
    attr_reader :name, :number, :position, :from, :to

    def initialize(attributes = {})
      attributes.each do |key, value|
        instance_variable_set("@#{key}", value) if self.respond_to?(key)
      end
    end

    # Returns an array of Player objects given a team roster
    def self.all_from_roster(players)
      players.map do |player|
        next unless player['to'].nil?

        new(
          :name     => player['player'],
          :number   => player['number'],
          :position => player['position'],
          :from     => player['from'],
          :to       => "Present"
        )
      end.compact
    end
  end
end
