geoip-sinatra
=============

A simple Sinatra-based geoip server. It uses the free Maxmind geolite city database with the geoip ruby gem. The database is updated about once a month. The service runs here:

  * https://geoip.perkhub.com/json/
  * https://geoip.perkhub.com/json/123.123.123.123


## How to deploy to Heroku

The app is hosted on Heroku and run using Phusion Passenger.

  git remote add heroku git@heroku.com:perkhub-geoip.git
  git push heroku master

## How to update the database

  rake geoip:update

Commit and push to Heroku.

## Basic Authentication

Set a username and password with the environment variables AUTH_USERNAME and AUTH_PASSWORD.


## Acknowledgements

Part of the code was copied and distilled from https://github.com/JackDanger/geoip_server
