require 'rails_helper'

RSpec.describe Address, :type => :model do

  it "returns the current weather" do
    address = Address.create(:zipcode => '27703')
    weather_pattern = WeatherPattern.create(:address_id => address.id, :forecast => false)
    weather_forecast = WeatherPattern.create(:address_id => address.id, :forecast => true)

    expect(address.current_weather).to eq weather_pattern
    expect(address.current_weather).to_not eq weather_forecast
  end

  it "returns the weather forecast" do
    address = Address.create(:zipcode => '27703')
    weather_pattern = WeatherPattern.create(:address_id => address.id, :forecast => false)
    weather_forecast = WeatherPattern.create(:address_id => address.id, :forecast => true)

    expect(address.weather_forecast).to eq [weather_forecast]
    expect(address.weather_forecast).to_not eq weather_pattern
  end
end
