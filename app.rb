require 'sinatra'
require 'geoip'
require 'multi_json'

data_file = File.expand_path(File.join(File.dirname(__FILE__), 'data', 'GeoLiteCity.dat'))

configure :production do
  require 'newrelic_rpm'

  if ENV['AUTH_USERNAME']
    use Rack::Auth::Basic, "Restricted Area" do |username, password|
      username == ENV['AUTH_USERNAME'] && password == ENV['AUTH_PASSWORD']
    end
  end
end

get '/json/' do
  data = GeoIP.new(data_file).city(request.ip)
  request_response(data)
end

get /\/json\/(\d{1,3}\.\d{1,3}\.\d{1,3}\.\d{1,3})$/ do |ip|
  data = GeoIP.new(data_file).city(ip)
  request_response(data)
end

def request_response(data)
  content_type 'application/json;charset=ascii-8bit'
  headers['Cache-Control'] = "no-cache"
  headers['Access-Control-Allow-Origin'] = '*'
  return "{}" unless data
  MultiJson.encode(encode(data))
end

def encode data
  {
    # The host or IP address string as requested
    :ip => data.request,
    # The IP address string after looking up the host
    :ip_lookup => data.ip,
    # The ISO3166-1 two-character country code
    :country_code => data.country_code2,
    # The ISO3166-2 three-character country code
    :country_name => data.country_name,
    # The two-character continent code
    :continent => data.continent_code,
    # The region code
    :region_code => data.region_name,
    # The region name
    :region_name => data.real_region_name,
    # The city name
    :city => data.city_name,
    # The postal code
    :postal_code => data.postal_code,
    # The latitude
    :latitude => data.latitude,
    # The longitude
    :longitude => data.longitude,
    # The USA DMA code, if available
    :dma_code => data.dma_code,
    # The area code, if available
    :area_code => data.area_code,
    # Timezone, if available
    :timezone => data.timezone
  }
end
