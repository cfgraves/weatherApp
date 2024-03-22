class AddIconToWeatherPattern < ActiveRecord::Migration[7.1]
  def change
    add_column :weather_patterns, :weather_icon, :string
  end
end
