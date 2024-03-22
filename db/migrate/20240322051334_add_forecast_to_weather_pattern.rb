class AddForecastToWeatherPattern < ActiveRecord::Migration[7.1]
  def change
    add_column :weather_patterns, :forecast, :boolean, :default => false
  end
end
