module OpenWeather
  class Api
    include HTTParty

    WEATHER_URL = "https://api.openweathermap.org/data/2.5/weather?"
    FORECAST_URL = "https://api.openweathermap.org/data/2.5/forecast?"
    APP_ID = "appid=#{Rails.application.credentials.dig(:open_weather, :secret_key)}&"

    def query_current
      url = WEATHER_URL+@search_terms+APP_ID+@units
      puts url
      request = HTTParty.get(url).to_json
      @request = JSON.parse(request)
    end

    def query_forecast
      url = FORECAST_URL+@search_terms+APP_ID+@units
      puts url
      request = HTTParty.get(url).to_json
      @request = JSON.parse(request)
    end

    def initialize(zip)
      @search_terms = "zip=#{zip},us&"
      @units = "units=imperial"
    end
  end
end
