class AddGenreidClosedRestaurant < ActiveRecord::Migration[6.1]
  def change
    add_column :restaurants, :genre_id, :integer
  end
end
