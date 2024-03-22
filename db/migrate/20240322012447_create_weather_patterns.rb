class CreateWeatherPatterns < ActiveRecord::Migration[7.1]
  def change
    create_table :weather_patterns do |t|
      t.float :current_temp
      t.float :high_temp
      t.float :low_temp
      t.string :weather
      t.integer :address_id
      t.datetime :date
      t.timestamps
    end
  end
end
