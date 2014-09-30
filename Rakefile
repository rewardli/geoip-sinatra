require 'bundler'

namespace :geoip do
  desc "Update GeoIP City data file"
  task :update => :data do
    %x{wget http://geolite.maxmind.com/download/geoip/database/GeoLiteCity.dat.gz && gzip -d GeoLiteCity.dat.gz && mv GeoLiteCity.dat ./data}
  end

  task :data do
    %x{mkdir -p data}
  end
end
