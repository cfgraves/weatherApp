# README

Welcome to Its Weather Time! 

This simple app demonstates connecting to a 3rd party api (OpenWeather) to fetch and display weather data based on the zipcode entered.

Ruby version, recommended to use RVM for Ruby library management

    Ruby version 3.3.0
    Rails version 7.1.3.2

For other gems, please refer to the Gemfile

Database creation

This app uses default database, sqlite3. Make sure to install before attempting to create the database.

    rails db:create

Database initialization

    rails db:migrate

How to run the test suite

The test framework uses rspec. You can run the test suite with the following:

    rspec

Credentials
    
This system uses the built-in Ruby/Rails encrypted credentials file. The only key is for OpenWeatherAPI that is managed by my personal account.

