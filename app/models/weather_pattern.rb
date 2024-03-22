class WeatherPattern < ApplicationRecord
  # handles weather patterns, connected to an address via zipcode
  belongs_to :address

  def self.create_weather_pattern_set(address)
    # create the current weather pattern
    WeatherPattern.create_current_weather_pattern(address)
    # create the current weather forecast
    WeatherPattern.create_current_forecast_patterns(address)
  end

  # creates a weather pattern for the current weather experienced at the zipcode
  def self.create_current_weather_pattern(address)
    raw_data = OpenWeather::Api.new(address.zipcode).query_current
    data = WeatherPattern.coerce_api_data(raw_data)

    return if data.empty?

    WeatherPattern.create(
      address_id:       address.id,
      current_temp:     data[:current_temp],
      high_temp:        data[:high_temp],
      low_temp:         data[:low_temp],
      weather:          data[:weather],
      weather_icon:     data[:weather_icon]
    )
  end

  # creates a series of weather patterns as forecasts
  def self.create_current_forecast_patterns(address)
    raw_data = OpenWeather::Api.new(address.zipcode).query_forecast
    pattern_data = WeatherPattern.coerce_forecast_data(raw_data)

    return if pattern_data.empty?

    pattern_data.each do |pattern|
      WeatherPattern.create(
        address_id:       address.id,
        current_temp:     pattern[:current_temp],
        high_temp:        pattern[:high_temp],
        low_temp:         pattern[:low_temp],
        weather:          pattern[:weather],
        weather_icon:     pattern[:weather_icon],
        forecast:         true
      )
    end
  end

  # takes the data from the API request and coerces it to build the object
  def self.coerce_api_data(data)
    return [] if data.empty?

    data_hash = {
      current_temp: data["main"]["temp"],
      high_temp: data["main"]["temp_max"],
      low_temp: data["main"]["temp_min"],
      weather: data["weather"][0]["main"],
      weather_icon: data["weather"][0]["icon"]
    }

    return data_hash
  end

  # loops through the first 8 sets of forecast data
  def self.coerce_forecast_data(data)
    data["list"][0..7].map do |pattern|
      WeatherPattern.coerce_api_data(pattern)
    end
  end
end
