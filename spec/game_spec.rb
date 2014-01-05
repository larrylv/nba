require 'spec_helper'

describe NBA::Game, '.all' do
  before :all do
    @date = '20140104'
  end

  subject { described_class.scoreboard(@date) }

  context 'with timeout' do
    before do
      stub_request(:get, 'http://scores.espn.go.com/nba/scoreboard').with(:query => {:date => @date}).to_timeout
    end

    it 'does not raise an exception' do
      expect { subject }.not_to raise_exception
    end
  end

  context 'without connection' do
    before do
      stub_request(:get, 'http://scores.espn.go.com/nba/scoreboard').with(:query => {:date => @date}).to_raise(SocketError)
    end

    it 'does not raise an exception' do
      expect { subject }.not_to raise_exception
    end
  end

  context 'with no route to host' do
    before do
      stub_request(:get, 'http://scores.espn.go.com/nba/scoreboard').with(:query => {:date => @date}).to_raise(Errno::EHOSTUNREACH)
    end

    it 'does not raise an exception' do
      expect { subject }.not_to raise_exception
    end
  end
end

