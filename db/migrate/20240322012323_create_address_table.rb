class CreateAddressTable < ActiveRecord::Migration[7.1]
  def change
    create_table :addresses do |t|
      t.integer :zipcode, null: false
      t.datetime :cached_at
      t.timestamps
    end
  end
end
