ENV['RACK_ENV'] = 'test'

require './app'
require 'rspec'
require 'rack/test'

describe "GeoIP Sinatra" do
  include Rack::Test::Methods

  def app
    Sinatra::Application
  end

  describe "GET /json/:ip/" do
    it "returns ok" do
      get '/json/173.239.76.85'
      expect(last_response).to be_ok
    end
  end

end
