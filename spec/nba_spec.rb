require 'spec_helper'

describe NBA::Team, '.all' do
  context 'with connection' do
    before do
      stub_request(:get, 'https://www.googleapis.com/freebase/v1/mqlread').with(:query => {:query => NBA::Team.mql_query}).to_return(:body => fixture('teams.json'))
    end

    after do
      NBA::Team.reset
    end

    it 'requests the correct resource' do
      NBA::Team.all
      expect(a_request(:get, 'https://www.googleapis.com/freebase/v1/mqlread').with(:query => {:query => NBA::Team.mql_query})).to have_been_made
    end

    it 'returns the correct team results' do
      teams = NBA::Team.all
      expect(teams.first.name).to eq 'Atlanta Hawks'
    end

    it 'returns the correct player results' do
      teams = NBA::Team.all
      expect(teams.first.players.first.name).to_not be_nil
    end
  end

  context 'with timeout' do
    before do
      stub_request(:get, 'https://www.googleapis.com/freebase/v1/mqlread').with(:query => {:query => NBA::Team.mql_query}).to_timeout
    end

    after do
      NBA::Team.reset
    end

    it 'returns the correct results' do
      teams = NBA::Team.all
      expect(teams.first.name).to eq 'Atlanta Hawks'
    end
  end

  context 'without connection' do
    before do
      stub_request(:get, 'https://www.googleapis.com/freebase/v1/mqlread').with(:query => {:query => NBA::Team.mql_query}).to_raise(SocketError)
    end

    after do
      NBA::Team.reset
    end

    it 'returns the correct results' do
      teams = NBA::Team.all
      expect(teams.first.name).to eq 'Atlanta Hawks'
    end
  end

  context 'with no route to host' do
    before do
      stub_request(:get, 'https://www.googleapis.com/freebase/v1/mqlread').with(:query => {:query => NBA::Team.mql_query}).to_raise(Errno::EHOSTUNREACH)
    end

    after do
      NBA::Team.reset
    end

    it 'returns the correct results' do
      teams = NBA::Team.all
      expect(teams.first.name).to eq 'Atlanta Hawks'
    end
  end
end
