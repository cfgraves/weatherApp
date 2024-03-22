class WeatherController < ApplicationController
  before_action :find_address_by_zip

  def index

  end

  private

  # using params from the form, attempt to check for weather updates. Will only search for zip if is 5 digits
  def find_address_by_zip
    zipcode = params[:zipcode]
    if zipcode && zipcode.length == 5
      @address = Address.where(zipcode: zipcode).first || Address.create(zipcode: zipcode)
      check_weather_updates
      @current_weather = @address.current_weather
      @weather_forecast = @address.weather_forecast
    end
  end

  # check for weather updates, starts the path to API call
  def check_weather_updates
    if @address.cached_at.nil? || @address.cached_at < 30.minutes.ago
      # update weather patterns with new data
      if WeatherPattern.create_weather_pattern_set(@address)
        @address.update(cached_at: Time.now)
      end
    else
      @cached = true
    end
  end

end
