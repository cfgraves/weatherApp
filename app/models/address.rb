class Address < ApplicationRecord
  # stores addresses that have been search for caching data
  has_many :weather_patterns

  # returns the most recent weather pattern
  def current_weather
    WeatherPattern.where(address_id: id, forecast: false).last
  end

  # returns the last 8 weather patterns, to build the next 24 hours of weather
  def weather_forecast
    WeatherPattern.where(address_id: id, forecast: true).last(8)
  end

end
