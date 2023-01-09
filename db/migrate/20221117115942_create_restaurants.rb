class CreateRestaurants < ActiveRecord::Migration[6.1]
  def change
    create_table :restaurants do |t|

      t.string :name,   null: false, default: ""
      t.string :business_time,  null: false, default: ""
      t.integer :price, null: false, default: 0
      t.string :telephone_number, null: false, default: ""
      t.string :address,  null: false, default: ""
      t.boolean :is_active, null: false, default: true

      t.timestamps
    end
  end
end
