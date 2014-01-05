require 'spec_helper'

describe NBA::Team, '.all' do
  before do
    stub_request(:get, 'https://www.googleapis.com/freebase/v1/mqlread').with(:query => {:query => described_class.mql_query}).to_return(:body => fixture('teams.json'))
  end

  after do
    described_class.reset
  end

  subject do
    described_class.all
  end

  it 'there are thirty teams' do
    expect(subject.size).to eq 30
  end

  it 'teams are sorted alphabetically, by name' do
    expect(subject).to eq subject.sort_by(&:name)
  end

  it 'every team has a founding year' do
    subject.each do |team|
      expect(team.founded).to be_between(1870, 2008), "got: #{team.founded} for #{team.name}"
    end
  end

  it 'every player has a one- or two-digit number' do
    subject.each do |team|
      team.players.each do |player|
        expect(player.number).to be_between(0, 99), "got: #{player.number} for #{player.name}"
      end
    end
  end

  it 'every player has at least one position' do
    subject.each do |team|
      team.players.each do |player|
        pending 'Some players do not have a position' # Delonte West
        expect(player.positions.size).to be >= 1, "got: #{player.positions.size} for #{player.name}"
      end
    end
  end

  it 'every player has a starting year' do
    subject.each do |team|
      team.players.each do |player|
        pending 'Some players do not have a starting year' # 0 for Ivan Johnson
        expect(player.from).to be >= 1995, "got: #{player.from} for #{player.name}"
      end
    end
  end

  it 'every player is active' do
    subject.each do |team|
      team.players.each do |player|
        expect(player.to).to eq('Present'), "got: #{player.to} for #{player.name}"
      end
    end
  end

  context 'with timeout' do
    before do
      stub_request(:get, 'https://www.googleapis.com/freebase/v1/mqlread').with(:query => {:query => described_class.mql_query}).to_timeout
    end

    it 'does not raise an exception' do
      expect { subject }.not_to raise_exception
    end
  end

  context 'without connection' do
    before do
      stub_request(:get, 'https://www.googleapis.com/freebase/v1/mqlread').with(:query => {:query => described_class.mql_query}).to_raise(SocketError)
    end

    it 'does not raise an exception' do
      expect { subject }.not_to raise_exception
    end
  end

  context 'with no route to host' do
    before do
      stub_request(:get, 'https://www.googleapis.com/freebase/v1/mqlread').with(:query => {:query => described_class.mql_query}).to_raise(Errno::EHOSTUNREACH)
    end

    it 'does not raise an exception' do
      expect { subject }.not_to raise_exception
    end
  end
end
