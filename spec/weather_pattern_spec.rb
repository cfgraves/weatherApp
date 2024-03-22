require 'rails_helper'
# ran out of time for all the tests that I would like to do here.

RSpec.describe WeatherPattern, :type => :model do
  it 'creates a weather pattern set by address'

  it 'creates current weather pattern'

  it 'creates current weather forecasts'

  describe 'the process of coercing data from API' do
    it 'coerces api data' do
      json_response = {
        "main": {
          "temp": 65.66,
          "temp_min": 62.08,
          "temp_max": 70.07,
        },
        "weather": [{
          "id": 804,
          "main": "Clouds",
          "description": "overcast clouds",
          "icon": "04d"
        }]
      }.to_json

      example_coerced_data = {
        current_temp: 65.66,
        high_temp: 70.07,
        low_temp: 62.08,
        weather: "Clouds",
        weather_icon: "04d"
      }

      parsed_data = JSON.parse(json_response)
      coerced_data = WeatherPattern.coerce_api_data(parsed_data)

      expect(coerced_data[:current_temp]).to eq example_coerced_data[:current_temp]
      expect(coerced_data[:high_temp]).to eq example_coerced_data[:high_temp]
      expect(coerced_data[:low_temp]).to eq example_coerced_data[:low_temp]
      expect(coerced_data[:weather]).to eq example_coerced_data[:weather]
      expect(coerced_data[:weather_icon]).to eq example_coerced_data[:weather_icon]
    end

    it 'returns an empty array from empty data set' do
      empty_set = []

      expect(WeatherPattern.coerce_api_data(empty_set)).to eq []
    end
  end
end
