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

    it 'returns the correct results' do
      teams = NBA::Team.all
      expect(teams.first.name).to eq 'Atlanta Hawks'
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
end
